+++
Author = "Lord"
Description = "Lassé de voir des milliers de tentatives d'intrusion sur mon serveur web, j'ai décidé de mettre en place un ptit piège pour emmerder les scanneurs. Une gzip-bombe va contrecarrer un peu tout ça. Voyons comment mettre ça avec Nginx et sans PHP."
Categories = ["nginx", "adminsys"]
menu = "main"
notoc = true
PublishDate = 2018-11-09T15:29:10+01:00
date = 2018-11-09T15:29:10+01:00
lastEdit = 2018-11-09T17:50:10+01:00
title = "Gzip-bombe avec Nginx sans PHP"
editor = "kakoune"
TopWords = [  "zip", "nginx", "php","sécurité"]
+++

Bon je matais un ptit coup GoAccess et dans la section *404*.
Là, près de 18000 tentatives de connexion à *wp-admin.php* qui correspond à l'accès à l'interface d'administration de WordPress.
Et plein de tentatives vers divers trucs du même genre pour tenter s'infiltrer dans la machine.

Heureusement pour moi, j'utilise **Hugo** qui est un générateur statique.
Donc côté serveur web, il n'y a pas de **PHP** ou autre langage dynamique.
Les pages webs sont de simples fichiers textes et le serveur web n'a aucune intelligence et ne fait qu'envoyer les pages demandées.

Mais du coup ça fait un bail que ça me titille de tenter de faire chier les scanners.

## GZip Bombe
C'est une technique assez ancienne et simple.
Vous créez un fichier bidon mais très gros contenant plein de fois un même caractère.
Vous compressez ce fichier.
Un trèèèès gros fichier donnera un très petit fichier.

La magie des serveurs web et clients web (les navigateurs mais aussi les logiciels qui scannent (entre autre)) fait que la plupart des logiciels savent communiquer en s'échangeant des fichiers compressés.
Du coup le but du jeu est que le serveur envoie une bombe à un scanneur qui tentera alors d'ouvrir la page web en décompressant le fichier reçu sauf que ce fichier est énorme ce qui bouffera du CPU et probablement énormément de RAM.

## Mise en place sur NGINX
On trouve déjà pas mal d'exemples de ce genre de truc avec **Nginx** mais ils sont tous prévus pour être utilisés via PHP.
Un ptit tour sur votre moteur de recherche favoris vous donnera plein d'exemples.
Sauf que je vais pas foutre PHP juste pour ça…

Il va donc falloir ruser.


### 1. Créer la bombe
On va créer un fichier de 10Go avec uniquement des zéros.
Et on va le gziper et ça va faire 10Mo.

**<samp>dd if=/dev/zero bs=1M count=10240 | gzip -9 > 10G.php</samp>**

Ça prend un peu de temps, vous inquiétez pas.
Vous le placez à la racine de votre site ouaib.

### 2. Mise en place du piège
On édite la conf de votre vhost nginx : */etc/nginx/conf.d/lord.re.conf*

{{< highlight nginx >}}
location ~* \.php(/|$) {
	root /home/nginx/lord.re;
	try_files $uri /10G.php;
	types { text/html php; }
	add_header Expires "Wed, 11 Jan 1984 05:00:00 GMT";
	add_header Content-Encoding gzip;
}
{{< / highlight >}}

Voilà on ajoute deux entêtes HTTP.
Le premier sert pas à grand chose mais visiblement il est défini sur deux installations Wordpress que j'ai testé.

Le second entête indique que ce sont des données gzippés et que donc le client va devoir les décompresser.
Si vous le faites pas, votre navigateur web va tenter de télécharger le fichier au lieu de tenter de l'afficher.

On redéfini le type du fichier php en tant que *text/html* pour indiquer au client que c'est une page web classique.

### 3. Profit !


## Vous voulez tester ?

Et bha [venez](https://lord.re/wp-login.php).
Les navigateurs réagissent tous un peu différemment.
Certains bouffent du CPU mais pas trop de RAM, d'autres bouffent à mort de RAM…

---------
Merci à Fol pour les modifs qui rendent le truc un peu plus simple encore !
