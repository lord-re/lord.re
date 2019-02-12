+++
Author = "Lord"
Description = "Tout le monde y va de son débunkage à propos de Wayland et je veux apporter ma ptite pierre à l'édifice !"
Categories = ["wayland", "réponse"]
menu = "main"
notoc = true
PublishDate = 2019-02-12T19:14:47+01:00
date = 2019-02-12T19:14:47+01:00
title = "Debunkage de Debunkage des mythes de Wayland"
editor = "kakoune"
+++
DrewDevault s'est lancé dans [un blog post pour débunker les mythes autours de Wayland](https://drewdevault.com/2019/02/10/Wayland-misconceptions-debunked.html).
Bon pour info ce gars est un des devs de **Wlroots** et **Sway**.
Le premier est une lib permettant de développer des compositeurs Wayland et le second est un compositeur Wayland assez populaire (mais sans plus), bref c'est un mec qui connait pas mal le sujet sans pour autant être l'expert ultime (qui n'existe pas).

Bon et du coup ça parle de différents trucs : la sécurité, les screenshots, l'embarqué, transparence réseau, le CSD (les décos de fenêtres), nVidia.
C'est globalement assez factuel avec pas mal de liens pour sourcer et tout.

Bref, l'article est pas mal.

Et là pouf [un journal qui apparait sur LinuxFr](https://linuxfr.org/users/gabin_2-2/journaux/le-degonflage-des-mythes-wayland-degonfles-sur-reddit) et là attention ça vire un peu au n'importe quoi (surtout en considérant les commentaires).

Bon déjà ça vient pleurnicher sur le sort de **Mir**.
Mir c'est le truc fait tout seul dans son coin par Canonical, vous savez ?
Les gens d'Ubuntu qui passent leur temps à réinventer de leur côté des trucs qui ne percent jamais ailleurs.

Bref, cracher sur Wayland qui est un protocole avec des specs et compagnie alors que Mir c'est juste un soft utilisé par personne d'autre que Canonical… no comment.

Ensuite il y a un ptit paragraphe qui voudrait nous faire verser une ptite larme concernant nVidia qui ne veut pas faire comme tout le monde en faisant des drivers graphiques libres.
Il faudrait en plus les encenser car c'est grâce à eux qu'on a de la 3D/accélèration décente sous Linux et FreeBSD…
Ce qu'il faut pas lire.
Bref pas mal de commentaires soulignent que *si, on peut jouer décemment avec les drivers libres AMD* (je peux en attester également).

## Ce qui n'est pas évoqué
Un point qui n'est survolé que dans les commentaires c'est le paradoxe actuel de Xorg.
Xorg c'est donc un serveur **X11**.
X11 le protocole qui fait tourner les applications graphiques sous les unix et il date de … gogowikipedia … *1987*.
Et autant vous dire que le protocole accuse son âge.

*Une grande partie du protocole est clairement obsolète et n'est quasiment plus utilisé* (une histoire de primitives), à l'inverse il y a eu du *bricolage dans tous les sens pour y ajouter des concepts inconnus à l'époque* : **l'accélération graphique**.

Parce que ouai en 1987 il n'y avait pas de carte 3D, pas d'OpenGL.
Et du coup les devs ont rusé en hackant le truc dans tous les sens pour permettre d'avoir de l'accélération graphique sur un serveur graphique (le cœur du métier quoi).

Du coup quand de nombreuses personnes pleurent la perte de transparence réseau en passant à Wayland je ris.
Il existe trouzemille façon d'avoir de l'affichage distant entre les VNC, le SPICE, le RPD… mais non ces gens pleurent la disparition du protocole vieillissant ne sachant pas gérer l'accélération graphique et ayant des perfs réseaux miteuses.

Le second point qui n'est pas abordé et qui est pourtant capital c'est qu'**une grande partie des devs (promoteurs) de Wayland SONT les devs de Xorg**.
Ce sont les mêmes gens qui lâche l'affaire de Xorg car c'est trop vieux, encombré, bricolé et qui avec l'expérience savent qu'il n'est plus possible de continuer inlassablement à faire vivre ce papy et qu'il est bien plus intéressant de repartir sur des bases plus modernes.

Petit à petit Xorg va être abandonné de ses devs (c'était déjà sacrément calme depuis quelques années) au profit de Wayland.

## Wayland n'est pas un logiciel
Ouai c'est un point qui est souvent zappé, mais Wayland c'est pas un logiciel que vous lancez et hop.
C'est un protocole qu'il faut implémenter pour créer un logiciel.

Il n'y a plus de *serveur d'affichage* + *gestionnaire de fenêtre* mais c'est remplacé par le *compositeur* qui a ces deux tâches désormais.
Donc ouai dans les commentaires quelqu'un resort le coup de “Quand mon WM plante sous Xorg tout continue de marcher, les fenêtres sont moches quelques secondes puis tout revient alors que sous Wayland tu perds tout”.
Ouai c'est vrai, mais quand c'est ton Xorg qui plante parce que (par exemple) le driver graphique se vautre, tu perds tout aussi.
Bref pas d'avantage pour l'un comme pour l'autre.

Ouai si à l'époque coder un WM (Window Manager, un gestionnaire de fenêtre), c'était ultra simple et quelques centaines de lignes de code pouvait suffire ce n'est définitivemnt plus le cas.
Mais c'est pas pour autant que ça ne sera jamais le cas.
*L'écosystème est encore tout jeune, mais il y a fort à parier qu'il existera des libs (à la wlroots) qui prémâcheront intégralement le boulot.*

Wayland c'est pas un seul protocole monolithique mais un amas de protocoles avec le noyau et pleins de petits rajouts à droite à gauche pour gérer le presse-papier/les claviers virtuels/le vérouillage du curseur/…
Donc ouai pour l'instant pas grand monde gère absolument tous les cas de figure et non il n'existe pas encore tous les "sous-protocoles" imaginables.
Ça mûrit petit-à-petit, ça grandit au fil du temps de disponibilité des devs.
Ce n'est pas rushé et les sous-protocoles sont discutés de longs mois avant d'être implémentés.
Il faut bien voir qu'une fois défini et utilisé massivement, *il est très difficile de modifier un protocole et tout l'écosystème l'ayant implémenté à posteriori*.
La compatibilité avec X via **XWayland** permet de ne pas avoir besoin de tout faire à la va-vite : faire tourner un soft via XWayland est transparent et permet pourtant de profiter de la sécurité améliorée de Wayland.

--------------

Bref Wayland arrive petit à petit en proposant plein de nouveautés pour les devs qui ne seront pas forcément visibles pour l'utilisateur lambda.
Refuser cette évolution sous prétexte que la transparence réseau n'est pas possible alors que ce cas d'utilisation est marginal et bancal est assez dommage.
Le fait que nVidia ne collabore pas… bha c'est du classique nVidia vis-à-vis du libre.

Pas la peine d'user de FUD à son encontre, Wayland est déjà là ou presque et tourne aussi bien sur de tous ptits trucs embarqué que des bons gros ordi avec du bon gros Gnome des familles.
