+++
Author = "Lord"
Description = "Voilà quelques ptits conseils quand vous touchez à la conf de votre serveur web nginx. Ça vous évitera quelques erreurs classiques et vous permettra d'aborder le truc tranquilement."
Categories = ["nginx", "tips", "adminsys"]
menu = "main"
notoc = true
WritingDate = 2019-12-04T19:57:19+01:00
date = 2019-12-04T19:57:19+01:00
title = "Quelques tips concernant la conf Nginx"
editor = "kakoune"
+++
Il arrive régulièrement de filer des coups de main à propos de serveur web et surtout Nginx.
Et parmi les erreurs classiques il y a les soucis dans les fichiers de conf.

Beaucoup de conf sont anormalement alambiquées et sont plus ou moins dupliquées pour rien.
On se retrouve avec des comportements foireux.
Et le classique c'est *“ J'ai un résultat différent en HTTP et en HTTPS ! ”* .

Bon voici quelques petites astuces pour simplifier la config.

## Les inclusions
Si vous avez plusieurs vhosts vous vous retrouvez très vite à affecter les mêmes options un peu partout.
Une bonne pratique est de placer les options communes dans un fichier séparé et de l'inclure à chaque fois que nécessaire.

C'est par exemple très pratique pour la configuration TLS.
J'ai un fichier *tls.conf* que je m'amuse à inclure de partout.
Et d'ailleurs je le trimballe également sur chaque nouveau nginx que je fous en place.

Dans vos vhost il ne vous reste plus qu'à ajouter <samp>include tls.conf</samp> et voilà.

Pour ceux intéressés je vous le mets ici, si ça peut vous inspirer ainsi que celui pour le cache.

<details><summary>*/etc/nginx/tls.conf*</summary>
{{<highlight "nginx">}}
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ecdh_curve X25519:prime256v1:secp521r1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305;
ssl_session_cache shared:ssl_session_cache:1m;
ssl_session_timeout 8h;
ssl_session_tickets off;
ssl_buffer_size 4k;
add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

ssl_stapling on;
ssl_stapling_verify on;
# PENSEZ À CHANGER CES ADRESSES DE SERVEURS DNS
# resolver 1.1.1.1 8.8.8.8;
{{< / highlight >}}
</details>

<details><summary>*/etc/nginx/cache.conf*</summary>
{{< highlight "nginx" >}}
gzip_vary on;
gzip_static on;
gzip_proxied any;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_http_version 1.1;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/activity+json application/atom+xml;
{{< / highlight >}}
</details>

Ça marche bien évidemment pour tout un tas de réglages usuels et pas uniquement la crypto.
Ça peut le faire par exemple pour du cache ou de la conf pour php/fastcgi.

## Arrêtez de dupliquer vos vhosts
Très souvent on voit des exemples de conf où les vhosts ont 2 bouts de confs : 1 pour le *HTTP* et une seconde pour le *HTTPS*.
C'est bien gentil mais très généralement ça sert à rien : vous voulez la même conf sur les 2.

*Nginx* est suffisamment malin pour comprendre que certains bouts de confs sont spécifiques au HTTPS et donc n'ont pas à s'appliquer au HTTP.
Je m'explique :

Si dans votre conf vous indiquez *le certificat est le fichier bidule*, cette directive n'a pas à s'appliquer à une connexion HTTP et donc pas besoin de générer une erreur pour rien.
Bref au lieu d'avoir une conf de ce style :

{{< highlight "nginx" >}}
server {
  listen 80;
  server_name truc.bidule;
  …
  …
  …
}
server {
  listen 443 ssl;
  server_name truc.bidule;
  ssl_certificate /votre/cert.pem;
  ssl_certificate_key /votre/cert.key;
  include tls.conf;
  …
  …
  …
}
{{< / highlight >}}

Le risque de faire des conneries et d'avoir des incohérences est maximal.

Il est préferrable de faire une conf de ce genre :
{{< highlight "nginx" >}}
server {
  listen 80;
  listen 443 ssl;
  ssl_certificate /votre/cert.pem;
  ssl_certificate_key /votre/cert.key;
  include tls.conf;
  …
  …
  …
}
{{< / highlight >}}

Votre conf sera bien plus légère et vous n'aurez plus de risque d'avoir un comportement différent en HTTP et HTTPS.

Et là je vous entends *“ Ouai mais comment je fais la redirection du HTTP vers HTTPS ?! ”* .
Bon déjà mon avis sur la question est que ça ne devrait pas être forcé, mais je sais que c'est pas un avis partagé par la majorité.
Cependant il est possible de rajouter un simple :
{{< highlight "nginx" >}}
if ($scheme = http) { return 301 https://$server_name$request_uri; }
{{< / highlight >}}

Bon par contre niveau perf, c'est un tout ptit chouilla moins bon que d'avoir deux blocs *server* donc à moins de vraiment grignotter les micro-optimisations de droite et de gauche ça ne devrait pas vous impacter plus que ça.

## La bonne syntaxe pour écouter sur toutes les interfaces
Constamment je vois passer des bouts de conf incorrects concernant les interfaces.
Très généralement, la conf voulue est d'écouter sur toutes les interfaces possibles.

La bonne conf est la suivante.

{{< highlight "nginx" >}}
  listen 80;
  listen [::]:80;
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
{{< / highlight >}}

Avec ça vous écoutez en IPv4 et en IPv6.
Et sur le port 443 vous écoutez en HTTP1 et HTTP2.

Là vous êtes parés pour le vieux web et le web du futur !

## Conf pour Let's Encrypt
Bon alors maintenant, comme tout le monde vous voulez du TLS surtout grâce à Let's Encrypt.
Mais j'espère pour vous que vous n'utilisez pas *Certbot* (pour [plein de raisons]({{< ref "posts/141-clients-acme-pour-letsencrypt" >}})).
Du coup il y a fort à parier que vous deviez renouveler vos certificats tous les trois mois.

Certains clients LE se proposent de modifier votre conf dans votre dos.
C'est gentil mais pas des plus rassurant.
Sinon vous pouvez couper votre *nginx* le temps du renouvellement ce qui n'est pas terrible niveau disponibilité.

La troisième technique n'a pas ces désavantages mais nécessitent une micro-bidouille dans la conf nginx.
Il suffit d'ajouter :
{{< highlight "nginx" >}}
location /.well-known/acme-challenge {
  alias /un/dossier/précis;
}
{{< / highlight >}}

Il faudra indiquer le même dossier à votre client Lets's Encrypt pour que ça fonctionne sans heurts.

## Tester sa conf à froid
Bon allez un dernier micro conseil.

Quand vous modifier votre conf, testez-la avant de tenter de la mettre en service.
Ça vous évitera un peu de stress et vous permettra de corriger les éventuelles erreurs avec plus de sérénité.

<samp>nginx -t</samp>

Là il vous indiquera si la syntaxe est ok et donc vous serez heureux et esquisserez un petit sourire.
La vie est belle.
