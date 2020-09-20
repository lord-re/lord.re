+++
Author = "Lord"
Description = "Quelques errances mentales à propos des déplacements dans les jeux vidéos."
Categories = ["réflexions", "jeux"]
menu = "main"
WritingDate = 2020-08-18T21:58:29+02:00
date = 2020-09-17T13:58:29+02:00
title = "Les déplacements dans les jeux vidéos vol.1"
editor = "kakoune"
TopWords = [  "visée", "gameplay", "3d", "déplacements", "contexte","level design","game design", "fps", "jeux"]
+++
Je sais pas trop comment commencer mais voilà le truc.
Ça fait quelque temps que ce sujet me trotte dans l'esprit.
C'est pas un article avec une trame bien définie mais un ensemble de petites réflexions sur un sujet particulier : *Les déplacements dans les jeux vidéos*.

Ouai c'est con et surtout où je veux en venir ?
Et bhé vous verrez en lisant (haha pas de tl;dr) (en plus je sais pas non plus où je vais).
Le but n'est pas de faire un truc exhaustif mais de parler de l'impact que ce détail peu avoir et que justement *ce n'est pas juste un détail mais un point crucial dans bons nombres de jeux*.

## Intro
C'est parti !

Il existe tout un tas de jeux vidéos avec des formes différentes et ce, même dans une catégorie donnée.
Mais, on se retrouve souvent à incarner un personnage et que l'on ait à déplacer ce personnage.
Et ce, que ce soit un jeu de plateforme, un FPS un jeu d'énigmes ou de puzzles voir certains jeux de gestion ou de construction.

*Une grosse partie du feeling du jeu va donc passer par le déplacement de son personnage*.
Naïvement on pourrait penser que faire se déplacer un personnage est un problème simpliste, mais il n'en est rien.
Tout un tas de paramètres peuvent être pris en compte et paramétré selon les souhaits des devs :

  - Est-ce que le réaliste est voulu ?
  - Est-ce que le personnage a des facultés surnaturelles ?
  - Comment les collisions vont-elles être prises en compte ?
  - Est-ce que la nature de la surface du terrain va impacter les mouvements ?
  - Comment la gravité doit-elle être perçue ?
  - Quelle est la vitesse du jeu ?

Et tout un tas d'autres questions qui vont influer sur la façon de coder les déplacements.

*Les jeux vidéos sont en perpétuelles évolutions*.
C'est bête à dire mais il y a un effet de mode, mais aussi les progrès de la technique.
Ce média est encore jeune et est étroitement lié avec les progrès techniques de l'informatique.
Ce qui était impensable dix ans auparavant peut désormais être fait dans un jeu.

De ce fait, on peut remarquer une certaine évolution dans les façons de mouvoir les personnages :
Les jeux de plateformes tels que **Super Mario** permettaient un simple scrolling horizontal vers la gauche.
Le personnage subissait une gravité mais aussi une simple inertie qui font que lorsque le plombier est lancé à fond dans une direction il a besoin d'un court laps de temps pour pouvoir repartir dans le sens opposé.

C'était simpliste mais largement suffisant pour ajouter une pointe de fun et de challenge.
D'ailleurs pas mal de clones de l'époque se sont frottés au moustachu sans parvenir à reproduire exactement le même comportement.
L'inertie est un tout petit détail mais en la supprimant ou en changeant sa force, rend de fait le contrôle du personnage bien différent.

Et cette différence peut rendre le jeu bien moins agréable à jouer en le rendant bien plus difficile ou bien en supprimant l'once de challenge que ça apporte.
*L'équilibre du jeu peut s'effondrer juste sur ce détail*.

Avec l'arrivée de la 3D à la moitié des années 90, les jeux de plateformes ont dû se réinventer.
*Tout ce qui était acquis devait être revu*.

D'un point de vue gameplay, à la plateforme pure, on a rajouté de l'exploration plus ou moins poussée.
La gestion de la caméra a été une nouvelle difficulté pour les devs qui ont galéré pendant des années avant d'avoir quelque chose de potable dans à peu près tous les jeux.
Et bien entendu les déplacements ont dû également être retravaillé.

## Tomb Raider : C'ÉTAIT chouette

Ce jeu est sorti de nulle part en 96.
On se retrouvait à controler une héroïne (ce qui était très rare à l'époque) mais en plus c'était en 3D de partout.

À nous les joies d'explorer des caves, de se faire croquer les gigots par des loups ou des ours ou des … dinos ?!

Le jeu a fait sensation à l'époque.
Faut dire qu'on allait pouvoir explorer pas mal d'environnements différents avec tout un tas de secrets à découvrir.
Et puis c'était photo réaliste (keuf keuf) !

Les jeux 3D n'étaient pas encore la norme, surtout pour un jeu de plateforme (teinté d'un peu d'action).
*On avait pas encore eu beaucoup de jeux de la sorte à l'époque, les codes du genre n'étaient pas encore définis*.
Tout était à faire.

Les jeux en vue à la troisième personne n'était pas courant du tout.
Le choix de l'époque a été de partir sur des déplacements un peu particulier où **la pauvre Lara ne peut pas <abbr title="se déplacer de gauche à droite">strafer</abbr> mais seulement tourner sur elle-même**.
On va donc constamment se retrouver à arrêter notre course, tourner pour s'orienter comme désiré, puis repartir en courant.
Et *ça casse vachement le rythme et c'est ultra frustrant*.

Rejouer aujourd'hui aux premiers opus est une tannée.
Les niveaux ont été construits avec pas mal d'obstacles où il va falloir faire des sauts millimétrés avec la bonne orientation.
Ramasser un objet au sol nécessite un placement parfait au-dessus de l'objet.
*Le jeu est intransigeant* sur ce point.

Autant graphiquement le jeu a certe vieilli mais ça reste quand même très supportable.
Autant le maniement de l'héroïne est chiant au possible au point où il m'est impossible d'y rejouer maintenant.

## Grim Fandango : Effacer les déplacements lorsqu'ils n'ont pas lieu d'être

Parlons un peu de **Grim Fandango** : c'est un jeu d'aventure de chez <abbr title="Illustre studio désormais fermé ayant sorti de très nombreux jeux d'aventures">Lucas Arts</abbr>.
C'est le descendant direct des Point'n Click 2D.
Il est le tout premier du studio à amorcer le virage de la troisième dimension.

Dans ce jeu on incarne Manuel Calavera un agent de voyage du pays des morts qui va devoir résoudre des énigmes dans des tableaux fixes : l'environnement est une image fixe en 2D avec quelques éléments mobiles en 3D (les personnages et les objets).

Les devs ont fait le choix de proposer deux types de déplacements : *le contrôle absolu ou le relatif*.
Donc avec les flèches on dirige le personnage : *quand on appuie sur la touche droite, le personnage tourne sur lui-même vers la droite ou bien par rapport à l'écran tourne vers la droite*.
C'est tout.
On est donc assez proche de ce que propose **Tomb Raider**, sauf qu'ici l'environnement est en 2D avec des angles de caméra imposés généralement assez loin du personnage.

On a donc *l'impression de promener un tank* tout le long de l'aventure.
*C'est fastidieux, pas très précis et lourdingue.*
Heureusement le gameplay n'a pas d'exigence de timing ou autre, donc on est pas pressé.
D'ailleurs le placement de caméra étant imposé et fixe, ils ont été savamment foutus pour globalement réduire les difficultés de maniement du perso.

C'était clairement pas une super décision.
*Déplacer le personnage est assez chiant* on se retrouve souvent à tourner sur soi-même pour s'orienter comme il faut.
On est très souvent contre un mur/obstacle à tenter d'avancer en tournant jusqu'à ce que ça passe.
Passer une porte à coup sûr relève de l'exploit.

Alors que l'original est sorti comme ça en 1998, son remaster de 2015 est quasiment identique avec juste quelques menus améliorations graphiques mais surtout l'ajout d'un mode "point'n click" où avec sa souris on clique à un endroit et le personnage y va.
Il tourne, accélère, se place tout seul comme un grand.

Plus besoin de se faire chier au clavier.
Toute la lourdeur du système disparait.
*Cette idée que l'équipe de dev n'a pas eu en 98 parait si naturelle désormais.*

Le déplacement n'a aucun intêret sur le gameplay tout le jeu repose sur la résolution de ses puzzles.
La maîtrise du personnage n'a aucun intêret.
**Le remaster a donc dégagé tout ce point noir du jeu en l'automatisant complètement et hop le jeu n'en devient que plus intéressant.**

D'ailleurs il est toujours aussi chouette, allez-y c'est du bon.

## Half Life : Les interfaces physiques

Je me souviens encore de la sortie de **Half Life** premier du nom en 98 lui aussi (grosse année dis donc).
À sa sortie les FPS n'étaient pas encore le genre de jeu le plus populaire mais il a énormément participé à sa popularisation.

Les aficionados du genre avaient déjà traîné leurs guêtres sur **Wolfenstein 3D**, **Doom** ou bien **Duke Nukem 3D** (team ID ici ^__^ ).
Ces trois gros FPS étaient assez différents avec tout de même une sacré évolution à la fois technique mais aussi de gameplay.
Mais aucun de ces trois *ne permettaient de viser à la souris, tout devait se faire au clavier*.
*Pas de visée verticale* (encore que Duke Nukem permettait d'attribuer une touche pour pencher la vue mais c'était très facultatif) les tirs touchaient toute la colonne verticale de pixel (pratique (ou pas)).

**Quake** est arrivé en 1996 avec l'argument : ici c'est full 3D, fini les sprites.
Et surtout il proposait la visée à la souris.
Les ennemis en hauteur doivent être correctement visés maintenant.

Mais quoi qu'on en dise, le jeu n'a pas été le plus populaire pour autant.
Son environnement très sombre était pas super grand-public.
Et puis son mélange de Moyen âge/fantaisie/science-fiction était assez étrange surtout que l'absence de scénar ou de continuité entre ses épisodes (hérité de la vente en sharewares épisodiques) lui donne un aspect un peu déroutant.

Par contre quand deux ans plus tard **Half Life** sort c'est la folie.
Tout le monde se doit d'y jouer.
Il propose une expérience encore complètement inédite en étant un FPS pas vraiment bourrin : ici on éclate pas du cochon de l'espace à la sulfateuse par paquet de douze, pas de démon qui vous saute dessus constamment.

Ici, il y a une histoire qui se veut cohérente dans ses codes.
Avec une vraie progression et des niveaux qui ont du sens.
Ici les maps ne servent plus uniquement le gameplay mais racontent une histoire.

Bref je m'égare, mais on a donc tout un nouveau public prêt à jouer à son premier FPS.
En plus à cette époque les cartes graphiques commencent un peu à se démocratiser donc c'est l'occasion de jouer à un jeu 3D.
Les magazines parlent tous du jeu et proposent sa démo dans leur CD.
Et donc le débat de **« Comment jouer au jeu ? »** faisait rage.
Il y avait le camp des vieux de la vieille ne jouant qu'au clavier (je sais vraiment pas comment ils faisaient, ça me dépassait et ça continue encore).

Tout cela pour dire que *jouer au clavier pour les déplacements et utiliser la souris pour viser n'était pas si évident pour tout le monde*.
Bon cela dit, le débat n'a plus duré après ça.
Le multi-joueur sur ces FPS a prouvé à tout le monde la supériorité évidente de ces contrôles.

Je sais que l'article parle des déplacements et là je vous fait un paragraphe complet sur la visée.
Mais dans un FPS, la visée fait partie des déplacements puisque c'est elle qui va orienter le personnage et donc influer la direction du mouvement (ouaip vous m'avez poussé à me justifier, pas merci).

## Alien Resurrection : Le timing

Sorti en 2000, **Alien Resurrection** est un FPS à ambiance sorti sur la première Playstation.
Le jeu a été un bide, je ne vous le cache pas.

Déjà *il est sorti trois ans après le film qu'il devait accompagné*, déjà c'est pas terrible pour profiter de l'effet de la hype.

Pour un jeu Playstation 1 c'était pas moche du tout mais il faut se rappeler que la Playstation 2 venait tout juste de sortir (ou allait sortir selon les endroits) ce qui de suite est pas mal handicapant.
Le jeu était complètment dépassé techniquement comparé aux nouveautés de la Playstation 2.
Encore un problème de timing.

Le jeu est dur, sombre, joue beaucoup sur son ambiance plus que sur ses combats avec pas mal d'exploration.
Le problème c'est qu'en 2000 c'est juste pas la mode du tout.
Maintenant ce jeu aurait plus de succès d'ailleurs **Alien Isolation** est un digne descendant dans la même franchise.
Le jeu avait des qualités qui étaient perçues comme des défauts à l'époque.

Mais revenons un peu plus sur le thème de notre article.
Le jeu a voulu innover sur le maniement de son personnage.
Les FPS sur consoles étaient assez rares à l'époque.
Le **Goldeneye** de la nintendo 64 n'est sorti que trois ans auparavant et n'a pas encore eu le temps de lancer la mode.

La Playstation n'était pas vendu avec la manette Dual Shock mais avec une manette plus simple sans les sticks analogiques.
Bon, on était quand même en fin de vie de la console, on commençait quand même à trouver des Dual Shock mais c'était pas non plus la norme.
*Les devs ont tout de même pris le parti d'utiliser le stick gauche pour se déplacer et le stick droit pour orienter la vue.*
C'est en gros ce que font désormais tous les FPS consoles, c'est le standard classique que l'on retrouve partout (enfin si l'on accepte de se salir et de jouer à un FPS à la manette).
Le truc c'est qu'à l'époque ça ne s'était pas fait.
Le jeu a été pourri par la critique à cause (entre autre) de sa maniabilité à chier et trop déroutante.

*Le monde n'était pas prêt et ne savait pas contrôler un personnage de la sorte à cette époque.*

-------------

Bon c'était déjà bien assez long pour aujourd'hui.
La suite dans un futur épisode :-)
