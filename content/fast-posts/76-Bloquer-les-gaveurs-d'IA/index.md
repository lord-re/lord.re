+++
Author = "Lord"
Description = ""
Categories = ["meta", "web","scraping","nginx"]
menu = "main"
notoc = true
WritingDate = 2024-04-15T15:21:14+02:00
date = 2024-04-15T15:21:14+02:00
title = "Bloquer les gaveurs d'IA"
editor = "helix"
Audio = ""
Soustitre = ""
+++
Vous avez un joli site ouaib avec vorte ptit contenu écrit main.
C'est votre blog, votre espace de réflexion, votre zone de création, votre espace rien qu'à vous partagé au monde, votre rejeton…
C'est super chouette mais bon maintenant en 2024, ça veut dire que vous nourissez les IA.

**ChatGPT**, **Claude**, **Mistral** et sont des modêles d'IA qui ont besoin d'être nourris.
Pour qu'une IA paraisse performante et naturelle, il faut lui faire ingérer le plus de textes possibles.
Et vous pensez bien que le web étant par nature majoritairement du texte et ouvert, toutes les entreprises du secteur en profitent pour scraper (parcourir, lire et intégrer) le web constamment histoire de parfaire leurs outils.

Bon, bha je vous cache pas que ça m'emmerde pas mal.
Je suis plutôt contre ces machines pour diverses raisons (écologiques, éthiques, politique) et du coup, à mon ptit niveau, je vais faire en sorte de ne pas contribuer à ces béhémoths.
Et par chance je ne suis pas seul et certaines personnes sont dans la même mouvance et ont prémâché tout le boulot.

## Dark Visitors
Le site [Dark Visitors](https://darkvisitors.com/) répertorie les scrapers des IA avec à chaque fois une ptite explication.

C'est joli et efficace avec mêmes quelques stats (qu'ils sortent d'où ?!).

Mais bon c'est pas 100% désintéressé (et ouai il faut toujours tout tenter de monétiser en ce bas monde …).

## ai.robots.txt
Et ce week-end, je suis tombé sur un repo github qui répertorie la même chose.
Et en plus ils fournissent ça dans des formats directement exploitables.
Et encore en plus (et oui !!) ils fournissent des bouts de conf pour **nginx** et **apache** !

Et oui, c'est la classe.

Bref [voilà le repo de nos rêves](https://github.com/ai-robots-txt/ai.robots.txt).

## Limites
Bon, bien entendu, le **robots.txt** c'est au bon vouloir de chacun de le respecter.
Vous pensez bien que les entreprises qui violent le copyright en pompant absolument tout ce qu'elles ne trouvent n'en ont pas grand-chose à foutre de votre robots.txt…

Perso j'ai mis direct le bout de conf dans nginx.
Mais ça encore, ça ne marche que tant que les dit-scrapers jouent encore le jeu d'afficher leur user-agent légitime.

Voilà voilà.
