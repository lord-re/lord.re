+++
Author = "Lord"
Description = ""
Categories = ["linux", "kernel","gentoo"]
Tags = ["linux", "kernel","gentoo"]
menu = "main"
notoc = true
PublishDate = 2018-12-23T17:50:32+01:00
date = 2017-12-23T17:50:32+01:00
title = "Créer son initramfs à la mode de Gentoo"
+++
Alors que quelques années en arrière, [le wiki d'Arch Linux](https://wiki.archlinux.org/) était une des rares documentations à aborder des sujets assez variés et techniques, désormais [le wiki Gentoo](https://wiki.gentoo.org/) s'améliore grandement. Il lui arrive même de dépasser son concurrent et a l'avantage d'être plus centré sur ma distro favorite. Il intègre désormais le [fameux handbook](https://wiki.gentoo.org/wiki/Handbook:AMD64) permettant d'installer sa Gentoo. Aujourd'hui je vais vous faire un ptit TL/DR de la partie dédiée à l'InitramFS.

## Initramfs ?
Je pensais avoir déjà fait un article à ce propos mais visiblement non… Donc un initramfs est la première *racine* (quand je dis racine, c'est la racine des fichiers, c'est "/", c'est aussi ce que l'on apelle le userland) que le kernel Linux va utiliser lors du boot. 

### Bon comment ça boot un ordi ?
Bon déjà le **BIOS** fait ses cachoteries. Et en théorie vous l'avez configuré en lui disant "Pour booter, tu vas d'abord tenter de booter sur ce truc, si c'est pas bon essaye ce machin et enfin si aucun ne marche boot sur ce bidule". Bon généralement le truc, le machin et le bidule sont des périphériques dits de bloc. C'est à dire un lecteur CD/DVD/Bluray (en voie de disparition), une clé usb ou plus classiquement un disque dur/SSD.

À partir de là l'ordi va donc regarder ce qu'indique le BIOS en espérant trouver un **bootloader**. Il s'agit d'un programme qui fonctionne avec différentes couches. La difficulté vient du fait que le BIOS ne peut charger qu'un bootloader d'une taille particulière qui se situe à un endroit particulier du disque dur. Le bootloader est donc découpé en différentes couches qui vont chacune devoir charger la couche suivante. Le bootloader doit être capable de lire la partition sur laquelle il se trouve. Il va ensuite devoir être en mesure de charger le Kernel et donner au kernel ses options pour monter le reste.

Il est de plus en plus fréquent que le kernel (Linux évidemment) ne soit pas capable de monter de lui même le système de fichier de sa *racine* : elle peut être chiffrée ou bien être sur un RAID par exemple. Un système de fichier doit donc être monté temporairement avant même que la véritable *racine* soit montée. Et cette racine temporaire contenant quelques outils est un **Initramfs** : initial ram filesystem quoi. Et très généralement le boulot de cet initramfs va être de monter la **partition racine** puis de s'effacer.

Résumons : **BIOS** → **Bootloader** → **Initramfs** → **Linux userland**

On a pas la main sur le BIOS, le bootloader on a la main mais on préfèrre le laisser le plus simple possible. L'initramfs est donc un vrai OS nunux qui n'est que temporaire pour charger l'OS définitif.

## Et du coup il y a quoi dans ce truc ?
En gros c'est une *racine* classique sauf que ça doit rentrer en ram donc on y met peu de choses et on fout tout ça dans un seul fichier que l'on compresse (le kernel sait décompresser pas mal de type fichier de lui même).

On y met donc ce que l'on veut. Il nous faut généralement un *shell* pour pouvoir trifouiller manuellement en cas de soucis. On y fout donc de quoi monter la partoche *racine* donc là ça dépend de votre cas. De quoi déchiffrer ou bien de quoi "assembler" le RAID.

Perso j'ai ajouté un peu de bonus, j'y ait mis un client SSH, mon bon fidèle tmux, le layout bépo pour pouvoir écrire tranquilement. Rien d'extraordinaire mais c'est toujours pratique.

## Comment on le créer alors ?
Il existe pas mal de méthodes différentes. Il ne s'agit que d'une archive de type cpio (un peu comme tar, zip et compagnie mais en plus primitif apparemment). Il existe pas mal d'outils différents pour le créer. Pas mal de distribution ont créer leur outil spécifique. Là on va tenter de faire ça selon les règles de Gentoo qui s'avèrent être la méthode officielle Linux.

Donc on créer le dossier */usr/src/initramfs* et dedans on va y mettre quelques fichiers utiles. On va créer un fichier */usr/src/initramfs/initramfs_list* qui contiendra les instructions pour générer le fichier en lui même :

```
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
```
La syntaxe est plutôt simple, on indique s'il s'agit d'un fichier ou d'un dossier, puis le chemin qu'il aura dans l'initram et enfin ses droits.
