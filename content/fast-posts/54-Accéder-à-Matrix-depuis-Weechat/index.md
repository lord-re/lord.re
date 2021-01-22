+++
Author = "Lord"
Description = "J'adore aller sur IRC en utilisant weechat. J'aimerai bien aller sur Matrix mais avec la même expérience et c'est pas si simple. Pas mal de possibilités et de tests."
Categories = ["irc", "matrix","weechat","tui"]
menu = "main"
notoc = true
WritingDate = 2021-01-16T23:45:29+01:00
date = 2021-01-22T22:45:29+01:00
title = "Accéder à Matrix depuis Weechat en 2020"
editor = "kakoune"
+++
J'ai déjà déclaré mon amour à IRC de nombreuses fois sur ce blog.
Mais je dois avouer que Matrix prend tellement d'ampleur que … bha … il faut y être aussi.

Et comme le dit si bien [XKCD](https://xkcd.com/1782/) je suis pas prêt à quitter mon client irc.
J'ai un peu expérimenté avec ~~Vector~~ ~~Riot~~ Element (pfiouu va faloir choisir à un moment donné) et c'est clairement pas ma tasse de thé.
*L'interface est énorme visuellement, c'est lourdeau, ça bouffe une quantité de ram impressionnante, faut prendre sa souris pour un oui ou pour un non… bref c'est trop kikoo moderne pour moi*.

Du coup j'ai à peine survolé vite fait la liste de [clients matrix](https://matrix.org/clients/) (c'est vraiment cool de la part de matrix d'en présenter comme ça sur leur site officiel).
Et j'ai pas trouvé de client qui me fasse vraiment rêver.
Il y a plein de clients natifs, dans pas mal de frameworks, dans plein de langages différents.

Bon par contre niveau client en TUI c'est bien plus rare.
On a [GoMuks](https://matrix.org/docs/projects/client/gomuks) et voilà.
C'est vite vu.

J'ai reluqué un peu et au final ça me branche moyen aussi comme client.
En fait avoir ça dans un soft séparé ça me fait chier.
J'ai déjà le meilleur client IRC du monde avec **weechat**.
*Pourquoi est-ce que je ne pourrai pas utiliser weechat pour Matrix ?*
Je n'en attends pas plus d'un client matrix.
Ne pas avoir d'image inline d'upload de fichier et tout, ça ne manque pas au final.
Et force est de constater que les quelques salons où je traîne utilise assez peu ces fonctionnalités.

Dans Matrix *je n'ai pas vraiment envie de corriger mes précédents messages, pas envie d'envoyer de photos, pas envie d'envoyer d'émojis…* bref je veux pouvoir faire de l'IRC.
C'est maintenant gravé en moi et il y a au final assez peu de chance que je change.

*Voyons donc les quelques possibilités afin d'accéder à Matrix depuis Weechat*.

## matrix.lua
Commencé au début de 2015, ce script en lua a été le premier permettant à Weechat de se connecter à Matrix.
Il marche vraiment pas mal mais a été abandonné début 2019.

Il est vraiment léger niveau fonctionnalité et ne gère pas le chiffrement donc de moins en moins compatible.

*En 2021 je ne recommande pas d'utiliser matrix.lua vu qu'il est abandonné et qu'il n'a pas de crypto ce qui entrave sa compatibilité.*

## matrix.py
Commencé au début de 2018 ce script en python est bien plus avancé et a été poursuivie son dev jusqu'à il y a peu.
Il a plus de fonctionnalité et notamment gère le chiffrement des rooms modernes.
Mais il est maintenant abandonné car l'architecture des scripts de weechat est trop limitante pour pouvoir aller plus loin.

Il est toutefois très utilisable.
D'ailleurs c'est le moyen le plus pratique pour se connecte à matrix depuis weechat.

*En 2021, bien qu'il soit abandonné, c'est bien matrix.py qui est le meilleur script pour weechat mais ça sera probablement pas valable très longtemps.*

## matrix.rs
Commencé fin 2019 ce plugin en rust souhaite prendre la relève et aller plus loin que ce que permettait le script python.
Il est initié par le même maindev que le script.

Il est pour l'instant légèrement fonctionnel mais c'est vraiment loin d'être fini pour le moment.
La dernière fois que j'ai testé, ça ne gardait pas les réglages en mémoire.
Ça a même planté.
Donc bon ça sera probablement bien mais pas maintenant.

Malheureusement le projet n'avance que très lentement.

*En 2021, matrix.rs n'est pas dans un état satisfaisant à moins d'être prêt à galérer un peu et ne pas avoir toutes les fonctionnalités que l'on trouve déjà dans matrix.py .*

--------
Bon puisque les scripts/plugins pour matrix sont moyennement satisfaisants comment faire ?

Hé bien une solution possible est un proxy matrix/irc.
En gros c'est un client matrix qui nécessite d'utiliser un client irc pour s'y connecter.

Ça pourrait le faire, hein ?

## matrix-ircd
Et bha voilà [**matrix-ircd**](https://github.com/matrix-org/matrix-ircd) !

Le bousin est écrit en rust a débuté fin 2016 et depuis ça n'est plus vraiment développé malheureusement.
Cela dit ça fonctionne mais c'est pas non plus la panacée.

Et du coup ça ne marche pas qu'avec weechat donc n'importe quel client irc pourra faire l'affaire.

-------

Pour le moment je vais rester sur le **matrix-ircd** mais faut avouer que ce n'est pas non plus une solution parfaite non plus.


