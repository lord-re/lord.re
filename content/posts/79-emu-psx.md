+++
Author = "Lord"
Description = "J'en ai jamais parlé jusqu'à présent mais abordons un peu l'émulation et plus précisément la Playstation. Ces derniers temps les choses progressent pas mal dans ce domaine."
Categories = ["jeux", "émulation","playstation","retroarch"]
menu = "main"
notoc = true
draft = false
PublishDate = 2018-03-03T23:32:32+01:00
date = 2018-03-03T23:32:32+01:00
title = "Nouveautés dans l'émulation Playstation"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/swkj6o/avanc_es_r_centes_dans_l_mulation"
+++
La Playstation première du nom est l'une des quatre consoles de jeux vidéos que j'ai pratiqué à l'époque.

Pas mal de jeux m'ont marqués et c'est donc avec nostalgie que parfois je dégaine un émulateur pour y rejouer.

Pour les malheureux pas au courant, un émulateur est un logiciel mimant le fonctionnement d'une machine.
Un logiciel qui remplace donc une machine.

Un émulateur peut même se permettre le luxe d'améliorer l'expérience originale en ajoutant de nouvelles fonctionnalités.
On peut par exemple sauvegarder/charger à n'importe quel moment.
Jouer avec d'autres périphériques que ceux d'origines. 
On peut même parfois améliorer les graphismes.

C'est d'ailleurs ce point qui va m'intéresser ici car il y a du nouveau depuis peu de temps.

## Double coup de pied dans les madeleines (de Proust)

Quand vous déballerez pour la première fois votre émulateur pour rejouer à ce bon vieux jeu, vous allez vous prendre deux violents coups de pieds dans les madeleines.

Le premier en entendant le son caractéristique du bios affichant ce logo orangé de Sony.
Celui-là est agréable.

Le second va être bien moins agréable quand le jeu se lancera et que vous mesurerez *le décalage entre vos tendres souvenirs et … la bouillie de pixels dégueux de la réalité*.

Ouai la nostalgie améliore grandement les souvenirs.

Les graphismes playstation ont pris un sacré coup de vieux.
Les textures sont pas fines mais ça encore ça va.
Par contre vous allez vite remarquer que les textures bougent dans tous les sens bizarrement.
Et non ça ne vient pas de l'émulateur car la console originale avaient cette même tremblote.

Et puis de nombreux jeux ramaient sévères.

Et puis … wow ces pixels.
La console dans le meilleur des mondes peut sortir un maigre 640*480.
Et subir ça en 2018 c'est pas la joie.

## Émulons et/ou améliorons ?

Du coup il existe deux écoles dans le monde de l'émulation.

  - L'émulation la plus fidèle. En utilisant des émulateurs qui vont jusqu'à émuler chacun des composants de la console.
  - L'émulation haut niveau. Prêt à arrondir les angles et également à ajouter de nouveaux effets pour améliorer l'expérience.

Je suis plutôt du second bord. Je ne pense pas que moderniser techniquement les jeux les dénature dans la limite du raisonnable.
Donc voyons comment faire pour résoudre chacun des reproches que je fait.

Déjà pour les jeux Playstation le meilleur émulateur actuel est par chance un émulateur opensource rattaché au projet [Retroarch](http://retroarch.com/).
Il s'agit de **Beetle PSX HW** qui est un fork de [Mednafen](https://mednafen.github.io/) par Retroarch.
Retroarch est une collection d'émulateur avec une interface commune et toute une configuration commune fonctionnant via des *cores*.
Chaque core émule une machine et est soit fait par l'équipe de retroarch soit un émulateur opensource légèrement modifié pour s'intégrer à retroarch.

Dans notre cas Beetle PSX HW est un fork de fork.
Au départ il y avait *Mednafen* qui est un émulateur multi console opensource pas mal du tout mais sans interface.
Puis Retroarch et Mednafen ont collaborés pour pondre Beetle PSX qui est donc un core retroarch pour l'émulation de la playstation.
Et enfin un ultime fork a été créé pour rajouter le *HW* qui signifie Hardware.
C'est à dire que la partie graphique n'est plus calculée par votre CPU mais votre GPU qui est amplement plus adapté à cette tâche.
Ça permet de gagner en perf mais surtout de pouvoir jouer avec quelques raffinements bien sympatiques comme une bien meilleure résolution.

## Améliorons le rendu

{{< figure src="/static/79-cb-orig.jpg" title="On va passer de ça" alt="capture d'écran de Crash Bandicoot en résolution d'origigne" link="/static/79-cb-orig.jpg" >}}
{{< figure src="/static/79-cb-enhanced.jpg" title="À ça" alt="capture d'écran de Crash Bandicoot avec des graphismes améliorés" link="/static/79-cb-enhanced.jpg" >}}

Cet article n'est pas un tuto pour Retroarch mais juste une ptite aide pour trouver les bons réglages pour Beetle PSX HW.
Si vous ne savez pas comment modifier les réglages et tout [RTFM](https://docs.libretro.com/).

Toutes les options se trouvent dans le *Quick Menu* de Retroarch, une fois avoir démarré le jeu.

Premièrement, on augmente la **résolution** autant que faire se peut.
Si votre ordi est suffisamment puissant n'hésitez pas à faire monter à *8x* la résolution initiale.
Au delà je ne vois pas la différence mais vous pourrez dire aurevoir aux pixels disgrâcieux.

Ensuite on active le **PGXP**.
Cette option au nom barbare permet de corriger les approximations que fait la playstation pour afficher des textures sur des objets 3D.
Ça enlève l'effet dégueulasse des textures biscornues qui gigotte quand la caméra se déplace.
Cette option est assez intensive en ressource mais est un must.
Cette technique est relativement récente puisqu'elle a débarquée il y a près d'un an dans le monde de l'émulation playstation et apporte une sacré différence de rendu.
Donc on le passe en *memory+cpu* et on active les deux options qui vont avec.
On obtient un rendu proche de ce qu'on est habitué désormais.
Je vous ai fait un petit [avant](/static/79-ctr-nopgxp.jpg)/[après](/static/79-ctr-pgxp.jpg) pour bien voir la différence.
Admirez les lignes droites une fois activée.
Et c'est franchement plus flagrant en mouvement.

La prochaine option est l'**augmentation de couleurs**.
On passe donc les couleurs en mode *32bpp* et on passe le dithering pattern à *internal resolution*.
Avec ça les dégradés seront plus lissés.
Bon ça fait pas de miracle non plus, les textures d'origines ne seront pas modifiées pour autant.

D'ailleurs en parlant de texture, certaines personnes aiment les lisser via le **texture filtering** mais là c'est question de goût.
Personnelement je suis habitué au classique *bilinear* qui est un peu flou mais au moins ça ne modifie pas outre mesure le rendu.

La dernière option sympatoche mais non des moindres est toute neuve (une semaine, donc il vous faudra mettre le core beetle psx hw à jour et relancer retroarch) : le **GTE Overclock**.
GTE est le gpu de la psx.
Donc là ça va être quitte ou double : soit le jeu va s'emballer soit tout sera nickel mais avec plus de fps.
Certains jeux galèrent à pousser ne serait-ce que 20fps, là vous pourrez éventuellement en avoir 60 grâce à ça.
Chaque jeu nécessitera un réglage différent cela-dit.
Les jeux les plus tardifs sur la consoles généralement le gèrent mieux mais c'est tout de même au cas par cas. (Alien Resurrection fait des merveilles)
D'autres jeux par contre ont les FPS fixés à une certaine valeur (par exemple les Final Fantasy pendant les combats sont fixés à 15FPS) ce qui du coup n'aura aucune influence.


 

Voilà amusez-vous bien !

D'ailleurs si vous voulez tester quelques jeux sympas il y a les Crash Bandicoot, ainsi que le Crash Team Racing qui est toujours aussi agréable à jouer.
Wipeout 2097 est pas mal. In The Hunt pour shmupper à bord d'un sous-marin.
MDK est toujours aussi… étrange.
Herc's Adventure n'a pas trop mal vieilli.
Mais mon chouchou reste Final Fantasy 8.


