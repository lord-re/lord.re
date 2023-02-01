+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2023-01-25T08:54:51+01:00
date = 2023-02-01T08:54:51+01:00
editor = "kakoune"
title = "Récap 42 : Janvier 2023"
+++
Allez pour fêter cette nouvelle année, j'ai renouvellé ma carte graphique.
J'ai un joli ptit monstre qui me permet de nouveau à jouer à un peu tout sans trop réflêchir à la compatibilité.

Du coup, premier nouveau jeu **Cyberpunk 2077** et c'est un peu à cause de lui que du coup c'est assez calme sur le blog ce mois-ci.

## Blog
J'ai retouillé deux trois trucs sur le blog.
Déjà sur le RSS j'ai changé le titre des visionnages afin d'ajouter un ptit header reconnaissable.
J'ai bidouillé également les catégories dans le flux histoire qu'il y ait des tags supplémentaires.

Et surtout j'ai pas mal modifié les pages de listings.
J'ai viré les grosses cartes qui donnait un aperçu de chaque article et j'ai remplacé ça par un classement chronologique avec séparation mensuelle et je n'affiche plus que le titre.
Ça donne un affichage bien plus compact, c'est plus pratique et j'ai quand même gardé l'aperçu que l'on peut avoir en survolant la ptite <span title="non là il n'y a rien à lire">❖</span>.
Voilà, ça donne des pages plus légères visuellement.

En bref ce mois-ci : 1 article, 6 commentaires, 11 visionnages, 508943 requêtes, 52952 visiteurs uniques pour 9.01 Go de trafic.

## Films

  - [Big Bug]({{< ref "visionnages/big-bug" >}})
  - [The Menu]({{< ref "visionnages/the-menu" >}})
  - [Barbarian]({{< ref "visionnages/barbarian" >}})
  - [Prey for the Devil]({{< ref "visionnages/prey-for-the-devil" >}})
  - [Arizona Dream]({{< ref "visionnages/arizona-dream" >}})
  - [Le Bal des Casse-pieds]({{< ref "visionnages/le-bal-des-casse-pieds" >}})
  - [North by Northwest]({{< ref "visionnages/north-by-northwest" >}})([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Singin' in the Rain]({{< ref "visionnages/singin-in-the-rain" >}})([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [A Clockwork Orange]({{< ref "visionnages/a-clockwork-orange" >}})([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Ikiru]({{< ref "visionnages/ikiru" >}})([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Hachi-a-dog-tale]({{< ref "visionnages/hachi-:-a-dog-tale" >}})([top imdb]({{< ref "visionnages/topimdb" >}}))

## Séries
### Willow
Aie aie aie.
J'adore le film sorti en 1988.
Ça m'émoustille plus que les films du seigneur des anneaux.

J'aime bien le ton pas trop sérieux mais sans non plus être dans la bouffonerie, les effets spéciaux, les décors, les acteurs, non j'aime vraiment beaucoup le film et là une série qui arrive près de trente cinq ans plus tard après de nombreux projets de suites et compagnie, enfin.

À la première vue du trailer c'est la douche froide.
Bon, bha …
Bha, je vais quand même regarder mais la hype est bien redescendue malgré une partie du casting qui est de retour.

Bon bha c'est un massacre.
Rhaaaa ce que c'est navrant.

Le public cible est l'ado rebel mais le rebel vu par Disney donc pas vraiment rebel, hein.
On a donc plein de mioches qui se galochent ou veulent le faire.
Mais vraiment rien ne va, c'est blindé d'incohérence, c'est moche, ça semble déborder de pognon mais certains costumes sont de simples jeans, on a même droit à un personnage avec un onesie o___O.

Chaque épisode se conclue par une musique qui … n'a rien à voir.
Alors qu'ils ressortent la musique d'origine à d'autres moments et que celle-ci est juste géniale : incompréhensible.

Ils visent un public d'ado qui n'a probablement pas vu le film mais ils font constamment des clins d'œil au film.
Pourquoi faire ça ?
Ils se sont clairement éloigné du film dans le ton et le public d'origine du film a quarante balais.
Soit vous jouez le tout pour le tout et tentez de poursuivre ce qui s'est fait dans le film soit vous le zappez et repartez sur de nouvelles bases pour plaire à un nouveau public.

Ça déborde d'incohérences en plus.
Il y a constamment des tentatives d'humour lourdeaude, les personnages sont pas attachants et la ptite équipe est juste en train de se tirer dans les pattes les uns des autres.

Rhhaa et puis ce pauvre Willow il est là que pour déballer du lore.
Trois fois sur quatre ça ne sert à rien si ce n'est ajouté du lore assez insipide et ça sort un peu de nulle part.
Ça donne vraiment l'impression qu'il a été rajouté parceque c'est le nom de la série : il ne sert à rien.

Le truc cool c'est que *mims* la fille du personnage est la vraie fille de l'acteur.
Voilà, c'est bien maigre.
À chier, encore une fois merci Disney.

Et visiblement aux US ça chouine parceque c'est woke.
Et ouai dans un monde de magie et de créatures mythiques et compagnie il y a des personnages gays !!!
Ptain, rien ne va dans la série et le seul truc que vous voulez reprocher c'est ça ?!
Pffff que vous êtes lamentables.

## Jeux
### Cyperpunk 2077
Je me régale !
Mais je vous en parle un peu mieux très bientôt.

## Nuxeries
J'ai changé de carte graphique et du coup il a fallu que j'adapte mon ptit nunux à cela.
Bon je suis passé d'une AMD RX580 à une AMD RX6950.
D'ailleurs c'est marrant il y a dix ans ou plus j'avais une radeon 6950HD qui n'a au final rien à voir.

Bref, AMD étant très sympa avec le monde du libre, ils contribuent au kernel linux avec un bout de driver libre (côté kernel) qui permet de faire tourner soit leur driver proprio à eux (côté userland) soit le driver libre communautaire (toujours côté userland).
Et c'est intégré dans le kernel classique, rien d'exotique du tout.

Le seul truc un peu particulier, c'est qu'il faut s'assurer d'avoir le firmware correspondant au GPU que l'on possède.
Du coup, la seule chose que j'ai réellement eu à faire est d'inclure le bon firmware dans le kernel.
Pour cela, il suffit d'éditer la ligne <kbd>CONFIG_EXTRA_FIRMWARE</kbd> dans */usr/src/linux/.config* et d'y ajouter les bons.
Le [brave wiki de Gentoo](https://wiki.gentoo.org/wiki/AMDGPU#Incorporating_firmware) vous donnera les bons noms à ajouter.

Une recompile et on boot dessus et … c'est bon ça marche.
Rien à modifier côté userland, **mesa** se débrouille comme un chef.

Merci AMD pour votre implication dans le libre !
Je continuerai d'acheter votre matos tant que ce sera le cas.

## Vidéos
Un super moyen métrage français sur les origines de France Five : [Message d'Outre-Espace](https://www.youtube.com/watch?v=9jNlx1vmtt0).
C'est très joliement bien fait.


## Vrac
Tiens sur HN il y a un article super cool sur [la victoire des réseaux sur les télécoms](https://www.devever.net/~hl/sip-victory#narrow).
Bossant côté télécoms mais fréquentant surtout le monde des réseaux j'ai vraiment bien aimé cet article que je trouve particulièrement juste.

Bon c'est en anglais mais en gros ça évoque les différences de cultures de deux clans qui ont les mêmes objectifs.
C'est centré principalement sur SIP et j'avoue que j'aimerai bien un article un peu plus global et complet ^__^
