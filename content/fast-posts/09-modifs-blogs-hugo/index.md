+++
Author = "Lord"
Description = "Les modifs récentes et en cours sur le blog"
Categories = ["meta", "hugo","blog","git"]
menu = "fast"
noread = true
draft = false
notoc = true
PublishDate = 2018-02-11T10:34:48+01:00
date = 2018-02-11T10:34:48+01:00
title = "Méta-actu du blog"
TopWords = [  "blog", "hugo", "modifs", "post", "listes"]
+++
Bon bha voilà après deux mois je fais un petit retour sur les avancées du blog.

## Rythme
Je pense avoir réussi à prendre un bon rythme.
Ce n'est plus du tout un effort.
Ça me vient vraiment naturellement.
Je prends vraiment du plaisir à rédiger pour le site.

Distinguer les posts classiques et les fast-posts a été une bonne décision qui m'offre plus de spontanéité.

## Layout
J'ai un poil édité le layout du site.

Premièrement j'ai ajouté *la date de dernière modification d'un article* (s'il y a eu modif).
C'est manuel pour le moment mais peut-être qu'à terme je baserai ça sur la vraie date d'édition du fichier.

Ensuite j'ai *corrigé les couleurs des fast-posts dans les listes d'articles*.
Pour celles et ceux ne l'ayant pas remarqué (ouai vous les lecteurs de rss par exemple), les fasts-posts ont une teinte légèrement bleutée.
Hé bien cette teinte n'était pas appliquée dans les listes d'articles.

Les listes ?
Ouai c'était à moitié pété mais j'ai *réparé les listes*.
Quand vous cliquez sur les tags d'articles (genre meta, hugo, blog qu'on retrouve dans ce post), ça vous mène sur une page listant tous les articles de cette catégorie.
Et bha vous l'aviez probablement pas vu mais c'était pété et c'est réparé.
J'ai donc bidouillé mon thème hugo (ouai c'est pas forcément le meilleur endroit pour faire ça mais bon…).
Un jour viendra je publierai mon thème quelque part.

Après j'ai profité du fait que les catégories fonctionnent pour *rajouter des tags aux articles existants* histoire que la fonctionnalité ait un peu d'intérêt.

## CSS
Dans le registre de l'esthétique j'ai fait *quelques ajouts/modifs dans le CSS*.

Mis un peu de style dans la date de modifs des articles.

J'en ai profité également pour un peu *styliser les \<hr>* qui passent de l'immonde au passable.

J'ai *indenté les listes* qui ne l'était pas du tout et du coup dépassait légèrement sur la gauche.

J'ai également *centré les images* qui ne l'était pas et qui du coup dés-harmonisait le tout.

Et enfin j'ai *stylisé les \<table>* qui servira pour un très prochain article.

## Comment je m'y prends ?
J'ai *toujours un ou deux articles sous le coude* en attente de modifs avant de parution.

Ça me permet de *laisser quelques jours à froid l'article et d'y retourner avant de publier*.
J'ai du coup, à mon goût, une meilleure finition des articles.

Auparavant, je créais l'article et le publiais dans la foulée.
Et quelques heures/jours après je voulais toujours modifier des trucs bénins ou non.
*En laissant l'article en attente quelques jours et en m'y repenchant dessus avant de le publier, j'arrive à le relire.*
Ça me permet de voir tout plein de fautes et de tournures de phrases foireuses.

Je rajoute/enlève du contenu qui me convient que moyennement.
Et tout ça sans pénaliser le rythme de sortie, car je fait un roulement.
Bref c'est une ptite astuce qui améliore le contenu sans impact négatif.

## Et niveau outils ?
Bon comment se présente une séance de rédaction ?

  1. **cd ~/www** - c'est là où je stocke mes fichiers sources
  2. **hugo new posts/xx-titre-du-post.md** - pour créer le fichier avec les méta-données pré-remplies
  3. **amp** - pour démarrer [amp]({{< ref "/posts/72-amp-text-editor" >}}) et rajouter le texte
  4. **hugo server --navigateToChanged -F -D --disableFastRender** - en parallèle pour voir les modifs en live
  5. **git add content/posts/xx-titre-du-post.md** - pour ajouter le nouveau fichier dans le dépôt git du site
  6. **git commit !$ -m "[BLOG] ajout article xx titre du post"** - pour prendre en compte et mettre un commentaire dans le dépôt git
  7. **git push** - pour sauvegarder le dépôt et par la même occasion publier le site sur le serveur.

Il y a peu de manipulations et c'est assez rapide.

## Et si vous montiez votre blog ?
