+++
Author = "Lord"
Description = "Que faire pour bénéficier des avancées de HTTP2 avec nginx ?"
Categories = ["www", "nginx","adminsys"]
menu = "main"
notoc = true
PublishDate = 2018-06-01T16:10:17+02:00
date = 2018-06-01T16:10:17+02:00
title = "Utiliser HTTP2 et le PUSH avec Nginx"
editor = "vi"
jdh = "https://www.journalduhacker.net/s/ph2eh1/utiliser_http2_et_le_push_avec_nginx"
TopWords = [  "protocole", "ressource", "ressources", "requête", "nginx", "http2", "push"]
+++
HTTP2 est une nouvelle version du protocole <abbr title="Hyper Text Transport Protocol">HTTP</abbr> qui améliore pas mal de points de l'original.

Tout d'abord la sécurité car la plupart des implémentations ne fonctionne qu'avec une couche de <abbr title="Transport Layer Secure">TLS</abbr> qui était autrefois réservé au HTTPS.

Mais surtout les perfs ont été grandement travaillées.
HTTP a été très largement utilisé pendant près de 20 ans avant que le boulot sur son successeur ne commence ce qui a laissé suffisamment de temps pour savoir où ça coinçait et donc comment améliorer le truc.

## Optimisations

### Compression des headers
Certaines optimisations ont été un peu controversées comme par exemple le fait de compresser les headers.
Ça permet d'échanger un peu moins de données mais la contrepartie est que ce n'est plus un vrai protocole texte.

Pour info, *un protocole texte échange des données uniquement sous forme de texte* ce qui permet à un humain de facilement pouvoir le comprendre contrairement à une machine qui devra bosser un peu plus.
L'argument de savoir si un protocole texte est bien provoque de nombreux débats depuis pas mal d'années.

### Multiplex
Un autre point d'amélioration de HTTP2 est le *multiplexage des données*.
Auparavant chaque ressource récuperé par le navigateur nécessitait l'envoi d'une requête au préalable dans une nouvelle connexion <abbr title="Transport Control Protocol">TCP</abbr>.
HTTP1.1 a ajouté le **PIPELINING** ce qui a permis de réutiliser la même connexion TCP pour plusieurs requêtes et réponses.
Le gain était déjà énorme mais il fallait toujours une requête, avec une réponse distincte pour chaque ressource, le tout dans une seule connexion TCP.
Malheureusement cette technique n'était pas utilisé dans tous les cas voire était rare.
HTTP2 lui apporte le **Multiplex** qui permet de faire à peu près pareil mais encore plus efficace.
Dans une seule requête, un client peut demander plusieurs ressources différentes et toutes les recevoir dans une seule réponse.

Cette technique a rendu obsolète certains bidouillages mise en place avec HTTP1 tel que le *sharding* qui consistait à répartir les ressources sur de nombreux domaines différents pour forcer le navigateur à ouvrir plusieurs connexions simultannées.
Maintenant, une seule connexion est préferrable plutôt que plusieurs.

Mais pour aller encore un peu plus loin, il existe aussi le **PUSH**.

### Push-toi de là !
Lorsqu'un client va demander une ressource, le serveur web va envoyer le document voulu, mais il peut également en envoyer d'autres qui lui semblent pertinent.

Le client reçoit les données avant même d'en avoir fait la demande ce qui permet (si c'est bien utilisé) de ne pas avoir à demander cette ressource et donc de pouvoir l'utiliser plus vite.

Par contre, vous vous doutez que si le serveur s'amuse à envoyer un fichier inutile, le client n'utilisera pas ce fichier et du coup vous aurez consommé de la bande passante pour pas grand chose…

## Et dans le Moteur X ?
### H2
Pour utiliser HTTP2, pas grand chose à faire dans votre conf nginx.
Dans le block <samp>*server*</samp> vous devriez avoir un <samp>*listen*</samp> (ou plus).
Sur celui concernant le port 443, ajoutez <samp>*http2*</samp>.

C'est tout.
### PUSH
Nginx sait pusher du contenu depuis la version *1.13.9* sortie en Février 2018.
Je me suis empressé de le mettre en place et de faire quelques tests.

Bon du coup dans bloc de type <samp>*location*</samp>, depuis l'endroit où vous voulez pusher votre contenu, il va falloir rajouter un simple :

    http2_push /css/neodark.css;
		http2_push /favicon.ico;

Et hop votre fichier css et votre favicon seront envoyés.

Si votre site est simple, ça sera vite torché, mais si vous avez pas mal de trucs ça va vite être chiant.
Et là [vbrandl](https://github.com/vbrandl) va vous sauver avec son [générateur de conf nginx](https://github.com/vbrandl/nginx-http2-push-generator).
Vous lui donnez une page web, vous lui dites quels types de ressources vous voulez push, il vous choppe les liens et vous transforme ça en bout de conf nginx à copier/coller.

Et maintenant pour vérifier que ça marche soit vous utiliser les devtools de chromium qui vous indiques (dans performance) si c'est issu d'une requête ou d'un push.
Ou bien si vous voulez un truc plus simple vous avez [http2-push](https://http2-push.io) qui est un ptit site ouaib permettant de tester une URL.

-----------
Voilà vous allez probablement pouvoir grapiller quelques ms sur l'affichage de votre site ouaib avec ça.
C'est en place depuis déjà plusieurs jours ici sans soucis, j'ai pas constaté d'augmentation de la conso de bande passante (j'ai été prudent sur les push).

-----------
## PS :
Comme signalé par [Buzut](https://buzut.fr/), si vous mettez le push comme indiqué dans l'article, à chaque requête les ressources seront poussées au visiteur ce qui n'est pourtant utile que la première fois.
Il est possible de gérer ça en utilisant un cookie et de ne pusher que lorsque le cookie n'existe pas comme c'est montré sur [l'article nginx à ce propos](https://www.nginx.com/blog/nginx-1-13-9-http2-server-push/#selective-push).
