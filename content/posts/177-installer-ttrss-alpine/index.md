+++
Author = "Lord"
Description = "Maintenant que j'ai une ptite Odroid à la maison, je vais ramener à la maison les services que j'hébergeais ailleurs. Je commence avec Tiny Tiny RSS."
Categories = ["adminsys", "autohebergement", "alpine", "rss"]
menu = "main"
notoc = true
PublishDate = 2019-08-07T14:51:46+02:00
date = 2019-08-23T14:51:46+02:00
title = "Installer Tiny Tiny RSS sur Alpine"
editor = "kakoune"
TopWords = [  "ecdhe", "tiny", "acme", "sh", "tt", "php", "php7", "ttrss", "nginx", "rss"]
+++
Bon bha je vais ramener à la maison quelques services que j'hébergeais ailleurs.
Je commence par *Tiny Tiny RSS* qui est un *agrégateur de flux RSS* que j'utilise depuis un peu plus de dix ans maintenant.
Il marche bien toussa toussa.

C'est une install en partant d'une Alpine vierge et on aborde tout ce qu'il faut pour avoir un truc fonctionnel avec du TLS et tout.

Bon on va commencer par la liste de paquets à installer :

  - acme.sh
  - git
  - nginx
  - openssl
  - php7
  - php7-curl
  - php7-dom
  - php7-fileinfo
  - php7-fpm
  - php7-iconv
  - php7-intl
  - php7-json
  - php7-mbstring
  - php7-pdo
  - php7-pdo_pgsql
  - php7-pgsql
  - php7-pcntl
  - php7-posix
  - php7-session
  - postgresql
  - postgresql-contrib
  - tmux

Ensuite on se crée un utilisateur exprès avec **<samp>adduser rss</samp>** on lui met un mot de passe bidon (qui ne servira pas).

## Configuration de Nginx
On crée un fichier */etc/nginx/conf.d/rss.lord.re.conf* avec dedans la conf du virtualhost.

<details open><summary>/etc/nginx/conf.d/rss.lord.re.conf</summary>
{{< highlight nginx >}}
server {
  listen 80;
  listen [::]:80 ;
  server_name rss.lord.re;
  root /home/rss/tt-rss;
  index index.php;
  location ~ \.php$ {
    fastcgi_pass 127.0.0.1:9000;
    fastcgi_index index.php;
    include fastcgi.conf;
    include fastcgi_params;
  }
}
{{< / highlight >}}
</details>

On peut ensuite le démarrer avec **<samp>/etc/init.d/nginx start</samp>** et d'ailleurs on démarre également php avec **<samp>/etc/init.d/php-fpm7 start</samp>** .

## Ajout du HTTPS via LetsEncrypt
On utilise le script **acme.sh** pour générer le certificat et le renouveler et tout.
Il faut donc lancer **<samp>acme.sh --issue --nginx rss.lord.re --keylength ec-384</samp>** .

On édite ensuite la conf nginx pour mettre en place tout ce qu'il faut.
<details open><summary>/etc/nginx/conf.d/rss.lord.re.conf</summary>
{{< highlight nginx >}}
  listen 443 ssl http2;
  include ssl.conf;
  ssl_certificate /root/.acme.sh/rss.lord.re_ecc/fullchain.cer;
  ssl_certificate_key /root/.acme.sh/rss.lord.re_ecc/rss.lord.re.key;
{{< / highlight >}}
</details>

Et on ajoute un fichier contenant toute la conf TLS qui vous permettra d'avoir une config au top (tout du moins à la date de l'écriture de l'article).
<details open><summary>/etc/nginx/ssl.conf</summary>
{{< highlight nginx >}}
ssl_protocols TLSv1.2 TLSv1.3;
ssl_prefer_server_ciphers on;
ssl_dhparam /etc/nginx/dhparam.pem;
ssl_ecdh_curve X25519:prime256v1:secp521r1:secp384r1;
ssl_ciphers ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384;
ssl_session_cache shared:ssl_session_cache:1m;
ssl_session_timeout 8h;
ssl_session_tickets off;
ssl_buffer_size 4k;
#add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;

ssl_stapling on;
ssl_stapling_verify on;
resolver 1.1.1.1 8.8.8.8;
{{< / highlight >}}
</details>
Vous êtes encouragé à changer l'adresse ip des *resolver* par les adresses des serveurs DNS qui vous inspire confiance.

On prévoit le renouvellement automatique des certificats en créant un ptit fichier.
<details open><summary>/etc/periodic/weekly/acme.sh</summary>
{{< highlight shell >}}
#! /bin/sh
/usr/bin/acme.sh --cron --renew-hook "service nginx reload"
{{< / highlight >}}
</details>

On peut reload nginx pour qu'il prenne en compte ces modifs **<samp>/etc/init.d/nginx reload</samp>** .

## On prépare la base de donnée
On démarre *postgres* avec **<samp>/etc/init.d/postgresql start</samp>** .
Ensuite on active les *trigrames* avec **<samp>su - postgres -c psql</samp>** et là vous vous retrouvez dans le shell de postgres.
Et là un simple **<samp>CREATE EXTENSION pg_trgm;</samp>** et c'est bon c'est activé.

Ensuite un **<samp>CREATE DATABASE ttrss;</samp>** et enfin **<samp>CREATE USER ttrss WITH PASSWORD 'truc';</samp>** et pour finir on lui donne les droits nécessaires **<samp>GRANT ALL PRIVILEGES ON DATABASE ttrss to ttrss;</samp>**.

Voilà votre base est utilisable par ttrss.

## Install de TT-RSS
Bon, on se loggue en tant que rss avec **<samp>su - rss</samp>** ce qui nous téléporte dans */home/rss/* là on récupère ttrss avec **<samp>git clone https://git.tt-rss.org/fox/tt-rss.git</samp>**.

Quelques secondes plus tard vous avez tout d'installé dans le dossier */home/rss/tt-rss*.

Ensuite, si vous avez bien configuré votre nom de domaine et l'éventuel NAT, vous pouvez ouvrir la page *https://rss.lord.re/install* dans votre navigateur.

Ici il faut rentrer tout ceci :

  - Username : *ttrss*
  - Password : *truc*
  - Database name : *ttrss*
  - Host name : *localhost*
  - Port : *5432*

En appuyant sur **test configuration** les éventuelles erreurs (vous n'en aurez pas !) apparaîtront.
Ensuite en bas un joli bouton rouge avec **Initialize database** apparaîtra.

Et là ttrss va vous pondre un fichier de conf à poser dans */home/rss/tt-rss/config.php* et c'est bon.


## Mettre tout ça au boot
Alors on va rajouter au boot les différents services nécessaires :

  - **<samp>rc-update add nginx</samp>**
  - **<samp>rc-update add php-fpm7</samp>**
  - **<samp>rc-update add postgresql</samp>**

Il manque un dernier truc : ttrss possède un daemon en php allant régulièrement récupéré les différents flux RSS pour trouver les nouveaux articles.
On va rajouter ça proprement en créant un fichier de service (vous allez voir, c'est pas plus compliqué qu'avec systemd).

<details open><summary>/etc/init.d/ttrss</summary>
{{< highlight shell >}}
#! /sbin/openrc-run
name="Tiny Tiny RSS"
description="Tiny Tiny RSS update Daemon"
command="/usr/bin/php"
command_args="/home/rss/tt-rss/update_daemon2.php"
pidfile="/var/run/ttrss.pid"
start_stop_daemon_args="--user rss --chdir /home/rss/tt-rss --stdout /var/log/ttrss.log --stderr /var/log/ttrss.err --background"
depend() {
  use postgresql
}
{{< / highlight >}}
</details>

Et enfin **<samp>rc-update add ttrss</samp>** .
Et voilà.

Bon appétit !
