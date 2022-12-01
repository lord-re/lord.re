+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2022-11-01T16:36:51+01:00
date = 2022-12-01T16:36:51+01:00
editor = "kakoune"
title = "Récap 40 : Novembre 2022"
+++
La météo tient bon.
On a tout juste rallumé le chauffage en fin de mois soit près de trois semaines plus tard que l'an dernier…

J'ai eu le droit à deux semaines de congés pour glander à la maison.
Ça fait du bien une ptite pause dans le boulot.
J'en ai profité pour découvrir un peu **Blender** et franchement ça m'a bluffé.
Bon je connaissais déjà de loin, j'avais déjà taté du logiciel de modélisation il y a fort longtemps mais surtout de voir comment le truc tourne tellement bien sous nunux … wow.
Et puis cette UI c'est vraiment top.
Tout est configurable c'est globalement plutôt bien rangé et même techniquement l'UI peut scale super simplement, c'est léger, ça démarre instantannément.
Ptain mais c'est fait en quoi leur UI ?!
Pourquoi il n'y a pas plus de soft qui sont fait pareil ?

Bon j'ai beaucoup écrit ce mois-ci, non ?
Je ne pensais vraiment pas que ma ptite série d'articles sur les séjours des étudiants étrangers marcherait autant !
J'ai eu pleins de retours sur différents canaux, ça fait super plaisir !

J'ai eu trois jours où le domaine ne pointait plus vers l'adresse IPv4 (la v6 était toujours bonne) du coup ça m'a fait un ptit trou d'air dans les stats mais ça a été plus que compensé par l'afflux de visiteurs sur mon article concernant le Fediverse.

## Blog

En bref ce mois-ci : 8 articles, 34 commentaires, 11 visionnages, 629842 requêtes, 54940 visiteurs uniques pour 15.22 Go de trafic.

## Films
Un peu de films ce mois-ci mais pas trop.

Bon bha ce mois-ci le film qui m'a le plus marqué est **Weird : The Al Yankovic Story** parceque c'est un biopic délirant sur un artiste que j'aime beaucoup et qui sort du lot.

  - [ X]({{< ref "visionnages/x" >}})
  - [Pearl]({{< ref "visionnages/pearl" >}})
  - [Under The Skin]({{< ref "visionnages/under-the-skin" >}})
  - [Rambo 3]({{< ref "visionnages/rambo-3" >}})
  - [Warrior]({{< ref "visionnages/warrior" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Yojimbo]({{< ref "visionnages/yojimbo" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Trainspotting]({{< ref "visionnages/trainspotting" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Raging Bull]({{< ref "visionnages/raging-bull" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Weird : The Al Yankovic Story]({{< ref "visionnages/weird-:-the-al-yankovic-story" >}})
  - [Le Dîner De Cons]({{< ref "visionnages/le-dîner-de-cons" >}})
  - [Stalker]({{< ref "visionnages/stalker" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))

## Jeux
### Brotato
Ouai je l'ai continué et même fini avec tous les persos que propose le jeu actuellement.
Bon par contre je l'ai pas completé à fond.
Je serai vraiment motivé, je tenterai de finir en difficulté 5 avec chacun des persos mais … heu … dur.

### Dome Keeper
J'avais fait la démo quand le jeu n'était pas encore sorti et j'avais trouvé ça très intéressant.
En plus, tout comme **Brotato** c'est un jeu tournant sur le moteur Godot donc ça donne encore plus envie de soutenir.

Ici, c'est un jeu en deux phases : une phase plutôt relax où l'on creuse sous notre dome à la recherche de ressources et d'artefacts.
Votre foreuse et votre jetpack pourront être upgradés afin d'être plus efficaces.

La seconde phase est la vague d'attaque où la faune locale extérieure tentera d'attaquer votre dôme qu'il vous faudra férocement défendre sous peine de mourir.

Avec les ressources vous pourrez également améliorer votre dôme, ses armes, son bouclier, ses équipements…

Le principe est relativement simple mais ça marche vraiment bien.
Je trouve d'ailleurs qu'ils l'ont pas mal simplifié par rapport à la démo où survivre était vraiment difficile.

C'est joli, la musique est ptet un poil trop discrète mais c'est très agréable à jouer.
La phase d'exploration est particulièrement relaxante je trouve mais la phase de combat revient continuellement pour pimenter le tout.

## Musique
Le nouveau morceau de **Gorod** [The Orb](https://www.youtube.com/watch?v=A8SgAUGXXPo) est très chouette.
Il rapelle indéniablement *Transcendence* qui est à mon goût leur meilleur morceau.
Là, certains passages sont assez proches, on pourrait presque croire une suite.

C'est malheureusement pas aussi long mais au moins il y a un clip !
J'aime bien l'esthétique des lasers colorés.
Contrairement au cliché des années 80, ils sont ici bien fins et multicolores et ça rend bien mieux du coup.

## Nuxeries

### Pleroma
J'ai viandé mon instance Pleroma ; une sombre histoire de Postgres pas content.

Au début j'ai pensé que c'était juste un problème d'IO dû au serveur.
Je me suis donc monté un postgres à la maison sur une ptite machine, j'ai foutu un tunnel Wireguard vers l'instance Pleroma (comme ça pas besoin de me faire chier avec du TLS, des certifs à renouveler toussa).
Bref, ça a pas trop mal fonctionné même si ça représentait quand même pas mal de trafic réseau.

Ça a tenu quelques jours mais en fait j'avais encore des soucis de DB et tout.
Déjà la restauration du dump de la db a pris plus de 10h pour seulement 10Go de données…
Et après une fois restauré je n'avais plus de soucis d'IOwait mais par contre j'avais quand même tout un tas d'erreurs dans tous les sens et des perfs assez misérables.

Du coup j'ai choisi l'option nucléaire : la double migration.
Je migre mon compte sur une autre instance Pleroma qui m'accueille quelques jours.
Comme ça je ne perds pas (trop) d'abonnés/abonnements.

Ensuite je réinstalle de zéro un pleroma tout neuf avec une db vierge et je refais une migration dessus.
Pour l'instant j'en suis à la première migration.
Dans l'opération j'ai perdu ~150 abonnements (probablement des gens dont l'instance a disparu ou bien dont le compte est sur approbation manuelle des abonnements) et ~400 abonnés (des gens qui ont pas coché de s'abonner automatiquement lors des migrations de comptes ou bien qui utilise un serveur qui ne gère pas cela (misskey par exemple).

### DNS
Dans un tout autre domaine (huhu), j'ai viandé mon DNS (enfin partiellement).
Alpine a eu une update passant de la 3.16 à la 3.17.
Je l'ai donc faites sur plusieurs machines dont celle qui me sert à héberger mes noms de domaines.

Et bha je ne m'en suis pas rendu compte tout de suite mais bizarrement l'utilisation CPU a fortement augmenté ainsi que les IO.
Un ptit tour dans htop plus tard et c'est **Knot** qui fait le con.
Un tour dans ses logs et là c'est la folie : il signe ma zone puis il prévoit la prochaine signature dans "il y a une heure".
Du coup vu que le timer est dépassé, il signe la zone puis il prévoit la prochaine signature dans "il y a une heure" et c'est reparti !
Bref, il signe en boucle ce qui en plus provoque une augmentation du serial.

Bon j'ai inspecté ma conf, regardé dans le changelog et franchement je ne trouve rien de particulier.
J'ai donc cherché un endroit où pleurnicher et il s'avère qu'ils n'ont pas de salon IRC mais un salon Gitter qui est connectable depuis Matrix (vu que maintenant c'est la même entité) que j'ai donc pu rejoindre via mon bridge et donc m'y connecter depuis mon client irc (magic !).
Bref, j'arrive assez tard j'expose mes galères et en dix minutes je tombe sur l'un des devs qui commence à m'aiguiller pour tester des trucs.

Je vire des clés, je désactive la signature puis réactive, je redémarre mille fois, je fais un rollover, je change ma timezone.
Je fais un peu tout et n'importe quoi.
J'ai commencé à douter d'Alpine et j'ai donc installé Knot sur ma Gentoo, j'importe les fichiers et paf exactement le même souci.
Le problème ne vient pas **musl** comme je craignais.

Et puis je me suis demandé si mes autres zones n'allaient pas avoir le souci.
Donc j'importe une autre et là, rien, tout fonctione.

Et il s'avère que le souci provenait de ma zone plus précisément du **SOA** dont le TTL était trop grand.
En réduisant le TTL à une valeur plus classique d'un coup plus de problème.

Le souci n'était pas présent sur les anciennes versions.
Bref, 4h de tests en tout genre avant de finalement trouver la solution.

## Vidéos
Allez un clip encore mais comme je suis pas fan de la musique je le pose plutôt ici.
C'est le dernier de **Meshuggah** [They Move Below](https://www.youtube.com/watch?v=c6Q1v4zRt1w).

J'aime bien son aspect très dérangeant.
Il est réalisé à base d'IA avec des images en noir et blanc qui se complètent.
C'est très joli j'aime bien ce style qui devient de plus en plus courant.

Bon par contre la musique… bha c'est du Meshuggah quoi.

