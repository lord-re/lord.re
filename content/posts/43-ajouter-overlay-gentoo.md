+++
Description = "Nous allons voir comment ajouter/supprimmer un overlay gentoo sans passer par le vénérable layman"
date = "2016-10-06T14:58:02+02:00"
title = "Ajouter un overlay Gentoo sans layman"
menu = "main"
Categories = ["adminsys","software","linux","gentoo","cli"]
Tags = ["adminsys","software","linux","gentoo","cli"]

+++
Les overlays sous Gentoo sont des surcouches à l'arbre Portage. Portage est en fait une grande collection de scripts pour installer des logiciels. Gentoo de base possède énormément de ces scripts cependant il arrive que parfois le logiciel que l'on cherche n'est pas disponible officiellement. Portage possède une fonctionnalité très intéressante permettant de rajouter des branches à votre arbre ce qui permet d'ajouter de nouveaux logiciels disponible via emerge.

Jusqu'à il y a peu, il fallait passer par le logiciel layman qui n'est pas installé par défaut. Cependant il est désormais assez simple de le faire sans celui-ci.

Bon tout d'abord on va éditer le fichier */etc/portage/repos.conf/gentoo.conf*. Il doit contenir quelques lignes déjà. J'espère pour vous qu'il y a le repo [gentoo] ainsi que [DEFAULT]. On va donc en rajouter un à la suite de la forme suivante :
```
[nom de l'overlay]
priority = 50
location = /là/ou/vous/voulez/le/stocker
sync-type = git (potentiellement un autre protocole)
sync-uri = git://url.de/l'/overlay.git
auto-sync = yes
```
Et voilà. Un ptit **emerge --sync** et éventuellement un **eix-update** et c'est tout bon.

Franchement, c'est pas une distro qu'elle est trop bien cette petite gentoo ?

