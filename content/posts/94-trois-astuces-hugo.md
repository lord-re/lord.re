+++
Author = "Lord"
Description = "3 astuces pour Hugo le générateur de site statique."
Categories = ["web", "hugo"]
menu = "main"
notoc = true
PublishDate = 2018-03-25T22:07:29+02:00
date = 2018-04-11T16:07:29+02:00
title = "Trois astuces pour Hugo"
editor = "kakoune"
+++
J'ai apporté encore quelques modifs sur mon thême Hugo (ouai j'en cause un peu trop souvent désolé mais ce coup-ci c'est plus une astuce qu'autre chose !).
Une des modifs récente est l'ajout d'un lien vers un article aléatoire.

Pas de bol cette fonction n'existe pas de base mais c'est assez facile à bricoler via les quelques fonctions internes d'Hugo.

J'ai aussi généré une page contenant absolument tous les articles à l'image de l'ancienne version du site.
C'est assez simple à faire.

Je publie désormais les brouillons des articles avant leur publication officielles mais je voulais les exclure du site pour pas que ce soit mélangé.

## Chopper un article aléatoire
Hugo possède de [nombreuses fonctions](https://gohugo.io/functions/) et surtout ces fonctions peuvent être chaînées à la manière du **|** dans le shell.

Du coup on va avoir besoin d'une fonction pour mélanger un array (un tableau) : *shuffle*.

Une fonction pour générer cet array à partir de critères définis : *where*.

Et une fonction pour chopper juste le premier élément de l'array : *range first*.

Le but exact de la fonction est de chopper tous les articles de la section "posts" dans la langue actuelle, les mélanger, extraire uniquement le premier.

```
{{ range first 1 (shuffle (where .Site.RegularPages "Section" "posts")) }} <a href="{{ .Permalink }}">{{ .Title }}</a>{{ end }}
```

La ptite astuce c'est que **range** est en fait une boucle qui doit donc être terminée par un **end** mais surtout qu'à l'intérieur le scope est définie par l'objet en question.
Ça veux dire que *.Permalink* et *.Title* sont donc propre à l'itération actuelle de la boucle.
Vous aurez donc bien le permalink et le titre de l'élément en cours de la boucle et non de l'article en cours de rédaction.

Voilà, maintenant vous aurez un lien aléatoire sur chacune de vos pages.

Par contre bien entendu ce lien changera à chaque nouvelle génération de votre site…

## Générer une page avec le contenu de tous les articles
Avant d'utiliser Hugo, j'étais sur une simple page web faite à la main avec absolument tous les articles.
Une seule grosse page.

J'aimais bien ce système pour pouvoir facilement rechercher un terme précis.
Du coup j'ai recréé ça sur Hugo.

C'est finalement assez simple puisqu'il suffira de définir une nouvelle section du site.

Donc on créer *layouts/mono* et dedans on y colle un un *list.html*.

Là le but est de mimer l'allure de la home page mais avec les articles en entiers.

Donc on copie-colles le *layouts/index.html* et on modifie **{{ .Summary }}** par un **{{ .Content }}**.
Bien entendu, on vire le ptit encart pour lire l'article entier.

Et hop [ça donne ça](https://lord.re/mono/).

## Publier ses brouillons sans interférer avec le reste du site

Depuis quelques temps maintenant j'ai décidé de rendre public les brouillons d'articles non finalisés.
Au lieu de traîner uniquement sur mon ordi, je me suis dit que ça pourrait éventuellement intéresser certaines personnes qui me font parfois des retours avant publication.

Donc pour ça on créer une nouvelle section avec un ptit **mkdir content/drafts** et dedans on y pose les brouillons.

Par contre, pas de bol quand on fait ça, les brouillons se retrouvent également dans la homepage ce qui n'est clairement pas désiré.
Du coup le but est de les exclure de la homepage.
Pour ça pas mal de solution possibles, perso j'ai opté pour l'arme lourde.

Premièrement j'ai créé une nouvelle variable dans *config.toml*

    [params]
      sectionsInHomepage = ["posts","fast-posts"]

Là on a donc défini quelles sections seront sur la homepage.

On édite maintenant le template des RSS pour ne pas y publier les brouillons : *layouts/_default/rss.xml* .
Il faut remplacer **{{ range .Data.Pages }}** par un **{{ range where .Data.Pages "Section" "in" .Site.Params.SectionsInHomepage }}** .

Voilà ça c'est bon, on fait la même modif sur *layouts/index.html* et ça devrait être bon.

Bon il ne reste plus qu'à affecter un template à nos drafts, j'ai juste copié celui de la section *posts* en rajoutant une petite phrase expliquant que ce sont des brouillons.

On obtient donc [une section drafts](https://lord.re/drafts/).


