+++
Author = "Lord"
Description = "Quelques petits conseils en vrac pour améliorer l'accessibilité de votre site sans devoir tout révolutionner. Rien qu'avec ça vous améliorerez l'expérience utilisateur de tout le monde."
Categories = ["web", "ux", "www"]
menu = "main"
notoc = true
PublishDate = 2019-06-28T14:18:43+02:00
date = 2019-06-28T14:18:43+02:00
title = "Petit vrac pour améliorer l'accessibilité de votre site"
editor = "kakoune"
+++
Hey encore un post sur les modifs sur le site.
Ce coup-ci c'est un peu plus orienté accessibilité et potentiellement plus intéressant pour vous si vous avez également un site.

Allez voilà en vrac quelques modifs intéressantes.

## Indiquer la bonne langue
C'est tout con, on y pense pas trop, mais il faut indiquer la langue de votre document.
Ça généralement c'est fait à peu près partout mais une piqûre de rappel ne fait pas de mal.

Donc dans votre balise html globale, indiquez la langue de votre page.

{{< highlight "html" >}}
<html lang="fr">
{{< / highlight >}}

Mais au-delà de ça, pensez à l'indiquer également si vous avez des éléments dans une autre langue sur votre page.
Dans mon cas, j'indiquais que la page était disponible en anglais mais je n'avais pas mis l'attribut *lang* sur l'élément.
Ça peut paraître con, mais un lecteur d'écran sait changer d'accent et de prononciation en fonction de cet attribut ce qui améliore grandement le rendu.

Donc maintenant j'ai :
{{< highlight "html" >}}
<p lang="en"><a href="…"> Available in Frenglish : …</a></p>
{{< / highlight >}}

## Les Alt c'est bien mais pas trop
Bon j'imagine que vous êtes déjà bien au courant mais si vous avez des images dans votre page web, il faut mettre l'attribut *alt* avec une ptite description de l'image.
Bon par contre, si c'est une image uniquement décorative qui n'apporte pas de contenu vous pouvez zapper.

Bon celui-là est basique comme conseil mais je me suis fait avoir.
Dans la sidebar j'ai les ptites icônes sur lesquelles j'avais mis des *alt*.
Mais au final je les ai supprimé car c'était redondant avec l'attribut *title* qui se trouvent sur les liens.

Et ouai, quand vous avez une image dans un lien et que vous avez bien fait votre lien, abstenez vous de garnir l'image d'un alt redondant.

## Avoir du HTML valide
Ouai ouai c'est bateau mais ça arrive de plus en plus fréquemment de voir des sites testés pour Chrome et… c'est tout.
Même si ça représente la vaste majorité des utilisateurs, il faut penser à tous les autres.

Un lecteur d'écran sera probablement bien plus sensible à du HTML crasseu.
Franchement c'est pas dur d'avoir un truc valide donc faite le sans concession.

## Tester avec un navigateur texte
J'enfonce encore des portes ouvertes mais celui-là permet de vite "voir" quel est le rendu qui sera interprété par un lecteur d'écran.
Certains sites ne montrent pas leur contenu dans un ordre pertinent et utilisent du CSS pour rendre le truc plus cohérent et c'est une mauvaise pratique.
Bref, si votre site est facilement navigable dans un navigateur tel que **w3m**, **elinks**, **lynx** ça devrait le faire.

## Utiliser les balises sémantiques d'HTML5
Bon HTML5 n'est plus tout neuf désormais.
Pas mal de nouvelles balises sont apparues avec lui.

Elles n'ont pas de rôle technique à proprement parlé et s'utilisent comme un *div* mais leur intérêt est dans le sens qu'elles convoient.
Vous ~~pouvez~~devez utiliser *header*, *nav*, *aside*, *main*, *footer*, *article*, *section* et *form*.
Grâce à ça vous donnerez plus de sens à votre page.
Ça bénéficie à la fois aux humains mais également aux logiciels qui comprendront mieux votre page et sauront mieux la décortiquer (il paraît que ça influence le référencement Google).

Toutes ces nouvelles balises sont associées par défaut à des *roles aria* (des attributs html que l'on peut apposer manuellement afin de rendre sa page plus accessible).

## Skip to content
En plus d'utiliser les nouvelles balises sémantiques vous pouvez aider les utilisateurs de lecteurs d'écran en leur épargnant les parties redondantes de votre site en ajoutant un lien permettant de se rendre directement au vrai contenu de la page.

Un lecteur d'écran lit toute la page (très rapidement) dans l'ordre.
Les pages ont très majoritairement leur menu bannière et compagnie au début.
Les gens doivent donc se les coltiner à chaque changement de page ce qui doit être des plus agaçants.

Du coup, vous pouvez ajouter lien pour passer tout l'enrobage et vous rendre directement au contenu.
Et vous pouvez bien entendu rendre ce lien invisible via du CSS ou en utilisant la classe *sr-only* qui ne s'affiche que pour les *sr*, les screen readers.

## Les couleurs pour le contraste mais aussi la taille
Le choix des couleurs n'est pas complètement anodin.
Bien que l'esthétique soit la première considération il faut tout de même garder un truc lisible.
Il faut donc toujours un fort contraste.

Mais sachez que si le contraste de votre texte par rapport à son fond est un peu faible, vous pouvez également contrebalancer ça en augmentant la taille du texte.
Plus le texte est imposant plus son contraste peu être faible.

## Les styles sur les liens
Un truc un poil à la mode et pourtant emmerdant c'est de planquer les liens.
On a été très longtemps habitué aux liens écrit en bleu avec un souligné continu.

Bon c'est vrai que c'est moche.
Mais on peut styliser le truc de façon à ce que ça ressorte quand même.
Bref mettez toujours un signe distinctif comme du souligné, des tirets, des points, un truc quoi.

Et surtout ne vous amusez pas à virer le *outline*.
Ça permet de savoir quelle partie a actuellement le focus.
Et c'est surtout utile pour les personnes utilisant la navigation au clavier.

On peut même s'amuser en foutant une très légère animation un grossissement et tout mais ne le virez pas.

-------

Voilà, ça sera pas parfait mais ça sera surement plus agréable pour vos lecteurs.

Je tiens à remercier |Lupin| pour ses précieux conseils.
