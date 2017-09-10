+++
Description = "Ma ptite infra perso pour cacher les downtime sur mon site perso."
PublishDate = "2017-09-24T22:01:38+02:00"
notoc = true
menu = "main"
date = "2017-09-24T22:01:38+02:00"
title = "Microcache nginx pour améliorer les perfs et diminuer le downtime"
Tags = ["www","software","adminsys","tips"]
Categories = ["www","software","adminsys","tips"]

+++
Depuis que mon serveur ne me sert plus de routeur il m'arrive de le couper de temps à autres. Et pourtant mon site reste accessible. J'ai en fait, sur mon routeur, installé un container avec un nginx qui tourne et qui proxy. Les connexions se font donc via le nginx du routeur qui sert de cache quand le vrai serveur ne répond pas. Mais histoire de ne pas avoir de contenu pas à jour mais toujours d'une fraîcheur exemplaire je me contente d'un cache de maximum 1seconde.

## 1s de cache
Oui oui une seconde suffit. Bon dans mon cas c'est overkill car mon site est statique mais pour des sites dynamiques à fort trafic c'est clairement valable. Fournir un contenu vieu d'un seconde n'est généralement pas gênant. Par contre la différence de perf est assez énormissime.

Mais au delà de ça, si on rajoute deux trois options de configuration, vous pourrez vous prémunir des downtime (ce que je recherchais surtout).

Bon on va définir **le_cache** qui va être l'endroit où seront stockées nos données en cache : ```proxy_cache_path /var/www/cache keys_zone=le_cache:1m max_size=20m inactive=10d use_temp_path=off;```

Bon sur la machine qui va vous servir de proxy vous allez dans la conf du bel nginx */etc/conf/nginx/nginx.conf* vous ajoutez la conf du vhost:
```
server {
        listen 80;
        listen 443 ssl http2;
        server_name www.lordtoniok.com lordtoniok.com bender.lordtoniok.com www.lord.re lord.re bender.lord.re _;
        include ssl.conf;
        ssl_certificate /etc/ssl/acme/lord.re/fullchain.pem;
        ssl_certificate_key /etc/ssl/acme/private/lord.re/privkey.pem;
        location /.well-known/acme-challenge {
            alias /var/www/acme;
        }
        location / {
                proxy_cache le_cache;
                proxy_pass http://10.0.0.1;
                proxy_cache_use_stale error timeout http_404 http_403;
                proxy_cache_valid any 1s;
                add_header X-Cache-Status $upstream_cache_status;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
								proxy_buffering off;
        }
}
```
La magie se trouve dans le ***proxy_cache_use_stale*** qui fait en sorte d'envoyer le cache si le serveur upstream ne répond pas.

Désormais je peux couper le serveur sans que ça ne se voit. Ça peut permettre de mettre à jour l'esprit libre. Sur un site dynamique ça peut énormément booster les perfs sans trop de détriments (surtout avec juste 1s de cache).

Le ```proxy_buffering off;``` n'est peut-être pas adapté à votre cas mais si je ne le met pas, lorsqu'un bienveillant internaute tente de récupérer un fichier un poil gros (plus de quelques Mo) bha ça déconne de partout car la machine a peu de ram, donc ça rentre pas en ram, donc nginx tente de fouttre ça dans le cache, mais comme j'ai restreint le cache à 20Mo… bha si ça rentre pas dedans ça merdoie et ça n'envoi plus les données. Voilà voilà.

