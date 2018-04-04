+++
Author = "Lord"
Description = "Cloudflare a ouvert son résolveur DNS 1.1.1.1 mais cette adresse lui a été attribué dans un but de recherche."
Categories = ["dns", "réseau"]
menu = "main"
notoc = true
PublishDate = 2018-04-03T13:32:16+02:00
date = 2018-04-04T22:32:16+02:00
title = "Le deal derrière 1.1.1.1"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/tp6npn/le_deal_derri_re_1_1_1_1"
+++
Cloudflare a réussi sa communication concernant le lancement de son service de Résolveur DNS ouvert.
Ils proposent donc désormais aux Internets de récupérer les adresses IP associés à un nom de domaine.
Et c'est maintenant un jeu (limité à peu de joueurs) de proposer le service avec l'ip la plus simple : **1.1.1.1** .

Google propose son fameux **8.8.8.8** et IBM est récemment rentré dans la partie avec **9.9.9.9** .

## Les IP (Bén|Maud)ites

En étant aussi simples, ces IP valent une petite fortune.
Le résolveur DNS est le seul service que vous n'utilisez que via son adresse IP (forcément puisque c'est lui qui vous permet de vous en passer par la suite).

Bref disposer d'une adresse simple à retenir est la condition sine qua none pour être utilisé par tout le monde.
Même moi qui n'aime pas dépendre de Google, il m'arrive régulièrement de foutre leur DNS car je ne connait pas d'autres adresses de mémoire…

Mais le problème de ces adresses IP est que de nombreux appareils et autres réseaux ne sont pas configurés proprement et traitent ces IP de façon particulière.
Le service de Google est présent depuis quelques années déjà et a donc fait son trou.
Mais visiblement Cloudflare se heurte à pas mal d'étrangetés de la part des FAI et équipementiers à travers le monde mais tout ça était attendu.

## Le deal avec l'APNIC
Les fameuses adresses IP **1.1.1.1** et **1.0.0.1** appartiennent à l'[APNIC](https://fr.wikipedia.org/wiki/APNIC) qui est l'organisme attribuant les adresses IP et AS (on en discutera une prochaine fois) pour la zone Asie/Pacifique.
L'APNIC a donc consentie à céder ces adresses à Cloudflare à des fins de recherches.
En gros l'APNIC aimerait avoir une meilleure vision de la nature des requêtes DNS : est-ce que c'est un trafic réseaux plus pour des humains ou d'autres machines. ?
Est-ce qu'il y aurait moyen de détecter les attaques de grande envergure en amont ?

Initialement le bloc d'adresse 1.0.0.0/24 (ce qui veux dire toutes les adresses entre 1.0.0.0 et 1.0.0.255) ainsi que 1.1.1.0/24 (donc de 1.1.1.0 à 1.1.1.255) étaient uniquement à but de recherche.
Pendant des années le traffic y était étudié (parfois même conjointement avec Google) puisque ces adresses de part leur mnémotechnie facilitée étaient fortement sollicitées.

L'APNIC s'engage donc à être respectueux de la vie privée (privacy est quand même mieux comme terme m'enfin) et ne s'intéressera qu'aux statistiques et supprimera donc toutes les requêtes DNS une fois comptabilisées et les données ne seront pas revendues.
Bref on ne peut que les croire mais contrairement à pas mal d'entreprises, l'APNIC ne fait pas son beurre sur les données personnelles et est une organisation respectable (tout du moins pour l'instant).
On verra donc où mènera cette collaboration.

## Fun facts
Il y a plusieurs exemples de réseaux mal branlés ou juste squatteurs.

Hamachi a été un des plus gros à faire des saloperies.
Leur service de *vpn magique* n'était en fait qu'un squat de **5.0.0.0/8** sans ménagement.
Et un peu plus tard ils ont récidivé avec **25.0.0.0/8**.

Dans le genre truc bizarre il y a chez certains FAI US des routeurs qui étaient joignables via **1.1.1.1**.
Parceque c'est bien trop compliqué pour leurs clients d'entrer 192.168.1.1 … autant squatter une plage d'adresse IP publique.
Avant d'être attribuée cette adresse était ce que l'on apelle un [bogon](https://en.wikipedia.org/wiki/Bogon_filtering) mais ce n'est désormais plus le cas et du coup Comcast a dû modifier leur bousin.

Je savais pas trop où le mettre mais il y a une chose que vous devez savoir !
*Vous pouvez pinguer 1.0.0.1 en tappant uniquement* **ping 1.1** .
Et ça même sous windows !
Et d'ailleurs ça marche avec pleins d'autres.
À la maison mon lan est en *10.0.0.0/8* et du coup je peux **ping 10.254** pour pinguer 10.0.0.254 .




## Liens

  - [Annonce de la part de Cloudflare](https://blog.cloudflare.com/announcing-1111/)
  - [Annonce de la part de l'APNIC](https://labs.apnic.net/?p=1127)
