+++
Author = "Lord"
Description = "Retour sur près de trois ans d'utilisation de blocky un résolveur DNS qui gère DNSSEC, DoH DoT, qui fait du cache et qui permet de bloquer les pubs."
Categories = ["dns", "software","linux"]
menu = "main"
notoc = true
WritingDate = 2023-02-16T11:26:45+01:00
date = 2023-02-16T11:26:45+01:00
title = "Retour sur Blocky et les résolveurs DNS"
editor = "kakoune"
TopWords = ["dns","résolveur","lan","turris","dnssec","doh","dot","grafana","prometheus"]
+++
Bon étrangement ça parle pas mal de DNS ces derniers temps sur ma timeline du Fediverse du coup j'ai eu envie de faire un ptit retour sur **Blocky**.

Je vous ai fait [un article](/posts/204-profiter-de-dns-over-httpstls-sur-linux/) il y a maintenant … presque 3 ans !!
Il est toujours d'actualité.

## Blocky a grandi
Alors déjà, j'utilise toujours **Blocky**.
Le projet était vraiment tout jeune à l'époque et maintenant il a connu plein de nouvelles releases.
Il marche toujours aussi bien en étant léger, rapide et toujours aussi simple à utiliser.

Niveau installation il commence à arriver dans les distros donc c'est encore plus simple qu'avant.
Ça fait plaisir de le voir reconnu par le monde nunuxien :-)

### Blocklists
Son premier argument de vente est dans son nom : il est là pour bloquer des requêtes.
Il se repose donc sur des blocklists qu'il met à jour de lui-même, ça ne nécessite aucune intervention.

J'ai ajouté quelques blocklists dont [celle de l'inénarrable Sebsauvage](https://sebsauvage.net/hosts/raw) même si franchement ça ne sert que très peu dans mon cas.

### Résolveurs upstreams
L'avantage de **blocky** par rapport à un résolveur classique est qu'il permet d'utiliser plusieurs résolveurs upstreams.
Et quand je dis plusieurs c'est pas 2 comme on l'entend habituellement.
Non là on peut en avoir autant qu'on veut.

Blocky va répartir les requêtes sur tous les résolveurs que vous allez lui filer.
C'est l'un des avantages qui me plaît le plus dans ce logiciel.
Ça permet de répartir mes requêtes sur biens plus de résolveurs différents.

De ce fait, si un résolveur "tombe" (que ce soit en panne ou entre de mauvaises mains), il ne vera qu'une petite partie de mon trafic DNS global.
Ça augmente donc à la fois la fiabilité mais surtout ça réduit le potentiel de nuisance sur la vie privée d'un résolveur.

D'ailleurs chaque requête sera envoyé sur deux résolveurs et il prendra la réponse du plus rapide.
Les résolveurs ne répondant pas assez vite ou bien étant en erreur auront moins de chance d'être contacté par la suite.

### Exporter Prometheus
Une des nouveautés depuis mon article précédent est la présence d'un exporter **prometheus**.
Cela permet donc de générer des stats et de visualiser tout cela dans **grafana**.
Et franchement ? J'adore voir tout ça !

## Que peut-on dire de ces stats ?
Pour cet article j'ai limité les stats sur les dernières 24h.

{{< img src="stats_diverses.png" alt="diverses stats plus ou moins utiles" title="Tous les champs ne sont pas fonctionnels mais c'est pas bien grave." >}}

Alors déjà on a pas mal d'information dès ce premier écran.

Tout d'abord on voit que le temps de réponse moyen est de 2.41ms ce qui est extrèmement rapide.
C'est en très grande partie grâce au cache qui évite d'aller consulter des ressources extérieures dans une grande partie des cas.

D'ailleurs on voit que 97% des réponses proviennent du cache.
Bon j'ai un taux anormalement élevé de réponses provenant de ce dernier parceque j'ai certaines machines qui font des tests réseaux constamment vers des pairs réseaux identiques.
Du coup, comme c'est testé chaque minute, bha … j'ai de très nombreuses requêtes pour la même destination.

Ensuite, on voit que j'ai généré près de 93000 requêtes et je n'ai eu que 2 erreurs (résolveurs upstreams HS si je ne m'abuse) durant cette période.

{{< img src="duration.png" alt="graphique montrant la répartition des durées de réponses concentrée majoritairement autour des 25ms." title="Mes temps de réponses sont vraiment pas dégueux !" >}}

Alors là, je ne sais pas pourquoi mais **Grafana** a un bug d'affichage, il décale la légende vers le bas ce qui fausse tout.
Il faut en gros tout décaller de deux lignes vers le bas.

Ce graph permet de voir un peu comment est réparti le temps de réponses.
On voit que c'est très souvent autour des 25ms et surtout rien au-dessus de 200ms

C'est plutôt dispensable ce morceau.

{{< img src="query_type.png" alt="46 de requêtes pour du AAAA et 54% pour du A" title="À peu près la moitié des requêtes sont pour de l'IPv6 !">}}

Haa ça c'est de suite bien plus intéressant comme stats.
Ça permet de voir qu'environ la moitié des pairs auxquels je me connecte je le fais en IPv6 !
C'est plutôt chouette !

On a fait la moitié du chemin pour pouvoir virer IPv4.

{{< img src="response_type.png" alt="96% des requêtes proviennent du cache, 4% sont resolved et seulement 65 soit 0% ont été bloquées." title="De l'intéret d'un résolveur cache bloquant." >}}

Le cœur du boulot de Blocky.
Ici on voit bien qu'il m'évite une énorme partie de trafic DNS sortant grâce à son cache.
En plus ça accélère le process vu que ça reste local.

{{< img src="sources.png" alt="Répartition de l'utilisation des résolveurs upstreams. Le plus gros est à 7% et le plus petit à 1%." title="Le graph qui me procure le plus de plaisir." >}}

Voilà la dillution de mon trafic DNS représenté en 1 graph.
On voit que le résolveur upstreams qui reçoit le plus de trafic de ma part n'en voit que 7%.

Idéalement j'aimerai bien en avoir encore plus dans la liste pour dilluer toujours plus.
J'aimerai notamemment dégager ceux de Cloudflare de la liste et n'avoir si possible plus que du DoT ou DoH.
Si jamais vous connaissez des fournisseurs qui peuvent répondre à mes critères, je suis preneur !

## Blocky C'est super bien !
Je vous le recommande chaudement en plus maintenant ils ont [un ptit site web](https://0xerr0r.github.io/blocky/) pour présenter le projet.
