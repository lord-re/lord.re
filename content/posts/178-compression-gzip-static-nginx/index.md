+++
Author = "Lord"
Description = "Les sites statiques c'est cool c'est rapide et tout. Un truc classique pour améliorer la vitesse de transfert d'un site ouaib c'est de compresser les données (basique, hein). Voyons comment mettre ça intelligemment pour Hugo avec Nginx."
Categories = ["nginx", "hugo", "web"]
menu = "main"
notoc = true
PublishDate = 2019-08-15T22:16:24+02:00
date = 2019-08-27T22:16:24+02:00
title = "Compresser ses fichiers statiques pour son site ouaib"
editor = "kakoune"
TopWords = [  "compression", "gzip", "compresser", "nginx","blog","static","statique"]
+++
La mode actuelle des sites statiques n'est pas qu'une … heu … mode.
Les sites statiques ont en effet énormément d'avantages dont les excellentes performances.

Contrairement à un site dynamique qui va devoir générer la page à chaque fois qu'une personne la demande, le site statique, lui, aura généré toutes les pages en amont.
Le serveur web, n'a donc plus qu'à les envoyer et c'est tout.

*D'un point de vue performance c'est excellent* (et du coup c'est plus écolo, d'ailleurs) bref.
Il est assez courant de ne pas envoyer les pages brutes directement : elles sont souvent envoyées compressées histoire d'être moins gourmande en débit réseau.

## La compression sur le web
Le navigateur, lorsqu'il demande un document (une page, un fichier, une vidéo, un truc) envoie quelques informations supplémentaires avec sa demande.
Dans les entêtes de la requête, il indique quels sont les formats d'encodage qu'il sait gérer.
Par exemple mon navigateur indique <kbd>Accept-encoding: gzip, deflate, br</kbd>.
Ce qui signifie que les réponses peuvent être compressées selon les algorithmes **gzip**, **deflate** ou bien **brotli**.

*Ces systèmes de compression sont très efficaces pour les documents textuels* mais pour ce qui est images/vidéos/sons ça sert à peu près à rien (les données sont déjà compressées avec des algos largement plus efficaces).
Un site ouaib est très souvent rempli de texte même si on va pas se le cacher, c'est tous les média qui sont des centaines de fois plus gros que du texte.
Mais c'est pas pour autant que ça ne vaut pas le coup de compresser les textes.

*En compressant le texte de mon site, j'ai presque divisé par deux la taille de la page d'accueil puisque je n'ai quasiment pas d'images.*
Tous mes fichiers textes représentent environ 20Mo et après moulinette font un peu moins de 6Mo en brotli.
En sachant que ces fichiers seront envoyés en permanence aux clients, ça peut vous permettre d'économiser un tiers de votre bande passante mine de rien.

## Compression dynamique (à la volée)
Habituellement, après avoir configuré le serveur web, c'est lui qui se démerde à compresser les données à la volée et les envoyer.
*C'est bien mais pas top.*
Il va les compresser le moins possible (histoire d'être le plus rapide pour pas que les gens attendent) et le faire à chaque fois (bon en vrai j'imagine qu'il va les mettre un peu en cache pour pas le refaire à chaque fois mais bon.).

## Compression statique (à l'avance)
Une meilleure solution est de passer par un autre module de nginx qui permet de lui filer les fichiers originaux mais également les fichiers compressés à côtés.
Donc vous stockez votre *index.html* mais aussi *index.html.gz* et pourquoi pas *index.html.br*.
Et lorsqu'un navigateur annonce qu'il supporte par exemple le gzip, nginx lui servira le fichier gzippé plutôt que le non-compressé.

Pour activer ça dans **nginx** il vous faut avoir le module *gzip_static* et/ou *brotli_static*.
Pour vérifier lancez un simple **<kbd>nginx -V</kbd>** et vérifiez qu'il apparait bien dans la liste.
Ensuite dans votre conf nginx ajoutez juste un **<kbd>gzip_static on;</kbd>** et/ou **<kbd>brotli_static on;</kbd>**.
C'est tout.

Il ne vous reste qu'à compresser vos fichiers.
Vous pouvez vous le tapez à la main mais perso j'utilise un ptit outil fait pour **static-compress**.
C'est du rust donc c'est bien !
Ouai je suis hypé, désolé.
Pour l'installer c'est avec **<kbd>cargo install static-compress</kbd>** et voilà.

Maintenant il suffit de lancer un joli **<kbd>static-compress -c zopfli -e gz -j 16 "\*\*/\*.svg" "\*\*/\*.html" "\*\*/\*.csv" "\*\*/\*.css" "\*\*/\*.txt" "\*\*/\*.xml"</kbd>** .
À lancer dans votre dossier contenant votre site ouaib.
Il va le parcourir et compresser tous les fichiers avec les extensions données.
D'ailleurs en passant, zopfli c'est un chouilla mieux que gzip mais c'est compatible, donc à privilégier.

Et *si vous re-générez votre site, pensez à relancer la commande histoire qu'il recompresse tout*.
Perso, j'ai ajouté ça dans la liste des commandes de déploiement du site.
Je vous en parlerai un peu plus un de ces quatre.

-------
Cet article passede 14Ko à 4.9Ko.
