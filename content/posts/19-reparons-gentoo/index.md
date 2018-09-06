+++
Author = "Lord"
menu = "main"
Categories = ["gentoo","adminsys","tips","portage"]
Description = "Installer des paquets gentoo quand sa chaîne de compil est pétée"
date = "2011-08-25T22:05:17+02:00"
title = "Bidouil^wRéparons de la gentoo."
nodate = true

+++
Imaginons que par un improbable hasard vous tombiez sur une pauvre petite gentoo abandonnée.
Vous voulez faire la mise à jour et là, pas ici, mais là, vous vous apercevez que vous avez une glib et une glibc impossible à emerger pour diverses raisons.

Il est possible d'émerger les paquets relous sur une autre Gentoo fonctionnelle.
Pour plus de simplicité, il est appréciable que les architectures soient identiques et si possible d'avoir le même *ACCEPT_KEYWORDS*.
Il est toujours possible de bidouiller pour adapter ça (même pourquoi pas monter une chaîne de crossdev pour créer des paquets pour d'autres architectures, mais là n'est pas le propos).

Pour faire ce genre de manip, il faut emerger le paquet sur la machine saine avec **<samp>--buildpkgonly</samp>**.
Il sera placé dans */usr/portage/package/catégorie/paquet.tbz2*, vous le transversez vers la machine foireuse dans le même dossier et vous l'émergez avec **<samp>--usepkgonly</samp>**.

