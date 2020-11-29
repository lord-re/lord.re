+++
Author = "Lord"
Description = "Il peut arriver que vous ayez besoin de simuler une connexion internet un peu capricieuse en ajoutant de la perte de paquet ou bien juste de la latence supplémentaire. Linux vous permet de faire ça via la commande tc faisant partie d'iproute2."
Categories = ["réseau", "linux","tips"]
menu = "main"
notoc = true
WritingDate = 2020-11-24T22:37:44+01:00
date = 2020-11-28T21:37:44+01:00
title = "Simuler de la perte de paquet et de la latence sous Linux avec tc"
editor = "kakoune"
TopWords=["iproute","tc","shaping","qos","simulation","perte","tcp","udp","réseau","net","iptables"]
+++
En voilà un titre bien explicite !

Il pourrait arriver qu'un jour… vous ayez envie, à des fins purement scientifiques (mais non pas du tout pour troller les gens) d'**induire de la latence sur certains flux réseau**.
Et pourquoi pas aussi **simuler un peu de perte de paquet**, pour voir si la magie des couches réseaux fonctionne bien.

Un outil sous linux tout cryptique vous permet de faire ça mais franchement vla la gueule du truc.
**tc** qui veut dire **T**raffic **C**ontrol fait partie d'**iproute2**.
À première vue c'est assez horrible avec une syntaxe des moins explicite mais au final c'est encore pire.
Même en ayant quelques connaissances en nunux et en réseau son <kbd>man tc</kbd> n'apporte pas tant d'aide que ça.
Il y a pas mals de concepts et de jargon très poussé niveau réseau qui rendent le truc assez abscon.

Bref, il faut juste repomper la même commande et la réutiliser encore et encore plutôt que de tenter d'apprendre l'outil si l'on ne compte pas approfondir le truc plus que ça.
(c'est habituellement pas ma philosophie du tout mais là je dois avouer que c'est un des outils les plus contre-intuitif que je connaisse)

J'en ai marre de la rechercher constamment donc autant me la partager et à vous aussi au passage afin de retrouver ça plus vite les prochaines fois.

Ça ne se fait pas en une seule commande mais en au moins trois (quatre pour défaire les conneries).

{{< highlight shell "linenos=inline" >}}
tc qdisc add dev eth1.832 root handle 1: prio priomap 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
tc qdisc add dev eth1.832 parent 1:2 handle 20: netem delay 400ms 800ms
tc qdisc add dev eth1.832 parent 1:2 handle 20: netem loss 10%
tc filter add dev eth1.832 parent 1:0 protocol ip u32 match ip dport 443 0xffff flowid 1:2
tc qdisc del dev eth1.832 root
{{< / highlight >}}

Bon, petite explication approximative de texte ligne par ligne :

  - 1: Ça créer un *qdisc* (pas besoin de savoir parfaitement ce que c'est) par défaut que je ne toucherai pas sur ma carte réseau *eth1.832* .
  - 2: On créer une règle qui ajoute de la latence aléatoire entre 400 et 800 ms (très gênant) toujours sur cette même interface réseau.
  - 3: Elle s'amuse à ajouter *10%* de perte de paquet (elle ne peut pas être cumulée avec la ligne 2, c'est soit l'une soit l'autre, j'ai mis les deux à la suite pour vous montrer les possibilités).
  - 4: Celle-là affecte la règle précédemment créée (numérotée 1:2) au protocole ip utilisant le port de destination *443*.
  - 5: Enfin celle-ci supprime le *qdisc* créé et donc vire tout ce qu'on a fait.

Vous n'avez plus qu'à adapter ces quelques lignes à votre cas d'usage pour expérimenter sur votre lab.
Bien entendu, vous pouvez faire ça sur votre machine rien qu'à vous (si vous êtes root) mais c'est bien plus drôle de faire ça sur un routeur pour mieux voir les effets néfastes.

D'ailleurs vous remarquerez très vite que le taux de perte de paquet n'a vraiment pas besoin d'être élevé pour vite rendre tout inutilisable.

Bien entendu *tc sait faire bien plus de choses* mais … c'est complexe et je n'en ai pas l'utilité.
Voilà, vous avez le bon outil pour vous pourrir le réseau.
Brûlez-vous les doigts, il n'y a pas mieux pour apprendre !
