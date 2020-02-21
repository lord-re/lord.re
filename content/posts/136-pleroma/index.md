+++
Author = "Lord"
Description = "Pleroma est une alternative super intéressante à Mastodon surtout si vous souhaitez vous héberger votre instance à vous. Plus léger et plus simple à administrer que Mastodon, ça peut aisément tourner sur un ptit SBC."
Categories = ["fediverse", "mastodon","pleroma"]
menu = "main"
notoc = true
PublishDate = 2018-11-04T10:30:58+02:00
date = 2018-11-04T10:30:58+02:00
LastEdit = 2019-05-31T11:22:58+02:00
title = "Pleroma : L'alternative à Mastodon"
editor = "kakoune"
TopWords = [  "postgresql", "mix", "fediverse", "nginx", "plume", "mastodon", "pleroma"]
+++

Je me suis monté une instance Pleroma perso.
Il y a peu je vous chantais les louanges de l'interface de Mastodon et là PAF je vous parle de la concurrence !

Pleroma est logiciel de microblog fédéré compatible OStatus et s'appuyant sur ActivityPub.
Cette description devrait faire tilt chez certains d'entre vous : « Mais c'est de Mastodon qu'il parle le con ! »
Et bien oui et non.

## Pleroma == Mastodon ?
*Pleroma est une alternative à Mastodon mais participe au même réseau : le Fediverse.*
Ça veut dire que n'importe qui sur Pleroma peut s'abonner à un mastonaute et vice versa.
Tout comme on peut également s'abonner à un compte Peertube, à une instance Plume, à un compte PixelFed…
Bref, *le nouveau web décentralisé et fédéré*.

{{< img src="pleroma.thumb.png" link="pleroma.png" alt="capture d'écran de l'Interface MastodonFE pour Pleroma" title="C'est très proche de Mastodon, hein ?" >}}

Mastodon est le logiciel le plus populaire du Fediverse avec le plus grand nombre d'instances et d'utilisateurs.
Mais il existe pas mal d'autres logiciels dans le Fediverse avec des buts différents.
Beaucoup sont orientés microblog (à la twitter) dont Pleroma et GnuSocial.
*Pleroma est très proche de Mastodon dans son fonctionnement*, au point d'avoir même un fork de l'interface par défaut de Mastodon avec de très légères modifs.
Du coup Pleroma propose actuellement deux interfaces différentes : PleromaFE se basant sur une colonne de contenu et MastodonFE se basant sur un nombre variable de colonnes configurables.
Pleroma est bien moins connu mais mériterait plus de reconnaissance et de popularité dans le Fediverse.

## Mon indépendance
J'ai utilisé un compte Mastodon d'ailleurs pendant un peu plus d'un an et demi.
Mais je squattais une instance choisie un poil au hasard (mais ça s'est avéré un excellent choix avec une super admin et tout).
Je n'ai pas l'habitude d'utiliser des services que je n'administre pas en dépendant du bon vouloir de quelqu'un d'autre, du coup ça fait un bail que ça me titillait de me monter une instance Masto.
Bref je me suis monté une ptite instance Pleroma (voir plus bas) uniquement pour moi et j'en suis super content.

## Pourquoi du Pleroma au lieu du Mastodon ?
Parceque *contrairement à Mastodon ça consomme trois fois rien, pas cinquante dépendances et bha pour l'instant ça tourne automagiquement*.
Je n'ai pas encore eu d'upgrade majeure (juste du <samp>git pull</samp>, <samp>mix deps.get</samp>, <samp>/etc/init.d/pleroma restart</samp>) mais pour l'instant rien à déplorer.
Un ptit downtime de trois minutes à chaque fois et c'est reparti.

Un des points forts de Pleroma est qu'il s'agit d'une implémentation un peu plus stricte d'ActivityPub par rapport à Mastodon.
En interne, Pleroma fonctionne nativement en ActivityPub et suit plus les spécifications.
Du coup *si vous suivez un blog Plume parlant ActivityPub, vous voyez les articles complets avec leur formattage.*
*Pleroma arrive à se fédérer à plus de services différents que Mastodon.*

{{< img src="plume-from-masto.thumb.png" link="plume-from-masto.png" alt="Un article du blog Funkwhale vu depuis Mastodon." title="Vu depuis Mastodon c'est pas la joie." >}}
{{< img src="plume-from-pleroma.thumb.png" link="plume-from-pleroma.png" alt="Un article du blog Funkwhale vu depuis Pleroma avec le formattage et l'article complet." title="Vu depuis Pleroma c'est bien plus joli." >}}

Le souci c'est que Mastodon étant devenu le mastodonte du Fedivers (facile celle-là), il faut se plier à ses façons de faire et être compatible avec lui.
Mais la communauté étant plutôt bienveillante tout s'arrange assez vite et tout progresse dans la bonne direction.

## Monter son instance
Sur Alpine Linux c'est un poil plus exotique mais c'est pas pour autant compliqué.
Elixir est un peu chiant, car il veut compiler des trucs avec gcc.
Bref il va vous falloir install tout un tas de trucs avec **<samp>apk add elixir erlang-runtime-tools erlang-tools erlang-xmerl gcc make musl-dev postgresql postgresql-contrib</samp>** .

J'ai créé un user spécialement dédié, ensuite un ptit git clone depuis [leur gitlab](https://git.pleroma.social/pleroma/pleroma).
On installe les dépendances via **<samp>mix deps.get</samp>** et enfin on conf la bête avec **<samp>mix generate_config</samp>**.
La conf générée est à mettre dans *config/prod.secret.exs* (ouai n'ayant jamais tripotté d'Erlang avant on est dépaysé par ces commandes et ces extensions de fichiers).

On crée la base postgresql via le script fourni **<samp>su postgres -c "psql -f config/setup_db.psql"</samp>** .
Yapuka démarrer ça tout seul avec un fichier d'init fait maison genre 
{{< highlight bash >}}
#! /sbin/openrc-run
name="Pleroma"
description="Pleroma : social network qui poutre."
depend() {
  use postgresql nginx
}

start() {
  ebegin "Starting Pleroma"
  start-stop-daemon -v --start --exec "/usr/bin/mix" --user "pleroma" --chdir "/home/pleroma/pleroma" --env "MIX_ENV=prod" --background --stdout "/var/log/pleroma.log" --stderr "/var/log/pleroma.err" --make-pidfile --pidfile "/run/pleroma" -- "phx.server"
  eend $?
}

stop() {
  ebegin "Stopping Pleroma"
  start-stop-daemon --stop --exec "/usr/bin/mix phx.server" --user "pleroma" --chdir "/home/pleroma/pleroma" --env "MIX_ENV=prod" --pidfile "/run/pleroma"
  eend $?
}
{{< / highlight >}}

Il vous reste plus qu'à copier (et adapter un peu) la conf nginx fournie : **<samp>cp installation/pleroma.nginx /etc/nginx/conf.d/pleroma.conf</samp>**.
Là il faut changer le *server_name* (à deux endroits), l'emplacement des clés *ssl_trusted_certificate* et *ssl_certificate* et enfin *ssl_certificate_key* ~~et enfin le *connect-src 'self' wss://example.tld*~~ et à reload votre nginx.

Ça y est, vous avez votre instance prête à démarrer.
Vous allez pouvoir créer votre utilisateur et commencer à follow vous amis du Fediverse !

Bon ça prend rien en CPU, concernant le skeudur par contre ça augmente (enfin uniquement la base de donnée).

| |   DB Postgres   |   /home/pleroma   |
|:-:|:-:|:-:|
|29/10/2018| 26 Mo | 144.5 Mo |
|04/11/2018| 88 Mo | 144.9 Mo |
|20/11/2018| 320Mo | 161.5 Mo|
|02/02/2019| 1212 Mo | 256.4 Mo|
|18/03/2019| 1809 Mo | 280.4 Mo|
|31/05/2019| 5021 Mo | 345.7 Mo|



## Migration de Mastodon vers Pleroma
Par défaut *la limite de caractères est de 5000* ce qui est au moins dix fois mieux que les 500 de Mastodon.

Pour migrer depuis Mastodon, j'ai exporté la liste de comptes que je follow que j'ai ensuite importé dans Pleroma.
Ça m'a permis de *très vite peupler ma federated timeline et de retrouver tous les gens que je suivais auparavant*.
Et d'ailleurs, fait amusant, comparé à Mastodon, on voit également les réponses des gens que l'on follow quand la conversation est initiée par des gens que l'on ne follow pas, ce qui permet de facilement trouver des gens potentiellement intéressants.

*Dans les options de compte Mastodon, on peut indiquer le nouveau compte vers lequel on migre* ce qui permettra aux gens de volontairement vous suivre sur le nouveau compte.

Autre bon point, *les applis pour Mastodon sont compatibles avec Pleroma* : j'utilise encore Tusky sans rien faire de particulier.

Bref, *j'ai pas perdu de contenu et je n'ai pas changé mes habitudes* : j'utilise MastodonFE qui est l'interface de Mastodon avec quelques légères modifications : les colonnes s'adaptent en largeur toutes seules.
Par contre j'ai perdu tous mes followers… pas un drame, si les gens aimaient ce que je publiais avant, ils aimeront ce que je publie maintenant et me followeront à nouveau.

Si vous débutez dans le Fediverse et que vous voulez avoir un minimum d'indépendance, il est probablement préferrable de vous monter une instance Pleroma plutôt qu'une instance Mastodon.
C'est plus simple et plus léger tout en étant quasi identique (voire mieux) à l'utilisation.
Par contre je ne sais pas comment ça se comporte avec de multiples utilisateurs, peut-être que ça monte moins en charge que Mastodon…

--------------------
EDIT : 20/11/2018 : Pleroma envoie les bons headers HTTP de lui même donc plus la peine de faire ça via Nginx. Merci *Tetsumaki*.
