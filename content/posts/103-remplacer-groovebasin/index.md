+++
Author = "Lord"
Description = "L'aventure pour remplacer Groovebasin par MPD avec un peu d'édition de code C."
Categories = ["software", "dmenu"]
menu = "main"
notoc = true
PublishDate = 2018-05-27T21:08:11+02:00
date = 2018-05-27T21:38:11+02:00
title = "Remplacer Groovebasin par MPD"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/whdrdq/remplacer_groovebasin_par_mpd"
+++
Voilà maintenant des années que j'utilise le logiciel **Groovebasin** pour écouter de la musique.
C'est un lecteur audio web. Ça veux dire qu'il faut utiliser un serveur web, et un navigateur web pour pouvoir l'utiliser.
Ça a de sacrés avantages tel que la disponibilité de votre bibliothèque numérique de partout.
De reprendre la lecture là où vous en étiez, pouvoir contrôler la lecture depuis une autre machine.

Mais au final ça a ses inconvénients : il faut passer par un navigateur web, ce qui est assez lourd.
L'intégration dans le reste du système est compliquée : pas facile de faire des hotkeys pour le contrôler à distance.
Et puis il ne gère pas les notifications du coup pas moyen de voir le titre de la nouvelle chanson qui démarre sans aller chopper la page web.

J'ai utilisé pas mal d'alternatives : *Subsonic* qui est très similaire mais moins bien globalement sauf pour la partie application android (qui gère la création d'un cache offline entre autre).
J'ai également testé *Ampache* il y a très longtemps et ça m'avait moyen convaincu.
J'ai utilisé quelques temps *MOC* qui est un player audio en console que j'aimais bien mais du coup on perd toutes les features qu'apporte un player web.
Et encore plus longtemps avant j'ai utilisé *foobar2K* sur windows et encore un peu avant *Winamp*.

**Bon du coup… vers quoi me tourner ?**

## MPD
Music Player Daemon est un projet qui est maintenant assez connu de part son âge.
Il était particulièrement novateur à l'époque dans son concept d'avoir un serveur musical.
C'est une approche pas trop éloigné des players web à la différence que c'est pas du web.

On a donc des clients MPD dédiés plus ou moins variés dont un certains nombre en console.
On peut donc manipuler le serveur avec de nombreux programmes différents, du plus basique (*mpc*) à d'autres plus lourdingues avec de vrais interfaces graphiques en GTK+ ou QT…
Bref il va forcément y avoir un truc qui va me plaire !

## NCMPCPP
Mon premier réflexe a été de chercher un client console.
Après tout j'ai l'habitude de manipuler quasiment tous mes softs dans des terminaux désormais et puis bon… jouer de la musique ne nécessite pas d'interface graphique.

Ayant déjà fais mumuse avec la bête il y a quelques années, je me suis retourné vers **ncmpcpp** qui est l'un des clients consoles les plus réputés.

Et bhé…
J'aime pas trop trop.
Je trouve l'interface étrange : par défaut on tombe sur la playlist mais du coup si l'on veux rajouter une chanson à la playlist là commence la bataille.
Il faut aller dans la bibliothèque.
Trois choix possibles, la première c'est *Browse /* qui affiche l'arborescence de fichier, la seconde est le *Search engine* et enfin la *Media Library*.
Et c'est là que je commence à râler.

Ptain que l'interface est désagréable !
Si l'on va dans l'arbo de fichier, on cherche une chanson, et si on a le malheur d'appuyer sur Entrée paf ça vous la fout en fin de playlist et ça passe dessus…
Mais heuuu pourquoi ce comportement ?
Ça serait compréhensible que ça la foute en fin de playlist mais sans la jouer tout de suite, parcequ'une fois la chanson finie bha la playlist est finie.
Ou alors ça la fout à la place du morceau courant du coup la suite de la playlist est pas impactée.
Bref un choix bien étrange.

Toujours dans la catégorie interface étrange, le *Search engine* est d'un lourdingue.
Là on peut faire une recherche globale ou alors rechercher uniquement dans un tag précis des fichiers (genre que dans les "artists" ou que dans les "albums") ce qui est vraiment bien.
Par contre pour lancer la recherche faut descendre tout en bas de la liste de choix possible pour aller sur *Search*…
Ptain habituellement les interfaces textes sont tellement plus efficaces.
Et encore une fois gare à vous !
Si vous avez le malheur d'appuyer sur Entrée, rebelotte ça vous le fout en bas de playlist et ça passe dessus : la plaie.
Si vous voulez l'ajouter dans votre playlist actuelle faut appuyer sur **a**, là s'ouvre un fenêtre vous demandant dans quelle playlist, puis ensuite une autre fenêtre pour savoir où la placer dans la playlist.
Beaucoup trop d'étape pour une action aussi basique.

Et c'est pareil pour la *Media library*, au moins l'interface est cohérente dans sa lourdeur.

## PMS
J'ai vite fait testé un autre client pour MPD du nom de [PMS](https://kimtore.no/pms/) qui est plus récent que le vénérable ncmpcpp et qui est actuellement en train de subir une réécriture en Go.
J'ai donc testé la version classique avant réécriture qui est annoncé comme stable et pour l'instant avec plus de fonctionnalité et pour faire vite j'ai pas aimé l'interface non plus.
Et puis la doc est … déplorable.
Pas réussi à faire ce que je voulais simplement du coup j'ai capitulé en voyant la non-doc.

J'ai un peu trop pris mes habitudes avec Groovebasin.
La migration vers autre chose est donc difficile.
Va falloir que je me décroute et du coup avec l'aide du Fediverse, j'ai décidé de prendre le taureau par les cornes.

## SMPCD
Du coup j'ai fait un ptit cahier des charges :

  1. Je veux pas que la musique s'arrête pour cause de playlist vide
  2. Je veux pouvoir revenir au morceau précédent et ptet celui d'avant aussi et aussi au précédent…
  3. Je veux pouvoir le contrôler via des raccourcis claviers
  4. Je veux des ptites notifs quand ça change de morceau avec le titre/l'auteur
  5. Je veux un truc super léger

Bon bha en fait tout rentre dans un simple script shell.
MPD propose **MPC** qui est une interface en ligne de commande basique mais qui a accès à toutes les fonctionnalités de MPD.
Si c'est pas faisable dans MPC, c'est que MPD peut pas faire.

Allez c'est parti pour ce dimanche maussadee !

### Vérifier que MPD tourne

    CheckMPD(){
      if [ ! $(pgrep -x mpd) ]; then
        timeout 3 i3-nagbar -m "MPD ne tourne pas"
        exit 1
      fi
    }

Cette partie est ultra simple, si le daemon ne tourne pas on quitte

### La boucle qui fait tout

    Loop(){
      while true
      do
        CheckMPD

        if [ $(mpc playlist | wc -l) -lt 30 ]; then
          mpc findadd Title "$(mpc list Title | shuf -n 1)"
        fi

        if [ $(mpc current -f %position%) -gt 15 ]; then
          mpc del 1
        fi

        mpc idle player
        flock -nF /tmp/mpdnotif.lock -c 'mpc current -f "%title% - %artist%" | timeout 8 dmenu -g' &
      done
    }

Voilà la bête.
Au final c'est ultra simple, d'abord on lance une boucle infinie avec le *while true*.
Dans cette boucle d'abord on lance la fonction décrite précédemment histoire de pas mouliner pour rien.

Ensuite le premier if s'assure que si la playlist fait moins de 30 morceaux de musique d'en rajouter un au hasard depuis la bibliothèque.

Le second if lui veille à ce que si l'on dépasse le quinzième morceau de la playlist de virer le premier morceau de la playlist.
Ça évite de garder un historique des morceaux passés trop long.

Après se trouve le *mpc idle player* qui permet d'attendre que MPD fasse une action au de type *player* ce qui correspond à passer au morceau précédent/suivant ou juste faire une pause/reprendre.
Ça évite de faire un sleep dans la boucle.

Et enfin le *flock* permet de mettre un vérou (dans /tmp) pour éviter de lancer plusieurs fois simultanément la commande qui suit.
Sans ça, lors d'une frénésie de passage à la chanson suivante on se retrouve avec pleins de notifs de morceau suivant.
Et pour afficher la notif j'ai rusé, j'ai utilisé *dmenu* avec la commande *timeout*.
*timeout* permet de lancer une commande pendant quelques secondes puis de l'interrompre.
Dans mon cas je lance un dmenu à qui j'ai passé les informations depuis *mpc current*.

## DMENU MPD
Dmenu est amour et des gens ont déjà bidouillé des scripts pour manipuler MPD via dmenu.
Mais globalement c'était soit overkill soit pas tout à fait ce que je cherchais.
Du coup j'ai fait mon mien qui est ultra simple :

    #! /bin/sh
    mpc listall | dmenu -i | mpc insert

Ouai c'est ultra basique.
Le but est juste de lister tous les morceaux dispo dans la bibli et de pouvoir en chercher un et de l'ajouter à la playlist.
Il suffit d'ajouter un ptit raccourcis pour lancer ça depuis **i3** et le tour est joué.

## Adaptation de Dmenu
J'adore dmenu, c'est un outil formidable.
Je m'en sert pour pleins de trucs comme lancer des commandes, pour récupérer mes mots de passe, pour lancer mes films, pour contrôler la musique et aussi pour les notifs.
Le souc c'est que pour les notifs… bha ce couillon il choppe le focus du clavier.
Du coup à peine lancé vous vous retrouvez "coincé" dans dmenu.

Du coup au début j'ai fouillé dans la doc i3 pour contrer cette habitude.
J'ai aussi demandé sur leur salon irc mais pas de bol c'était l'heure de la sieste.
Du coup j'ai cherché plus globalement sur le net mais rien de bien probant.

*Et si en fait c'était pas du fait d'i3 mais de dmenu lui même ?*

Allons voir un peu le code de dmenu.
Je sais que c'est du C et je n'ai que de vagues notions de C mais bon c'est made in Suckless, ça devrait être concis.

Un ptit tour dans */usr/portage/distfiles/* et un *cp* plus tard et me voilà avec le code de dmenu.
17 fichiers !
Ça va je devrais pouvoir m'y retrouver.

Commençons direct par le *dmenu.c* qui fait 750 lignes.
Bingo, visiblement c'est quasiment tout le code de dmenu qui reste plutôt lisible même pour un noob de mon genre.

Bon va quand même falloir un peu fouiller.
Je commence par chercher *focus* qui n'a que 11 occurrences.
Il y a des trucs qui paraissent pas mal et je vois que ça parle de *grabfocus()*.
Intéressant !

Cherchons un peu ce qu'il y a avec *grab* et ses 12 occurrences.
Une fonction *grabfocus(void)* des plus pertinentes !
Et en plus en toute fin de fichier elle est appelée, à ce qui ressemble le lancement de dmenu.

Bon bha yapuka !

En début de main() il y a le parse des arguments, je rajoute une nouvelle option *-g* pour ne pas grab le focus, j'initialise la variable juste avant bien entendu.
Et je rajoute un ptit (en vrai deux) if pour vérifier la présence de cette nouvelle variable pour ne pas appeler la fonction *grabkeyboard()* et voilà.

Je **make** et je teste.
Ça marche du premier coup \o/.

Bon j'en profite pour modifier le man, et l'ajouter dans la liste des options et voilà.
Je fait génère le patch et je fout ce patch dans */etc/portage/patches/x11-misc/dmenu*.

Je réinstalle dmenu à la gentoo avec **emerge dmenu -av** et quelques secondes plus tard je teste en vrai et ça fonctionne, le man est mis à jour aussi.

Bon bha cette partie a été au final torchée en trente minutes.
Finalement le C c'est facile et Gentoo est toujours aussi formidable.

## Raccourcis claviers
Bon maintenant je veux pouvoir faire pause/suivant/précédent avec des raccourcis claviers.
Pas de bol j'ai pas de touches multimédia sur mon clavier.

Il faudrait que je modifie un ptit coup le firmware du clavier pour en ajouter avec Fn mais j'ai un peu la flemme.
Je n'ai pas conservé l'IDE arduino…
Bref ça sera pour une prochaine fois.

Pour l'instant me contenterai de créer un raccourcis clavier i3 classique sur des touches non utilisées même si c'est moins propre.

## Publication des codes
Pour l'instant je publie pas SMPCD (Shell Media Player Client Daemon) car je pense qu'en l'utilisant quelques jours j'y apporterai des modifs mais je le ferai vous inquiétez pas.
Si jamais vous le voulez vraiment n'hésitez pas à demander.

Pour dmenu pour l'instant j'ai annoncé ce que j'avais fait sur le chan irc de Suckless sans trop de réponse donc pour l'instant ça reste chez moi.
Pour les intéressés je le fout [ici](103-dmenu-4.8-nograb.patch).
