+++
Author = "Lord"
Description = "Croc est un ptit logiciel en Go pour s'échanger des fichiers entre deux machines sans se prendre la tête."
Categories = ["cli", "software"]
menu = "main"
notoc = true
WritingDate = 2020-04-04T23:32:10+02:00
date = 2020-04-04T23:32:10+02:00
title = "Croc : un outil méconnu mais surpuissant"
editor = "kakoune"
TopWords = [  "chiffré","sécurisé","scp", "rsync", "vitesse", "échanger", "linux", "relai", "transfert", "ssh", "croc"]
+++
Il y a fort longtemps, j'avais mis dans wishlist de logiciel à inventer le **magic pipe** pour passer des données d'une machine à une autre malgré les frontières…

Et bhé en fait ça existe.

## Croc

Ouai c'est un poil miteux comme mise en scène mais pardonnez-moi s'il vous plaît.

Donc je reprends.
Croc est un petit logiciel en Go donc sans dépendances (fusil de Tchekhov) qui tourne sur un peu tous les OS du bien (Linux, Linux et aussi Linux entre autres, même s'il parait qu'il tourne aussi sur des OS moins biens).

Il sert tout simplement à s'échanger des fichiers entre deux machines.
Il le faut donc des deux côtés : chez l'émetteur et chez le récepteur.

Il fonctionne en ligne de commande mais est tout simple.
Il suffit de faire <samp>croc send /votre/fichier /un/autre/fichier /et/pourquoi/pas/un/dossier/</samp> .
À ce moment-là, il vous apparaitra trois mots plus ou moins aléatoire qu'il faudra donner à votre destinataire.

Le destinataire n'aura plus qu'à faire <samp>croc right-bucket-orlando</samp> (enfin vos 3 mots à vous) et hop ça initiera l'échange et tout.
**Pas d'ouverture de port**, c'est **très rapide** (à peu près la vitesse de la connexion), c'est **chiffré de bout-en-bout**.

Il affiche une *ptite barre de progression, la vitesse de téléchargement, le temps passé et une estimation du temps restant*.

Je ne vous cache pas que c'est pas non plus à 100% magique.
Ça nécessite un relai.
Si vous n'en avez pas, le projet en fourni un qui est celui utilisé par défaut mais si jamais vous ressentez l'envie d'être autonome, vous pouvez faire votre propre relai.
Et là c'est ultra simple aussi un simple <samp>croc relay</samp> et hop votre machine sert désormais de relai.

Pour l'utiliser il vous faudra juste le préciser avec <samp>--relay a.b.c.d:port</samp> et voilà.

## Le petit plus
Franchement ça ne serait que ça je n'aurai pas écrit ce ptit article.
Il y a déjà tout un tas de soft pour s'échanger des fichiers donc bon.

Là, le truc qui me fait l'apprécier encore plus, c'est que l'**on peut piper des trucs dedans !**
Et là, ça en devient un simili-ssh du pauvre.

À vraie dire, ça complémente vachement ssh.
Le truc qui m'arrive souvent, c'est de me connecter à une première machine via ssh, de celle-là je me connecte ensuite sur une autre machine via ssh et parfois encore un coup (mais rarement tout de même).
Et du coup dans ce genre de cas, on peut pas forcément établir une connexion directe entre notre machine locale et la machine distante finale.
Et du coup on peut pas forcément s'échanger un fichier.

Et là c'est la tristesse et vous savez quoi ? 
La tristesse c'est vraiment pas cool.
Du coup, là, un simple coup de **croc** et hop, tout s'arrange.
La brume du désespoir se dissipe et laisse place à un soleil radieux.

Et donc avec un pipe sur la machine A on lance : <samp>ps auxf| croc send</samp> et sur la machine B on lance le <samp>croc edward-brown-parade | grep machin</samp> et pouf ça fonctionne.
Je vous laisse imaginer les ptits enchaînements possibles avec tout ça :-D

Et comme c'est du Go donc statique, il suffit de coller le binaire où vous en avez besoin et hop ça fonctionne.
Pas de libs à installer, si ça fonctionne aujourd'hui ça fonctionnera demain.
Voilà, n'hésitez pas à en abuser, ça se trouve sur [Github](https://github.com/schollz/croc) et [le blog de son auteur](https://schollz.com/blog/croc6/) qui est bien comme tout.

----------

Si vous voulez tester, je vous propose de récupérer un fichier avec <samp>croc truc-machin-bidule</samp>.
