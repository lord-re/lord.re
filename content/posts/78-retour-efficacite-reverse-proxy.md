+++
Author = "Lord"
Description = "Avec maintenant près de six mois de recul voici un petit retour sur le reverse proxy de ce blog"
Categories = ["nginx", "www", "adminsys", "software","meta"]
draft = false
menu = "main"
notoc = true
PublishDate = 2018-03-01T10:55:02+01:00
date = 2018-03-01T10:55:02+01:00
title = "Retour sur le reverse proxy du blog"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/mwzbyq/retour_sur_le_reverse_proxy_du_blog"
+++

En septembre dernier, je vous avais parlé de la mise en place d'un [micro-cache nginx en reverse proxy]({{< ref "posts/60-cache-proxy-nginx" >}}) et du coup je voulais vous faire un petit retour.

Depuis cet article je n'ai pas changé la config en dehors de la durée du cache que j'ai augmenté récemment à dix minutes.

Bon déjà niveau entretien, rien à faire.
Tout fonctionne comme voulu sans aucune intervention.
Le seul truc qu'il m'arrive de faire de temps à autre c'est de vider manuellement le cache quand je fait des modifs et que j'ai pas envie d'attendre l'expiration du cache pour voir les résultats.
Mais bon un simple **rm /var/www/lecache/\** sur le reverse proxy et c'est torché.

D'ailleurs, je ne l'avais pas précisé dans l'article initial mais le cache se trouve en vrai dans un *tmpfs* c'est à dire dans la ram.
Il n'est pas stocké réellement sur le système ce qui permet de gagner un poil en perf.
Dans mon cas j'ai limité le tmpfs à 100Mo ce qui est plus que suffisant pour acceuillir l'intégralité du blog (qui ne fait que 12Mo).

Bref

## Petit rappel vite fait du principe d'un cache

Le **client** (toi le lecteur) va demander à afficher une page.

Le **reverse proxy** va recevoir cette requête et va voir si la page est dans le cache.
Si elle n'est pas là, il se connecte à l'**upstream** pour lui demander la page.

Le proxy envoi la page au client et la place dans son cache.

Pendant la durée de validité de la page, le proxy ne se connectera plus à l'upstream et enverra directement la page en cache.

## Comment je collecte et lit les stats de mon site ?

Vous avez peut-être remarqué que mon site est plutôt … minimaliste.
*Il s'affiche particulièrement bien dans les navigateurs en console et j'espère de ce fait qu'un screen reader saura s'en débrouiller.*
En dehors des rares articles avec des illustrations, l'affichage d'une page du blog nécessite seulement trois requêtes : une première pour la page en elle-même.
Une seconde pour le CSS.
Et une dernière facultative pour le favicon.

Je n'utilise pas de javascript ou image bidon pour traquer mes visites.

La seule chose que je fait pour connaître le traffic de mon site est donc de lire les logs du serveur web.
Je m'aide du logiciel [GoAccess](https://goaccess.io) qui propose une interface console toute mimi et colorée.
Mais ça reste tout de même rudimentaire comparé à un Google Analytics ou un Piwik.
Cela dit, pour mon usage c'est largement suffisant.

Ce n'est qu'un blog perso.
En dehors de la satisfaction de voir que des gens le lisent, je ne tire aucun profit de mon site.

## Impact du reverse proxy sur l'upstream

Mon upstream est un tout petit [Atom D510 de 2011]({{< ref "15-migration" >}}) qui pourrait largement tenir la faible charge des visites de ce blog.

Mon reverse proxy est également une toute petite machine.
C'est mon routeur, un [Turris Omnia]({{< ref "posts/44-turris-omnia" >}}), avec un container lxc pour le reverse proxy nginx.

Pour voir à quel point l'upstream est soulagé il suffit de comparer les logs de l'upstream et du reverse proxy sur la même période et comparer.

Je constate une **nette différence** (surtout depuis le passage d'1s à 10minutes) entre les logs.

Sur les “journées molles” la différence est minime alors que sur les journées fastes **le proxy arrive à écouler les deux tiers du traffic** sans contacter l'upstream.

J'ai également coupé plusieurs fois l'upstream sans provoquer de coupure du site vu de l'extérieur (par contre le turris est devenu le spof, je n'ai pas plus de redondance).

## Des chiffres !

Sur Février par exemple :

|               | Upstream  | Proxy |
|---------------|----------:|------:|
|Total requests |      56389| 131813|
|Unique Visitors|      12848|  19894|
|Log Size       |     9.93MB|22.61MB|
|Bandwidth      |    4.35GiB|7.55GiB|

