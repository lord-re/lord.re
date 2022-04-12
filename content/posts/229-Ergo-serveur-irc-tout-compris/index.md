+++
Author = "Lord"
Description = "Petit tour d'Ergo un serveur IRC avec services intégrés et bouncer également. Écrit en Go et suivant de très près le standard IRCv3 il est à mon goût la meilleure alternative pour monter un serveur irc en 2022."
Categories = ["irc", "adminsys"]
menu = "main"
notoc = true
WritingDate = 2022-04-12T14:50:47+02:00
date = 2022-04-12T14:50:47+02:00
title = "Ergo : serveur IRC tout compris"
editor = "kakoune"
TopWords = [  "configuration", "logiciel", "oragono", "client", "ircd", "serveur", "ergo", "irc"]
+++
Allez je vous présente **Ergo** un serveur <abbr title="Internet Relay Chat">IRC</abbr> avec tout ce qu'il faut là où il faut.

## TL;DR
Si vous souhaitez avoir votre serveur IRC en 2022 **Ergo** est une alternative très intéressante.
Sa mise en service nécessite peu de connaissances et de ressources et de temps.

Son seul inconvénient est qu'il ne propose pas de mécanisme de haute disponibilité.

## Contexte
IRC n'est toujours pas entièrement mort.
Et logiciellement c'est d'ailleurs loin d'être le cas.
Il y a quelques nouveaux clients IRC (comme [Catgirl](https://git.causal.agency/catgirl/about/) ou bien [Goguma](https://sr.ht/~emersion/goguma/)) mais c'est vrai que côté serveurs et services ça bouge assez peu.
Je vais vous présenter un ptit nouveau mais d'abord un peu d'explications !

### Le duo classique
Si vous n'avez jamais administré de réseau IRC, il y a deux éléments principaux :

  - l'**<abbr title="IRC Daemon - serveur IRC">ircd</abbr>** qui est le serveur IRC à proprement parlé
  - les **services** qui sont des bots qui ajoutent des fonctionnalités comme l'authentification, la gestion un peu plus poussée des salons, l'envoi de mémos

Les services sont optionnels mais les réseaux digne de ce nom en utilisent tous.
Sans ça, pas de gestion de l'identité des utilisateurs… c'est un peu le far west.

Pour les serveurs IRC il existe pas mal de concurrence même si on ne va pas se le cacher, le principal est le très fameux **UnrealIRCD**.
Il est vieux comme le monde (bon en fait il y a d'autres serveurs bien plus vieux).

D'ailleurs une ptite parenthèse au passage : IRC est un écosystème à fond dans le logiciel libre.
*Quasiment tous les ircd sont libres et sont des forks les uns des autres*.
Il n'y a presque pas de serveur sorti de nulle part (et Ergo n'échappe pas à cette règle).
Et ça se ressent du coup par moment dans leurs configurations ou bien certains abus de langage que l'on utilise lors de l'administration.
Voilà, c'était juste une brève remarque.

Pour les services il y a bien moins d'abondance.
*En gros il y **Anope** et **Atheme** qui se partage à peu près tout le marché.*
Sur <abbr title="super réseau irc principalement francophone">Geeknode</abbr>, nous avons par contre nos services fait maison : [Child](https://github.com/Ethylix/child).
Ils sont tout beau et mine de rien sacrément robustes, merci les devs ;-)

D'un point de vue technique, les services ont un fonctionnement un peu particulier.
*Ce ne sont pas des plugins à greffer aux serveurs mais des serveurs IRC à proprement parlé.*
IRC est protocole "fédéré" (je met des guillemets parceque c'est de la fédération assez étrange qui prédate un peu ce que l'on a tendance à appeler fédéré désormais. Du coup je n'aborderai ce point que plus tard dans un autre article dédié).
*Il est donc fait pour marcher par agrégation de serveurs IRC qui bossent ensembles.*

On différencie les types de serveurs par rapport aux connexions qu'ils écoutent :
  - **hub** : serveur recevant des connexions d'autres serveurs. Pas de client sur ces nœuds.
  - **leaf** : serveur se connectant à un hub où les clients se connectent.
  - **service** : serveur ne recevant pas de connexion se rattachant à un hub mais apportant les fameux services

*Un des soucis c'est que autant la norme IRC spécifie très bien comment doivent discuter un client et un serveur, autant la communication entre deux serveurs est plus exotique.*
C'est très généralement de l'IRC classique mais avec des ajouts spécifiques à chaque implémentation.

Toujours est-il que du coup, les services sont en fait un serveur "irc" discutant avec un autre serveur IRC.
C'est au final une architecture assez cool permettant pas mal de folies mais ça veut aussi dire que d'un point de vue mise en place c'est pas spécialement simple.
Surtout lorsqu'on débute et que l'on a pas trop les bases de réseau et d'adminsys.

Il faut mettre en place plusieurs serveurs qui communiquent entre eux, donner des droits, chiffrer, pourquoi pas ajouter quelques mots de passe…
C'est pas spécialement super complexe mais c'est pour un débutant c'est une étape assez laborieuse qui nécessite de comprendre pas mal de points différents.
Surtout que *les docs sur les différents projets sont vraiment pas géniales* (sérieux vous avez vu le site pourri d'[Anope](https://anope.org/) ? Un lien sur deux hs, la doc c'est le désert, …).

## Oragono
Bon, IRC est un protocole qui remonte à 1988 mais il n'est pas non plus figé.
Il a connu plusieurs RFC et surtout il y a en ce moment l'initiative [IRCv3](https://ircv3.net/) qui vise à moderniser un peu le protocole.

*D'un point de vue assez extérieur et/ou novice ça semble être des ajouts vraiment mineurs voir négligeables*.
Mais si l'on y regarde de plus près il y a certaines nouveautés pas mal comme par exemple [l'historique d'un salon](https://lord.re/posts/217-irc-backlog-caps/) ou bien les [notifs d'écritures](https://lord.re/posts/223-notifications-décritures-sur-irc-avec-weechat/).
Mais surtout toutes ces modifications sont faites avec *un respect absolu de rétrocompatibilité* : un serveur ou un client IRC qui ne les gèrent pas, ne doit pas être impacté.

Et toutes ces nouveautés n'arrivent que quand le serveur les a implémentés, que les services aussi (enfin celles qui concernent les services) et aussi les clients.
Donc *ça n'arrive que lentement* très lentement.

**Oragono** est un des serveurs ayant à cœur d'implémenter au plus vite ces nouveautés.
Mais *c'est un peu plus qu'un serveur puisqu'il intègre également les services*.
Vous n'aurez donc pas besoin de vous faire chier à configurer et administrer vos services en plus.
Non, ici c'est un seul logiciel.
C'est beaucoup plus simple du coup et puis ça évolue ensemble : pas d'incompatibilité ou autre.

Mais **Oragono** est mort.

## Ergo
Vous avez vu ce cliffhanger !

Et bien non il n'est pas mort, il a juste changé de nom.
C'est désormais **Ergo** c'est moins marquant mais plus simple.
Parceque ouai c'était oragano, oregano, orogano, oragono ?
Personne ne sait…

Bref en changeant de nom ils ont gommé la plus grande difficulté.
Le fait qu'il soit *codé en Go simplifie énormément son installation* (ils fournissent des binaires pour un peu toutes les plateformes).
L'ultime difficulté de mise en place est désormais la partie TLS qui nécessite un outil extérieur pour cela (mais bon ils peuvent pas faire de miracle).

D'un point de vue fonctionnalité, *il gère tout ce que l'on peut attendre d'un serveur IRC moderne et même un peu plus*.
Il intègre les services avec les fonctions usuelles de **nickserv** ainsi que **chanserv** pour la gestion de son identité ou de son salon.
Il sait fournir des cloak (planquer l'adresse ip des utilisateurs) via **hostserv**.

Mais en plus de cela, *il peut également assurer la fonction de bouncer IRC*.
En théorie sur IRC, quand vous n'êtes pas connectés… bha vous ne voyez pas les messages.
Quand vous vous reconnectez bha vous ne savez pas ce qui s'est passé lors de votre absence.

Pour pallier ce souci, les utilisateurs utilisent souvent des bouncers qui sont en fait des clients IRC qui servent de proxy.
Ils tournent sur des serveurs 24h/24 et sont donc connectés en permanence.
Lorsqu'un utilisateur se connecte, il le fait non pas au serveur mais à son bouncer qui lui rebalance tous les messages qu'il a ratés.
De ce fait, *l'utilisateur apparait comme toujours connecté pour les autres*.

Et bien Ergo fait ça de lui-même (enfin si vous le configurez pour et si l'utilisateur en fait le choix).
Comme ça vos utilisateurs n'ont plus besoin de le faire de leur côté.
Plus besoin de faire tourner un client 24h/24 sur un coin de serveur pour cela.
C'est un peu plus optimisé et écologique !

Bon par contre, *contrairement à la majorité de ses collègues, Ergo ne sait pas fonctionner de façon fédérée*.
Vous ne pouvez donc pas agréger plusieurs serveurs pour former un réseau.
Ici, vous avez 1 seul ergo.
*Pas de redondance*.
Vous perdez une machine vous disparaissez.
C'est à mon sens le seul inconvénient de ce logiciel.

On passe un peu à la pratique ?

## Mise en place
Bon à moins qu'il ne soit packagé pour votre OS (ce dont je doute), il va vous falloir faire un ptit tour sur leur repo git pour y chopper [la dernière release](https://github.com/ergochat/ergo/releases) en fonction de votre OS.
<kbd>wget https://github.com/ergochat/ergo/releases/download/v2.9.1/ergo-2.9.1-linux-x86_64.tar.gz</kbd> (ne copiez/collez cette ligne que si vous êtes sur un linux avec un processeur classique).

On décompresse le bousin.
<kbd>tar xvf ergo-2.9.1-linux-x86_64.tar.gz</kbd>

Et là vous obtenez un dossier avec tout ce qu'il faut.
Je vous conseille d'aller ranger ce dossier dans un endroit à peu près logique (genre /opt)
Dans ce dossier il vous faut créer un fichier de configuration que vous pouvez copier depuis celui fourni.
<kbd>cp default.yaml ircd.yaml</kbd>

Ce fichier doit être édité pour y mettre vos préférences.
Il est rempli de commentaires partout détaillant toutes les options.
Donc on l'édite dans son éditeur de texte favoris.
<kbd>kak ircd.yml</kbd>

Donc là-dedans les personnalisations de base à faire sont les changements de nom.
Ensuite les chemins pour les fichiers de certificats tls (à laisser par défaut si vous vous contentez de l'auto-signé (je l'aborde plus loin)).
Ensuite, changez absolument le mot de passe dans opers/admin/password. 

Pour savoir quoi mettre il faut le générer via ergo lui-même.
Pour cela faites dans un autre terminal un ptit <kbd>./ergo genpasswd</kbd> et il vous sortira une ligne de texte à foutre dans le fichier de configuration.

Voilà tout pour la configuration.

Si jamais vous avez des modifs à y faire il suffit de trifouiller le fichier de configuration et pour lui faire prendre en compte les modifs, pas besoin de le relancer mais il faut faire ce que l'on nomme communément un **rehash**.
Pour le déclencher il faut envoyer un **SIGHUP** à ergo avec un joli <kbd>kill -1 $(pgrep ergo)</kbd>.

### TLS
Un léger encart pour vous dire que je n'aborderai pas cette partie en profondeur.

En gros, deux possibilités :
  - vous pouvez utiliser des certificats autosignés (ça fera couiner les clients irc mais c'est pas si grave)
  - vous utilisez un certificat signé par une CA (je vous recommande LetsEncrypt avec un client cool comme par exemple **acme.sh** ou n'importe quel autre (**certbot** est le plus connu mais pas le plus simple ni le plus rapide ni le plus fiable ni le plus léger).

Si vous partez pour la première solution un simple <kbd>./ergo mkcerts</kbd> et le tour est joué.
Si vous optez pour l'autre solution, démerdez-vous :-)

## Utilisons-le !
Bon bha qu'est-ce qu'on attend ?
<kbd>./ergo run</kbd>
Voilà, ça tourne.

Maintenant on s'y connecte avec un client irc.
Pouf ça marche.

Voilà.
En l'espace d'une ptite demi-heure on a un serveur irc et ses services pleinement fonctionnels.
À vous de parvenir à le peupler maintenant :-)

Bon, déjà vérifiez que les bots ne sont pas en train de roupiller.
Embêtez-les avec un ptit <kbd>/query nickserv help</kbd>

## Aller plus loin
Bon, je ne vais pas paraphraser plus que cela leur documentation donc je m'arrête là.
C'était surtout pour *prouver que c'est une alternative très rapide à mettre en place et vraiment simple*.
Pour aller plus loin, je vous conseille d'aller voir [cette doc](https://github.com/ergochat/ergo/blob/stable/docs/MANUAL.md) qui est certe en anglais mais reste assez claire à mon sens.

Voilà, c'est à mon sens un excellent choix en 2022 de partir sur ce logiciel plutôt que les grands anciens ircd.
Vous n'aurez pas besoin de vous faire chier avec toutes les notions de \*:line, pas de link, bref c'est pas mal simplifié par rapport aux autres.
