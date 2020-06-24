+++
Author = "Lord"
Description = "Petite astuce pour renouveler le certificat LetsEncrypt utilisé par Weechat pour le relay de façon automatique. Un peu de cron et utilisation de la fifo de weechat."
Categories = ["irc", "cli","sécu"]
menu = "main"
notoc = true
PublishDate = 2018-09-25T19:01:54+02:00
date = 2018-09-25T19:01:54+02:00
title = "Sécuriser le relay Weechat avec LetsEncrypt"
editor = "kakoune"
TopWords = [  "interfaces", "letsencrypt", "pem", "vhost", "irc", "nginx", "ssl", "acme", "relay", "weechat"]
+++
Weechat (le meilleur client IRC de tous les temps et de loin) possède un fonction super sympa : *le relay*.
Il permet soit à un autre client IRC de se connecter à Weechat comme un bouncer soit à des interfaces de Weechat de se connecter.

## Les interfaces Weechat

Il y en a plusieurs selon les besoins.

Il y a [Weechat-Android](https://github.com/ubergeek42/weechat-android) qui est pour les moins perspicaces une interface pour les smartphones Android.
L'interface utilisateur est vraiment pas mal, c'est pas moche et c'est très fonctionnel.

Également vous pourriez être intéressé par [Glowing Bear](https://www.glowing-bear.org) qui est une interface Web qui permet donc d'avoir accès à votre client favori directement dans votre navigateur.
Elle possède en plus quelques ajouts sympa comme la prévisualisation des images directement dans le chat, pareil pour les tweets, les vidéos Youtube, on s'approche d'un clone systèmes de chats à la Matrix/Slack/Mattermost (comme quoi ça peut se faire via IRC également).
Cette interface est en plus assez Michu-Friendly.

Il en existe quelques autres que je ne vais pas lister.

## Le relay

Donc ces interfaces ne sont pas des clients IRC complets mais juste une interface utilisateur pour Weechat.
Il faut donc un Weechat qui tourne dans un coin (ou ailleurs) et le configurer pour activer le **relay**.

Un simple **<kbd>/relay add ssl.weechat 5002</kbd>** fera l'affaire.

Et qui dit SSL, dit certificat et compagnie donc *LetsEncrypt*.

### Chez Alpine

Je vous ai pas assez parlé d'Alpine Linux.
C'est une super distro ultra légère et tout, je vous ferai un article à ce propos un de ces quatre.

Voyons comment faire pour avoir notre petit cert en deux minutes :

**<kbd>apk add nginx acme-client</kbd>**

On conf le ptit *Nginx* pour qu'il puisse s'occuper tranquilou de servir le <abbr title="Le système permettant de prouver que vous contrôler le domaine pour lequel vous demandez un certificat">challenge LetsEncrypt</abbr>.
Donc dans */etc/nginx/conf.d/votre.vhost.truc.conf*

>        location  ^~ /.well-known/acme-challenge {
>                allow all;
>                alias /var/www/acme;
>        }

Un ptit **<kbd>/etc/init.d/nginx reload</kbd>** (ça vous rapelle les bons souvenirs où ça marchait bien, hein les debianneux ?).

Et maintenant on crée le script qui sera exécuté chaque semaine pour mettre à jour votre certif :

{{< highlight bash "linenos=table" >}}
#!/bin/sh
weerenew(){
        cat /etc/ssl/acme/private/votre.vhost.truc/privkey.pem /etc/ssl/acme/votre.vhost.truc/fullchain.pem > /home/lord/.weechat/ssl/relay.pem
        printf '%b' '*/relay sslcertkey\n' > /home/lord/.weechat/weechat_fifo
}
hosts="votre.vhost.truc"
for host in $hosts; do
        acme-client -a https://letsencrypt.org/documents/LE-SA-v1.2-November-15-2017.pdf -Nnmv $host && renew=1
done
[ "$renew" = 1 ] && rc-service nginx reload && weerenew
{{< / highlight >}}

Et vous l'exécutez et c'est tout bon, plus besoin de s'en soucier.

L'astuce réside dans le fait de concaténer la *privkey* et le *fullchain* dans le *relay.pem* et ensuite d'envoyer la commande */relay sslcertkey* dans la fifo de weechat.
Comme ça, de l'extérieur du client IRC vous déclenchez le rafraîchissement du certificat par Weechat.
