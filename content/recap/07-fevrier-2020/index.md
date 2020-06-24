+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2020-02-02T19:00:13+01:00
date = 2020-03-01T00:00:13+01:00
title = "Récap 07 : Février 2020"
editor = "kakoune"
+++

## Blog
Comme je vous l'ai marqué, j'ai donc affiné les suggestions d'articles similaires, j'ai commencé à le faire également sur les visionnages.
C'est loin d'être parfait mais c'est tout de même plus pertinent qu'avant.

J'ai aussi ouvert les commentaires sur les visionnages soit dit-en passant.
Vous allez pouvoir vous y moquer de mes goûts douteux questions films.

En bref ce mois-ci : 5 articles, 12 commentaires, 9 visionnages, 550214 requêtes, 47708 visiteurs uniques pour 12.53 Go de trafic.

## Films

Et ainsi s'achève le marathon des adaptations des œuvres de Stephen King en film.
Il y a pas mal de téléfilms à la qualité variable et aussi quelques séries.

### [Mercy]({{< ref "/visionnages/Mercy" >}})
*Un film moyen tentant vainement de faire peur.*
C'est pas mauvais mais c'est pas bon.

### [Cell]({{< ref "/visionnages/Cell" >}})
*C'est mauvais et longuet pour une fin nulle à chier.*
Pourtant avec John Cusack et Samuel L Jackson ça pouvait augurer quelque chose de bon.
Comme quoi, ni l'époque ni le casting n'influencent la qualité d'un film.

### [Jessie]({{< ref "/visionnages/Gerald-s-Game" >}})
Titré Jessie en français mais Gerald's Game en anglais *ce film est génial*.
L'histoire d'une femme accrochée (volontairement) au lit par son mari qui vient d'avoir une crise cardiaque.
Pleins de clins d'œil, une histoire top et un excellent jeu d'acteur.

### [Empire Of The Sun]({{< ref "/visionnages/Empire-Of-The-Sun" >}})
Film de Spielberg de 1987 où l'on découvre le début de carrière de *Christian Bale* tout jeune.
*C'est posé, historique, bien foutu et l'histoire est intéressante.*

### [Goodnight Mommy]({{< ref "/visionnages/Goodnight-Mommy" >}})
Petit film d'horreur allemand.
*Sympa et bien froid*.

### [1922]({{< ref "/visionnages/1922" >}})
*Film très mou et au final super prévisible*.
Le seul point fort est le jeu de l'acteur mais sinon c'est vraiment dispensable.

### [Simetierre 2019]({{< ref "/visionnages/simetierre-2019" >}})
*Bien moins bon que l'original et moins fidèle au livre*.
J'en attendais trop et ça n'a vraiment pas atteint ses objectifs.
Le premier était cheapos et semblait daté mais au moins c'était bien.

## Jeux

### Devil Daggers
C'est un ptit jeu au concept assez simple.
C'est un FPS, sans map, avec des ennemis cons mais qui submerge.

On est plongé dans le noir avec un vague carrelage mal éclairé et des gros pixels qui tâchent.
Notre arme ?
Heuuuu … comment dire ?
C'est notre grosse paluche pourri.

Quand on clique gentiement ça fait office de fusil à pompe.
Quand on reste vautré sur le clic ça devient une mitrailleuse.

Des ennemies vont spawner à l'infini et il faut tenter de résister tant bien que mal.

C'est un jeu de scoring.
C'est assez prenant et on rage d'avoir raté ce ptit clic de rien du tout qui aurait pu probablement vous faire tenir quelques secondes de plus et vous permettre de pulvériser votre score.

J'aime bien le concept et je m'en fais des ptites sessions de 10/15 minutes pas plus.

## Musique
Une petite musique relaxante.
Le second acte de Diablo 2 se déroule dans la ville de Lut Gholein une cité dans le désert.
Et elle est donc accompagnée d'[une musique d'ambiance sympa comme tout](https://invidio.us/watch?v=l7Ey-APyXR8).

## Nuxeries
Je sais pas comment je me suis débrouillé mais j'avais paumé mon sous-volume BTRFS.
Mais bon c'est pas bien grave, ce n'était que de l'expérimental.

Du coup j'ai voulu m'en refaire un tout propre.
J'en ai profité pour passer ma gentoo dans un nouveau sous-volume btrfs.
Actuellement elle était dans le sous-volume par défaut (le 5).
Du coup j'ai fait un snapshot d'un simple <kbd>btrfs subvolume snapshot / /gentoo</kbd>.

Je récupère ensuite son id avec <kbd>btrfs subvolume list /</kbd> qui me donne l'id 601.
J'ai modifié [mon initramfs]({{< ref "/posts/176-creer-initramfs-manuellement" >}}) pour monter le bon sous-volume.
Je reboot et le tour est joué.

Désormais, si je monte le sous-volume btrfs 5, dedans j'y trouve un dossier <kbd>/gentoo</kbd> et également un dossier <kbd>/alpine</kbd> que j'ai recréé dans son sous-volume.

J'ai mon dualboot de fonctionnel sans avoir touché grub.



Je continue de tripotter un peu **tmux** en ce moment.
Je vais probablement pondre un autre article à ce sujet.

## Vrac
On a eu le droit à quelques jours de beau temps, l'occasion de reprofiter à fond des allergies.
Ça m'a été dévastateur, le nez en corne d'abondance et les yeux qui démangent malgré leur transformation en cascade… il ne me tarde pas le printemps.
