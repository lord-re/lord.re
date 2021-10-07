+++
Author = "Lord"
Description = "Le bon vieil IRC gagne de nouvelles fonctionnalités petit à petit. Cette fois-ci c'est la possibilité de voir quand quelqu'un est en train d'écrire. Mettons ça en place dans Weechat."
Categories = ["irc", "weechat","tips"]
menu = "main"
WritingDate = 2021-10-07T17:53:39+02:00
date = 2021-10-08T00:13:39+02:00
title = "Notifications d'écriture sur IRC avec Weechat"
editor = "kakoune"
+++
IRC est un vieux protocole de chat encore utilisé qui a plus de trente ans mais qui connait des évolutions.
L'une d'elle est la possibilité de signaler le fait que l'on est en train d'écrire.

Oui oui, tous les autres protocoles de chat le font déjà depuis des lustres mais voilà ça arrive aussi sur IRC et comme d'hab ça passe par une lente phase de standardisation puis encore plus lente phase d'implémentation dans les serveurs et les clients.
Dans sa récente version 3.3 sortie en septembre 2021, **Weechat** a changé sa conf par défaut pour activer un gros paquet de ces nouveautés qu'il supportait depuis déjà quelques-temps.
Mais cette version a aussi apporté ce support des notifications d'écriture.
Ce n'est par contre pas activé par défaut.

Ça se passe en 3 étapes.

## 1 Activer la CAP nécessaire
Cette fonctionnalité s'appuie sur les **CAPABILITIES** de la norme IRCv3.
C'est le système de négociation des fonctionnalités entre le client et le serveur.

Il faut donc que le serveur sur lequel vous vous connectez le gère (c'est le cas notamment de Geeknode).
Pour savoir si le serveur le gère, rendez-vous sur le buffer du serveur (généralement avec <kbd>/buffer 1</kbd>) et là entrez <kbd>/cap ls</kbd>.
Le serveur vous renvoie ce qu'il sait faire de la forme : <samp>-- irc: client capability, server supports: account-notify away-notify chghost extended-join multi-prefix sasl=PLAIN,ECDSA-NIST256P-CHALLENGE,EXTERNAL tls account-tag cap-notify echo-message solanum.chat/identify-msg solanum.chat/oper solanum.chat/realhost</samp> .

Le serveur doit gérer la CAP nommée **message-tags** (ce n'est pas le cas de Libera comme le montre l'exemple ci-dessus).

Si c'est le cas, vous pouvez demander à activer cette fonction avec <kbd>/cap req message-tags</kbd> ce qui devrait vous renvoyer <samp>irc: client capability, enabled: message-tags</samp>.

Pour ne pas avoir à faire cette manip à chaque fois, vous pouvez l'ajouter dans les réglages du serveur avec la commande <kbd>/set irc.server.NOM_DU_SERVEUR.capabilities message-tags</kbd>.

Si vous souhaitez vérifier que la CAP est bien activée vous pouvez faire un ptit <kbd>/cap list</kbd> ce qui vous donne <samp>-- irc: client capability, currently enabled: extended-join chghost cap-notify userhost-in-names multi-prefix away-notify sasl account-notify message-tags batch server-time account-tag</samp> (enfin ça sera pas forcément les mêmes hein).

Voilà cette première partie est bonne.

## 2 Activer le plugin dans Weechat
Voilà maintenant votre client IRC reçoit bien les messages tags mais pour l'instant Weechat n'en fait rien.
D'ailleurs si vous voulez voir à quoi ça ressemble, vous pouvez faire un ptit <kbd>/server raw</kbd> pour voir tout ce que reçoit weechat de manière brute.
Dans tout ça vous verrez probablement des message-tags avec le fameux "typing".

Bon faisons en sorte que Weechat les prenne en considération.
Il y a quatre options à activer :
<kbd>/set typing.look.enabled_nicks on</kbd> et <kbd>/set irc.look.typing_status_nicks on</kbd> vous permet de voir les notifications des autres.
Alors que <kbd>/set typing.look.enabled_self on</kbd> et <kbd>/set irc.look.typing_status_self on</kbd> vous permet d'envoyer vos notifications d'écriture aux autres.

Une fois fait, pensez à sauvegarder votre configuration avec <kbd>/save</kbd>.

Bon, c'est tout bon, tout devrait marcher mais il est possible que vous ne voyiez rien encore.

## 3 Afficher le plugin
Ce système s'appuie sur un nouveau plugin nommé… "typing".
Et il faut configurer votre Weechat pour afficher ce plugin.

Par défaut, il devrait être présent dans la barre *status* mais si comme moi vous l'avez modifiée, bha … il ne s'y ajoutera pas tout seul dedans.

Donc pour ajouter ce plugin, la première chose à faire c'est de lister vos barres avec <kbd>/bar listfull</kbd> .
Et il vous enverra quelque chose de la sorte :
<pre>
18:15 List of bars:
18:15	ubar: root (conditions: -), bottom, filling: horizontal(top/bottom)/vertical(left/right), height: 1
18:15		priority: 0, fg: default, bg: default, bg_inactive: default, items: buffer_number+:+buffer_name,hotlist,input_text,time,[completion],[typing],input_paste
18:15	fset: window (conditions: ${buffer.full_name} == fset.fset), top, filling: horizontal(top/bottom)/vertical(left/right), height: 3
18:15		priority: 0, fg: default, bg: default, bg_inactive: default, items: fset, with separator
</pre>

Donc là dans l'exemple j'ai 2 barres : *ubar* que j'ai créé et *fset* qui existe par défaut.
Dans les infos pertinentes à voir, c'est la liste des *items* dans *ubar* qui contient notamment *[typing]*.

Il est possible que vous n'ayez pas cet item dans vos barres et c'est celui qui nous intéresse.
Pour le rajouter dans une de vos barres il faut donc modifier une de vos barres et lui ajouter l'item en question à l'endroit que vous voulez :
<kbd>/bar set NOM_DE_VOTRE_BARRE items buffer_number+:+buffer_name,hotlist,input_text,time,[completion],[typing],input_paste</kbd>
Et vous voilà prêt.

## Profit !
Bon je ne vous cache pas que pour le moment… à peu près personne n'utilise cette fonctionnalité.
Et puis bon… on va pas se mentir ça n'a pas grand intéret.

{{< img src="typing.png" alt="capture d'écran du plugin en action" title="voilà l'allure que ça a lorsque xiu écrit." >}}

Mais il est possible de le faire.
Et ce qui est bien, c'est que ces nouvelles fonctionnalités ne perturbent pas les vieux logiciels non mis à jour.
C'est tout bien foutu sur ce point.
