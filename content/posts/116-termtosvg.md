+++
Author = "Lord"
Description = "Termtosvg est un outil pour enregistrer votre console pour produire un SVG."
Categories = ["cli", "linux"]
menu = "main"
notoc = true
PublishDate = 2018-07-15T22:36:48+02:00
date = 2018-07-15T22:36:48+02:00
title = "Termtosvg : capturer la cli dans un svg"
editor = "kakoune"
jdh = ""
+++

{{< figure src="/static/116-termtosvg.svgz" link="/static/116-termtosvg.svgz" title="L'article en cours de rédaction ~3min" alt="Capture faites lors de la rédaction de cet article ! Peut prendre un peu de temps pour charger." >}}

Voilà vous le voyez sous vos yeux ébahis : *Termtosvg* est un petit logiciel en python qui permet d'enregistrer ce qu'il se passe sur votre terminal et d'en faire un joli SVG.

SVG est un format graphique permettant de faire des images zoomables sans perte de qualité et "sélectionnables" car les données enregistrées ne sont pas des pixels mais des éléments graphiques définis de manière procédural.
Il est donc possible de sélectionner le texte du SVG pour faire un copie/coller.

Bref c'est un format bien comme tout, le seul soucis c'est qu'il a une légère tendance à rapidement devenir assez massif surtout quand c'est animé.
Par chance ça se compresse assez bien dans le format *gzip* ce qui devient donc un fichier .svgz qui est bien interprété par les navigateurs nativement.

Termtosvg est donc un excellent outil pour présenter voir faire des tutos de manips faites en console.
Je l'utiliserai probablement pour de futurs articles.

Bon par contre un petit point négatif, c'est que par défaut le navigateur n'essaie pas de décompresser les svgz s'il ne reçoit pas le bon *content-encoding*.
Vous me direz c'est tout justement à quoi sert le content-encoding.
Ouai mais malheureusement, dans mon cas, **nginx** et **hugo server** n'envoient pas le bon content-encoding pour svgz du coup j'ai pas de preview avec hugo.
Bon et j'ai dû faire une ptite modif à nginx pour qu'il envoie ce qu'il faut : 

    location ~ \.svgz$ { add_header Content-Encoding gzip; }

Bon c'est trois fois rien mais c'est dommage que ce soit pas par défaut…

Bon voilà.
C'est quand même pratique le rendu est propre (quelques ptits glitch mais ça devrait s'arranger, le projet est super jeune).

Par contre il n'y a pas moyen de contrôler l'animation (play/pause/barre de progression) ce qui peut être un poil gênant pour des animations un peu longue comme dans l'exemple.
Ptet qu'un jour les navigateurs ajouteront cette possibilité (rien à attendre à court terme).

Pour ceux intéressés sur le fonctionnement interne, dans sa série Github All Stars, [Artur Skowroński](https://medium.com/@ArturSkowronski) a détaillé la bête dans [cet article](https://medium.com/github-all-stars/github-all-stars-3-termtosvg-6ea433c702d3).

Bref vous le trouverez dans toutes les bonnes distros nunux ;-)
