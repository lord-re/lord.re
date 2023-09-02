+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2023-08-13T09:32:33+02:00
date = 2023-09-01T09:32:33+02:00
editor = "kakoune"
title = "Récap 49 : Aout 2023"
+++
Allez je suis à la bourre mais vous inquiétez pas je fous quand même la date du 1 Septembre pour la parution comme ça personne ne peut me blâmer !
Et toc !

Bon bha voilà, c'est la rentrée, l'été approche de sa fin, les canicules sont finies.

Je crois pas en avoir déjà parlé ici mais … depuis bientôt deux ans je fais de l'escalade.
J'ai toujours aimé être en hauteur, je n'ai aucun vertige et depuis môme grimper ravive mes gènes ancestraux de grands singes.
Bref, mois-ci je commence à faire mes premières 6A+ !
Bon je vous embête pas plus, à la prochaine !

## Blog
Quelques ptits ajustements de-ci de-là sur le blog.
J'ai viré le blogring pour le moment mais je vais ptet faire une page plus globale avec des liens vers différents blogs que j'affectionne.

J'ai enfin foutu un logo sur le site.
Bon c'est juste la favicon que je me suis faite il y a quelques années mais que j'avais jamais vraiment mise en avant.

Je dois avouer que je commence légèrement à me lasser de ce design.

En bref ce mois-ci : 3 articles, 18 commentaires, 12 visionnages, 621595 requêtes, 64236 visiteurs uniques pour 34.16 Go de trafic.

## Films
Pas mal de films ce mois-ci !
Et j'ai un peu repris le classement IMDB.
Mais je dirais que mon film préferré c'est … **They Cloned Tyrone**.

Il sort du lot de par son originalité.

  - [Before Sunrise]({{< ref "visionnages/before-sunrise">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [They Cloned Tyrone]({{< ref "visionnages/they-cloned-tyrone">}})
  - [Vesper Chronicles]({{< ref "visionnages/Vesper-chronicles">}})
  - [The Munsters]({{< ref "visionnages/the-munsters">}})
  - [Blown Away]({{< ref "visionnages/blown-away">}})
  - [Judgment at Nuremberg]({{< ref "visionnages/judgment-at-nuremberg">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [True Romance]({{< ref "visionnages/true-romance">}})
  - [Spiderman : Into the Spiderverse]({{< ref "visionnages/spiderman-into-the-spider-verse">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Spiderman : Across the Spiderverse]({{< ref "visionnages/spiderman-across-the-spiderverse">}})
  - [Memories of Murder]({{< ref "visionnages/memories-of-murder">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Oldboy]({{< ref "visionnages/oldboy">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [The Boogeyman]({{< ref "visionnages/the-boogeyman">}})

## Séries
**What We Do In The Shadows** est sortie en saison 5.
Je me régale toujours autant !

Je vous en ai déjà parlé plusieurs fois donc pas grand-chose à ajouter.
Mais vraiment si vous n'y avez toujours pas jeté un œil… bha allez-y.

## Jeux
### Creeper World 4
Les trois premières versions de ce jeu était un simple jeu flash et cette quatrième s'est émancipé et est désormais un jeu sous Unity ce qui permet d'y jouer un peu partout.

Il s'agit d'une sorte de Tower Defense un peu sauf que l'on ne se bat pas contre des vagues d'ennemis.
Non on se bat contre … des ennemies vagues.
Comment dire, les choses que l'on combat sont en fait un fluide qui se répand.
Il faut donc placer des tours pour détruire ce fluide qui coule inexorablement.

Vous avez donc votre QG d'où partent les ressources, des tours qui permettent d'acheminer les ressources et les armes qui vont combattre l'envahisseur.
Il faut récolter des ressources et tout.
C'est assez proche d'un RTS sur certains aspects tout en ayant aucune unité à gérer, que des bâtiments.

Alors oui le jeu est moche, mais il est tout comme ses prédecesseurs (même s'ils se sont pris la tête à faire de la 3D) : super addictif et plaisant à jouer.

Bon ils ont rajouté un peu de scénario mais … <kbd>skip</kbd> <kbd>skip</kbd> <kbd>skip</kbd>.

## Nuxeries
Vous connaissez l'adage “It's not a bug, it's a feature.” ?
Ce n'est qu'une bonne vieille blagounette.
Et pourtant parfois c'est presque vrai !

Et en fait ma pauvre Gentoo était buggée !
Et ce depuis presque toujours et je ne m'en étais même pas rendu compte.
Bien au contraire j'appréciais ce bug.

Depuis toujours, la commande <kbd>halt</kbd> n'est pas censé éteindre l'ordinateur mais juste éteindre l'OS et laisser la machine alimentée.
Pour éteindre la machine il fallait faire <kbd>halt -p</kbd> et pourtant ça fonctionnait mais il a fallu que quelqu'un report [ce bug](https://bugs.gentoo.org/show_bug.cgi?id=911257) et du coup Gentoo a corrigé le truc.

Et voilà pourquoi pendant dix jours je ne comprenais pas pourquoi ma machine ne se coupait plus.

Bon est-ce que j'ai envie de rompre quinze ans de mémoire musculaire pour éteindre ma machine ?
Non.
Je pourrais créer un alias mais bof j'aime pas trop ça (encore que ce que je n'aime pas c'est changer un comportement par défaut d'une commande ce qui est pile ce que je cherche à faire mais bon).
Il s'avère qu'il y a un ptit <samp>/sbin/halt.sh</samp> qui ne demande qu'à être édité pour lui rajouter le <kbd>-p</kbd> qui va bien.

Est-ce que je l'ai fait ?
Oui.
Est-ce que ça marche ?
Oui.
Est-ce que ça va m'emmerder dans une prochaine mise à jour ?
Probablement.
Est-ce que je m'en rappelerai ?
Non (c'est pour ça que je l'écris ici).
