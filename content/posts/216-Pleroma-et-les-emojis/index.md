+++
Author = "Lord"
Description = "Donnez un peu de joie à votre instance Pleroma. Avec quelques émojis, vos toots seront 15% plus drôles à lire."
Categories = ["pleroma", "web","fediverse"]
menu = "main"
notoc = true
WritingDate = 2021-01-23T23:10:46+01:00
date = 2021-02-06T13:10:46+01:00
title = "Pleroma et les emojis"
editor = "kakoune"
TopWords=["emoji","smiley","pleroma","fediverse","mastodon"]
+++
Votre petite instance de Pleroma est toute tristouille ?
Faut dire que les emoji unicode sont bien trop sérieux.
Il leur manque un ptit grain de folie.

Ils sont trop basiques mais par chance il est possible d'en rajouter.
Mais si vous êtes comme moi, vous avez la flemme et que de toute façon vous n'en avez pas… bha… c'est foutu.

Foutu ?
NON !

Il existe deux techniques pour en rajouter !
Bien entendu ce qui va suivre est à destination des administrateurs d'instance, si vous êtes simple utilisateur, embêtez votre administrateur (mais pas trop, ce sont de gentils ronchons).

## 1. Ajouter des packs d'emoji
Cette technique vous permet d'ajouter des emojis par packs entiers.
C'est pas compliqué mais les packs sont pas si simples à trouver.

Par chance, vous avez [ici une galerie](https://fedi.absturztau.be/emoji-packs/index.html) qui en plus vous donnera la commande à lancer pour les ajouter.

Bon par contre si comme moi, vous êtes sur les verisons OTP de Pleroma la syntaxe est un chouilla différente.
<kbd>su - pleroma -s $SHELL -lc "./bin/pleroma_ctl emoji get-packs blobcat -m https://fedi.absturztau.be/emoji-packs/manifest.json</kbd>

Une fois fait, pensez à recharger la page de votre navigateur.

Voilà, rien qu'avec ça vous avez de quoi bien agrandir votre collection.

## 2. MRF Steal Emoji

Bon les packs c'est pas mal mais souvent vous verrez passer des emojis sympas dans votre timeline.
Et si il y avait un moyen de les voler directement !?

Pleroma intègre ce que l'on apelle les <abbr title="Message Rewrite Facility">MRF</abbr> qui est un système permettant d'effectuer des actions lors de la réception de toots.
On peut y faire pas mal de trucs plus ou moins variés mais bon si comme moi Elixir c'est pas votre truc… bha on se contente des MRF existantes.
Bon il y en a déjà pas mal.

En plus dans les versions OTP, vous ne pouvez pas rajouter de MRF vous-même, vu que c'est une version de Pleroma déjà compilée.
Mais revenons à nos emojons : il y a la **MRF Steal Emoji** qui comme son nom l'indique vous permet de voler les emojis passant à portée de votre instance.

Il faut activer la MRF en question, puis lui indiquer la liste des instances sources qu'on autorise à piller.

Pour l'activer, rendez-vous dans l'administration via le ptit bouton en forme d'aiguille et de compteur tout en haut à droite.

{{< img src="admin.png" alt="C'est l'icône nommée 'administration' en haut de page" title="La troisième icône en partant de la gauche" >}}

À gauche, choisissez **settings** puis rendez-vous dans la partie **MRF**.

Il vous faut ajouter la MRF **StealEmojiPolicy** dans la liste de **Policies**.

Il faut maintenant configurer cette MRF mais pas de bol, pour le moment c'est pas faisable dans l'interface d'admin il faut donc retourner dans les fichiers de configurations comme des primitifs.

<details><summary>/etc/pleroma/config.exs</summary>

{{< highlight "elixir" >}}
config :pleroma, :mrf_steal_emoji, hosts: ["maly.io","freespeechextremist.com","mstdn.io"]
{{< / highlight >}}

</details>

Vous pouvez en mettre autant que vous voulez mais méfiez-vous, plus vous en mettez plus vous aurez d'emojis…
Ça peut vite devenir le bordel.

Vous pouvez mettre des instances autres que pleroma (mastodon, misskey…).

Maintenant, lorsque votre instance vera passer des emoji en provenance des instances que vous avez renseignées, ils iront se rajouter dans votre collection dans */var/lib/pleroma/static/emoji/stolen* .
Comme ça sans rien faire vous allez avoir une ptite panoplie d'emoji à tooter !

{{< img src="emojis.png" alt="" title="">}}
