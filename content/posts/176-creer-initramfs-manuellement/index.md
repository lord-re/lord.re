+++
Author = "Lord"
Description = ""
Categories = ["linux", "kernel","gentoo"]
Tags = ["linux", "kernel","gentoo"]
menu = "main"
notoc = true
draft = false
PublishDate = 2017-12-23T17:50:32+01:00
date = 2019-08-14T15:50:32+01:00
title = "Se créer un initramfs manuellement"
+++
ou

## Se monter un système Linux minimal

Alors que quelques années en arrière, [le wiki d'Arch Linux](https://wiki.archlinux.org/) était une des rares documentations à aborder des sujets assez variés et techniques, désormais [le wiki Gentoo](https://wiki.gentoo.org/) s'améliore grandement et arrive à faire au moins aussi bien.
Il lui arrive même de dépasser son concurrent et a l'avantage d'être plus centré sur ma distro favorite.
Il intègre désormais le [fameux handbook](https://wiki.gentoo.org/wiki/Handbook:AMD64) permettant d'installer sa Gentoo.
Aujourd'hui je vais vous faire un ptit TL;DR de la partie dédiée à l'InitramFS.

## Initramfs ?
Je pensais avoir déjà fait un article à ce propos mais visiblement non…
Donc un initramfs est la première *racine* (quand je dis racine, c'est la racine des fichiers, c'est "/", c'est aussi ce que l'on appele le userland) que le kernel Linux va utiliser lors du boot. 

### Bon comment ça boot un ordi ?
Bon déjà le **BIOS** fait ses cachoteries.
Et en théorie vous l'avez configuré en lui disant : “Pour booter, tu vas d'abord tenter de booter sur ce truc, si c'est pas bon essaye ce machin et enfin si aucun ne marche boot sur ce bidule.” .
Bon généralement le truc, le machin et le bidule sont des appareils dits de blocs, c'est-à-dire un lecteur CD/DVD/Bluray (en voie de disparition), une clé usb ou plus classiquement un disque dur/SSD.

À partir de là l'ordi va donc regarder ce qu'il se trouve au dans les premiers blocs de l'appareil choisi en espérant trouver un **bootloader**.
Il s'agit d'un programme qui fonctionne avec différentes couches.

La difficulté vient du fait que le BIOS ne peut charger qu'un bootloader d'une taille particulière qui se situe à un endroit particulier du disque dur.
Et ce bootloader est d'une taille assez ridicule.
Il doit donc être découpé en différentes couches qui vont chacune devoir charger la couche suivante.
Il doit être capable de lire la partition sur laquelle il se trouve.
Il va ensuite devoir être en mesure de charger le Kernel et lui donner ses options pour monter le reste.

Il est de plus en plus fréquent que le kernel (Linux évidemment) ne soit pas capable de monter de lui-même le système de fichier de sa *racine* : elle peut être chiffrée ou bien être sur un RAID par exemple.
Donc afin de monter la racine, il faut déjà avoir des outils capables de déchiffrer ou bien assembler le RAID.
Du coup *il faut un système provisoire embarquant ces outils afin de monter la véritable racine*.
Ce système provisoire est donc fourni au kernel par le bootloader et est placé en ram.
C'est le système de fichier initial en ram : **initial ram filesystem** ou **initramfs**.
Une fois la racine montée, l'initramfs a terminé son boulot et passe la main à la racine et ça fini de booter.

Résumons : **BIOS** → **Bootloader** → **Initramfs** → **Linux userland**

On a pas la main sur le BIOS, le bootloader on a la main mais on préfère le laisser le plus simple possible. L'initramfs est donc un vrai OS nunux qui n'est que temporaire pour charger l'OS définitif.

## Et du coup il y a quoi dans ce truc ?
En gros c'est une *racine* classique sauf que ça doit rentrer en ram, donc on y met peu de choses et on fout tout ça dans un seul fichier que l'on compresse (le kernel sait décompresser pas mal de type fichier de lui-même).

On y met donc ce que l'on veut.
Il nous faut généralement un *shell* pour pouvoir trifouiller manuellement en cas de soucis.
On y fout donc de quoi monter la partoche *racine* donc là ça dépend de votre cas : de quoi déchiffrer ou bien de quoi "assembler" le RAID, gérer votre gestionnaire de volume (LVM).

Perso j'ai ajouté un peu de bonus : 

  - j'y ai mis un client SSH afin de pouvoir déjà bidouiller sérieusement
  - mon fidèle tmux histoire de pas vivre comme des sauvages non plus
  - le layout bépo pour pouvoir écrire tranquilement
  - deux trois ptits outils comme kakoune, ncdu …

Rien d'extraordinaire mais c'est toujours pratique.

## Comment on le crée alors ?
Il existe pas mal de méthodes différentes.
Il ne s'agit que d'une archive de type cpio (un peu comme tar, zip et compagnie mais en plus primitif apparemment).
Il existe pas mal d'outils différents pour le créer. Pas mal de distribution ont créé leur outil spécifique.
Là on va tenter de faire ça selon les règles de Gentoo qui s'avèrent être la méthode officielle Linux.

Donc on crée le dossier */usr/src/initramfs* et dedans on va y mettre quelques fichiers utiles. On va créer un fichier */usr/src/initramfs/initramfs.list* qui contiendra les instructions pour générer le fichier en lui même :

### Création de la structure

<details><summary>*/usr/src/initramfs/intitramfs.list*</summary>
{{< highlight shell >}}
# directory structure
dir /proc       755 0 0
dir /usr        755 0 0
dir /bin        755 0 0
dir /usr/bin    755 0 0
dir /sys        755 0 0
#dir /var        755 0 0
#dir /lib        755 0 0
dir /sbin       755 0 0
dir /lib64      755 0 0
dir /usr/lib64      755 0 0
#dir /lib32      755 0 0
dir /mnt        755 0 0
dir /mnt/root   755 0 0
dir /etc        755 0 0
dir /root       700 0 0
dir /dev        755 0 0
# depends
file /lib64/libmount.so.1       /lib64/libmount.so.1    755 0 0
file /lib64/libblkid.so.1       /lib64/libblkid.so.1    755 0 0
file /lib64/libc.so.6           /lib64/libc.so.6        755 0 0
file /lib64/libuuid.so.1        /lib64/libuuid.so.1     755 0 0
file /lib64/ld-linux-x86-64.so.2  /lib64/ld-linux-x86-64.so.2 755 0 0
file /lib64/libz.so.1           /lib64/libz.so.1        755 0 0
file /lib64/libpthread.so.0     /lib64/libpthread.so.0  755 0 0
file /lib64/liblzo2.so.2        /lib64/liblzo2.so.2     755 0 0
file /lib64/libresolv.so.2      /lib64/libresolv.so.2   755 0 0
file /lib64/libdl.so.2          /lib64/libdl.so.2       755 0 0
file /usr/lib64/libelf.so.1     /usr/lib64/libelf.so.1  755 0 0
file /lib64/libmnl.so.0         /lib64/libmnl.so.0      755 0 0
file /lib64/libnss_files.so.2   /lib64/libnss_files.so.2        755 0 0
file /lib64/libnss_dns.so.2     /lib64/libnss_dns.so.2  755 0 0
file /lib64/libutil.so.1        /lib64/libutil.so.1     755 0 0
file /lib64/libncurses.so.6     /lib64/libncurses.so.6  755 0 0
file /usr/lib64/libevent-2.1.so.6       /usr/lib64/libevent-2.1.so.6    755 0 0
# busybox
file /bin/busybox /bin/busybox 755 0 0
# btrfs
file /sbin/btrfs /sbin/btrfs 755 0 0
# our init script
file    /init                   /usr/src/initramfs/init 555 0 0
# our stuff
file /root/bepo.bmap            /usr/src/initramfs/bepo.bmap            444 0 0
file /usr/bin/ssh               /usr/bin/dbclient       555 0 0
file /bin/ip                    /bin/ip                 555 0 0
file /etc/nsswitch.conf         /etc/nsswitch.conf      755 0 0
file /sbin/boot                 /usr/src/initramfs/boot 555 0 0
file /usr/bin/tmux              /usr/bin/tmux           555 0 0
# mount fix
file /lib64/libmount.so.1	/lib64/libmount.so.1	555 0 0
file /lib64/libblkid.so.1	/lib64/libblkid.so.1	555 0 0
file /lib64/librt.so.1		/lib64/librt.so.1	555 0 0
file /lib64/libpthread.so.0	/lib64/libpthread.so.0	555 0 0
file /root/mount		/bin/mount		755 0 0

{{< / highlight >}}
</details>

La syntaxe est plutôt simple, on indique s'il s'agit d'un fichier ou d'un dossier, puis le chemin qu'il aura dans l'initram et enfin ses droits.
Vous pouvez bien évidemment vous inspirer du mien mais il y a fort à parier que si vous ne faites qu'un copier/coller ça ne marche pas.

### Création de l'init
Alors le kernel démarre, son boulot va être de démarrer l'**init** à l'intérieur de l'**initramfs**.
Donc c'est le programme init qui va faire le boulot qui nous intéresse.

Ça peut être un logiciel ou juste un script shell qui fait ses ptites affaires.
Perso, je me suis fait un script shell assez basique (qu'on retrouve en exemple dans les différentes doc du web, hein, j'invente pas grand chose).

<details><summary>/usr/src/initramfs/init</summary>
{{< highlight shell >}}
#!/bin/busybox sh

rescue_shell() {
  echo "$@"
  busybox --install -s
  busybox loadkmap < /root/bepo.bmap

  echo "Voulez-vous la conf réseau habituelle ?"
  read network
  if ! test -z "$network" ; then net_setup ; fi

  echo -e "Une fois fini de faire mumuse : \033[41mexec /sbin/boot\033[0m"

  setsid cttyhack sh
}

mount_root() {
  echo "scanning for btrfs filesystems...."
  /sbin/btrfs device scan
  echo "mounting /mnt/root"
  mount /dev/sdb /mnt/root -o subvolid=$1
}

finish_boot() {
  # clean up. The init process will remount proc sys and dev later
  umount /proc
  umount /sys
  umount /dev

  # switch to the real root and execute init
  exec switch_root /mnt/root /sbin/init
}

net_setup() {
  echo "nameserver 10.0.0.254" > /etc/resolv.conf
  ip link set dev eth0 up
  ip a a 10.0.0.3/8 dev eth0
  ip r a default via 10.0.0.254
}

boot_menu() {
  echo "Qu'est-ce qu'on boot aujourd'hui ?"
# Gentoo is installed in the subvolid 5 and Alpine in the 555
  echo -e "\t1 | A | B : Gentoo"
  echo -e "\t2 | É | Z : Alpine"
  echo -e "\t3 | R : Rescue"
  read -t 5 choice

  case $choice in
    "1" | "\"" | "A" | "a" | "B" | "b")
      echo "Ça sera Gentoo !"
      /sbin/btrfs device scan
      mount /dev/sdb /mnt/root -o subvolid=5 || rescue_shell "Error trying to mount rootfs"
    ;;
    "2" | "É" | "é" | "Z" | "z" | "alpine")
      echo "Go pour Alpine !"
      /sbin/btrfs device scan
      mount /dev/sdb /mnt/root -o subvolid=555 || rescue_shell "Error trying to mount rootfs"
    ;;
    "3" | "R" | "r" | "rescue")
      rescue_shell
    ;;
    *)
      echo "Pas de le temps de niaiser, c'est l'heure de booter."
      /sbin/btrfs device scan
      mount /dev/sdb /mnt/root -o subvolid=5 || rescue_shell "Error trying to mount rootfs"
  esac
}

# 1) temporarily mount proc and sys
mount -t proc none /proc
mount -t sysfs none /sys
mount -t devtmpfs none /dev

# 2) disable kernel messages from popping onto the screen
echo 0 > /proc/sys/kernel/printk

# 3 ) Custom boot loader
boot_menu


echo "All done.\n\n"
finish_boot || rescue_shell
{{< / highlight >}}
</details>

Bon je ne vous cache pas qu'en ce moment je le bidouille pas mal et donc qu'il est assez mouvant.
J'ajoute des trucs j'en retire.
Il y a moyen d'enlever des trucs si vous voulez vraiment le strict minimum.
Dans mon cas le but est **scanner les devices pour le btrfs** et **proposer le choix entre Gentoo et Alpine et un Resue**.
Et le rescue c'est en fait *busybox* plus quelques logiciels en plus pour pouvoir démerdouiller ce qui arrive.

### Assemblage
On va avoir besoin d'un ptit outil bien planqué.

On va lancer **<samp>/usr/src/linux/usr/gen_init_cpio /usr/src/initramfs/initramfs.list > /usr/src/initramfs/initram.cpio</samp>** .
Et pouf !
On a un joli initram qu'on va pouvoir filer à bouffer à notre kernel.

<details><summary>exemple de menu.lst de Grub</summary>
<pre>
title Gentoo RAID
root(hd1,0)
kernel /boot/kernel511 rootflags=device=/dev/sdb,device=/dev/sda,… rootfstype=btrfs quiet
initrd /boot/initram.cpio
</pre>
</details>

## Vous avez un joli initramfs fait main !

Cet article est dans les brouillons depuis deux ans.
J'en ai eu besoin ces derniers jours et du coup je me suis dit que ça pourrait vous être utile également.
Voilà tout.

J'ai d'ailleurs trouvé un bug sur la commande *mount de busybox* qui n'est pas capable de monter un sous-volume btrfs autre que celui par défaut.
