+++
Author = "Lord"
Description = "Pourquoi et comment jouer à Doom en 2017."
Categories = ["opensource", "jeux","fps","doom","mods"]
menu = "main"
notoc = true
PublishDate = 2017-12-22T11:44:50+01:00
date = 2017-12-22T11:44:50+01:00
title = "Doom et ses Mods"
+++

Voilà Noël approche et du coup probablement quelques jours de congé/wacances. Quel est le meilleur passe-temps en ces périodes de mièvreries et chansons ringardes ?

## Jouer à Doom en 2017

Doom a toujours été un jeu à part pour moi. Il y assurément une part de nostalgie car c'est l'un des plus anciens dont je me souvienne. J'y ai joué très jeune. Et je n'ai jamais cessé d'y revenir de temps à autre. Doom 1 et Doom 2. Jusqu'à il y a peu j'avais jamais fait les extensions officielles. Je n'avais non plus jamais été voir du côté de la scène des mods. Et OMG quelle erreur. Il y a une *cargaison énorme de contenu* fait par des fans. La qualité est variable mais l'avantage d'un jeu aussi populaire et aussi moddable, c'est qu'au bout de vingt ans on trouve beaucoup d'excellent contenu. Que ce soit des maps par-ci par-là ou bien carrément des TC (Total Conversion) ou des modifications plus subtiles.

Le jeu jouit d'une popularité certaine, d'une part pour ses qualités intrinsèches de jeu vidéo (*gameplay ultra nerveux, ambiance sympa, feeling addictif,…*), mais également pour son côté technique. À sa sortie le jeu était une claque graphique qui poursuivait la tradition naissante d'Id de faire des jeux techniquement à la pointe. Mais en plus de ça, ils ont libéré le code du moteur du jeu quelques années plus tard. Et ont toujours poussé le développement de mods.

*Quand on démarre Doom, on sait que dans les trente secondes qui suivent on sera dans la partie en train de s'amuser*. C'est un *plaisir instantané*, on se fait pas trop chier avec une histoire, des temps de chargements, des mécaniques de gameplay faussement poussées. Tout est fait pour s'amuser tout de suite. L'*action est frénétique* et le *feedback direct*. Avec l'âge j'ai de moins en moins de temps à consacrer aux jeux-vidéos du coup quand j'ai peu de temps j'aime pouvoir tout de suite me retrouver dans cet état d'esprit. Et avec l'opulence de contenu additionnel gratuit et de qualité c'est le summum.

{{< img src="*7-doom-0.jpg" title="Entrée de NERVE avec Project Brutality et l'UVD" alt="Entrée de NERVE avec Project Brutality et l'UVD" link="/static/67-doom-0.jpg" >}}

## Les moteurs
Le moteur ayant été opensourcé, il y a eu des tas de réimplémentations du moteur. Certaines plus poussées que d'autres. Quelques-unes en ont profité pour pousser de nouvelles fonctionnalités d'autres s'évertuent à rester le plus près possible du moteur d'origine s'amusant même à reproduire les bugs. Petit tour non exhaustif des moteurs libres existants :

 - [ZDoom](https://zdoom.org/index) et [GZDoom](https://zdoom.org/index) sont les moteurs les plus populaires. Le gros de la communauté s'est attroupé sur eux. GZDoom a poussé le moteur vers OpenGL (le moteur d'origine n'utilise que le cpu d'où le rendu particulier). Ils sont parmi les plus compatibles avec Doom et les mods de la communauté.

 - [Zandronum](https://zandronum.com/) est un fork de GZDoom (qui est aussi un fork de ZDoom) qui a poussé le côté multiplayer un peu plus que les autres. C'est le second plus populaire. De par sa popularité, sa compatibilité avec les mods est excellente (mais pas parfaite non plus). Je l'utilise de temps à autre pour le multiplayer.

 - [Doomsday Engine](http://dengine.net/) est un moteur un peu différent des autres. Il propose une interface toute mimi moderne bien foutue toussa. Après c'est pas spécialement ce que je recherche mais ça peut plaire.

 - [Chocolate Doom](https://www.chocolate-doom.org/wiki/index.php/Chocolate_Doom) est le moteur le plus proche de l'expérience originale. Perso ça ne m'intéresse pas spécialement mais si vous voulez une expérience des plus authentique c'est celui-là qu'il faut prendre.

Voilà pour le tour, j'ai principalement choisi GZDoom. J'aime le fait qu'il tente de moderniser le feeling sans pour autant révolutionner les graphismes. On retrouve une sensation de FPS moderne dans les déplacements : le strafe, la visée libre, c'est vif tout en ayant les bons vieux graphismes qui ont un charme certain.

{{< img src="*7-doom-1.jpg" title="Malmené par un Overlord dans le second niveau de NERVE" alt="Malmené par un Overlord dans le second niveau de NERVE" link="/static/67-doom-1.jpg" >}}
## Les WAD
Les WAD sont les fichiers que l'on donne à manger au moteur. Ils contiennent les assets du jeu, c'est à dire les textures, les sons, musiques, maps, campagne, ennemies, les armes… tout quoi. Il faut distinguer deux types de WAD : les IWAD et les PWAD.

  - Les ***IWAD*** sont autonomes. Ce sont les jeux complets comme Doom, Doom2, Heretic … La plupart ne sont pas opensource mais se trouvent pour une bouchée de pain sur GOG ou ailleurs. En libre vous trouverez [Freedoom](https://freedoom.github.io/) qui recréer des assets pour jouer librement avec un moteur libre.
  - Les ***PWAD*** sont des Patchs. Ils nécessitent l'utilisation d'un iwad pour fonctionner. Il peut s'agir d'une simple map, de musique ou d'une campagne complète voir une TC (total conversion). La communauté fait des miracles ici.

Il faut bien voir que l'on peut cumuler les pwad simultannément et que l'ordre de chargement a une importance.

{{< img src="*7-doom-2.jpg" title="Petit aperçu de la map Starport de HellBound" alt="Capture d'écran d'une partie de Doom sur la map17 du mod Hellbound" link="/static/67-doom-2.jpg" >}}

## Les mods intéressants
Un des plus populaire est le fameux [Brutal Doom](http://www.moddb.com/mods/brutal-doom) qui se charge de moderniser le gameplay et de rajouter des armes, des ennemis et même désormais une campagne super sympa. Le jeu devient plus nerveux et encore plus amusant. La version 21 est sur le point de sortir avec des ajouts de véhicules (oui oui !). Vu le nom vous devez un peu vous douter mais le mod se targue de proposer *un peu* de gore. Ça démembre, déchiquète, mutile à tour de bras. Vous pourrez même prendre possession d'un démon pour plus de fun… Ce mod a gagné de nombreux prix depuis des années, son auteur continue de pousser son bijoux depuis des années. Il s'attèle à des variantes telles que [Brutal Doom 64](http://www.moddb.com/mods/brutal-doom-64) et évoque un éventuel Brutal Hexen !

Un ptit nouveau pousse le concept de brutal doom encore plus loin : c'est le [Project Brutality](http://www.moddb.com/mods/brutal-doom/addons/project-brutality). Ils ont ajouté encore de nouvelles armes, la possibilité d'en avoir deux simultanées, quelques taunts supplémentaires. Des ennemis plus coriaces et variés (*mention spéciale* à l'imp qui peut désormais s'accrocher au plafond, c'est le must). Un système de progression dynamique dans les ennemis et les armes. Bref c'est Brutal Doom++. La version 3 est sur les rails, elle proposera visiblement sa campagne officielle.

Il existe des mods plus restreints ne cherchant qu'à modifier des détails plus petits. Par exemple [UDV](http://www.moddb.com/mods/brutal-doom/addons/doomvisor-hud-for-pa1nki113r-v51) est un mod qui change le HUD pour avoir un truc un peu moins moche. Il est adapté à brutal doom et project brutality pour afficher toutes les nouvelles armes et munitions. Je vous montrerai le résultat un peu plus bas :-) . Pour que ça fonctionne il faut penser à ne pas mettre l'affichage fullscreen (ingame pas la fenêtre elle-même).

Un peu de musique ? Ouai ! [Doom Metal Soundtrack vol 4](http://www.moddb.com/mods/brutal-doom/downloads/doom-metal-soundtrack-mod-volume-4). Des remix sympatoches des musiques originales.

{{< img src="*7-doom-3.jpg" title="Changement radical d'ambiance dans Pirate Doom" alt="Capture d'écran du mod Pirate Doom" link="/static/67-doom-3.jpg" >}}

### Les campagnes
Quelques campagnes plus ou moins sympa. Celles-ci sont jouables avec Brutal Doom ou Project Brutality ainsi qu'UVD.

[Hell on Earth Starter Pack](http://www.moddb.com/mods/recurring-nightmare/downloads/brutal-doom-hell-on-earth-starter-pack) est la campagne officielle de Brutal Doom. Il s'agit de map modernes qui se passent un peu sur terre un peu en enfer. Perso j'aime bien même si c'est globalement assez simple mais on retrouve des choses qu'on ne trouve pas ailleurs.

Ensuite il y a [No Rest for the Living](https://doomwiki.org/wiki/No_Rest_for_the_Living) aussi appelé **NERVE**. Ces maps sont super bien branlées avec des passages secrets et un level design particulièrement travaillé. Cette campagne est vendue avec Doom3 BFG edition. Cette campagne se fait assez rapidement mais dans la joie.

Une campagne faite par un amateur mais pourtant d'une excellente qualité : [Hellbound](http://www.moddb.com/mods/hellbound). Les maps ont été faites sur de très nombreuses années et n'ont pas forcément de continuité les unes entre les autres mais globalement ça se tient. On y retrouve des atmosphères assez différentes. J'ai adoré la map Starport.

Une campagne prometteuse mais pas terminée est [Don't Play With Hell - Black Edition](http://www.moddb.com/mods/dont-play-with-hell-black-edition). Seules quelques maps sont terminées mais WOW. Ce sont des maps modernes qui sont radicalement différentes de ce qu'on voit ailleurs. Les graphismes sont uniques : on retrouve énormément de plans inclinés (ce que le moteur d'origine ne sait pas faire) ce qui est surprenant pour un habitué de Doom. Je n'ai pas terminé la black edition qui se veux carrément un jeu complet en solo. Pour l'instant c'est vraiment sympa. Il y a un travail de scénario, de mise en scène vraiment poussé. Ça pourrait être Doom 3 mais en 1996. C'est plus lent que du Brutal Doom mais plus rapide que du Doom 3. Ils ont repris les *Glory Kills* du Doom 2016. Dans son genre c'est très probablement ce qui se fait de mieux.

### Les Total Conversion
On passe aux Total Conversion qui ne se jouent du coup pas avec Brutal Doom ni Project Brutality.

Sortez le rhum et choquez les balancines ! On va accoster sur [Pirate Doom](https://onemandoom.blogspot.fr/2013/12/pirate-doom-pirateswad.html). Bonne ambiance pour un mod qui commence comme une simple blague et qui se révèle étonnamment bon et dépaysant.

Votre ordinateur est tout juste assez puissant pour Doom mais pas assez pour Half Life ? Ça tombe bien Mr Freeman ! [Paranoid](https://www.doomworld.com/idgames/levels/doom2/Ports/p-r/paranoid) est fait pour vous. C'est tellement bien fait qu'on s'y croirait vraiment. Il faut s'y reprendre à deux fois pour voir la supercherie.

Dans un style encore complètement différent on a [Urban Brawl](http://action.mancubus.net/) qui vous balance dans une bande dessinée. Le cell shading est finalement plutôt bien adaptée. Le rendu graphique est plutôt surprenant. Il faut au moins [voir le rendu](https://www.youtube.com/watch?v=AwacI1bZD5U).

## Comment qu'on y joue ?
Allez vite fait un mini tuto. Le mieux c'est de commencer par vous procurer *doom2.wad* (trouvable sur [GoG](https://www.gog.com/game/doom_ii_final_doom) et souvent en promo à 5€ ou moins). Ensuite vous installez **GZDoom**. Selon votre distro la suite va différer : sous gentoo il va vous falloir poser vos wad dans */usr/share/doom-data* mais après c'est pas obligatoire.
Ensuite créez vous un script contenant la liste de vos wad à charger dans le bon ordre :
```
#! /bin/sh
/usr/bin/gzdoom \
	/usr/share/doom-data/Project\ Brutality\ 2.03.pk3 \
	/usr/share/doom-data/hud/UDV_v1.62_A_BASE_GZDoomOnly.pk3 \
	/usr/share/doom-data/hud/UDV_v1.62_B_ADD_IN_Mod_ProjectBrutality.pk3 \
	/usr/share/doom-data/DoomMetalVol3.wad \
	/usr/share/doom-data/DoomMetalVol4.wad \
	/usr/share/doom-data/NERVE.WAD
```
Et voilà, vous lancez et ça marche :-)

## Et après ?
Bha franchement vous pourriez vous pencher sur **Heretic** puis **Hexen** qui utilisent le même moteur (avec de légères modifs tout de même). C'est plus Heroic Fantasy mais ça reste des FPS vraiment agréables à jouer. Si vous êtes plus orienté action-rpg vous pouvez tenter **Strife** mais personnellement je n'ai pas ce jeu… Si vous n'en avez pas assez, vous trouverez de très nombreux WAD sur les Internets : fouillez du côté des [Cacowards](https://www.doomworld.com/cacowards/) qui chaque années célèbrent les meilleures créations de la communauté.
