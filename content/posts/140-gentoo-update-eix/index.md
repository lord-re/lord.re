+++
Author = "Lord"
Description = "Depuis que l'on peut mettre à jour son arbre Portage via Git, l'outil eix de Gentoo ne trouve pas les nouveaux paquets. Pour remédier à cela il faut regénérer le cache des méta-données."
Categories = ["gentoo", "git"]
menu = "main"
notoc = true
PublishDate = 2018-11-18T17:02:14+01:00
date = 2018-11-18T17:02:14+01:00
title = "Updater le cache nginx lorsque portage utilise git"
editor = "kakoune"
+++
Gentoo se modernise et depuis quelques années l'arbre Portage peut-être transmis non plus uniquement via *rsync* mais aussi par *git* maintenant.
D'un point de vue réseau c'est bien plus rapide : au lieu de parcourir toute l'arborescence pour voir ce qui doit être mis à jour ou non, vous allez juste récupérer les commits depuis la dernière mise à jour.
C'est vraiment plus rapide.

Par contre lorsque vous faites ceci, vous n'aurez plus les méta-données de l'arbre.
Et ça pose soucis si comme moi vous utilisez **eix** pour chercher des infos sur les ebuilds.
Si vous mettez à jour via **<samp>emerge --sync</samp>** ou même via **<samp>eix-sync</samp>** vous aurez donc potentiellement de nouveau paquets mais eix n'aura pas les infos.

Du coup pour mettre à jour le cache de méta-données il faut utiliser la commande **<samp>egencache --jobs=8 --update --repo=gentoo</samp>**

Et armez-vous de patience.

Autant la synchro via git fait gagner énormément de temps, la régénération du cache est super lent.
Je ne le fais pas systématiquement.
Étant donné que je suis tous les nouveaux ebuilds qui rentrent dans l'arbre via RSS, je sais à peu près ce qui est susceptible de m'intéresser et quand j'en vois un qui m'attire je régen le cache.
