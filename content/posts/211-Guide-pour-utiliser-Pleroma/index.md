+++
Author = "Lord"
Description = "Petit guide explicatif concernant l'interface web de Pleroma. Quelques screenshots et capture vidéo pour illustrer."
Categories = ["fediverse", "ux","pleroma"]
menu = "main"
notoc = true
WritingDate = 2020-10-27T19:45:40+01:00
date = 2020-10-27T19:45:40+01:00
title = "Guide pour utiliser Pleroma"
editor = "kakoune"
+++
On entend parfois qu'utiliser Pleroma est compliqué.
Et oui et non.
En vrai c'est pas plus compliqué que Mastodon ou Twitter, ce sont surtout des habitudes différentes à prendre.

Donc voilà un petit guide expliquant quelques bouts de l'interface utilisateur.

## À quoi ça ressemble ?

Si vous n'avez pas de compte ou si vous n'êtes pas encore connecté, vous tomberez directement sur la page affichant tous les toots publics accessibles depuis l'instance en question.

{{< img src="outside.png" alt="L'interface classique monocolonne de pleroma sur la timeline globale" title="Par défaut en anglais, vous êtes sur la Known Network">}}

Avant d'aller plus loin, un petit rappel sur les différentes **Timelines** existantes.

  - **Fil d'actualité** : c'est votre timeline personnelle contenant les toots des personnes que vous suivez. Elle contient aussi bien des toots publics que des toots à visibilités restreintes.
  - **Bookmarks** : Ne contient que les toots que vous avez bookmarké (marque-page).
  - **Messages Directs** : Ne contient que vos messages persos (DM).
  - **Fil d'actualité publics** : Il s'agit de la timeline public de votre instance. Elle contient tous les toots publics publiés par les personnes de votre instance.
  - **Ensemble du réseau connu** : Il s'agit de la timeline globale de votre instance. Elle contient tous les toots publics passant par votre instance. Il s'agit donc de la timeline précédente + tous les toots des autres instances qu'elle reçoit.


## L'interface

L'interface de Pleroma est quelque peu déroutante la première fois.

### Colonne de gauche
Cette colonne assez fine comporte trois sections.

La première s'avère être l'interface de rédaction de toot.
Un dessin sera bien plus explicite.

{{< img src="colonne_gauche.png" alt="Explication de chacune des parties de la colonne de gauche" title="Très dur à décrire" >}}

Sachez que vous pouvez formatter vos toots en les rédigeant en *html*, *bbcode* ou bien *markdown*.

### Colonne de droite

Celle-ci peut afficher différents contenu.
Mais ne nous voilons pas la face, la majorité du temps ça sera les *timelines*.

<video controls preload="metadata" style="max-width:100%;" alt="Les différentes timelines.">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/timelines.webm">
</video>

Le fédiverse ne garantit pas le temps que mettra un toot a être délivré du coup parfois vous recevrez des messages envoyés quelques minutes/heures/jours/semaines auparavant.

Bon, du coup dans la timeline, vous verez des toots arrivant sur votre instance.
Et souvent ces messages ne sont pas sortis de nulle part mais appartiennent à des conversations.

<video controls preload="metadata" style="max-width:100%;" alt="Comment afficher une conversation">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/conversation.webm">
</video>

### Barre du haut

On a tendance à l'oublier mais tout en haut il y a une barre horizontale.

Vous trouverez tout d'abord le nom de l'instance.
En cliquant dessus vous vous retrouverez le *fil public* de votre instance.

Ensuite au milieu vous avez le logo Pleroma qui lors d'un clic vous remontera la page (un raccourcis bien venu).

Et enfin à droite, trois icônes : la *recherche*, les *réglages* et le *bouton pour se déconnecter*.

La recherche permet de chercher un mot, une personne ou bien un hashtag.
C'est très pratique même si parfois les résultats sont un peu aléatoires mais ça s'améliore.

## Les gens

L'intéret d'un réseau social c'est d'avoir des interactions avec les gens de l'Internet.
Le concept ici est de *suivre* une personne afin de recevoir toutes ses publications.

Pour ça il existe deux façons de faire.

Tout d'abord vous tombez au hasard sur quelqu'un, vous consultez son profil :

<video controls preload="metadata" style="max-width:100%;" alt="courte vidéo montrant comment ouvrir un profil">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/consultation_profil.webm">
</video>

<video controls preload="metadata" style="max-width:100%;" alt="courte vidéo montrant comment suivre un utilisateur">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/follow.webm">
</video>

La seconde façon est un cas légèrement différent.
Vous connaissez quelqu'un que vous voulez suivre et donc vous allez devoir chercher cette personne.

<video controls preload="metadata" style="max-width:100%;" alt="vidéo montrant comment utiliser la recherche de personne tout en haut">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/chercher-suivre.webm">
</video>

Sur la vidéo précédente vous voyez qu'à la fin je n'ai pas déjà reçu les messages, ça peut prendre quelques secondes le temps que les données transitent d'instance à instance.

Il ne vous reste plus qu'à répéter ça plusieurs fois pour créer votre petit harem de gens que vous suivez.
Votre *timeline* se remplira maintenant de tous leurs toots.

## Un toot

Vous allez vite voir les toots des gens.
Ils ont tout un tas d'infos un peu cryptiques au début et pleins de boutons.

{{< img src="toot_complet.png" alt="À quoi ressemble un toot et qu'est-ce qui est cliquable" title="Voilà tous les éléments clickable et leur signification" >}}

La visibilité des toots est une des grandes fonctionnalités du **fédiverse**.
Lorsque vous en écrivez un, vous pouvez choisir qui recevra le message.

  - **Direct** : Uniquement les personnes mentionnées dans votre message recevront le toot.
  - **Followers-only** : Seuls les personnes qui vous suivent verront ce message.
  - **Unlistel** : Tout le monde peut recevoir le toot mais il n'apparaitra pas dans les timeline publics
  - **Public** : Potentiellement tout le fédiverse peut voir ce toot

C'est assez simple mais cette possibilité amène parfois à quelques déconvenues : il n'est pas rare que dans une même discussions plusieurs niveaux de visibilité soit mélangés.
On se retrouve donc à ne pas voir toute la discussion en voyant des réponses sans voir le message d'origine mais bon, c'est le jeu, chacun choisit ce qui lui plaît.

À cela s'ajoute le fait que toutes les instances ne fédèrent pas à 100% avec tout le monde.
Il est pas rare qu'il y ait des trous dans la fédération que ce soit volontaire (modération) ou par souci technique.

## Le chat

Depuis peu, Pleroma permet de chatter entre utilisateur du fédiverse.
Tous les logiciels ne sont pas compatibles (ça viendra ou pas).

En pratique ça ressemble beaucoup à des discussions à base de messages privés de type **DM**.

<video controls preload="metadata" style="max-width:100%;" alt="courte vidéo montrant le fonctionnement du chat accessible depuis la colonne de gauche">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/chat.webm">
</video>

À l'heure actuelle ce n'est pas compatible avec Mastodon, à vraie dire, seul **Pleroma** et **Misskey** peuvent discuter ensemble.

Bon, pour le moment je trouve ça franchement gadget mais j'imagine que si ça se déploit chez **Mastodon** l'adoption rendra ptet le truc plus intéressant.

## Les DM
DM == Direct Message dans le langage twitesque.

Il s'agit des messages directs entre les utilisateurs donc ce n'est pas publique.
Alors pour info, potentiellement les administrateurs des instances peuvent lire ces messages, ce n'est pas chiffré.
Le Fédiverse n'est pas un bon médium pour des conversations confidentielles.

Pour les retrouver il faut se mettre la colonne de droit sur *timeline* et en haut sélectionner **Direct Messages**.
Ils apparaitront tous là.

Si vous voulez en envoyer un nouveau il suffit de commencer par rédiger un toot normal, d'y mentionner le destinataire et de choisir la visibilité adéquate.

<video controls preload="metadata" style="max-width:100%;" alt="Envoi d'un DM via l'interface de rédaction.">
 <source src="https://lord.re/posts/211-guide-pour-utiliser-pleroma/dm.webm">
</video>

Il est également possible de passer par le profil d'un utilisateur et de cliquer sur le bouton <kbd>mention</kbd>

---------------------

Voilà voilà avec ces quelques éléments il est possible de se débrouiller.
Je n'ai pas abordé la partie réglages mais c'est disponible via la ptite roue crantée tout en haut à droite.

Vous y trouverez les options pour personnaliser votre *profil*.
Mais vous aurez également toutes les options pour personnaliser l'affichage de l'interface, bloquer les indésirables ainsi que les options plus générales.

Lorsque j'ai migré de **Mastodon** à **Pleroma** j'ai tout d'abord utiliser l'interface mastodon car je trouvais celle de Pleroma moins efficace et moins agréable.
Mais après lui avoir laissé sa chance je me suis rendu compte que je la préferais largement : l'interface plus large, les ptits trucs par-ci par-là la rende plus pratique.
