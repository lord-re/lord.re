+++
Author = "Lord"
Description = "Et si les FAI devenaient des ISP ? Au lieu de vous vendre des services vous rendant dépendants, ils pourraient vous aider à vous auto-héberger pour vous libérer des GAFAM."
Categories = ["autohebergement", "réseau","impossiburu"]
menu = "main"
notoc = true
PublishDate = 2018-07-30T16:38:36+02:00
date = 2019-08-20T16:38:36+02:00
title = "De FAI a ISP"
editor = "kakoune"
+++
Un truc que j'ai toujours trouvé intrigant c'est la différence de traduction entre le Français et l'Anglais pour "F.A.I.".
En Français c'est donc *Fournisseur d'Accès Internet* alors que dans la langue de <abbr title="Excellente série à dévorer basé sur des bouquins de Douglas Adams le papa de H2G2">Dirk Gently</abbr> on dit plutôt "I.S.P." pour *Internet Services Provider* que l'on pourrait se risquer à traduire mot-à-mot par *Fournisseur de Services Internet*.

## Accès à Internet
Donc d'un côté on nous fournit un accès à l'Internet.
Ce qui veut dire que l'*on nous relie physiquement à des millions d'autres machines à travers le monde*.
Oui oui, les machines sont réellement reliées entre elles physiquement.
En dehors du wifi et autres connexions sans-fil, on pourrait s'amuser à aller de votre ordinateur jusqu'au mien en suivant des fils serpentant à travers le monde.

Mais en plus de ce lien physique, il y a bien évidemment un peu plus.
Le FAI va vous prêter une adresse IP qui sera votre adresse pour que les autres puissent vous joindre.
Un bon FAI devrait se contenter de cela, en s'assurant que ses interconnexions avec les autres réseaux soient toujours au top niveau fonctionnement.

S'il fait plus que cela, c'est généralement pas par bonté d'âme.

Par exemple, un FAI pourrait vous fournir l'appareil faisant l'interconnexion entre votre réseau local et son réseau à lui.
Cet appareil est un routeur, mais il faut avouer que c'est pas un nom des plus sexy, donc autant l'apeler **box** et tant qu'à faire, maintenant qu'on a un pied chez l'abonné, *autant y rajouter des fonctionnalités pour le rendre un peu plus captif*.

Tiens, on va lui donner un peu de téléphonie, ça coûte plus grand-chose et les autres le font donc pour pas perdre pied face à la concurrence on le fait.

Ho et puis *la téloche c'est quand même le meilleur moyen de remplir les caisses* : vendre un abo par-ci par-là, quelques VOD et hop, on double rapidement la facture mensuelle de l'abonné.

Bref ces services supplémentaires s'appuient sur le réseau Internet mais au final ne sont pas vraiment des services propres à l'Internet.
L'Internet n'est ici qu'un simple moyen de transport interne au réseau de l'opérateur.
Ces services ne sont pas issus de réseaux extérieurs à votre FAI.

## Services Internet
Mais du coup ça serait quoi des services Internet ?
Il fut un temps, un des ptits arguments de vente des FAI étaient **la mise à disposition d'un hébergement de pages web** plus ou moins poussées.
Un peu de stockage web, éventuellement du PHP et le grand luxe de l'époque : l'accès à une base de donnée Mysql.
Et hop chacun des abonnés peut avoir un ptit site ouaib à peu près gratuitement.
À une époque pas si reculée, Free hébergeait pas mal de contenu vraiment sympatique, créé par ses abonnés.
Mais ça devient de moins en moins utilisé, les utilisateurs se tournant vers d'autres systèmes.

Avant le tout web, il existait des "forums de discussions" par Internet fonctionnant un peu comme les mails.
Et ça a d'ailleurs été un poil détourné pour s'échanger des fichiers de toutes sortes (ahoy !).
Ça s'appelle les **Newsgroups** et il y a quelque temps c'était un des arguments de vente de Free qui proposait un accès gratuit dans son abonnement (mais faut pas se voiler la face, c'était assez foireux).

Les FAI proposent tous de vous créer une **adresse mail** qui est l'une des bases de l'Internet.
Ce n'est par contre pas la panacée : une fois votre boîte créée chez un FAI, vous êtes à la mercie de son bon vouloir en cas de résiliation.
Mais c'est un service purement Internet.

Fût un temps, Free proposait même un service ultra original pour l'époque, **la possibilité de streamer**.
Mais contrairement à maintenant où c'est rentré dans les mœurs, c'était il y a dix ans et diffusé directement sur la téloche (via la box).
Ça s'apelait *TV Perso*.
Et franchement à l'époque c'était ahurissant, Twitch n'existait pas, Youtube ne proposait pas de live et n'était pas le mastodonte d'aujourd'hui.
Un service qui ne pouvait être fait que grâce à Internet, où la connexion uploadait un flux vidéo de chez vous vers tous les spectateurs de votre chaîne.
Bon malheureusement le service n'aura pas eu une vie particulièrement longue du fait du manque de popularité mais il avait le mérite d'exister et d'être un sacré précurseur d'une mode actuelle.

Bref ça va ça vient mais globalement les FAI français se contentent d'être des fournisseurs d'accès et non de services Internet.
Au lieu de rajouter des services supplémentaires qui ne servent d'Internet que comme un medium de transport ils pourraient fournir de vrais services Internet.

## Exploiter les box
*Les box fourni par les FAI sont de véritables petits ordinateurs* qui seraient à même de faire pleins de choses.

Elles pourraient vous permettre d'*héberger des pages webs voir des applications web*, elles ont la puissance nécessaire.
Au lieu de recourir à une [brique Internet](https://labriqueinter.net/), cela pourrait être inclu dans la box ce qui permettrait de simplifier la configuration réseau nécessaire (NAT, DHCP/adresse statique).
Et d'un point de vue écologique ça permettrait d'avoir un seul appareil regroupant les deux fonctions.

Un FAI pourrait vous *fournir un nom de domaine*, ça ne coûte pas grand-chose (entre 5 et 20€/an en général) voir uniquement un sous-domaine (c'est une vue de l'esprit).
Et comble du luxe configurer le reverse de l'adresse IP associée avec le nom de domaine (si vous comprenez pas c'est pas grave, ça permet de faire du mail un poil plus facilement et c'est plus propre).

Imaginez la grande classe, la box de votre FAI qui héberge son ptit serveur mail.
La box qui héberge une instance mastodon/pleroma !

**Des vrais services web distribués sur chacun des clients.**
Du peertube de partout !
Des galeries photos chez chacun.
Plus besoin de Facebook pour donner des nouvelles du petit, plus besoin de Youtube pour montrer les photos du mariage, pas besoin de Gmail pour s'envoyer un mail entre amis.

Bref *au lieu de ne servir que de routeur et de boîte noire, votre box pourrait se rendre utile pour* **vous**.

## Ça serait cool.
Ce système permettrait de *décentraliser un peu le net*.
En redonnant plus de pouvoirs aux gens en leur permettant de sortir des silos que sont les GAFAM.

Mais d'un autre point de vue, c'est un risque à se retrouver dépendant de son FAI au point de ne pas pouvoir aller voir la concurrence.
Bon, pour pas que ça se transforme en calvaire faudrait un backup et surtout un moyen en cas de résiliation de tout copier sur un service externe ou sur une clé usb, que l'on foutrait sur la box du nouveau fai et c'est reparti !

Bref, ça n'a à peu près aucune chance d'arriver mais imaginez si un gentil FAI (Free aurait été le meilleur candidat à une certaine époque) intégrait **Yunohost** dans sa box !
Ils pourraient contribuer un peu au projet histoire de régler les problèmes de compatibilité entre yunohost et la freebox et hop ils pourraient proposer plein de nouveaux services pour peanut !
Bon je m'enflamme mais franchement ça serait cool.

D'un certain point de vue j'aimerai que les FAI se contentent de fournir un accès au net sans rien de plus mais de l'autre quand je vois la situation actuelle je me dis qu'il pourrait en faire plus de ce point de vue.

