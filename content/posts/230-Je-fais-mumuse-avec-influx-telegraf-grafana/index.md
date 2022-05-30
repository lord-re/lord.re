+++
Author = "Lord"
Description = "Je redécouvre Influx Telegraf Grafana. Je remet en place tout ce petit monde sur mes machines à la maison. Dans ce premier article on défriche et on met en place une base saine que l'on exploitera un peu plus dans un autre post."
Categories = ["graph", "monitoring"]
menu = "main"
notoc = true
WritingDate = 2022-05-29T08:31:40+02:00
date = 2022-05-30T18:31:40+02:00
title = "Je fais mumuse avec influx telegraf grafana : vol.1"
editor = "kakoune"
+++
Haaa le monitoring.
C'est un truc marrant : certains en sont passionnés mais moi c'est par vague.
Je suis plus attiré par les beaux graphs que le monitoring et alerting pour ma part.

Il y a douze ans (wow) j'avais écrit [une merdouille concernant **Munin**]({{< ref "/posts/11-muninons-reseau" >}}) (ouai c'était vraiment pas top ce que j'écrivais à l'époque, je me suis un peu amélioré).
Et c'est vrai que depuis j'avais un peu laissé tomber.

Je m'y étais remis quand j'ai découvert en 2014 le new cool kid qui débarque **InfluxDB** et son cher **Telegraf** en 2014.
C'était la folie à l'époque : un truc ultra simple à installer, une conf par défaut qui est bien foutue et 0 dépendance, ça changeait réellement de **Munin**.
Le truc c'est que c'était un peu jeune à cette époque et le format de données a changé, il y avait un peu de doc mais c'était succint et surtout pour générer les graphs bha … il n'y avait pas grand-chose.
**Grafana** venait de naître mais n'était pas connu, n'avait pas sa communauté et ses tutos qui vont avec.
**Telegraf** était cool mais ne savait pas relever beaucoup de métriques différentes.

Du coup, bha j'ai fait d'autres trucs.
Parceque autant j'aime bien monitorer mais j'en ai pas trop l'intéret non plus dans le cadre perso et ce n'est pas mon boulot dans le pro.
Donc après avoir fait mumuse avec quelques semaines/mois au final j'ai viré le truc.

## Mon objectif
Et nous voilà en mai 2022 et là je sais pas trop pourquoi je voulais m'y remettre un peu.
Faut dire que je commence à avoir pas mal de ptites machines à la maison et que j'aimerais savoir comment elles vont assez vite.

Le truc c'est que ce sont des machines sous **Alpine** ou **Gentoo** et **OpenWRT** (pfiouu pas de windows).
J'ai des archis CPU variées avec de <abbr title="un cpu classique">amd64</abbr>, de l'<abbr title="cpu arm un peu vieux mais pas trop">armhf</abbr> et de l'<abbr title="cpu arm moderne">arm64</abbr> et là c'est moins simple.

Bon, monitorer les machines c'est bien mais c'est pas non plus mon kif.
C'est le genre de truc que je vais mettre en place et jamais consulter.
Non un *truc qui m'amuse beaucoup plus et qui m'est plus utile : monitorer les trucs à la con !*

Chaque semaine je relève mes *compteurs de gaz, d'électricité et d'eau* à la main.
J'ai bien un linky mais les autres ne sont pas connectés mais bon ça me prend trente seconde chaque jeudi (ou vendredi si j'ai zappé).
Mine de rien j'ai déjà un historique assez précis de 6 ans de relevés dont je ne suis pas peu fier.
Je me suis même fait un ptit programme en Go qui lit ce CSV et calcul les deltas d'une semaine à l'autre ce qui me permet d'avoir des données un peu plus exploitables.

Une autre donnée un peu exotique est le *relevé de température et d'humidité relative*.
J'ai une ptite sonde USB toute mimi pour ça.
C'est du matos libre avec firmware libre qui ne fait que ça et très efficacement.
Le souci c'est qu'ils n'en fabriquent plus mais c'est bon j'ai les miennes…
J'ai à peu près deux ans de relevés que je n'avais pour l'instant pas exploités qui sont eux aussi dans un CSV que j'alimentais chaque quart d'heure.
*J'aimerais beaucoup avoir une sonde de CO2 du même type si vous en connaissez* (qui ne nécessite pas de soft tordu et qui ne coûte pas une fortune).

Un peu plus exotique : *monitorer mon pognon*.
J'utilisais **Budgea** en version web qui est un service qui permet d'avoir des graphs sur le pognon, se fixer des alertes en fonction du montant et du type de dépenses.
Bref, des trucs plus trop exotiques mais qui l'étaient lorsqu'ils ont débutéss.
Malheureusement ils passent en version appli android uniquement et ça … bha … ça ne me plaît pas du tout.
Merci pour le service mais du coup je vais arrêter du coup.
Ces gens contribuent beaucoup à **Woob** (ce sont les mêmes gens) qui est un soft de scraping qui a de très nombreux modules pour les banques.
En gros le logiciel sait se connecter à vos banques et extraire votre balance.
C'est pile ce qu'il me faut, il n'y a plus qu'à grapher.

Je *monitore mon poids* aussi.
C'est encore une fois manuel avec une balance basique (qui n'est vraiment pas précise).
Toute la maison y passe.
Bon en pratique ça fait quelque temps que je zappe un peu de le faire, c'est vraiment irrégulier.
Mais j'ai quand même pas mal de relevés qui méritent leur courbe.

## Cheminement (zappable si vous voulez vraiment)

### Tout d'abord InfluxDB
Bon j'ai donc commencé par installer **InfluxDB** sur une machine.
Par chance ça se trouve dans les dépôts d'**AlpineLinux** donc c'est installé en deux temps une commande.

Bon je commence à regarder la conf dans */etc/influxdb.conf* et … bha j'y connais rien.
Mais le fichier fourni est tout joliment fait.
Il a toutes les options existantes de déjà renseignées et commentées avec leur valeur par défaut.
Et chaque option a deux trois lignes d'explications avec.

J'adore ce genre de fichier de conf par défaut ça permet de comprendre pas mal de trucs sans même aller voir une doc ou un tuto.

Bon et du coup, je n'y ai rien changé.

### Ensuite Telegraf
Là c'est un peu pareil.
C'est aussi dans les dépots d'**AlpineLinux** du coup ça s'installe sans souci.

Et pareil on a fichier de conf comme je les aime.
Accrochez-vous par contre, il fait 9700 lignes…

Dans celui-là il va falloir décommenter les différents plugins que vous voulez activer.

FIXME


### Et pour finir Grafana
Dernière brique à installer.
Pareil c'est dans les dépots, on installe et on lance et ça y est ça marche.

Quel pied.

Bon alors je mets connecte en SSH à la machine où ça tourne et je me fais un ptit tunnel de port pour accéder à Grafana sans ouvrir le port à l'extérieur (<kbd>ssh grafana -L 3000:localhost:3000</kbd> puis dans le navigateur on ouvre http://localhost:3000 et c'est bon on tombe bien sur la bête).
Dans mes souvenirs c'était la brique la plus ardue à prendre en main.
Donc j'ai un peu d'appréhension.

Le système permet de créer de multiples dashboards qui eux contenir des panels.
Ils fournissent sur leur site des dashboards préconstruits ce qui permet de ne pas trop se salir les mains.
Mais franchement, c'est pas si fun et puis on apprend pas trop si on s'en contente.

J'ai donc pris un dashboard pour telegraf et je vais aller picorer dedans.

### Proprifions tout ce merdier

### Grafana
Bon on va commencer par clarifier l'accès à Grafana en ajoutant ce qu'il faut dans mon reverse proxy **nginx**.
Je crée une nouvelle entrée dans ma zone DNS qui pointe vers la machine hébergeant nginx.

Ensuite, je crée un vhost nginx dédié qui contient ce qu'il faut pour joindre le **grafana**.
Le souci c'est que ce dernier n'écoute que sur localhost.

J'édite donc le bout de conf **Alpine** où se trouve la conf pour **grafana** (donc le */etc/config/grafana*) et je le fais écouter sur son IP du LAN et je lui donne le <abbr title="le nom d'host, hein">domain</abbr> sur lequel il va recevoir les connexions.

Un ptit coup de <kbd>acme.sh issue --domain le.domain --nginx</kbd> et une petite édition du vhost nginx plus tard et c'est bon.
Le domaine et son certificat tourne.

<details><summary>/etc/nginx/conf.d/grafana.conf</summary>
{{< highlight "nginx" >}}
# this is required to proxy Grafana Live WebSocket connections.
map $http_upgrade $connection_upgrade {
default upgrade;
'' close;
}

server {
listen 80 ;
listen [::]:80 ;
listen 443 ssl http2;
listen [::]:443 ssl http2;

#if ($scheme = http) { return 301 https://$server_name$request_uri; }

server_name le.domai.ne;
access_log /var/log/nginx/le.domai.ne.access.log;
error_log /var/log/nginx/le.domai.ne.error.log;

include ssl.conf;
ssl_certificate /root/.acme.sh/le.domai.ne/fullchain.cer;
ssl_certificate_key /root/.acme.sh/le.domai.ne/le.domai.ne.key;

gzip_vary on;
gzip_static on;
brotli_static on;
gzip_proxied any;
gzip_comp_level 6;
gzip_buffers 16 8k;
gzip_http_version 1.1;
gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/activity+json application
/atom+xml;

charset utf-8;


location /.well-known/acme-challenge {
   alias /var/www/acme;
}

location / {
proxy_set_header Host $http_host;
    proxy_pass http://10.0.0.250:3000/;
}

 # Proxy Grafana Live WebSocket connections.
location /api/live {
rewrite  ^/(.*)  /$1 break;
proxy_http_version 1.1;
proxy_set_header Upgrade $http_upgrade;
proxy_set_header Connection $connection_upgrade;
proxy_set_header Host $http_host;
proxy_pass http://10.0.0.250:3000/;
}

}
{{< / highlight >}}
</details>

Bon pour **Grafana** c'est propre vu qu'il sait gérer tout seul l'authentification et ce qu'on a fait.
Maintenant au tour de **InfluxDB**.

### InfluxDB
Bon on répète les mêmes étapes : création d'une entrée DNS, création d'un vhost, création d'un certif.

Par contre ce coup-ci on lui ajoute un peu d'auth vu qu'il ne le fait pas de lui-même.

Donc on installe **htpasswd** avec <kbd>apk add apache2-utils</kbd> puis on se crée un utilisateur avec <kbd>htpasswd -c /etc/nginx/influx_auth_db user</kbd>.
Et on l'ajoute dans le vhost avec <kbd>auth_basic_user_file /etc/nginx/influx_auth_db;</kbd> et c'est bon.

On a donc un reverse proxy qui permet d'avoir un peu d'auth et de la crypto.
On peut exposer ça sur le net sans trop de risque.


## Une base saine pour la suite.
Ça y est tout est en place et on a tout qui fonctionne.

Bon ça commence à être un peu long donc pour la partie plus croustillante on verra plus tard, hein.
