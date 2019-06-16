+++
Author = "Lord"
Description = "Vous l'avez probablement vu si vous venez sur le blog régulièrement, ces derniers temps j'ai fait quelques modifs sur le site. Voyons ça vite fait."
Categories = ["meta", "hugo"]
menu = "main"
notoc = true
PublishDate = 2019-06-16T15:13:35+02:00
date = 2019-06-16T15:13:35+02:00
title = "Modif du premier semestre 2019 sur le blog"
editor = "kakoune"
+++
En ce moment je m'amuse en modifiant un peu le site.
Rien de bien transcendant, hein.
Mais ça m'amuse quand même.

## Raffinage de l'esthétique

### Rayures
Déjà j'en avais un poil marre de l'aspect un peu trop lisse.
J'ai donc ajouté des rayures, de la texture sur quelques fonds.
Ça reste quand même assez léger mais au moins c'est moins insipide.

D'ailleurs les rayures de fond d'articles donnent une impression de 3D grâce à un très subtil dégradé.

### Lumières et bordures
J'ai un poil ajusté les bordures des articles en passant aux couleurs de type *hsl* pour la cohérence.
Hein !? Mais ça n'a aucun sens !

Jusqu'à présent j'utilisais des couleurs choppées au pif.
À la fois pour la couleur supérieure et sa version moins saturée (bordure du haut vs les trois autres bordures).

Les couleurs peuvent être représentées de plusieurs façons différentes en css.
Soit avec un *nom* comme <span style="color:orangered;">orangered</span>, soit avec une représentation *héxadécimale* comme <span style="color:#bad;">#bad</span>, soit avec la représentation *rgb* (red green blue) comme <span style="color:rgb(117,32,100);">rgb(117,32,100)</span> mais aussi en *hsl* qui représente hue saturation luminance comme <span style="color:hsl(54,58%,58%);">hsl(54,58%,58%)</span>.
Avec hsl, il est donc possible de choisir une teinte (hue) et ensuite de choisir son intensité et sa luminosité.
C'est donc beaucoup plus logique de choisir sa couleur principale et de la décliner en gardant la même teinte.
Et on peut donc avoir la même différence relative pour différentes couleurs très facilement sans avoir rien à calculer par cette représentation.

Bref je l'ai utilisé pour les quatre couleurs de type de postes.

<div class="posts" style="padding:1rem;">Les posts</div>
<div class="fast-posts" style="padding:1rem;">Les fast-posts</div>
<div class="shares" style="padding:1rem;">Les shares</div>
<div class="ideas" style="padding:1rem;">Les ideas</div>

Franchement je trouve ça joli toutes ces ptites couleurs !

## Blogrolls
J'ai déjà abordé plusieurs fois le sujet mais j'y retourne.
*Je pense qu'une forme de lutte contre les GAFAM est la production de contenu hors de leur emprise.*

Bon j'ai déjà écrit des bouts de tutos pour un peu toutes les étapes.
Mais maintenant vais aussi faire un peu de pub pour vos blogs avec un *blogroll*.

Sur la homepage, je vais afficher un certain nombre (pour l'instant je sais pas encore exactement combien, je vais voir à l'usage) d'extrait d'articles vers des blogs francophones pour en faire la pub.
Voilà voilà :-)

Pour le générer, j'utilise [Openring](https://git.sr.ht/~sircmpwn/openring) qui est écrit en Go et permet tout simplement de générer un ptit fichier html qu'il n'y a qu'à inclure.
Ça s'emboîte pas trop mal dans Hugo.
Ce logiciel est vraiment très récent, mais il fait déjà le boulot.

