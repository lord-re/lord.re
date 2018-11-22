+++
Author = "Lord"
Description = "Je suis fatigué de voir les gens se faire du mal à utiliser Certbot. LetsEncrypt fonctionne grâce au protocole ACME qui est implémenté par pas mal de clients. Certains sont vraiment mieux que Certbot !"
Categories = ["tls", "sécu"]
menu = "main"
notoc = true
PublishDate = 2018-11-22T20:41:59+01:00
date = 2018-11-22T22:17:59+01:00
title = "Clients ACME Pour Letsencrypt"
editor = "Kakoune"
+++
La vague de blogposts concernant LetsEncrypt a l'air de s'être dissipée, du coup j'en profite pour en remettre une couche.

LetsEncrypt c'est une Autorité de certification gratuite mais ce n'est pas leur seule contribution.
LetsEncrypt c'est également une automatisation pour la génération/signature des certificats x509 via un protocole [normalisé](https://tools.ietf.org/html/draft-ietf-acme-acme-16) : **ACME**.

Du coup, il y a le serveur (le logiciel se nomme *Boulder* et est libre lui aussi, vous pouvez [le trifouiller depuis son dépot](https://github.com/letsencrypt/boulder)) qui est peu connu mais surtout les clients.
Et j'ai bien dit LES clients.

## Certbot
Avant de s'appeler **Cerbot** c'était **LetsEncrypt** mais la confusion entre l'autorité de certification et l'outil a poussé à le renommer.
Il s'agit du client officiel et est donc le plus populaire.

Et c'est là que je vais jouer les grognons : *il est pas terrible* et chaque fois que je vois des gens l'utiliser j'ai mal pour eux.

### Trop lourd
Il est écrit en Python et déjà ça commence comme un point noir : sur des install Linux minimaliste, Python est déjà suffisamment massif pour être contraignant.
Je sais que pas mal de monde me trouve un peu trop extrémiste sur ce sujet et pourtant je persiste : *installer autant de paquets pour ça me paraît absurde*.

Chaque paquet que l'on installe est un potentiel de bugs et de failles et augmente d'autant la maintenance nécessaire.
*Avoir un système minimaliste est une des composantes de la sécurité* (réduire la surface d'attaque).

### Il s'auto-update
Ouai pour la sécurité c'est bien.
Mais par contre ça prend une plombe.
Et surtout *il arrive que parfois ça se passe mal*.
Je l'ai déjà rencontré le coup du “Tiens mais pourquoi le certif est expiré, pourtant j'ai bien cronné cerbot !” qui déconne à cause de ses updates (et biensûr 0 supervision sur cette machine :-°).

### Il touche potentiellement à la conf de votre serveur web
Ouai pour certains c'est un argument de vente mais pour moi absolument pas.
*J'aime pas qu'on touche à mes précieux fichiers de conf*.

## Les autres
Bon, j'ai pas donné trop d'arguments contre certbot mais c'est suffisant pour au moins aller voir la concurrence.

Il y en a dans tous les langages, tous les formats.
Je ne les listerai pas, car je les ai pas tous testés, mais je vais vous en recommander deux différents.

### Acme-client
[Celui-là](https://kristaps.bsd.lv/acme-client/) est en bon vieux C des familles.
C'est-à-dire que vous aurez pas grand chose à installer : *très peu de dépendances*, pas d'interprêteur ni de machine virtuelle pour le faire tourner.

Il est *issu de chez OpenBSD*, ce qui est pour moi un gage de qualité (notez que je dis ça mais j'ai jamais fait tourner de BSD… une fois goûté Gentoo, on ne veut plus aller ailleurs).
Il est *dispo chez Gentoo et Alpine* (entre autre) ce qui couvre mes besoins et *s'appuie sur LibreSSL*.

Il ne gère que le challenge **http-01** ce qui suffit pour la majorité des cas (pas de wildcard du coup) et il va falloir confer votre serveur web comme il faut pour que ça tourne tout seul.
*Il s'automatise super bien, est très rapide et le code stable*.

### Dehydrated
[Celui-ci](https://github.com/lukas2511/dehydrated), est en fait un *simple script bash* avec tous les outils qu'il faut lier les uns aux autres.
Enfin simple script bash… il est tout de même super complet et fiable.
*Il utilise des outils qui ont fait leurs preuves*, les dépendances les plus exotiques sont *openssl* et *curl*, c'est dire.

Il est plus complet qu'acme-client dans le sens où *il gère également le challenge* **dns-01** ce qui vous permettra d'avoir un certificat wildcard.

Le fait d'être un script bash signifie qu'*il est compabtible avec à peu près tous les nunux*, c'est donc ma solution de repli quand acme-client n'est pas dispo.
Un seul fichier à transférer pour l'installer, ensuite un fichier de conf à remplir et éventuellement un hook pour recharcher votre serveur.
Le ptit fichier de conf de la doc est bien commenté de partout, il n'y a pas de surprise.

-------------------------

Voilà j'espère qu'avec ce ptit article je vous donnerai l'envie d'aller voir un peu les alternatives.
Certaines peuvent probablement répondre mieux à vos besoins que Certbot.

Et merci LetsEncrypt pour tous ces certs.
