+++
Author = "Lord"
Description = "Après beaucoup de proctrastination je me suis enfin décidé à me refaire une nouvelle favicon. Aurevoir le bitmap, bonjour le SVG avec animation !"
Categories = ["meta", "svg"]
menu = "main"
notoc = true
WritingDate = 2020-05-24T15:24:26+02:00
date = 2020-05-24T15:24:26+02:00
title = "SVG fait à la main"
editor = "kakoune"
TopWords = [  "forme", "rectangle", "rendu", "syntaxe", "coordonnées", "favicon", "svg"]
+++
*Je suis pas doué du tout en graphisme.*
Il y a fort longtemps, j'ai tâté du Photoshop, du 3D Studio Max (ça remonte à vraiment très longtemps).
J'ai vu un peu ce qu'on pouvait faire avec ces outils, vraiment des trucs ultras basique et voilà.

La dernière fois que j'ai pondu un truc graphique, c'était ma favicon dégueulasse il y a près de trois ans.
Et franchement c'était bien pourri.
Un bitmap de 32x32 où j'ai posé les pixels uns les uns après les autres.

## Pourquoi changer ?

{{< img src="favicon.ico" alt="la favicon avant les modifs est cadenas vert sur lequel est marqué TLS, c'est vraiment très mal fait" title="Pas besoin d'explication" >}}

La blagounette à l'époque était de faire une imitation pourrie de l'icône du cadenas vert d'une connexion sécurisée.
La blague de merde qui n'a amusé personne (pas même moi).
Et franchement la favicon je la vois jamais.
Enfin si, dans le lecteur de flux RSS (ouai je me suis abonné à moi-même dans l'espoir de voir apparaître un article que quelqu'un aurait eu l'amabilité de me rédiger.
Et en fait il y a un second endroit où je vois cette favicon, c'est lorsqu'un lien vers mon site est posté sur le Fediverse.
Là, ça pique les yeux parcequ'elle est postée en gros avec un upscale des plus baveux.
C'est ce qui m'a convaincu de m'y mettre.

## Une nouvelle piste
Ce matin j'ai donc entrepris de moderniser ça.
Un ptit tour sur [Can I Use](https://caniuse.com/#feat=link-icon-svg) histoire de s'assurer que le SVG passe bien.
Bon c'est possible pour 65% de la population, bien mais pas top.
Mais bon, au pire … bha ça s'affichera pas et puis voilà, c'est pas bien grave.

Bon, ensuite *que dessiner ?*
Rhaaa sacré question.
Et j'ai eu un peu de mal :

  - ~~Tux~~ compliqué à faire et puis un peu trop soupé de ce manchot
  - ~~Cadenas~~ j'ai déjà fait la blague
  - ~~Clavier~~ le format est trop petit pour un rendu satisfaisant
  - ~~Quad Damage~~ rhaaa c'est tentant quand même
  - ~~Terminal~~ c'est cliché, j'aime beaucoup, mais on en voit vraiment partout
  - RJ45 : enfin un connecteur femelle plus précisément !

Ouaip je me suis arrêté là en mixant avec un simili-prompt de shell.

Bon, faut choisir les couleurs… et galère !
J'ai *repioché dans la palette du site en appuyant un peu le violet et voilà*.

Bon, j'ai le motif en tête, la palette yapuka.

## Dessinner c'est pas gagné

J'ai maté déjà un peu des svg sur le ouaib de connecteur RJ45.
Il y en a des pas mal du tout, j'ai failli craquer mais je préfèrre que ce soit du fait maison.
Je suis donc allé faire un tour sur [un éditeur de SVG en ligne](https://vectorpaint.yaks.co.nz/).
J'ai fait un peu mumuse, c'est pas mal du tout.
*J'ai un rendu qui me satisfait pas mal*.

Je télécharge le SVG : BAM **8Ko** !
hmmm pour un truc aussi petit et vectoriel c'est le choc.
Je dégaine mon éditeur de texte et là, l'horreur, des lignes et des lignes de trucs dans tous les sens.
Je vais y faire le ménage.

## La perfection ne s'atteint lorsqu'on peut plus rien à jarter

Je commence à dégager une ligne, j'enregistre, j'affiche le résultat… rien ne change.
J'en regarde une autre qui semble assez pleine de vide, je la vire, j'enregistre je regarde… ça a la même gueule.
Je fais ça quelques fois et là je commence à virer des éléments importants, c'est pas cool.

Au bout de 5 minutes j'ai viré tout un tas de lignes superflues je suis plus qu'à 5Ko.
*J'ai presque perdu la moitié du poids du fichier sans que l'aspect visuel n'ait bougé d'un iota.*

Bon ensuite je remarque que les coordonnées des éléments visuels ont tout un tas de chiffres après leur virgule et franchement j'ai un peu dessiné à main levé, j'ai pas besoin d'une telle précision.
Du coup j'arrondis les coordonnées de partout et je gagne encore pas mal mais c'est toujours bien mastoc.

## À la main pour des formes simples
Finalement, en ayant un peu regardé la syntaxe que ça a, je me dis que je pourrai très probablement en réécrire une partie à la main directement pour gagner pas mal de place.
Je commence par indenter le fichier de partout et à bien séparer chaque élément sur sa propre ligne pour pouvoir bosser plus proprement.
Ensuite je commence par créer un premier rectangle pour dessiner les contacts du connecteurs.
La syntaxe est plutôt simple et logique, il s'agit de balise xml où l'on indique les coordonnées, la taille, la largeur, la couleur et voilà.
J'en fous 8 et c'est bon, j'incrémente juste la position en x et c'est torché.

Ensuite pour le texte, j'ai conservé ce qu'avait fait l'éditeur, j'ai viré deux trois attributs superflus.
J'ai rajouté un rectangle blanc pour le prompt.

Je m'attaque ensuite à la forme du connecteur.
Là la syntaxe est pas trop mal foutue non plus.
Il s'agit d'un élément **path** avec une couleur de fond et surtout le trajet.
On définit un point de départ avec <kbd>M XX,YY</kbd> avec XX et YY étant les coordonnées.
Jusque-là c'est facile, maintenant vu que c'est une forme super simple tout en angle droit, j'ai indiqué <kbd>v-300</kbd> pour indiquer qu'il faut se déplacer verticalement de -300, puis <kbd>h55</kbd> pour se déplacer horizontalement de 55…
Et on clôture la forme par <kbd>Z</kbd>.
C'est super simple et c'est assez compacte comme notation.

Bon, j'ai mon icône de terminée, je m'étais autorisé jusqu'à 2Ko et je suis bien en-dessous.
Du coup est-ce que je m'offrirais pas un ptit truc en plus ?

Allez, je vais tenter d'animer un peu le truc, j'aimerai faire clignotter le rectangle du prompt.
Après deux minutes de recherche sur le web, ça a l'air facile d'accès.
On rajoute un tag, deux attributs une ligne et hop c'est bon.
Adjugé vendu.

## Tadaaaaa !

Je passe le bousin dans [SVG OMG](https://jakearchibald.github.io/svgomg/) qui permet d'alléger le SVG en l'alterrant soit pas du tout soit suffisamment peu pour que ça soit très tolérable.
Je gagne encore quelques petits octets.

{{< img src="favicon.svg" alt="résultat final" title="Et voilà pour 796 octets (447 compressé) le rendu final" >}}

J'en suis super content.

C'était fun à faire, j'ai appris un peu mieux comment était foutu les SVG.
En plus c'est largement plus beau que mon truc précédent et ça reste joli à n'importe quelle taille.
