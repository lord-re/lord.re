+++
Author = "Lord"
Description = "Petite astuce pour verrouiller le fichier /etc/resolv.conf définissant votre résolveur dns sur openwrt."
Categories = ["tips", "adminsys","dns"]
menu = "main"
notoc = true
PublishDate = 2018-04-04T21:41:29+02:00
date = 2018-04-07T18:41:29+02:00
title = "Verrouiller le fichier /etc/resolv.conf sur Openwrt"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/kpl0as/verrouiller_le_fichier_etc_resolv_conf"
+++
OpenWRT me gonfle !

Ouai c'est une intro brute mais vraie.
À chaque fois que je dois me plonger dans leur interface web ça me saoûle.
Je suis plus habitué à gérer un nunux classique via ssh plutôt que leurs interfaces bizarre.

Rien que définir un résolveur DNS est compliqué dans leur système.

Ma connexion Internet m'est fournie via du DHCP or ce protocole vous envoi votre conf IP, votre route par défaut ET le résolveur DNS à utiliser.

Sauf que j'ai pas besoin de ce généreux service de mon FAI vu que j'utilise mon propre résolveur de mon côté.
Et ce joyeux luron qu'est OpenWRT n'est manifestement pas des plus compréhensif à mon égard.

Ni une ni deux, je SSH sur le bousin et je tente un ptit **chattr +i /etc/resolv.conf**.

    chattr: Operation not supported while reading flags on /etc/resolv.conf

O___o hmmm bizarre

Ha bha tiens, c'est un lien symbolique vers */tmp/etc/resolv.conf* .
Bon pourquoi pas.

Je tente le chattr +i sur ce fichier là du coup.

Pas mieux.

GRRRRRRR JE DÉTESTE TOUTES CES MAGOUILLES D'OPENWRT !

*On inspire*

**rm /tmp/etc/resolv.conf**

**rm /etc/resolv.conf**

*Et on expiiiiiiiire*

**crontab -e**

    * * * * * printf "#SET VIA CRONTAB\nnameserver 10.2.0.1\nnameserver 10.2.0.2\n" > /etc/resolv.conf

On patiente une minute.

Et si le fichier est bien comme il faut.

**chattr +i /etc/resolv.conf**

Et voilà.

Plus d'emmerdes à ce niveau.

J'ai l'impression de me battre contre la distro mais c'est aussi ça nunux, on peut toujours le plier à sa volonté le manchot !

Cette technique c'est « ceinture + bretelles » mais au moins je suis à peu près sûr de plus être emmerdé.
