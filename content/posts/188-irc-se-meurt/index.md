+++
Author = "Lord"
Description = "C'est triste mais l'activité sur IRC est en perte de vitesse. Je le constate sur différents réseaux et salons mais ces deux dernières années et particulièrement 2019."
Categories = ["irc", "communauté"]
menu = "main"
notoc = true
WritingDate = 2019-12-20T19:11:00+01:00
date = 2019-12-22T11:11:00+01:00
title = "IRC se meurt"
editor = "kakoune"
+++
Je suis **Team IRC** depuis très longtemps.

Ce protocole mais surtout son environnement me râvie.
C'est simple, sans artifice, c'est stable, ça n'évolue que très peu et lentement.
C'est rassurant, sans surprise, pas besoin de s'inscrire, l'ensemble de connaissances nécessaires est très restreint.
C'est un peu à l'opposé des alternatives modernes et même des réseaux sociaux sur le web.

Ici, quand tu veux discuter, tu t'installes un client irc, tu te connectes à un serveur et tu rejoins un salon de discussion et c'est bon.
Pas de création de compte, pas de profil à remplir, pas de mail à donner, rien.
Et c'est brut, pas de bouton, de vibration, de notification juste un peu de texte et hop.
Ça bouffe pas de CPU, ni de RAM, ni de réseau.

Par contre c'est vrai que si on est pas connecté on ne voit pas ce qui se raconte mais tant mieux, non ?
Et puis quand bien même, il existe des moyens d'être connecté constamment.

Bref, malgré tous ses avantages (tout du moins à mes yeux), force est de constater que la communauté s'étiole petit à petit.
Récemment Mozilla vient d'annoncer qu'ils migrent d'IRC vers Matrix.
Ils étaient parmi la plus grosse communauté à héberger un réseau IRC non généraliste.

Freenode qui est le des plus gros réseaux IRC vient de se faire acquérir (indirectement) par PIA et du coup on ne sait pas trop ce qu'il adviendra du réseau.
Bon je doute que Freenode disparaisse comme cela du jour au lendemain mais c'est tout de même peu rassurant.

## Des chiffres

On en discutait un peu sur #weechat-fr et j'ai eu l'idée de faire quelques stats sur mes logs de différents salons irc sur différents réseaux.
Voici le nombre de lignes par années : 


| salon         | 2014   | 2015   | 2016   | 2017   | 2018   | 2019   |
|:-------------:|:------:|:------:|:------:|:------:|:------:|:------:|
| #fdn          | 206300 | 149873 | 129766 | 100459 | 71664  | 72635  |
| #ffdn         | 139850 | 121075 | 89192  | 99414  | 83748  | 65050  |
| #troll        | 42253  | 30534  | 21081  | 11940  | 21363  | 31939  |
| #alacritty    |        |        |        | 23211  | 39571  | 61522  |
| #alpine-linux |        |        |        | 153916 | 146090 |150625  |
| #bepo         |        |        | 59545  | 24281  | 25212  | 30309  |
| #debianfr     |        | 80119  | 142313 | 141069 | 137146 | 55766  |
| #gentoofr     | 78229  | 61015  | 45535  | 49698  | 39227  | 30740  |
| #qutebrowser  |        |        |        | 129711 | 151354 | 110156 |
| #sway         |        |        | 29446  | 30329  | 78783  | 135948 |
| #weboob       | 54310  | 39988  | 37583  | 32532  | 29830  | 17496  |
| #weechat-fr   |        | 16957  | 14898  | 13437  | 15999  | 9586   |
| #iloth        | 79535  | 52060  | 22864  | 18593  | 16402  | 10391  |
| #online       |        |        | 235134 | 217374 | 140566 | 111832 |

On voit clairement que sauf exceptions, l'année 2019 marque une grosse perte de vitesse dans des communautés un peu variées.

## Pourquoi ?
Beaucoup de nouveaux compétiteurs ces dernières années.
**Slack** est arrivé et a bouffé beaucoup de part de marché auprès des entités corporates.

**Discord** a fait à peu près pareil auprès de la communauté des gamers.

**XMPP** a … heu … non.
C'est mort né, ça n'a jamais vraiment décollé (je sens venir des commentaires).

**Matrix** est le nouveau messi qui s'attèle à créer la plateforme ultime avec toutes les features, des bridges vers tous les autres réseaux.
Bref le fourre-tout un peu bricolé mais qui malheureusement est encore un peu jeune.
Tellement jeune, que je ne saurai dire si ses défauts actuels vont s'estomper ou s'ils vont s'affirmer.
C'est lourdingue, c'est décentralisé en théorie mais très centralisé en pratique ce qui induit des soucis techniques de performances mais également de résilience et de concentration.

Matrix est un peu à l'opposé d'IRC.
En voulant tout faire, on se retrouve avec des clients lourdingues mais pire encore, des serveurs ultra-lourdingues.
Derrière il y a une entreprise qui a commencé la définition de protocole et la création des premières implémentations et qui a mis un peu de temps à ouvrir le tout et on est toujours pas à l'abris d'un fork du protocole.

Toutes ces alternatives sont brillantes et tout, et l'écosystème de clients IRC a bien du mal à se moderniser.
C'est vrai que déballer un *hexchat* en 2019 c'est pas reluisant, ni même un *mIrc*.
Sans parler des clients irc en TUI comme *irssi* et *weechat*.

Ça manque de client tout joli avec les derniers frameworks à la mode, des icônes avec un style d'aujourd'hui, des réglages par défaut bien foutus, un ptit tuto au premier lancement, des serveurs préconfigurés.
Avec ça on rajoute des fonctionnalités modernes pour l'envoi d'image/vidéo (en feintant en uploadant ça vers un service externe et en ne postant que l'url), l'affichage inline de différents documents (prévisu d'image/vidéos/sons/tweets/…).
En normalisant la gestion des services dans le protocole (c'est déjà en cours de réflexion mais c'est pas prêt d'arriver) pour que la gestion de l'enregistrement de pseudo et de salon puisse avoir une interface graphique.

## N'est-il pas trop tard ?
Je ne sais pas.
Mais ce dont je suis sûr c'est qu'[IRC sera toujours là](https://xkcd.com/1782/) quand les autres plateformes se seront pétées la gueule.

C'est vrai quoi.
*Google Chat* est devenu *Google Talk* pour finalement se transformer en *Google Hangout* et est mort.
*MSN Messenger* a changé quinze fois de nom et est mort.
*Jabber* est devenu *XMPP* et vivotte toujours difficilement.
*ICQ* ne recherche plus grand monde.

Bref, tous les protocoles proprios (ouai je sais xmpp ne l'est pas) ont connu une mort plus ou moins douloureuse à terme.
Dès que la source de pognon se tarit le service est coupé et hop disparition, on fout une ptite obèle sur la page wikipedia correspondante et voilà.

De part sa simplicité mais aussi qu'il s'agit d'un protocole de l'Internet (il y a une RFC), IRC connaîtra des implémentations et des réseaux plus ou moins populaires pendant encore longtemps.

