+++
Author = "Lord"
Description = "Après tant d'années, voici enfin l'ouverture des commentaires sur mon blog."
Categories = ["meta", "communauté"]
menu = "main"
notoc = true
PublishDate = 2018-08-22T19:28:10+02:00
date = 2018-08-22T19:28:10+02:00
title = "Ouverture Des Commentaires"
editor = "kakoune"
TopWords = [  "lan", "commentaires", "isso"]
+++
Ceux qui lisent jusqu'en bas des articles ont dû voir que depuis hier, ça y est, il y a moyen de commenter.

J'ai donc installé une ptite instance [Isso](https://posativ.org/isso/) qui gère les commentaires.
C'est un système auto-hébergé en python qui stocke les commentaires dans une ptite base de donnée SQLite.

Ces commentaires ne sont donc pas stockés ailleurs que chez moi, **vous n'êtes pas plus traqués qu'avant**.
Ça repose bien entendu sur javascript, sans ça vous les verrez pas.

Les commentaires ne sont pas modérés à priori cela-dit, si du spam apparaît, je passerai en modération à priori ce qui nécessitera que je les valide un par un.

J'espère que ça insufflera un peu de vie et d'interaction.

## Comment ça a été mis en place ?
La doc sur le site d'Isso est plutôt claire et suffisante.

J'ai donc créé un user dédié, installé isso via pip, créé un ptit fichier de conf, créé un vhost avec son certif x509 pour TLS, ajouté deux lignes dans le template hugo pour avoir le html et le script js qui va bien.

Et voilà !
Et bha non.
Ça marchait pas.

Le souci vient du fait que Isso se protège en acceptant les commentaires que du site que vous définissez dans la config.
Or le site et isso se trouvent sur la même machine mais tous deux derrière un reverse proxy où se trouve du NAT.
Donc isso ne pouvait pas se connecter à https://lord.re/ nativement (via l'ip publique).

Il me manquait un peu de **Hairpinning** sur le routeur.
En gros dans mon LAN mes machines discutent entre elles avec des adresses *IP locales en 10.0.0.0/8*.
Par contre quand sur mon LAN je tente de me connecter à lord.re les machines tentent de se connecter à *92.167.84.9*.
Or, depuis mon LAN cette IP n'est pas renatté vers l'intérieur…
Un ptit coup de **<samp>/usr/bin/iptables -t nat -A POSTROUTING -s 10.0.0.0/8 -d 10.2.0.51 -p tcp --dport 443 -j MASQUERADE</samp>** et le tour est joué.
Tout mon LAN peut désormais accéder à https://lord.re sans recourir à du bidouillage dans */etc/hosts*.

Et là comme par miracle Isso a accepté de fonctionner.
Et du coup c'est *Arnauld* qui nous a gratifié d'un [premier commentaire](https://lord.re/posts/121-voyage-uk/#isso-1) :-).
