+++
Author = "Lord"
date = "2015-12-28T14:36:41+02:00"
lastmod= "2018-02-11T14:36:41+02:00"
title = "Réimplémentations libres de moteurs de jeux"
menu = "main"
Categories = ["libre","software","linux","jeux","fps"]
Description = "Petite collection de jeux libres issus de jeux proprios. Des heures de glandage en perspectives."

+++

C'est nowel 2015. À nowel on a plein de temps. Quand on a plein de temps on aime se divertir. Et pour se divertir un bon petit jeu vidéo c'est royal. Les jeux vidéos c'était mieux avant. C'est vrai quoi. Les vieux jeux vidéos sont pour beaucoup mieux que les anciens. Ouai c'est un peu de nostalgie mêlé à de la vieuconnerie mais bon. Le soucis c'est que les vieux jeux, bha souvent ils ont besoin d'un viel OS avec de vieilles libs toussa. Par chance pas mal de devs sont confrontés à ce problème. Du coup pas mals de projets de moteurs libres fleurissent. Ils ont souvent besoin des assets originaux. Donc voilà un petit tour non exhaustifs de réimplémentatios de jeux libres. C'est parti !

## Bullfrog
Un de mes favoris : [**CorsixTX**](http://corsixth.com/) recrée Theme Hospital le jeu culte de chez feu Bullfrog.
Toujours chez Bullfrog, [**OpenDungeons**](https://opendungeons.github.io/) qui lui s'attèle à Dungeon Keeper.
J'avoue ne pas l'avoir testé.
J'attend qu'il mûrisse un peu plus.
J'ai également trouvé [**Swars**](http://swars.vexillium.org/) qui est un portage de Syndicate Wars (il existe aussi pour Syndicate mais n'y ayant jamais joué…).
Bref il ne manque que Theme Park et Magic Carpet et on aura fait le tour de la ludothèque de Bullfrog.

## Les jeux de gestion
De la même époque, [**OpenRCT2**](https://openrct2.org/) qui mime à la perfection Roller Coaster Tycoon 2 et propose des améliorations comme par exemple du multi-joueur !

Dans un genre assez proche, il y a le très connu [**OpenTTD**](https://www.openttd.org/en/) pour Transports Tycoon Deluxe. Il a su se créer une sacré communauté au point d'avoir suffisamment de main d'œuvre pour pouvoir recréer de nouveaux assets permettant de se passer du jeu originel.

[**Freeciv**](http://freeciv.org/) est l'un des pionniers de cette mode (et grand bien lui fasse).
Il existe même une version html5 jouable direct dans le browser.

Assez proche, on retrouve [**Freecol**](http://www.freecol.org/) mais il m'attire moyen celui-là.

Le bon vieux Caesar 3 a son ptit [**CaesarIA**](https://sourceforge.net/projects/opencaesar3/) qui a tenté un [crowdfunding pour créer de nouvaux assets](https://www.indiegogo.com/projects/caesaria-divide-et-empera#/) sans succès.

The Settlers 2 a aussi droit à son remake opensource : [**Return to the roots**](http://www.siedler25.org/) mais aussi [**Widelands**](https://wl.widelands.org/) qui est vachte bien!

Il sera bientôt possible de rejouer à SimCity 2000 grâce à [**OpenSC2K**](https://github.com/rage8885/OpenSC2K).
Ça sera de l'electron donc dispo sur tous les OS et ça bouffera tout plein de ram.

Sinon on trouve [**Lincity-NG**](https://github.com/lincity-ng/lincity-ng) avec ses assets dégueux et son interface à la sim city 3.
À faire en cas de grosse disette mais c'est tout.

## Du RPG
Commençons doucement par [**FLARE**](http://flarerpg.org/) qui à la base devait s'occupper de Diablo mais les avocats de chez Blizzard sont apparemment encore proche de leur licence.
Du coup bha Flare tente de faire un moteur pour ce genre de jeu sans toutefois mimer trait pour trait.

Par contre il existe [**Freeablo**](https://freeablo.org/).
Le dev commençait bien vite et fort et malheureusement ça patine un peu.
Dommage.

Toujours dans les RPG, on peut jouer à [**OpenMW**](http://openmw.org/en/) qui s'entête à refaire le bon vieux Morrowind.
Le projet est en super forme et commence même à proposer quelques améliorations par-ci par-là.

Les puristes des RPG pourront retâter *Baldur's Gate*, *Icewind Dale* et *Planescape: Torment* grâce à [**GemRB**](http://gemrb.org/wiki/doku.php?id=start).

Le malheureusement peu connu *Arx Fatalis* des français d'Arkane a aussi un tout nouveau moteur opensource : [**Arx Liberatis**](http://arx-libertatis.org/) créé grâce au généreux don d'Arkane ayant placé le moteur sous GPL3.
Il n'y a plus trop de mise à jour cela-dit, c'est dommage.

## Les FPS
Du côté des FPS de chez id, c'est un peu de la triche… Vu que les devs originaux publient les sources de leur moteur il y a foison de réimplémentations.
**GzDoom** est une réimplémentation en OpenGL du id tech1 donc tous les jeux à base du moteur de Doom mais il y a également **Zandronum** qui est sensiblement identique mais avec du multiplayer et également **Doomsday** qui mérite de s'y attarder.
Pour plus d'info à ce propos, j'ai écrit [un article dédié à Doom]({{< ref "posts/67-doom-et-ses-mods" >}})

**GlQuake** pour l'id tech 2 mais aussi [**DarkPlaces**](https://icculus.org/twilight/darkplaces/) pour les deux implé principales.

Ensuite pour l'id tech 3 ça sera principalement à base d'[**ioquake3**](http://ioquake3.org/) qui est utilisé par la plupart des jeux même si certains se basent encore sur le moteur originel.

L'id tech 4 est le dernier moteur opensourcé par id… il leur reste le 5 et peut-être un jour le 6 à ouvrir mais visiblement c'est plus dans les politiques de la maison.
Bref ce moteur a moins inspiré.
Il y a trois implés opensource [**iodoom3**](https://github.com/iodoom/iod3), [**dhewm3**](https://github.com/dhewm/dhewm3) et [**rbdoom-3-bfg**](https://github.com/RobertBeckebans/RBDOOM-3-BFG), dans l'ordre d'activité (du plus molasson au plus vivant).

Tiens avec le moteur de quake3 on a [**OpenMohaa**](http://openmohaa.sourceforge.net/) qui nous replonge dans le Medal Of Honor (vous savez, le jeu précurseur de CoD (les biens)).

Il n'y a pas qu'id dans la vie.
Le build engine avec son fameux Duke Nukem, Redneck Rampage ou bien Shadow Warrior a aussi droit de figurer ici avec [**JonoF**](http://www.jonof.id.au/jfsw) et [**Eduke32**](http://www.eduke32.com/).
Voilà, rien de plus à dire si ce n'est que ça a moins bien vieilli que Doom je trouve. (ouai je suis un fanboy)

Le bon vieux Thief a aussi droit à son [**OpenDarkEngine**](https://sourceforge.net/projects/opde/).

## Les RTS
Passons aux RTS.

Là on a le bon age of empire 2 qui a le droit à son [**OpenAge**](https://blog.openage.sft.mx/) mais pas de bol, avec Microsoft qui resort le jeu, j'ai peur qu'il y ait quelques soucis.

On peut également citer [**0AD**](https://play0ad.com/) qui s'apparente à un Age of Empire 3 sans toutefois vouloir l'être mais bon comme c'est le jeu libre/opensource avec les plus beaux assets je lui offre une petite place.
Il sort régulièrement des nouvelles versions et peut se targuer d'être l'un des jeux libres les plus aboutis techniquement proche d'un jeu commercial.

Et pour les afficionados de Westwood Studios il faut plutôt chauffer son clavier/souris vers [**OpenRA**](http://www.openra.net/) pour se refaire les *Command&Conquer*, *Red Alert* et *Dune 2000* (les meilleurs !).

## L'aventure
Les jeux d'aventure de Lucas Arts sont toujours aussi casse tête et sympa à jouer.
Pour ceux-là [**ScummVM**](https://www.scummvm.org/) fait des merveilles pour quasiment tous.
Et quand je dit tous, on pourrait dire tous les jeux d'aventure 2D et pas uniquement les Lucas Arts

Pour les jeux en 3D plus modernes il y a [**ResidualVM**](http://www.residualvm.org/) pour redire bonjour à ce cher Manny de *Grim Fandango* mais aussi *Escape from Monkey Island* et *Myst 3 Exile* (la thématique du voyage globalement).

[**Open Tomb**](http://opentomb.github.io/) permet de se refaire les cinq premiers Tomb Raider mais aussi [**OpenLara**](https://github.com/XProger/OpenLara).
Je les ai pas testé mais c'est pas très tentant à vraie dire même si OpenLara nous pond des graphismes améliorés pas trop dégueux.

## Les jeux de course
Pas trop de jeux de courses…
Ouai j'aime pas trop à vraie dire.
Mais bon il y en a quand même un qui a toujours une place dans mon cœur ... **Carmageddon**.
Bha il a le droit à un nouveau moteur opensource **OpenC1** mais le projet n'a pas trop abouti !

Il y a [une pétition pour ouvrir le code source de Wipeout 2097](https://www.ipetitions.com/petition/opensourcewipeout2097xl) mais avec seulement 11 gonzes dans le monde l'ayant signés...

[**Super Tux Kart**](https://supertuxkart.net/Main_Page) se démène pour fournir une alternative crédible à Mario et ses potes.
On y est pas encore totalement mais on sent que c'est déjà crédible et puis conduire son Tux est assez fun.

## Vrac !
Le ptit jeu sympatoche Chu Chu Rockets a inspiré des devs pour [**Duck Marines**](http://tangramgames.dk/games/duckmarines/).
[**Frets on Fire**](http://fretsonfire.sourceforge.net/) recréer les nombreux jeux de guitare ou bien [**Stepmania**](https://www.stepmania.com/) pour tous les beatmania.
C'est toujours sympa comme jeu mais difficile au début…

[**XoreOs**](https://xoreos.org/) s'attèle à faire une nouvelle implé de l'Aurora, un moteur pondu pour Bioware pour une palanquée de jeu.

L'indémodable [**Frozen Bubble**](http://frozen-bubble.org/) pour péter ces saloperies de boulettes multi-colores qui collent au plafond.

Dans les grands classiques il y *Worms* et du coup c'est [**Hedgewars**](http://www.hedgewars.org/) qui vous brouillera avec vos amis.

Pour les amateurs de *Super Monkey Ball* vous pourrez vous délecter de [**Neverball**](https://neverball.org/).

Le célèbre *Kerbal Space Program* inspire [**Open Space Program**](https://www.openspaceprogram.org/).
Bon pour l'instant rien à se mettre sous le mulot mais ça pourrait devenir très intéressant un de ces jours.

Je mettrai à jour cet article au fil des temps.
Reviendez !

## PS : Février 2018
Ajout de blabla et de mise en forme.
Lincity-ng, OpenSC2K, Frozen Bubble, Freecol, Hedgewars, Neverball, Open Space Program et Super Tux Kart

Globalement pas mal de projets dorment calmement.
