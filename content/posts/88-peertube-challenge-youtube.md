+++
Author = "Lord"
Description = "La sortie prochaine de Peertube est enthousiasmante mais est-ce une alternative plausible à Youtube ? Malheureusement j'en doute."
Categories = ["réseau", "p2p","video","autohebergement"]
menu = "main"
notoc = true
title = "Peertube et l'impossible challenge de remplacer Youtube"
date = "2018-03-21T21:08:01+01:00"
PublishDate = "2018-03-22T19:00:00+01:00"
draft = "false"
editor = "kakoune"
jdh = ""
+++

Ça y est dans le cercle des libristes la nouvelle fait grand bruit ! 
Peertube débarque.
Tout du moins en beta.
Techniquement ça a l'air de fonctionner.
J'ai pu regarder quelques vidéos hébergées ça et là sur diverses instances.

**Peertube est donc une plateforme web de streaming de vidéo s'appuyant sur le p2p pour diffuser ses vidéos et sur la fédération de multiples instances.**
Un savant mélange de PopCorn Time et Mastodon.

## Quelques réticences sur la technique
J'ai peur que ça ne fonctionne pas en dehors du cercle restreint des libristes et ce serait vraiment dommage.
Peertube ne pourra pas concurrencer un site de vidéo grand public à mon avis.
En partie à cause des problèmes d'hébergement.

### La praticité de Youtube a mal habitué les gens

*Youtube représente bien les maux des Gafam : centralisation, enfermement dans une plateforme, espionnage constant, matraquage publicitaire, …* 
Mais Youtube s'appuie sur Google et son savoir-faire en matière de Web et aussi un portefeuille en forme de corne d'abondance.
La plupart des autres plateformes d'hébergement de vidéos sont à même de témoigner de la difficulté technique et financière que ça représente.

Youtube a habitué les gens à consommer de la vidéo en grande qualité, mauvaise qualité, sur mobile, sur ordi, sur téloche et sans attente (ou presque) …
Toituyau (Youtube) a aussi également habitué les gens à envoyer des vidéos sans se soucier de la durée, le format de l'image, le codec vidéo, le format de fichier ni même du framerate de leur production.
Sur ce point j'ai peur que Peertube ne se vautre.

**Comment se comportera Peertube ?**

*“ Veuillez envoyer votre vidéo en format désentrelacé en vp8, opus dans un webm avec un bitrate de moins de XMbps ? ”* et à ce compte on perd une bonne partie des petits créateurs qui veulent juste envoyer leur vidéos de ce qu'ils viennent de filmer avec leur téléphone.

Ou alors Peertube demandera aux hébergeurs de réencoder des vidéos et à ce compte là personne ne sera en mesure d'héberger une instance publique recevant de multiples vidéos par jour sans devoir investir sur une infra conséquente pour le réencodage vidéo.

### Youtube fonctionne grâce à une infrastructure démentielle

Concernant l'hébergement et la bande passante, comment ça va se passer ?

Qui sera à même d'accepter de multiples vidéos pour les stocker à long terme et les redistribuer inlassablement ?
*Le P2P c'est bien gentil mais il faut toujours au moins un seeder.*
Qui pourra se permettre d'héberger une vidéo ne faisant que très peu de vue à long terme ?
*Vous avez déjà essayé de télécharger un fichier torrent peu populaire datant de plus d'1 an (voir cinq ans, mais je suis prêt à renchérir sur dix ans !) ?*

Et la bande passante même si elle sera répercutée sur les spectateurs sera tout de même conséquente : *est-ce que les gens continueront de partager la vidéo une fois celle-ci visionnée ?*
Un visiteur aura vite fait de changer de vidéo et pouf la vidéo précédente ne sera plus partagée… bref je suis sûr que ça va vite poser soucis.

Pouvoir seeder les vidéos sans passer par un navigateur mais via un client torrent classique sera déjà une première marche (mais ça ne dépend pas de peertube).

Et d'ailleurs sur mobile où l'aspect p2p est pas forcément (compris) voulu par les utilisateurs ? 
Ça va que les forfaits de données sont de plus en plus généreux mais ce n'est pas le cas partout dans le monde et même en France, le débit sur mobile n'est pas toujours des plus adapté.
J'ai d'ailleurs testé sur l'[instance de Datagueule](https://peertube.datagueule.tv/videos/recently-added) en ouvrant la même vidéo avec mon téléphone en 4G et l'ordi en connexion filaire mais pas de bol, le lecteur vidéo est toujours resté à 1 peer sans aucun upload du coup j'ai pas vraiment pu tester plus que ça.

*Mais bon la technique peut toujours évoluer* et ce qui n'était possible que dans un datacenter hier est faisable dans une poche aujourd'hui… Bref ça évoluera et je suis confiant sur ce point.
Nous ne sommes que sur une première beta et force est de constater que le tour de force est réussi.


## Le soucis de l'effet de réseau

Une rengaine de plus en plus fréquente des Youtubeurs concerne les règles imposées par Toituyau.
Certains “sujets sensibles” sont hors des clous de Youtube mais pas trop non plus, ce qui mène au fait qu'une vidéo est démonétisée mais pas non plus supprimée de la plateforme.
*Du coup des Youtubeurs râlent.*

Google est le roi des algorithmes et s'amuse régulièrement à les modifier.
Ce qui fait que du jour au lendemain les critères pour être dans les vidéos mises en avant par la plateforme changent.
D'un coup d'un seul un créateur peut disparaître des radars.
*Du coup les Youtubeurs râlent.*

Les internautes lassés du bombardement cosm^W publicitaire se foutent un quelconque adblock et profitent désormais tranquillement de Youtube en tout quiété.
*Du coup des Youtubeurs râlent.*

Bref les Youtubeurs râlent parcequ'ils basent leur business model sur la grande mansuétude d'un Google prêt à partager une partie des profits publicitaires avec les créateurs de contenu.
**Mais si les visionneurs sont les cochons nourris avant l'abbatoir, les Youtubeurs ne seraient-ils pas les poissons nourris dans leur bel aquarium ?**
On leur fait un aquarium des plus jolis, avec une bonne température d'eau, une nourriture de qualité mais ça reste une prison.
Le toituyauteur a le droit à peu d'argent, une bonne visibilité, parfois même un ptit trophée et pourquoi pas un hommage en fin d'année dans une vidéo toute pimpante et pour les plus chanceux même le droit d'utiliser un studio professionnel mais tout ça enfermé dans un cadre rigide au possible et sans possibilité de contester quoi que ce soit.

*Les Youtubeurs profitent d'un service extrèmement coûteux.*
Un Youtube c'est avant tout une plateforme ultra fiable aux performances sans concurrence.
Les pannes sont rares (de tête, je ne me souviens pas de panne globale de Youtube), le stockage est illimité, la bande passante est illimitée (sauf ponctuellement envers certains FAI), de nombreux services sont ajoutés (création de communauté, de la diffusion live, tous les appareils modernes savent lire de la vidéo issue de Youtube, …).

Dans un monde sans GAFAM, ce service se paierai probablement très cher.

Et du coup revenons à ce sous-titre : l'effet réseau.
**Est-ce que vous pensez que les Youtubeurs qui tentent tant bien que mal de vivre de leurs création iront héberger leur contenu sur une instance Peertube ?**

Malheureusement j'en doute.
Youtube est un eldorado où l'on peut gagner (pour quelques élus) sa vie en faisant des vidéos.
Si l'on enlève l'aspect lucratif d'une plateforme concurrente, aussi fiable/rapide/respectueuse/fonctionnelle/attractive soit-elle, elle n'attirera pas les vidéastes.

L'éthique c'est bien, mais pouvoir remplir sa gamelle c'est quand même mieux !
Je ne les blâmerai pas sur ce point.

**Du coup sans vidéaste à succès est-ce que ça peut dépasser la ptite sphère libriste ?**
Mouai.

## I Want To Believe

En bref *la monétisation est à mon avis le point bloquant numéro un*.
Bon qu'est-ce qui pourrai changer la situation ?

Hmmm j'ai pas de solution.
Mais le problème n'est pas propre à Peertube, mais la solution pourrait venir de Peertube.
Deux trois idées qui mériteraient d'être réfléchies/débattues/testées mais rien de sûr.

### Une instance privée avec abonnement payant
J'imagine que ça pourrait être le cas.

Imaginons une instance où les spectateurs payent X€/mois et que sur ce pognon une partie soit utilisée pour payer l'infra et que le reste soit redistribué aux vidéastes.
Je pense que c'est de plus en plus envisageable, surtout pour ceux ayant un public déjà établi.

Twitch, montre que des gens sont prêt à payer pour du contenu "amateur".
Pour ceux ne connaissant pas, c'est une plateforme spécialisée dans le streaming de joueurs de jeux vidéos où les visionneurs sont encouragés à laisser un pourboire en échange de quoi, traditionnellement, le pseudo est écrit en live et le vidéaste remercie la personne en citant le pseudo.
*Bref cette plateforme montre que de nombreuses personnes sont prêtes à ouvrir leur cœur (bon certe, c'est le portefeuille mais c'est pareil !) pour remercier le boulot derrière une vidéo.*

Cela risque par contre d'exclure les moins fortunés (souvent des jeunes mineurs).
Je pense que ce modèle est plus envisageable pour d'actuels Youtubeurs connus ayant un public déjà bien établi.

Une intégration avec Liberapay pourrait être intéressante avec un système comme intègre Brave.
Imaginons qu'on s'alloue un budget de X€/mois et ces X€ seraient redistribués aux auteurs des vidéos réellement vues.

### Une instance publique financée par de la pub
**Ouai je pense que ça pourrait éventuellement marcher mais ne retomberai-t-on pas sur un clone de Youtube ?**

Un peu si, mais on peut imaginer un modèle plus éthique.

Rappelez-vous ces moyens cinémas ; ceux diffusant des blockbusters mais tout de même indépendant, diffusant des pubs cheap de commerces locaux.
Je vois bien un truc un peu similaire.
Une instance spécialisée au niveau d'une métropole par exemple.
Diffusant des pubs des commerçants locaux et autres attractions locales.
Bon par contre pour le contenu, pourquoi pas l'office de tourisme local qui nous présente les alentours, des vidéastes locaux, une école de graphisme exposant les créations de ses élèves, des salles de concert qui mettent des extraits des évènement passés, des visites de monuments, des informations locales.

*Je me doute que ça resterait à petite échelle, mais c'est aussi le but de Peertube : fédérer de nombreuses petites instances.*
On peut même pousser le vice à imaginer l'hébergeur de l'instance subventionner des vidéastes populaires pour créer du contenu attirant un public étranger sur leur instance très ciblée à des fins de pub numérique pour attirer des gens physiques sur leur territoire (j'm'emporte un peu ptet). 

Je sais, j'ai critiqué la pub plus haut, mais là si la pub est non ciblée (mais pourtant pertinente car locale) je suis déjà moins gêné.

C'est plus du sponsoring que de la pub pure.

### Une instance publique avec envoi payant
Imaginons une instance où regarder serait gratuit mais envoyer une vidéo (pour profiter du service d'hébergement et publication du contenu) soit payant.

Hmmm ça risque d'être dur.
Très dur.

Le seul cas que je parviens à imaginer serait une instance très populaire avec donc un important public qui servirait aux vidéastes peu connus pour promouvoir leur création.
Le dit vidéaste posterait un échantillon de son contenu histoire de se faire remarquer puis continuerai l'aventure ailleurs.

C'est tordu mais pourquoi pas ? Après tout on arrive bien à louer annuellement quelques lignes dans un fichier texte !

### Une instance publique qui rémunère chaque envoi de vidéo
Si c'est pas un tiers qui apporte le pognon (la pub), ni le spectateur, ni le créateur, il ne reste plus que l'hébergeur.

Bon bha voilà la blague est faite.

Alors là même mon imagination me fait défaut…

## Et la conclusion ?

Bha j'en ai pas !
À l'avenir on verra bien ce qu'il va se passer.

J'aimerai vraiment que ce modèle de fédération/acentralisation bouscule un peu l'ordre des choses.
Peertube en l'état montre que techniquement c'est faisable (fait).

Mais pour ne pas se limiter à une niche d'utilisateurs, *il va falloir trouver comment ajouter le pognon dans l'équation sans retomber dans les travers de Youtube*.

Voilà voilà.

Tiens j'ai repéré [l'instance de Thinkerview](https://thinkerview.video/videos/local) et aussi [le cygne noir](https://videos.lecygnenoir.info/videos/local) si vous en avez d'autres sympatoches…
