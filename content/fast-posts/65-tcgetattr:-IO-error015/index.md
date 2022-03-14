+++
Author = "Lord"
Description = "Quand l'odroid n2 envoie des message tcgetattr I/0 error#015 il faut vérifier que le tty définit pour getty dans /etc/inittab est bien existant."
Categories = ["odroid", "alpine"]
menu = "main"
notoc = true
WritingDate = 2022-03-14T21:20:16+01:00
date = 2022-03-14T21:20:16+01:00
title = "Erreur tcgetattr: I/O error#015 sur Alpine Linux"
editor = "kakoune"
TopWords = [  "direct", "rebooter", "série", "serveur", "syslog", "getty", "logs", "ttys0"]
+++
J'ai une nouvelle machine à la maison.
Et je me suis dit que ça commençait à faire beaucoup et donc qu'il me faudrait centraliser les logs.

Déjà, je découvre que l'implémentation de syslog de **Busybox** fonctionne parfaitement en client mais ne sait pas faire serveur (du coup je me suis tourné vers **rsyslog**).
Je mets en place le truc à l'arrache et je choisis une première machine que je configure pour qu'elle balance ses logs en local mais également en réseau vers mon tout nouveau serveur syslog.

Et ça marche direct.
Et quand je dis direct c'est tout de suite j'ai des logs qui spamment (à leur rythme, hein).
Ma pauvre petite **Odroid N2** pleure et je ne m'en étais même pas rendu compte !

Toutes les dix secondes elle envoie une ptite ligne de log : <samp>getty[28111]: tcgetattr: I/O error#015</samp> .
Et ça fait un ptit moment que ça dure !

Bon, je demande à Mojeek et j'en viens à la conclusion que non elle n'est pas en train de mourir.
C'est déjà pas mal.
Mais qu'en plus c'est très probablement rien.

En fait, elle tente de lancer **getty** sur un port série qu'elle n'a pas.
La ptite carte utilise un port série avec un nom exotique : */dev/ttyAML0* au lieu du plus classique */dev/ttyS0* .
Et j'ai comme l'impression qu'une mise à jour d'Alpine a bougé le fichier */etc/inittab* .
En effet dans ce fichier je vois la ligne <samp>ttyS0::respawn:/sbin/getty -L ttyS0 115200 vt100</samp>.

Je m'empresse de la recommenter et il n'y a plus qu'à rebooter.
Rebooter ?
Hahahahahaah qu'est-ce qu'on se marre.
Non je déconne.

Il suffit d'envoyer un ptit **SIGHUP** à init avec <kbd>kill -s 1 1</kbd> et ça va être pris en compte.
Et bha voilà.
Plus de message d'erreur.

Tout est bien qui finit bien mais je sens que ça va me le refaire de temps à autre donc autant que je me le note comme ça, plus besoin de retrouver bien loin d'où ça vient.
