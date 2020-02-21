+++
Author = "Lord"
Description = "Petit récap des services auto-hébergés que j'utilise."
Categories = ["web", "autohebergement","adminsys"]
menu = "main"
notoc = true
PublishDate = 2018-03-24T22:07:29+02:00
date = 2018-04-27T22:07:29+02:00
title = "Mon environnement auto-hébergé"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/kxcyrd/mon_environnement_auto_h_berg"
TopWords = [  "musique", "backup", "rss", "sandstorm"]
+++
Ça fait un ptit moment que je voulais faire un point des services autoheberge que j'utilise.

## Mails
Allez on commence par les mails.
Je vous ai déjà pas mal bassinné avec ça mais bon un ptit point rapide.
**Vos mails sont une grande partie de votre identité numérique.**
Ils regorgent d'identifiants, de factures, de conversations, de pièces-jointes…

Bref, ça se refile pas au premier venu qui vous regarde gentiment avec des grands yeux et un grand sourire en vous disant qu'il s'en occupera gratuitement.
C'est l'un des services les plus importants à auto-héberger mais c'est aussi le plus chiant.

Avoir un serveur de mail pleinement fonctionnel n'est pas si difficile en soit.
Par contre faire en sorte qu'il fonctionne encore dix ans plus tard sans perdre de mail et voir ses mails acceptés partout… ce n'est pas la même affaire.
Je ne le recommande donc pas à tout le monde.
Pour le webmail j'ai longtemps utilisé Roundcube mais je suis désormais sur [Rainloop](https://www.rainloop.net/).
L'interface est un poil plus joli que Roundcube et passe mieux sur téléphone.

Et dans le fond j'utilise Postfix, Dovecot, [Rspamd]({{< ref "/posts/46-rspamd-rmilter" >}}), [Sisyphus]({{< ref "/posts/87-sisyphus-antispam" >}}).

## RSS
Dans les services web, un dont je suis ultra friand est l'aggrégateur de flux RSS/Atom.
Dans mon cas c'est [Tiny Tiny RSS](https://tt-rss.org/).
Malgré l'attitude quelque peu particulière du main dev, ce logiciel est excellent et super fiable.
Mon instance a soufflée sa 11ème bougie récemment, sa base de donnée s'est déjà fait migrer plusieurs fois et tout fonctionne encore sans aucune prise de tête.
Juste de temps à autres une update via l'interface web et hop je le backup même plus tellement je suis inconsc^W mal-habitué.

Les RSS sont ma source principale de news et autres.
J'adore le fait de pouvoir chopper des news de blogs très rarement mis à jour sans devoir vérifier constamment.
Et contrairement à Fb et compagnie c'est pas filtré, tout le contenu des créateurs est publié sans le faire passer à la caisse.

## Musique
Pour la musique j'ai une instance [Groovebasin](https://github.com/andrewrk/groovebasin) qui tourne.
Ça stream de la musique, gère les playlists, sait importer de la musique via youtubedl, ça normalize et surtout ça génère une playlist infinie.
Malheureusement c'est maintenant à l'abandon et il n'y a plus de mise à jour ni rien depuis des mois.

Un des reproches est que l'interface n'est pas du tout adaptée aux appareils tactiles (il faut double cliquer et parfois faire un clic droit)…
En dehors de ça pas grand chose à reprocher.
Je pense qu'il va tout de même falloir migrer si les developpements ne reprennent pas mais j'ai pas encore trouvé vers quoi.

J'ai déjà testé Ampache, Subsonic pour lequel je me suis même pris une licence d'un an, mpd, mais au final j'ai préferé Groovebasin.

## Galeries photo
J'en ai deux en parallèle sur la même base de photos.
La première basée sur [SFPG](https://www.sye.dk/sfpg/) en PHP mais sans base de donnée ni rien.
Pas mal du tout.
Ça marche sans broncher mais pas super moderne.

Puis j'ai découvert [PhotoFloat](https://git.zx2c4.com/PhotoFloat/about/) qui est par contre bien plus moderne.
Plus besoin de rafraîchir la page, ça charge quasi instantanément.
Bien plus agréable à utiliser mais c'est en Python, faut générer la galerie à chaque fois qu'on rajoute des photos (générateur de site statique quoi).
Pas de bol c'est plus trop maintenu (c'est le dev qui a aussi pondu les excellent [Password-store]({{< ref "/posts/36-gestionnaire-passwords" >}}) et aussi [Wireguard](https://www.wireguard.com/)).

## Cloud multi-services
Je me suis également monté un instance [Sandstorm](https://sandstorm.io/).
C'est une plateforme de cloud assez magique qui vous permet de faire tourner des services web très facilement.
Ce qui différencie Sandstorm de toute la concurrence (cozy, yunuhost, cloudron, …) c'est qu'ils ont une approche de la sécurité exotique.

Déjà il n'y a pas de mot de passe, ça fonctionne par tokens temporaires qui sont envoyés par mail.
Ensuite ils ont une approche *1 document = 1 instance*.

C'est à dire que si par exemple vous avez besoin d'un pad, sandstorm vous démarra une instance etherpad-lite.
Si ensuite vous voulez ouvrir un second pad, sandstorm vous démarra une nouvelle instance indépendante d'etherpad-lite.
Tout est fortement isolé.

Si vous partagez un document, vous obtiendrez une url unique que vous pouvez bloquer en écriture.
Et chaque personne à qui vous partagerez ce grain (c'est le nom des applis) aura une adresse unique.
Vous pouvez révoquer ces droits et tout.

C'est vraiment génial.
Par contre il y a quelques désavantages : les applis doivent être légèrement modifiées pour s'intégrer dans Sandstorm et le temps d'accès à un document est plus long que la normale vu qu'il faut le temps que la dite appli soit démarrée mais ça reste largement tolérable car de l'ordre de 3/4secondes.

## DNS
Avoir un nom de domaine c'est essentiel mais le gérer soit même c'est encore mieux !
J'utilise [Knot](https://www.knot-dns.cz/) qui est globalement assez simple et robuste.
Il permet de faire du DNSSEC facilement en plus.
Pas grand chose de plus à dire.
Il sait se faire oublier.

## Backup
J'utilise depuis très longtemps [Rsnapshot](http://rsnapshot.org/) qui permet de faire des backup incrémentaux en utilisant ce bon vieux rsync et de pousser ça via SSH.
Mais je dois avouer que je commence à reluquer sérieusement Borg Backup qui sait chiffrer de lui même du coup je couplerai bien ça avec un fournisseur de stockage externe genre [Wasabi](http://wasabi.com/).
C'est dans la catégorie "Pour plus tard” sauf que la mort de mon NAS/serveur bouscule un peu plus les priorités.

## Les services abandonnés
Voilà les services que j'ai actuellement.
J'en ai eu pas mal d'autres que j'ai stoppé au fil du temps.

À un moment j'ai tenté de croire à *xmpp* mais au final… bof. J'ai tout de même utilisé ejabberd, prosody, movim.
J'ai également fait mumuse avec *Identi.ca* mais c'était pas ma tasse de thé (bien que je commence à faire mumuse avec Mastodon depuis un an (sur octodon) ).

J'ai eu du *Wordpress* mais vite largué pour un simple fichier texte puis maintenant Hugo.
J'ai utilisé *Wok* aussi pour faire du site web statique.
J'ai presque utilisé *Dokuwiki* avant de me rendre compte que pour du perso c'est overkill, j'en ai vraiment pas besoin. 

J'ai également utilisé très peu de temps un service de localisation qui permet de voir en live (quand une page web était utilisée où se trouvait la personne). Je retrouve pas le nom du service et au final je ne m'en suis servi qu'une fois ou deux.

J'héberge ponctuellement un serveur *Quake 3* avec le mod CPMA mais ça ne dure rarement plus de quelques semaines.

J'ai utilisé de l'*OpenVPN* en perso aussi quelques temps avant de me rendre compte qu'un bête tunnel SSH est bien plus léger et tout aussi bien et avec bien moins de dépendances. Cela dit je pense me tourner vers du Wireguard bientôt.

J'ai essayé d'utiliser *Funambol* pour synchroniser des contacts et autre merdouilles avec le téléphone mais au final… bha ça me sert à rien. Je fais un backup manuel des contacts du téléphone tous les six mois et voilà…
Je dois surement en oublier quelques-un.

J'ai hébergé du *Mumble* durant ma folle période gamer.

Avant de migrer sur du pur Weechat, j'utilisais *ZNC* qui est donc un bouncer irc sur lequel je connectais Weechat sur l'ordi et un client irc sur l'Android mais maintenant j'utilise un client weechat sur le téléphone aussi.

Pour les synchro de fichier, j'ai utilisé *Syncthing* pendant quelques temps mais son fonctionnement un peu trop p2p n'était pas forcément ce que je recherchais le plus mais surtout sa trop grande gourmandise et son côté service de Schrödinger qui marche ou ne marche pas m'a vite saoulé.
Cela dit il y a eu un paquet de nouvelles versions désormais ptet que ces reproches n'ont plus lieu d'être.
