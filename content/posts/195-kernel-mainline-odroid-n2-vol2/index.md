+++
Author = "Lord"
Description = "Seconde partie de ma quête. Après un premier échec, je reviens plus fort avec ce coup-ci un câble UART -> USB afin de pouvoir me plonger à fond dans uboot. Parviendrais-je à booter un kernel libre sur l'odroid N2 ?"
Categories = ["sbc", "kernel","linux","odroid"]
menu = "main"
notoc = true
WritingDate = 2020-03-19T19:02:32+01:00
date = 2020-03-20T18:02:32+01:00
title = "Kernel Mainline sur Odroid N2 vol.2"
editor = "kakoune"
TopWords = [ "make", "arch", "odroid", "dtb", "n2", "arm64", "uboot", "kernel"]
+++

**Suite de [l'épisode précédent]({{< ref "posts/194-kernel-mainline-odroid-n2" >}})**

Il y a un **TL;DR** à la fin.

## UART

Bon, je me suis armé d'un câble UART > USB.
Ce petit câble va me permettre d'avoir un accès console dès le démarrage de la ptite SBC.
Je vais donc pouvoir voir ce qu'elle fait réellement quand elle ne boot pas.

Bon du coup je m'installe **minicom** et je lui crée un ptit fichier de conf qui va bien.

<details><summary>/etc/minicom/minirc.odroid</summary>
{{< highlight "shell">}}
# Machine-generated file - use "minicom -s" to change parameters.
pu port             /dev/ttyUSB0
pu pprog9           /usr/bin/ascii-xfr -dsv
pu pname9           /YUNYNascii
pu downdir          /tmp/TTYUSB-Downloads
pu rtscts           No
pu xonxoff          Yes
{{< / highlight>}}
</details>

Bon maintenant quand je veux m'y connecter j'ai plus qu'à <kbd>minicom odroid</kbd> et hop.

Un premier test sur l'odroid C2, nickel, ça fait ses ptits trucs, c'est cool ça fonctionne.

Allez, je recopie le blog sur une autre machine, j'y fous un nginx, le certif, sur le routeur je nat le port vers cette nouvelle machine.
C'est bon je peux couper la N2 un peu plus longuement.
J'ai quand même mon instance Pleroma coupée ainsi que mon TTRSS, du DNS et mon bot IRC… bref c'est pas super impactant non plus mais si ça pouvait ne pas s'éterniser ça m'arrange.

Allez c'est parti pour un premier boot sur le kernel 4.9 blobbé.
Effectivement au démarrage j'ai le temps de voir passer un peu de truc made in **uboot**.

## Reprise une semaine plus tard

Allez je ré-édite le boot.ini pour remettre ce que j'avais laissé en commentaire la fois précédente.
Et on fait un reboot.

Hmmm j'ai pas gardé les logs c'est dommage ça aurait été pas mal mais en gros uboot râle que le CRC du kernel est pas bon.
Voilà…
Bon je sais pas trop pourquoi, est-ce le transfert de fichier qui a merdé ou autre je ne sais pas.

Bon, je redégaine l'[article gentoo pour la n2](https://wiki.gentoo.org/wiki/Odroid_N2) et je recommence de 0.
Je rechope les sources du kernel, je choppe le compilo qui va bien.

Je fous les variables d'environnement qu'il faut pour crosscompiler vers du Arm64.
Je modifie les quelques options indiquées sur la page du wiki, je compile et je touille le truc pour le passer en … bha je sais pas trop exactement ce que c'est mais en un format utilisable par uboot.
Je copie ça sur la SD, je choppe le DTB qui est le fichier représentant l'architecture matérielle de la board afin que le kernel puisse bosser convenablement.
Le fichier est présent dans les sources du kernel dans *arch/arm64/boot/amlogic/meson-g12b-odroid-n2.dtb* .

Je tente de booter et là en fait, je tente d'un peu mieux apprivoiser uboot.

## Uboot

Lors du boot on peut marteler <kbd>Enter</kbd> pour arriver à un shell avec quelques commandes permettant d'outrepasser le fichier de conf (qui n'est même pas lu à ce stade).
Et là déception ce shell est vraiment très minimaliste, j'ai pas trouvé d'éditeur de texte, bon je m'y attendais mais c'est pas trop grave.
Je ne trouve pas non plus de quoi lire un fichier.

Il y a bien la commande ls qui nécessite par contre une syntaxe un chouilla particulière vu qu'il n'y a pas de système de fichier racine encore à ce moment.
Du coup faut d'abord lui indiquer sur quel appareil lire (la *mmc* dans mon cas), ensuite quelle partition ( *:1* pour la partoche boot).

Quand on charge un kernel en mémoire, si jamais on s'est planté, on peut en charger un autre sans rien faire de particulier.
C'est une ptite info qui m'inquiétait avec mes gros doigts qui ripent…

Bon, j'ai de quoi me débrouiller légèrement avec uboot désormais je vais pouvoir m'atteler à la suite.

## Ce coup-ci c'est la bonne pour uboot !
Bref, première chose à faire c'est s'assurrer qu'on demande bien au kernel de chopper la bonne partition.

Je me suis fait un mini fichier *boot.ini* contenant le strict nécessaire pour booter.

<details open><summary>boot.ini minimal</summary>
{{< highlight "shell" "linenos=table" >}}
setenv condev "console=ttyS*,115200n8"
setenv bootargs "root=/dev/mmcblk0p2 rootwait rw console=ttyAML0,115200 clk_ignore_unused"
setenv dtb_loadaddr "0x1000000"
setenv kernel_loadaddr "0x01080000"
fatload mmc ${devno}:1 ${dtb_loadaddr} meson-g12b-odroid-n2.dtb
fatload mmc ${devno}:1 ${kernel_loadaddr} uImage
fdt addr ${dtb_loadaddr}
bootm ${kernel_loadaddr} - ${dtb_loadaddr}
{{< / highlight>}}
</details>

  - 1: On déclare une variable indispensable à uboot, j'ai essayé sans, je me suis brûlé.
  - 2: On définit les options qui seront données au kernel
  - 3 et 4 : Déclaration de variables pour les adresses mémoires, on peut s'en passer et les mettre direct en dur dans les commandes suivantes mais pourquoi pas ?
  - 5 : La commande <kbd>fatload</kbd> charge depuis un device (*mmc*) en lisant une partition au choix (*:1*) pour mettre en mémoire à l'adresse voulue (*${dtb_loadaddr}*) le fichier spécifié (*meson-g12b-odroid-n2.dtb*). Donc là on charge le dtb en ram.
  - 6 : pareil qu'au-dessus mais pour le kernel ce coup-ci.
  - 7 : celle-là m'est un peu mystérieuse. J'imagine que cette commande lit le dtb et probablement qu'elle initialise le matos mais j'en suis clairement pas sûr.
  - 8 : la commande <kbd>bootm</kbd> est celle lançant le boot en lisant les adresses mémoires qui vont bien.

Le <abbr title="device tree binary">dtb</abbr> est en fait la description matérielle de la SBC.
Ça veut dire qu'en théorie ça ne change pas, sauf que celle fournie par le kernel officielle utilise des drivers particuliers qui sont différents du kernel mainline, donc il me faut un nouveau dtb pour le mainline.
À l'avenir, ce fichier ne devrait plus changer cela dit.

Voilà voilà.

Avec ça, plus besoin de tripoter cette partie.

## La bataille du kernel !
Bon je vous la fais courte : j'ai commencé à compiler un kernel tout droit sorti de git.
Mais j'avais des erreurs de merde concernant rcu et tout…
J'ai galeré cherché et tout et il s'avère que j'ai vraiment pas eu de bol.
Il y a un [léger bug trouvé depuis hier](https://lkml.org/lkml/2020/3/19/1103) et j'étais en plein dedans.

Bon, après une heure de perdue, retour à la case kernel.org.
Je choppe le dernier stable donc un 5.5.10 .

Tiens d'ailleurs un truc que j'ai appris c'est que les options présentes dans le <kbd>make menuconfig</kbd> changent en fonction de la variable d'environnement *ARCH*.
Du coup en définissant *ARCH=arm64* on a tout un set d'options qui changent.

Fast Forward, je choppe le fichier [.config d' ArmBian](https://github.com/armbian/build/blob/master/config/kernel/linux-meson64-current.config) histoire d'avoir un préset pas dégueu.
Je le compile sans erreur.

Je refais la manip pour le rendre compatible avec uboot.
Après réflexion je pense que ça y colle quelques métadonnées, comme par-exemple un CRC, les adresses mémoires, quel type de kernel c'est afin qu'uboot puisse faire quelques tests avant de charger le truc à l'aveugle.
La commande pour ça est donc <kbd>mkimage -A arm64 -O linux -T kernel -C none -a "0x1080000" -e "0x1080000" -n "$(make kernelrelease)" -d arch/arm64/boot/Image ../uImage</kbd> .

Il reste quand même les modules à transférer.
La ptite feinte c'est de monter (soit carrément la mmc sur l'ordi ou via sshfs si elle tourne) et de faire un ptit <kbd>make modules_install ARCH=arm64 INSTALL_MOD_PATH=/mnt/n2</kbd> .

Bon… moment de vérité.
On reboot.

Et … ça marche \o/ .
Bon ça m'a pris beaucoup d'essai et près d'une heure et demi mais ça fonctionne **j'ai booté sur un kernel mainline sur l'odroid N2 !**

Bon bha maintenant je refais pareil, mais je modifie le *.config* du kernel afin de dégager pas mal d'options inutiles pour moi.
Je vous le mets [ici](config)

Voilà c'était mon ptit voyage de découverte dans le monde du boot chez ARM.
À première vu uboot fait peur avec ses adresses mémoires et tout, mais au final c'est pas si horrible que ça.
J'aurai appris pas mal de chose et maintenant j'ai ma ptite SBC favorite avec un kernel tout libre et des mises à jour assurée pour des lustres.

## TL;DR

  - Choper les sources du kernel depuis [kernel.org](https://kernel.org)
  - <kbd>export ARCH=arm64</kbd>
  - <kbd>export CROSS_COMPILE=aarch64-linux-gnu-</kbd>
  - <kbd>export PATH=/chemin/vers/gcc-linaro-6.3.1-2017.02-x86_64_aarch64-linux-gnu/bin/:$PATH</kbd>
  - Choper un [.config](config) adapté à la N2 (ou le faire soi-même)
  - Compiler un joli kernel avec <kbd>make -j32</kbd>
  - <kbd>mkimage -A arm64 -O linux -T kernel -C none -a “0x1080000” -e “0x1080000” -n “$(make kernelrelease)” -d arch/arm64/boot/Image ../uImage</kbd>
  - Transferer les modules (en s'aidant de <kbd>make modules_install ARCH=arm64 INSTALL_MOD_PATH=../modules</kbd>)
  - Transferer également le kernel au format uImage à placer dans la partoche de boot de la SBC
  - Créer un *boot.ini*
  - Copier le dtb trouvable dans les sources du kernel : *arch/arm64/boot-dts/amlogic/meson-g12b-odroid-n2.dtb*
  - Et booter !
  
