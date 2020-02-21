+++
Author = "Lord"
Description = "N'activer javascript que sur certains sites dans la nouvelle version de Qutebrowser."
Categories = ["web", "qutebrowser","javascript"]
menu = "main"
notoc = true
date = 2018-04-02T19:51:09+01:00
Publishdate = 2018-03-15T13:51:09+01:00
title = "Qutebrowser per Domain Settings"
editor = "kakoune"
TopWords = [  "javascript", "réglages"]
+++
Dans sa version 1.2, Qutebrowser a ajouté une fonctionnalité toute sympa :

## Les réglages en fonction du domaine

En gros vous avez donc vos réglages habituels (globaux) mais sur certains sites vous pouvez avoir de nouveaux réglages spécifiques.
Ça permet enfin de *pouvoir désactiver globalement le javascript et de ne l'activer qu'au cas par cas*.

En faisant ça la navigation sur les interwebs devient bien plus agréable.
Tout est plus réactif, moins de risque de salopage dans votre dos par le premier site venu.
Bon ça ne remplace pas un uBlock Origin ou uMatrix mais c'est tout de même bien mieux qu'avant.

La syntaxe de la config est par contre pas jolie jolie.
MAIS, oui il y a un mais majuscule !
Il y un nouveau raccourci tout bien foutu pour ça.

Donc on *désactive globalement javascript* avec **:set content.javascript.enabled false** .
Ensuite sur chacune des pages autorisées à faire du javascript, vous faites **tSh** qui va réactiver javascript pour le domaine du site que vous consultez et recharger la page.

Si par contre vous voulez autoriser que ponctuellement sans sauvegarder dans la config, il faut faire un **tsh** (donc sans majuscule).

Et hop c'est bon.

## Les prochaines versions ?
Il s'agit de la première version des régagles spécifiques à un domaine.
De futurs améliorations sont prévues.
Un but à long terme est de répliquer les fonctionnalités d'uMatrix donc on aura très surement une meilleure granularité et plus de réglages possibles.

Dans mon cas je ne m'en sert que pour le js mais il est également possible de faire la même chose pour les images, les plugins et pas mal d'autres réglages.
