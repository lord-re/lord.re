+++
Author = "Lord"
Description = "Qu'est-ce qu'il se passe réellement quand vous ouvrez une page web dans votre navigateur."
Categories = ["web", "internet","vulgarisation","réseau"]
menu = "main"
notoc = true
PublishDate = 2018-04-21T17:38:50+02:00
date = 2018-05-08T23:12:50+02:00
title = "Ce qu'il se passe quand on ouvre une page web"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/vntd5d/ce_quil_se_passe_quand_on_ouvre_une_page_web"
TopWords = [  "réception", "javascript", "protocole", "paquet", "ordinateur", "paquets", "tcp", "document", "ip", "navigateur"]
+++
Vous ouvrez très probablement des dizaines voir des centaines de pages web tous les jours.
C'est devenu naturel à tel point qu'on ne se rend pas compte de toute la magie à l'œuvre pour nous afficher notre drogue moderne.

Déjà commençons par une petite mise au point : je vais causer principalement de Web mais pas trop d'Internet car souvenez-vous : [Web ≠ Internet]({{< ref "/posts/90-web≠internet" >}}). 

C'est parti !

## Comprendre l'adresse
Imaginons que vous vous comportiez bien en utilisant la barre d'adresse (et non la barre de recherche).
Vous entrez donc *lord.re/posts* .

Votre navigateur va devoir transformer ça en une véritable URL.

Donc premièrement il va rajouter le protocole utilisé.
Ça veux dire qu'il va rajouter *http://* devant pour indiquer **Hyper Text Transport Protocol**.
Peut-être que les navigateurs utiliseront http*s* par défaut bientôt ce qui permettrait d'utiliser une version plus sécurisée du web par défaut mais c'est pas encore le cas.

L'adresse est donc **http://lord.re/posts** avec les différents composants : 

  - *http://* étant le protocole
  - *lord.re* est le nom de la machine sur laquelle vous vous connectez
  - *posts* est le document que vous voulez voir


À partir de là, le navigateur va pouvoir passer à la suite.

## Requête DNS
Bon c'est bien gentil, votre ordinateur sait quel serveur contacter mais il ne sait pas où il se trouve.
Votre navigateur ne peut se connecter qu'à des adresses IP, il lui faut donc faire la correspondance entre le nom de la machine et son adresse IP.
Ce service est assuré par l'OS et plus spécifiquement *le service de résolution de nom* couramment appelé **DNS**.

Votre navigateur demande donc à votre OS : *« Quelle est l'adresse IP de lord.re ? »*

Votre OS va donc consulter le serveur DNS qui est configuré et celui-ci lui donnera une adresse IP de la forme *92.167.84.9* si c'est une IPv4 ou bien *2001:0db8:1234:4321:1234:4321:1234:4321* en IPv6 (oui c'est beaucoup moins simple à retenir).

Avec un peu de chance cette information ne vous aura nécessité l'envoi que d'un paquet DNS et la réception d'un paquet DNS.
On a donc déjà 2 paquets qui ont voyagé.
Votre OS transmettra ensuite cette réponse à votre navigateur qui pourra établir la connexion IP et TCP.

## Création des paquets IP
Lorsque deux machines se connectent pour ensuite parler, elles le font via le **protocole IP** (IPv4 ou IPv6).
Les données sont tronçonnées en de multiples morceaux.
Chaque morceau est placé dans un paquet IP.
En gros un paquet IP c'est une enveloppe avec l'entête (écrit sur l'enveloppe) et les données dedans.

Ces entêtes IP contiennent (entre autre) l'adresse IP d'émission du paquet (pour pouvoir revenir) ainsi que l'adresse IP de réception (pour pouvoir atteindre la destination).

Bref le navigateur est désormais capable de joindre le destinataire final en demandant à l'OS de créer des paquets IP.
Le réseau se chargera de les amener au bon endroit et de faire le retour également.
Mais ça c'est une autre histoire passionnante.

## Établissement de la connexion TCP
Si vous voulez parler via le protocole http, alors les paquets sont émis à destination du port *80* si c'est en https, alors ce sera le port *443* et seront émis depuis un port aléatoire de votre ordinateur.

Mais dis-moi Jamie, c'est quoi un port ?
*La notion de port est ce qui permet à un ordinateur d'établir plus d'une connexion simultanée.*

Vous n'allez pas vous connecter juste à un ordinateur en réalité mais à 1 port d'un ordinateur.
Un même ordinateur pourra faire tourner plusieurs logiciels simultanément qui attendront chacun des connexions sur des ports différents.
De ce fait un seul ordinateur peut à la fois parler http et https mais également faire serveur mail sur le port 25 par exemple et pourquoi pas aussi serveur de discussion via le port 6667…

Les ordinateurs en ont 65535 ce qui leur laisse pas mal de marge de manœuvre (et encore autant en UDP). 
*Un port est donc un point d'entrée et/ou de sortie de votre OS sur le réseau.*

Donc reprenons :

  - votre ordinateur va envoyer une demande de connexion tcp vers le port 80 ou 443 du serveur web (TCP SYN).
  - Lorsque le serveur web va recevoir cette demande, s'il est disponible, il enverra un paquet comme quoi il accepte cette connexion (TCP ACK).
  - Et enfin votre ordinateur à la réception de l'acceptation enverra un accusé de réception attestant que la connexion est établie (TCP SYNACK).

Cet échange s'appelle le **TCP Handshake** ou *3way-handshak* ou *la poignée de main TCP*.

TCP est dit fiable car il s'assure que chaque paquet envoyé est reçu et dans le bon ordre.
Si des paquets ne sont pas reçus, TCP le renverra.
Ce système fonctionne grâce à des accusés de réception et le fait que chaque paquet est numéroté.

On est donc dans le meilleur des cas à 5 paquets échangés et toujours 0 info à se mettre sous la dent.

## Établissement TLS
**TLS** est la couche de protection qui fait la différence entre le HTTP et le HTTPS.
Ce fameux petit **s** qui veux dire *secure*.

C'est lui le garant de la sécurité et de la confidentialité de vos données mais malheureusement ce n'est pas infaillible mais je ne pousserai pas dans ces détails.
Cette étape n'intervient donc que lorsque l'adresse rentrée est en HTTPS.

Bref maintenant votre ordinateur (le client) va parler SSL/TLS (SSL étant le nom de l'ancien protocole) avec le serveur.

  - Votre client indique quel domaine il veux contacter ( lord.re dans notre exemple) en clair.
  - Il y tout d'abord la négociation de la méthode de chiffrement pour que le client et le serveur puisse utiliser la même.
  - Le serveur envoi son certificat au client.
  - Le client vérifie que ce certificat est de confiance (en regardant qui l'a signé et si ce tiers est de confiance)
  - Si c'est ok, le client choisi une clé de chiffrement temporaire qu'il chiffre via la clé publique du serveur
  - Le serveur web déchiffre cette clé temporaire grâce à sa clé privée
  - Les échanges suivant sont chiffrés via la clé temporaire échangée de manière sécurisée.

Si les rouages sous le capot vous intéresse le bon vieux wikipedia possède [une page plutôt pas mal](https://fr.wikipedia.org/wiki/Cryptographie_asym%C3%A9trique) à ce sujet.

Autant vous dire que les méthode de chiffrements sont variées allant du vraiment blindé à la passoire.
Sachez que généralement les sites sont plutôt moyens et que généralement les banques sont dans le tout juste passable voir passoire…
Le site SSLLabs de Qualys propose un excellent [test de niveau de sécurité TLS](https://www.ssllabs.com/ssltest/) bien foutu ce qui vous permettra de juger de la sécurité d'un site (mais ça ne fait pas tout).

Bref l'utilisation de TLS a un léger impact sur les performances mais garantie (dans la grande majorité des cas) que les données échangées ne sont pas lisibles par quiconque et ne sont pas non plus alterées, c'est donc indispensable.

Bon bon bon, notre compteur atteint désormais les 11 paquets échangés et toujours pas de données utiles pour votre navigateur mais ça arrive à la prochaine étape. (spoiler pas vraiment mais presque)

## HTTP
Bon maintenant que la connexion est établie pour de bon et qu'elle est éventuellement chiffrée, ça va enfin pouvoir parler http.

Votre navigateur (le client web) va donc dire quel domaine il veux contacter, quel document il souhaiterait recevoir ainsi que quelques métadonnées.
Voilà un exemple de requête :

    > GET /posts/ HTTP/1.1
    > Host: lord.re
    > User-Agent: curl/7.59.0
    > Accept: */*

On y voit quel document je demande, ainsi que la version du protocole que j'utilise, quel hôte (le domaine) je demande, quel est mon navigateur (curl/7.59.0) et quels sont les types de données que j'accepte (*/* signifie tous les types).

Une des choses fondamentales à voir est que le navigateur et le serveur se parle en s'envoyant du texte lisible par un humain.
C'est donc très facile à débugguer et inspecter pour un humain, ce n'est par contre plus le cas avec HTTP2 qui ajoute de la compression et n'échange plus ces entêtes sous forme textuelle mais binaire.

Cependant cet exemple n'est pas super représentatif car *curl n'est pas un navigateur classique* mais un logiciel en ligne de commande un peu spécifique.
Voyons plutôt à quoi ça ressemble avec un bon vieux Firefox des familles :

    > GET /posts/ HTTP/1.1
    > Host: lord.re
    > User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:61.0) Gecko/20100101 Firefox/61.0
    > Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8
    > Accept-Language: en-US,en;q=0.5
    > Accept-Encoding: gzip, deflate, br
    > DNT: 1
    > Connection: keep-alive
    > Upgrade-Insecure-Requests: 1
    > If-Modified-Since: Mon, 30 Apr 2018 21:59:32 GMT
    > If-None-Match: W/"5ae791c4-21f57"
    > Cache-Control: max-age=0

Et là il y a beaucoup plus d'infos dont certaines permettent de vous profiler/espionner/suivre.

Le *User-Agent* indique quel navigateur vous utilisez et souvent quel OS vous utilisez.

Le *Accept* est aussi plus spécifique en spécifiant également la langue et quel formats de compression de données vous pouvez gérer.

*DNT* est là pour indiquer que vous ne souhaitez pas être traqué et n'est généralement pas mis par défaut et rarement pris en compte par les serveurs malheuresement.

*Connection* indique la façon dont vous voulez que la connexion soit gerée.
Ici on indique que l'on reste connecté (au sens TCP) même une fois les données transferées, ce qui permet de réutiliser cette même connexion dans le cas où il y aurait d'autres requêtes par la suite.
Bien évidemment au bout de quelques secondes/minutes c'est tout de même coupé.

*Upgrade-Insecure-Requests* indique que le navigateur web accepte de passer en HTTPS si c'est possible.

Les trois derniers éléments de la requêtes sont relatifs au cache du navigateur qui indique qu'il a déjà des données en cache afin que le serveur s'adapte.

Bref c'est beaucoup plus verbeux que le bon vieux curl mais ça apporte quelques raffinements bien utiles tout de même.

Ce coup-ci de multiples paquets seront nécessaires et contiendront enfin vos vrais données.
Maintenant votre navigateur va attendre la réponse du serveur.

## Création de la page
Vous voulez désormais recevoir le document demandé mais pas si vite!
Tout ne se déroule pas toujours aussi facilement.

Deux cas sont possible, le document est dit *statique* et de ce fait existe dans un fichier qui vous est transmis ou bien ce n'est pas le cas.

Et là je parle pas d'*erreur 404* mais juste que le document que vous demandez doit être généré juste avant l'envoi et que ces données sont volatiles.
Elles peuvent être regénérées mais ne sont pas un vrai fichier sur un disque dur quelque part, dans ce cas c'est dit *dynamique*.

**Le serveur reçoit votre requête http et en fonction de celle-ci va créer une page.**

C'est par exemple le cas des pages web en **PHP** utilisés par de nombreux sites (notamment Facebook ou plus simplement les sites utilisant le moteur Wordpress).
Les pages sont générées par le serveur à la volée et vous sont transmises.
Cette technique est désormais communes et s'est développé peu après le début du web vers la fin des années 90.

Il existe un troisième cas qui est de plus en plus répandu et qui est bien plus récent puisqu'il a débarqué ces dix dernières années où le contenu brut est envoyé au navigateur web mais c'est le navigateur web lui même qui va générer la page.
Cette technologie s'appuie largement sur le langage *Javascript qui s'exécute dans votre navigateur*.

Sachez d'ailleurs qu'il est possible de désactiver Javascript dans votre navigateur ce qui rend ces sites inutilisables.
Qui plus est, beaucoup de ces sites posent des problèmes d'accessibilités et parfois de référencement mais que voulez-vous ma petite dame, c'est la mode. 

## Réception de la page
À l'étape HTTP on a vu la requête envoyée par le navigateur, ici nous allons voir la réponse HTTP reçue :

    < HTTP/1.1 200 OK
    < Server: nginx
    < Date: Fri, 13 Apr 2018 17:29:43 GMT
    < Content-Type: text/html
    < Content-Length: 134839
    < Connection: keep-alive
    < Vary: Accept-Encoding
    < Last-Modified: Thu, 12 Apr 2018 11:25:23 GMT
    < ETag: "5acf4223-20eb7"
    < X-Cache-Status: MISS
    < Accept-Ranges: bytes

On voit la *version du protocole* ainsi que le *code de retour* (200 qui signifie OK, vous connaissez probablement 404 qui signifie document introuvable, 403 interdiction de voir le document, …).
On voit quel est le *serveur* (nginx est l'un des logiciel les plus répandu), la *date*, le *type de donnée* du document voulu, sa *taille*, la *dernière modif* du document et des informations concernant le *cache*.

Ensuite, il y a les données, c'est à dire le document demandé.

## Lire la page
Votre navigateur vient donc de recevoir votre page web, il va la lire et regarder son contenu.

**Une page web ce n'est qu'un fichier texte formatté d'une certaine façon.**

Ce fichier texte va donc devoir être transformé en un document plus regardable qu'un simple fichier texte.
Le navigateur va afficher *les images qui sont liées à la page*, appliquer un *style définie dans un fichier CSS*, placer *une/des vidéo ou jouer des sons*, pourquoi pas *afficher des éléments en 3D*.

Pour chacun de ces éléments, votre navigateur va refaire toutes les étapes précédentes avec d'éventuelles subtilités.
Par exemple si un document est sur le même domaine que la page actuelle, le navigateur pourra zapper l'étape du DNS et en fonction du protocole utilisé (si c'est du HTTP2 par exemple ou 1.1 avec quelques options) le navigateur pourra réutiliser la connexion TCP en cours ainsi que la session TLS actuelle.

Bref le navigateur va recevoir en premier lieu, à peu près tout le texte de la page (sauf s'il y a filouterie via javascript) puis recevra les autres éléments, mais le navigateur tentera de faire le rendu au plus tôt et le modifiera à chaque fois qu'il recevra de nouveaux éléments.

Par exemple le **CSS** est un fichier texte s'occupant de styliser la page en y définissant des couleurs, le placement des éléments et tout ce qui a attrait à l'esthétisme.
Une même page web peut avoir plusieurs fichiers CSS.

Toujours à ce propos, une même page web peut contenir de nombreuses images (no shit Sherlock) ou de nombreux Javascript.
Mais là où ça devient problèmatique, c'est que ces différents contenus ne proviennent pas forcément du site que vous consultez mais de sites extérieurs.

Par exemple tous les boutons de réseaux sociaux, sont très généralement issus de ces fameux réseaux sociaux eux-mêmes ce qui implique que même si vous ne cliquez pas sur ces boutons, les sites en questions collectent tout de même l'information que vous avez consultez telle-page, même sans y être connecté (via un champs *referer* de la requête http, qui contient l'adresse web de la requête précédente).
Bref, un désastre pour les performances mais aussi la vie privée.

## Exécuter le javascript
Une fois que votre navigateur a également reçu les javascripts, il va les exécuter.
Ce sont des sortes de *mini programmes* qui à l'origine étaient très limités mais qui au fil du temps ont de plus en plus de possibilités ce qui a amené à la création des web applications.

C'est eux qui permettent par exemple de créer des ptits graphs en live, qui affichent les prix les plus à jour sur les sites marchands, qui rafraîchissent partiellement la page pour afficher le nouveau contenu, bref tout **ce qui est un peu dynamique sur une page provient de Javascript**.

C'est d'ailleurs souvent un nid à emmerdes dans le sens où certains s'en servent pour chopper quelques données sur vous, pour miner de la crypto monnaie dans votre dos, pour utiliser votre processeur un peu trop intensivement juste pour afficher des effets négligeables…
Bref je suis pas un fan inconditionnel de Javascript et *je recommande de n'activer Javascript qu'au cas par cas* afin de vous épargner (ainsi que votre machine) tout plein d'emmerdes.


Et voilà votre page web est complète et aura nécessité de nombreux aller-retours un peu partout dans le monde.
J'ai pas mal insisté sur le nombre de paquets car il faut bien voir que chacun des paquets fais un aller-retour (le paquet fait l'aller, l'accusé de réception le retour), ce qui implique à chaque fois une certaine latence.
Ça explique en partie la lenteur d'ouverture de certaines pages.

Le second facteur de lenteur est tout simplement la quantité de données de tous les documents nécessaires à la page web.


--------------------

Cet article est une nouvelle version d'un [article publié](https://iloth.net/2016/10/ce-quil-se-passe-quand-on-ouvre-une-page-web/) sur le site d'[Iloth](https://iloth.net) un gentil Fournisseur d'Accès Internet dont je suis membre.
Je l'ai réécrit pour l'améliorer et le rendre un poil plus digeste et plus à jour.
