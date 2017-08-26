+++
Categories = ["irc","tips","réseau"]
Tags = ["irc","tips","réseau"]
Description = "C'est un quoi donc l'irc ? Petit survol des trucs de l'irc"
date = "2017-08-24T15:54:15+02:00"
title = "Guide d'utilisation d'IRC : niveau 2"
menu = "main"

+++
Bon bha après la première partie (non je l'ai pas encore écrite et je ne m'y attelerai probablement pas… on trouve déjà tout ce qu'il faut sur le sujet sur le wouaib), on va s'attaquer au niveau du dessus. On va s'attaquer aux modes. On va voir comment se protéger et protéger son chan voir son réseau. Cette série d'articles est rédigée suite à l'attaque des relous traditionnels de l'été qui sévit pas mal sur Geeknode où j'officie.

## Un ptit koikoukess
On commence en douceur par l'**architecture IRC**. Donc, IRC est un protocole où des utilisateurs se connectent à un serveur. Ce serveur est interconnecté à d'autres serveurs. Cet ensemble de serveur constitue un réseau IRC. Il existe plusieurs type de serveurs  : les hubs, les leaves, les services. Un Hub est un serveur où seuls les serveurs se connectent. Un Leaf (des leaves) est un serveur où les clients se connectent. Les Services sont des serveurs particuliers se connectant au(x) hub(s) et ajoutant des fonctionnalités au réseau.

Le **netsplit** c'est lorsqu'un un ou plusieurs serveurs du réseau ne sont plus interconnectés. Quand ça arrive on assiste à une belle purge. On se retrouve donc avec une vue partielle du réseau. Donc on ne voit qu'une partie des utilisateurs. Historiquement quand ça arrivait à l'époque, les vilains hackers tentaient un takeover (prise de contrôle) des chans pour devenir Opérateur dessus.

La commande **whois** permet d'avoir des informations concernant un utilisateur. **/whois Lord** vous affichera le pseudo, le realname, l'host, si la personne est identifié aux services, sur quels salons la personne se trouve. C'est très pratique.

Ensuite les **modes**. Ce sont des modifications (thx Cpt Obvious) symbolisées par des lettres. Il en existe deux types : les modes utilisateurs s'appliquant sur un utilisateur et les modes pour les chans qui s'appliquent… vous voyez le truc. Il en existe pas mal. Il faut savoir qu'IRC c'est une multitude de réseaux différents. Les modes ne sont pas forcément les mêmes sur tous les réseaux. Dans le cas de Geeknode, nous utilisons le serveur [UnrealIrcd](https://unrealircd.org) et donc les modes disponibles sont ceux d'unrealircd.

La **hiérarchie des utilisateurs** est assez basique. Dans un chan, dans la liste des connectés les utilisateurs sont classés en fonction de leur "niveau". L'utilisateur de base n'a pas de symbole. On trouve ensuite le **+** qui indique un utilisateur voicé (on verra plus tard l'intérêt). Les voicés sont généralement les habitués du lieu. Ensuite on retrouve les **%** qui sont des hop ou halfop ou semi-opérateur. Ils ont quelques droits d'administration sur un salon pour les tâches de base. Ensuite on a les **@** qui sont les op ou opérateurs. Ils peuvent quasiment tout faire sur un salon : changer les modes, kicker, bannir, … Il existe un ultime niveau qui n'apparait pas qui est le **q** qui correspond au owner, le propriétaire d'un salon. Ce mode est rarement utilisé et permet de reprendre le contrôle si un op fait le con. Il faut savoir que les modes ne sont valables que sur un seul salon. Vous pouvez être op sur #bidule, owner sur #truc mais rien sur #machin.

Les vilains qui gèrent un réseau irc sont les infâmes **ircop** ou aussi **netadmin**. C'est l'ultime barrière de défense en cas d'emmerdeurs. Ils sont là pour aider les utilisateurs ayant des soucis pour gérer leur salon ou pour ceux qui se battent avec les services.

Ce qui suit concerne plus particulièrement Geeknode : ils se planquent pour la plupart sur #geeknode et y sont op. Il ne faut pas hésiter à les contacter dans à peu près tous les cas. Par contre. Pas la peine de demander des renseignements concernant les adresses ip des utilisateurs. En cas de conflit interne entre les op d'un chan, débrouillez-vous avec l'owner pour résoudre ça, nous ne prendrons pas parti.

Le dernier point : les **services**. IRC est un procole ne faisant pas grand chose de base. Les services permettent d'ajouter des fonctionnalités indispensables telles que l'enregistrement et la gestion de son pseudo/chan. Ils permettent également aux ircop des les assister dans leurs tâches d'administrations (envoi de message sur un serveur ou sur tout le réseau, ajout de whitelist pour certaines ip, gestion des bots, …). Généralement les services sont un ou plusieurs bots se nommant nickserv/chanserv/memoserv/… Dans le cas de Geeknode tout est regroupé dans un seul bot, le fameux C développé en interne (son code est opensource, si vous êtes intéressé). C est bien foutu car il possède une aide pour chaque option. ex: */msg C help* ou alors */msg C help nick* ou bien */msg C help chan* voir */msg C help nick set*
