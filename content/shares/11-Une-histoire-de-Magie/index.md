+++
Author = "Lord"
Description = "Une histoire de 'Magie' racontée par Eric S. Raymond raconte ses mésaventures avec un bouton magique sur un ordinateur PDP-10 au MIT dans les années 70/80."
Categories = ["humour", "web"]
menu = "main"
notoc = true
PublishDate = 2018-12-14T18:07:26+01:00
date = 2018-12-15T21:07:26+01:00
title = "Une histoire de 'Magie'"
editor = "kakoune"
+++
J'ai découvert il y a peu cette histoire que j'ai trouvé excellente et donc il me fallait vous la partager.

C'est une histoire parue dans le *Jargon File* de **Eric S. Raymond** où il raconte une mésaventure qu'il a vécue il y a quelques années.

## [L'original](http://catb.org/jargon/html/magic-story.html) - [cache local](original)

L'article est en anglais, mais je me risque à vous le traduire ;-)

------------------------------

## Une histoire de “Magie”

Il y a quelques années, j'étais en train d'observer les baies contenant le [PDP-10](https://en.wikipedia.org/wiki/PDP-10) du labo MIT AI et remarqua *un petit interrupteur collé sur l'une des parois de l'armoire*.
C'était évidemment un bricolage maison, ajouté par l'un des hackers (bidouilleurs) du labo (personne n'a su qui).

Biensûr, on ne touche pas un bouton d'un ordinateur sans savoir ce qu'il fait, cela pourrait crasher l'ordinateur.
L'étiquettage du bouton n'aidait pas vraiment à connaître sa fonction.
Il avait deux positions qui étaient marquées au crayon sur le corps en métal du bouton avec “magie” et “plus de magie”.
Le bouton était sur “plus de magie”.

J'ai appelé un autre hacker pour venir voir.
Il n'avait jamais remarqué ce bouton auparavant.
Après plus d'observation il s'est avéré que le bouton n'avait qu'un seul fil !
Le bout du fil disparaissait dans les entrailles de l'ordinateur, mais c'est un fait connu de tous les électriciens et électroniciens qu'un bouton ne peut fonctionner que s'il y a deux fils connectés.
*Ce bouton avait un fil connecté d'un côté et rien de l'autre.*

Il était évident que ce bouton était une blague stupide.
Convaincu que ce bouton ne servait à rien, on l'a actionné.
*L'ordinateur crasha instantanément.*

Imaginez notre surprise totale.
*Nous pensions à une pure coincidence* mais quoi qu'il en soit nous avons remis le bouton sur “plus de magie” avant de redémarrer la machine.

Un an plus tard, j'ai raconté cette histoire à un autre hacker, David Moon si je me souviens bien.
Il semblait clairement pas convaincu par les vertues magiques de ce bouton.
Pour lui prouver, je lui montrai le fameu interrupteur, toujours collé sur l'armoire avec un seul fil, toujours sur la position “plus de magie”.
On reluqua encore plus l'appareil pour se rendre compte que l'unique fil était raccordé à un plot de masse de l'ordinateur.
*Cet indice supplémentaire rendait le bouton doublement inutile : non seulement électriquement il ne peut pas fonctionner, mais il est raccordé à un endroit qui ne pourrait pas avoir d'incidence sur le fonctionnement de l'ordinateur.*
On a donc actionné le bouton.

*L'ordinateur planta instantanément.*

Ce coup-ci nous avons appelé Richard Greenblatt à la rescousse, un éminent hacker du MIT qui était non loin de là.
Il n'avait jamais remarqué ce bouton auparavant, lui non plus.
*Il l'inspecta avant de juger qu'il ne servait à rien et choisi de le retirer complètement.*
Nous avons ensuite relancé l'ordinateur et il a toujours fonctionné parfaitement depuis.

On ne sait toujours pas pourquoi ce bouton fait planter l'ordinateur.
On a émis une hypothèse comme quoi il s'agirait d'une microfuite de courant pendant un millionième de seconde qui modifierait une capacité électrique suffisante pour perturber la machine.
Mais nous ne saurons jamais la vérité.
Tout ce qu'on peut dire c'est que le bouton était **magique**.

J'ai toujours ce bouton dans mon grenier.
C'est peut-être idiot, mais je le garde toujours sur “plus de magie”.

1994 : une autre explication m'a été apportée.
Il faut préciser que le corps du bouton est en métal.
*Supposons que le côté non branché de l'interrupteur était reliée au corps du bouton (habituellement le corps est connecté à un connecteur de terre, bien qu'il existe des exceptions).*
Le corps du bouton est connecté à la carcasse de l'ordinateur, qui est en théorie à la masse.
*Maintenant la masse de l'ordinateur n'est pas nécessairement au même potentiel que la masse de la carcasse.*
Donc **en actionnant le bouton, la masse de l'ordinateur se retrouve connectée à la masse de la carcasse causant un chute/hausse de tension** ce qui redémarre la machine.
Cela a très probablement été découvert douloureusement cet écart de potentiel entre les deux masses qui a ensuite décidée de rajouter ce bouton pour faire une blague.


