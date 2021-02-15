+++
Author = "Lord"
Description = "J'ai eu envie d'un peu de changement concernant la homepage. Du coup voilà que ce weekend je me suis repaluché les templates hugo et le css."
Categories = ["meta", "hugo","css"]
menu = "main"
notoc = true
WritingDate = 2021-02-15T16:51:51+01:00
date = 2021-02-15T16:51:51+01:00
title = "Refont de la Homepage"
editor = "kakoune"
TopWords=["hugo","template","css","grid","flexbox","archives","homepage","pagination"]
+++
Hey ça faisait longtemps que j'avais pas trifouillé mon site (non) du coup voilà c'est fait !

Je commençais à me lasser un peu de la page d'accueil.
Les grosses boites colorées c'est cool mais … qu'est-ce que ça prend comme place !

J'avais dans l'idée d'adopter un design plus léger visuellement mais je crois qu'au final j'ai dévié.
En gros ça s'est fait en deux étapes :

## Pagination : OUTTTO
La pagination c'est le truc basique.
Sauf que je commence à avoir un peu trop de contenu et donc j'en étais arrivé à 27 pages.
Bien plus que de doigts et d'orteils du coup ça devient vraiment pas pratique à utiliser.

En plus un des problèmes de la pagination c'est que ce qui est aujourd'hui en page 2 (ou 17, hein, c'est qu'un chiffre pour l'exemple) demain ne le sera plus mais se retrouvera en page 6 (ou 17, c'est aussi un chiffre pour l'exemple). Du coup c'est au final vraiment pas pratique.

J'ai donc eu dans l'idée de dégager la pagination et avoir une seule longue page (comme d'antan) et/ou comme sur la capsule gemini de [mon glog](gemini://lord.re). 

En cherchant un peu sur le web j'ai trouvé un ptit moyen simple dans un template Hugo pour classer par date et en groupant par année.
Et c'est franchement pas mal du tout comme rendu.

Ni une ni deux je poste une première ébauche sur le Fédiverse et j'ai quelques retours variés.
Et surtout le cher Chagratt qui m'a complètement perturbé (et je crois qu'il s'est aussi perturbé puisqu'il a commis [un article également](https://bwog-notes.chagratt.site/2021/au-revoir-la-pagination/) (il a dégainé le premier !).

Il m'a tooté que ce serait pas mal de n'afficher qu'un nombre limité d'article sur la homepage mais de rajouter d'autres infos/liens dessus.
Et là je me suis dit banco !

En plus c'est vrai que la homepage avec absolument tous les articles ça fait une page avec un poids assez conséquent qui m'aurait exclu du club des 512KB (non j'ai pas postulé mais je pourrai, mais je ne l'ai pas fait même si je suis encore dans les clous).

## Archives
Du coup, je conserve l'idée de la page avec absolument tous les articles listés et je nomme ça [les archives]({{< ref "archives" >}}).

Chaque post a donc la couleur de sa catégorie, la catégorie, un ptit ❖ que l'on peut survoler pour avoir le ptit résumé de l'article (easter egg), la date, le temps de lecture puis les tags.
Ça me semble assez léger, l'affichage est assez clair.

En plus comme c'est groupé par année c'est légèrement plus lisible.

Et ce bout de template je vais le piquer pour en mettre un pout sur la home.

## Sur la Home

### Intro
Sur la Home j'ai donc mis un ptit speech de présentation (rhaaa ce que c'est dur à écrire et j'arrive jamais à obtenir un résultat qui me satisfasse.
Je trouve ça limite cringe.
Je suis trop nul en introspection pour ça.

### Les derniers posts
Ensuite je fous les derniers posts avec la même présentation que sur les archives.
C'est assez concis et tout.

Un lien vers les archives et une icône de RSS.

### Toujours plus
Là j'ai foutu une explication des différentes catégories.
À chaque fois c'est cliquable pour n'avoir que ça, un lien vers le RSS également.

Là j'avoue m'être fait plaisir à faire un peu de flexbox pour les boiboites.
Du coup ça se range un peu comme elles peuvent et ça rend pas si mal.
Le seul inconvénient c'est que ça ne peut pas resize plus petit que la largeur d'une boite.
Mais franchement si un appareil ne peut pas en afficher une seule en largeur ça fait extrèmement petit.

### Foutoir
Ici je guide un peu plus les lecteurs vers les différentes entrées du header.
C'est vrai que c'était pas spécialement clair juste les icônes dans la barre de navigation donc là ça permet d'expliciter un peu plus.

En ayant en plus gardé l'icône et le texte coloré ça donne moins l'effet d'un mur de texte infranchissable (contrairement au speech d'intro).

## Visionnages
J'ai aussi un peu rangé la section visionnages.
J'y ait mis mon [Marathon Stephen King]({{< ref "visionnages/stephking" >}}) ainsi que [le marathon TOP 250 IMDB]({{< ref "visionnages/topimdb" >}}).

J'ai également mis un lien pour la section par année même si il est vrai que classer en vrac comme ça, ça n'a que peu d'intéret.

## Moralité
CSS Grid c'est franchement chouette quand on prend le temps de s'en servir comme il faut.
Le design reste responsive assez simplement.

En l'utilisant conjointement avec flexbox on peut faire à peu près tout ce qu'on veut beaucoup plus simplement qu'avant.

Bon j'ai quand même galeré un peu en tatônnant dans tous les sens mais j'ai fini par obtenir le résultat que j'avais en tête.

Les templates Hugo c'est vraiment chouette et pas si compliqué.
Quatre ans plus tard je suis toujours convaincu d'avoir fait le bon choix.

L'allure me convient bien mieux.
Je ne sais pas ce que vous en pensez mais je trouve ça plus sympas qu'avant.

Il me reste juste à trouver une solution pour l'intro.

{{< img src="new_home.png" alt="capture d'écran de la page d'accueil" title="Alors Alors ?" >}}
