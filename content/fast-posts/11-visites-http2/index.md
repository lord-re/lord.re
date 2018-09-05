+++
Author = "Lord"
Description = "J'ai bien plus de visite via HTTP2 que via HTTP1 seulement deux ans après la sortie officielle de ce nouveau protocole."
Categories = ["meta", "web","nginx"]
menu = "main"
notoc = true
PublishDate = 2018-03-12T18:09:29+01:00
date = 2018-03-12T18:09:29+01:00
title = "La rapidité de déploiement des technos web"
editor = "kakoune"
+++
En scrutant un peu GoAccess, je me suis rendu compte que j'avais désormais plus de visiteurs en HTTP2 qu'en HTTP1.0 ou HTTP1.1.

HTTP2 est officiellement [né en février 2015](https://www.ietf.org/blog/http2-approved/) et *en seulement deux ans il est devenu le protocole majoritaire* (tout du moins dans mon cas).
J'ai environ trois visites en H2 pour 1 en H1.

C'est impressionnant de voir une telle vitesse de déploiement côté client.
IPv6 ne peut pas en dire autant.
Et la puissance de frappe de Google n'y est surement pas pour rien.

La cadence effrénée de sortie de son navigateur Chrome y est pour beaucoup mais pas uniquement.

En étant le moteur de recherche numéro un, il peut pousser tous les éditeurs de site ouaib à faire tout et n'importe quoi en brandissant la promesse d'un meilleur classement.
Pour le bien et pour le pire (vous avez entendu parlé de la controverse AMP (pas l'éditeur de texte, hein) ?).

Le mois dernier, NGINX a ajouté [le support de la fonction PUSH](https://hg.nginx.org/nginx/rev/641306096f5b) qui permet, à l'initiative du serveur, d'envoyer préventivement des fichiers non demandés par le client.
Cette technique est pratique pour envoyer d'office votre feuille de style css, les quelques js nécessaires ou la favicon afin de limiter le nombre de requêtes nécessaires à l'affichage complet de la page.

Bref je foutrais ça en place dès que ça arrive dans le dépôt de ma distrib.
