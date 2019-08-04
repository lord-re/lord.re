+++
Author = "Lord"
Description = "Après l'Odroid N2, voici l'arrivée de l'Odroid HC2 pour l'accompagner. Elle possède un port SATA et est donc assigné au boulot du stockage de données. Et elle a quand même un bon CPU pour pouvoir lui assigner quelques tâches."
Categories = ["sbc", "hardware", "linux", "alpine"]
menu = "main"
notoc = true
PublishDate = 2019-08-04T16:28:13+02:00
date = 2019-08-04T16:28:13+02:00
title = "Adoption d'une Odroid HC2"
editor = "kakoune"
+++
Après les galères habituelles de livraison Made in Colissimo (grrrrr) j'ai enfin pû recueillir une ptite nouvelle à la maison.

## Odroid HC2
Attendez attendez !
*C'est pas le même article que le précédent !*

Ça sera plus … heu … différent que le précédent.

Bref, je reprends.
L'Odroid HC2 est une autre <abbr title="Single board Computer : ordinateur monocarte tel les raspberry pi">SBC</abbr> de chez HardKernel.
Celle-ci est spécialisée pour faire du stockage réseau : pas de sortie vidéo du tout.
Il n'y a qu'un seul port USB, mais elle possède un port Sata avec son alim.
Elle a un gros radiateur servant de socle pour accueillir un disque dur au format 3"1/2.
Elle a quand même un CPU assez puissant (plus qu'un raspi, c'est le même CPU que dans les Samsung Galaxy S5 pour info).
Elle a quand même un GPU mais aucune sortie vidéo…

Son OS se trouve par contre sur une carte microSD (pas d'eMMC possible).

## OS
Bon vous avez probablement lu l'article précédent.
Non ? Bha alors ?

Bon en gros : j'aime vraiment pas ArchLinux (ARM) mais ils sont à peu près les seuls à fournir tout ce qu'il faut : bootloader+kernel+initram+modules+userspace.
AlpineLinux eux fournissent un super userspace mais pas le reste
Du coup je me suis amusé à fusionner les deux.

Dans la procédure d'install du Odroid N2, ils font une partition */boot* séparée mais pas pour le HC2.
Il a fallu plus de bidouille du coup.

## Hybridation entre Alpine et Arch

### Archlinux ARM
Bon la HC2 contrairement à la n2 n'a pas de sortie vidéo, donc c'est à l'aveugle.
Je fous la microSD dans l'ordi, je trifouille les fichiers, je refous la carte dans la SBC je la branche et … bha je croise les doigts pour pouvoir m'y connecter en SSH.

Et je vous cache pas que j'y ai passé quelques heures de très nombreux essais.
Donc la première étape a été d'installer complètement ArchLinux Arm selon [leur tuto](https://archlinuxarm.org/platforms/armv7/samsung/odroid-hc2).
On le boot histoire de voir que la SBC fonctionne.
Ça marche, on voit bien qu'elle a faite une requête DHCP et on peut s'y connecter en root via ssh.
Bon ensuite, récupération de la microSD et début du bidouillage.

### Alpine linux
J'ai créé un dossier dans mon ordi, dedans j'y glisse le contenu de */boot* et de */usr/lib/modules* .
Bon ça c'est tout ce que je conserverai d'Arch.

Ensuite, je récupère le *mini rootfs en armv7* de [chez Alpine](https://www.alpinelinux.org/downloads/) que j'ai détarré dans le dossier de tout à l'heure.
Bon du coup là on a un truc à peu près bien comme base.
Sauf que le mini <abbr title="Il s'agit de la partition de données faisant tourner l'OS : le root file system : la partition racine">rootfs</abbr> est vraiment trèèès lite.

Il faut donc faire en sorte de faire la conf IP et démarrer le serveur SSH.
Easy ?

hahaha
NON.

Bref, j'ai tenté de booter en l'état.
Visiblement pas de requête DHCP, pas de ping.

Modif de la carte pour y foutre un */etc/networking/interfaces* en bonne et dû forme.
Boot.
Rien.

### Will it boot ?
En fait la SBC fait clignoter ses LED mais au final je n'ai aucune idée de ce qu'il s'y passe.
Du coup est-ce que ça boot ?
Est-ce que ça kernel panic ?
C'est vrai qu'on est en droit de se poser la question.

Bon j'ai rusé.
J'ai édité le */etc/inittab* pour y rajouter un script au boot qui ne fait qu'écrire un fichier dans /var/log/boot.

<details open><summary>/etc/inittab</summary>
{{< highlight "bash" >}}
# /etc/inittab
::sysinit:/sbin/hello
{{< / highlight >}}
</details>

Donc là, lorsque l'init de busybox démarre (sysinit) il va executer /sbin/hello

<details open><summary>/sbin/hello</summary>
{{< highlight "bash" >}}
#! /bin/sh
echo "boot" > /var/log/boot
{{< / highlight >}}
</details>

C'est ultra rudimentaire, hein mais le but est juste de savoir si au moins ça boot.
Allez, je refous la microSD dans la SBC et je patiente puis éteint et récup la microSD.

Ho miracle ça a marché \o/.
Donc elle boot bien avec son kernel et compagnie et démarre bien le mini rootfs.

### Je veux du Ping ici !
Booter c'est cool mais maintenant il faut un moyen d'interagir donc il va nous falloir du réseau.
Comme la première partie s'est bien passée j'ai fait pareil pour la suite.

J'ai donc rajouté un autre script au boot
<details open><summary>/etc/inittab</summary>
{{< highlight "bash" >}}
# /etc/inittab

::sysinit:/sbin/netinit
{{< / highlight >}}
</details>

Bon donc là on déclenche le script /sbin/netinit, donc… bha créons-le.

<details open><summary>/sbin/netinit</summary>
{{< highlight "bash" >}}
#! /bin/sh
echo "BOOT" > /var/log/boot.log
/sbin/ipaddr a 10.0.0.252/8 dev eth0 >> /var/log/boot.log 2>&1
/sbin/iplink set dev eth0 up >> /var/log/boot.log 2>&1
/sbin/iproute add default via 10.0.0.254 >> /var/log/boot.log 2>&1
{{< / highlight >}}
</details>

Bien penser à le rendre executable avec <samp>**chmod +x sbin/netinit**</samp>

Je vous passe la phase de tâtonnage pour arriver à ça, il m'a fallu quelques essais…
On fout la microSD dans la SBC on boot.
Et là, oui mesdames et messieurs : **ça ping !**

### Bon après le réseau du SSH
Bon j'ai vraiment envie de prendre la main sur cette machine maintenant.
Là ça doit bien faire deux heures que j'y suis mais on en voit le bout.

Il faut donc maintenant parvenir à installer des logiciels sur l'OS sans booter dessus.
Alors on refout la microSD sur l'ordi et on va Frankensteiner un peu plus.

Retour sur [la page de downloads d'alpine](https://www.alpinelinux.org/downloads/) pour y chopper ce coup-ci le *generic ARM en armv7*.
On l'untar dans un dossier temporaire et là au lieu de trouver un rootfs tout mignon, on trouve un bootloader, kernel et initramfs et surtout les apk pour divers paquets.
Cette image est particulière parce qu'en fait l'initramfs est minimal et permet d'installer les paquets qu'elle contient.

Bon donc le but c'est de s'installer *openssh-server* donc pour voir les paquets nécessaires, on se rend sur [la page du paquet](https://pkgs.alpinelinux.org/package/v3.10/main/armv7/openssh-server) et on reluque les *depends*.
Donc dans un nouveau dossier temporaire on récupère les apk des dépendances ainsi que celui d'openssh-server :

  - openssh-server
  - openssh-server-common
  - openssh-keygen
  - openssh
  - zlib
  - openrc

Par chance, on aura pas besoin que d'un autre paquet… *openrc* qui est l'init officiel d'Alpine.
Une fois tous ces paquets réunis.
On va les extraire avec un mini script shell :
<details open><summary>deapk.sh</summary>
{{< highlight "bash" >}}
#! /bin/bash
for i in $PWD/*.apk
do
  tar xvpf $i
done
rm *.apk
rm ./.*
rm ./deapk
{{< / highlight >}}
</details>

Une fois exécuté vous vous retrouvez avec une jolie ptite arborescence qu'il suffit de glisser sur la microSD.

Il faut *ajouter sshd au boot*.
Pour ça un simple <samp>**ln -s etc/init.d/sshd etc/runlevels/default**</samp> et le tour est joué.

On en profite pour pousser sa clé publique ssh dans */root/.ssh/authorized_keys* pour s'éviter des emmerdes.

Et enfin l'ultime étape nécessaire pour pouvoir se connecter : débloquer le compte root.


On enfile la microSD dans l'HC2 et c'est bon.

### PTY allocation request failed on channel 0
Et ouai on peut toujours pas se connecter avec un message d'erreur particulier.
Bon j'ai pas la science infuse mais j'imagine que le problème vient du fait que le système est un peu installé à la rache et que tous les scripts d'init sont pas forcément bien passé.

Bref, c'est pas grave.
<samp>*ssh root@10.0.0.252 /bin/sh*</samp>
Et ça marche.

Bon, il n'y aura pas tous les ptits raffinement d'un shell parfaitement fonctionnel mais c'est pas grave : **on a la main.**

On peut installer *setup-alpine*.
On se laisse guider et on reboot.

Et voilà on peut s'y ssh convenablement avec un truc parfaitement fonctionnel.

## Pourquoi s'être fait chier comme ça ?
Même si ArchLinux (et son dérivé non officiel pour ARM) adopte la philosophie du <abbr title="Keep it simple, stupid">KISS</abbr> je ne trouve pas ça si simple et si léger.
**Systemd est trop bloaté à mon goût.**
C'est d'autant plus vrai pour un système qui va tourner sur une pauvre petite carte microSD qui aura tendance à claquer comme une merde au premier coup de vent.

Et puis, vu que l'architecture CPU est différente de ce que j'ai ailleurs, j'ai pas pu faire toutes ces manips à base de chroot (ça aurait été bien plus simple).
J'aurai pu tenter de me simplifier la vie en passant par *qemu* mais j'avais pas spécialement envie de l'installer.
Et puis **c'était un défi sympa**.

L'Odroid N2 ayant une sortie vidéo, il était assez simple de voir ce qu'il se passait pendant le boot et en rajoutant un clavier interagir avec pour corriger les éventuelles merdes.
Là, sans ça, il fallait **parvenir à avoir un système fonctionnel tout à l'aveugle**.
Un vrai Die&Retry.


Va falloir backup la microSD pour ne pas avoir à refaire tout ça la prochaine fois.
Je pense que je passerai la carte en *read-only* par la suite histoire d'éviter qu'elle ne s'use trop vite.
:wq
