+++
Author = "Lord"
Description = "Les blaireaux de spammers vous rendent la vie difficile ? Voyons ce qu'on peut faire pour amoindrir leur impact."
Categories = ["irc", "actu"]
menu = "main"
notoc = true
PublishDate = 2018-08-05T10:20:59+02:00
date = 2018-08-05T10:20:59+02:00
title = "Contrer la vague de spam touchant IRC"
editor = "kakoune"
+++
Bon ça fait plus de deux semaines qu'un bande de péquenots s'amuse à spammer joyeusement à peu près tous les réseaux IRC existants (enfin s'ils sont suffisamment gros).

## L'attaque
C'est un flood avec toujours les mêmes phrases (!) consistant à envoyer des URL vers des blogs.
Là où c'est encore plus dégueulasse, c'est que ces blogs sont ceux des membres de l'équipe de *Freenode* qui est le plus gros réseau.
Et ces blogs annoncent fièrement que la pédophilie c'est super chouette…
Cela va sans dire que ces blogs ne sont pas les blogs du staff Freenode mais ont été monté pour l'occasion avec des articles antidatés.

L'attaque utilise donc une belle armada de bots, tout d'abord hébergés sur le Google Cloud, puis l'Amazon Cloud, puis juste dispersés à droite à gauche désormais.
Les bots prennent des pseudos d'utilisateurs légitimes en ajoutant parfois quelques chiffres en fin et hop.

Maintenant l'attaque se poursuit également en discussions privées.

Chouette -____-

## La défense
### Par les serveurs
Pour bloquer tout ce spam côté serveur, le mieux est de mettre en place des *spamfilters* mais tous les ircd ne possèdent pas cette fonctionnalité (comme, par exemple, ceux qu'utilise Freenode).
Cette technique permettra de virer les bots au moment où ils envoient les fameuses phrases qui du coup ne seront pas relayées aux utilisateurs.
Il ne reste alors que les *join/quit* qui malheureusement ne peuvent pas être distinguées de ceux légitimes.

### Par les @ d'un salon
Plusieurs possibilités avec chacunes leurs inconvénients.

  - Voicer tous les utilisateurs légitimes et passer le salon en *<samp>+m</samp>* : il faut voicer tous les nouveaux arrivants.
  - Restreindre le salon aux utilisateurs enregistrés avec *<samp>+R</samp>* : les utilisateurs doivent avoir enregistré leur pseudo auprès des services.
  - Restreindre le salon aux utilisateurs avec une connexion sécurisée (tls) *<samp>+z</samp>* : les utilisateurs doivent se connecter via TLS.
  - Mettre en place une liste de *badwords* (la façon de faire varie beaucoup) : il faut se tapper la liste à la main et que le serveur le gère.

### Côté clients
Pas grand-chose à faire.

Mais il y a quand même moyen de rendre le truc invisible si un spamfilter a été mis côté serveur.
Le but va être de planquer tout ce merdier de join/quit

{{< img src="f-21-joinquit.thumb.png" link="f-21-joinquit.png" alt="Une myriade infinie de Join/Quit sur le salon de La Brique Internet" title="C'est moche hein ?" >}}

*Weechat* possède un super truc appelés les **smartfilters** qui permettent de n'afficher les Join/Quit uniquement si la personne en question a parlé il y a quelques minutes (ce qui n'est pas le cas des bots).
Les salons de discussions redeviennent agréables à utiliser.

    /set irc.look.smart_filter on
    /filter add irc_smart * irc_smart_filter *

Et hop.
Vous pouvez l'activer/désactiver avec *<samp>Alt =</samp>*

Pour *Irssi* il existe un [script perl](https://github.com/lifeforms/irssi-smartfilter) apportant cette même fonctionnalité mais en 2018 plus personne n'utilise Irssi, non ?

Pour les autres clients IRC ?
Voici une [doc exhaustive](https://weechat.org/files/doc/stable/weechat_quickstart.fr.html) qui vous sera utile.
