+++
Author = "Lord"
Description = "Sway est le nouveau cool kid in town. Après pas loin de dix ans à utiliser exclusivement i3, j'ai profité des avancées de Sway pour migrer dessus."
Categories = ["sway", "linux","ux"]
menu = "main"
notoc = true
PublishDate = 2018-12-13T15:44:10+01:00
date = 2018-12-13T15:44:10+01:00
lastEdit = 2020-01-18T01:26:00+01:00
title = "Sway la suite spirituelle de i3"
editor = "kakoune"
TopWords = [  "gestionnaire", "protocole", "wlc", "fenêtre", "fenêtres", "xdg_runtime_dir", "i3", "x11", "wayland", "sway"]
+++
J'utilise **i3** depuis bientôt dix ans maintenant et ça fait maintenant près d'un mois que j'ai migré sur **Sway**.

## Attends attends c'est quoi déjà tout d'abord ?

**i3** est un *gestionnaire de fenêtres* pour le serveur Xorg.
Son rôle est donc de placer les fenêtre à tel endroit, les organiser, les afficher ou non.
Il permet également de gérer les raccourcis globaux pour lancer un programme ou une action lorsqu'il détecte une combinaison de touche.
Tout ça est possible, car la gestion de l'affichage sous Linux est basé sur le protocole *X11* qui défini tout un tas de règles et propriétés…
Bref on s'en fout un peu de tout ce blabla…

X11 est donc un vieux protocole qui remonte à la moitié des années 80 et qui a subit des changements certes mais rien de bien folichon non plus.
Depuis le temps, vous vous doutez que le matériel et le logiciel a radicalement changé.
Maintenant certains concepts du protocole sont désuets et plus du tout adapté au matériel d'aujourd'hui.
Du coup, un ensemble de nouveaux protocoles ont été développés pour remplacer X11 : **Wayland**.


Beaucoup de devs de Xorg ont donc décidé de participer à cette nouvelle initiative depuis dix ans et depuis ça mûrit doucement mais surement.
Les plus gros environnements graphiques ont déjà (au moins partiellement) adopté Wayland (notamment GNOME et KDE).
Mais tous les gestionnaires de fenêtre X11 n'ont pas encore commencé la transition.

{{< img src="sway.thumb.jpg" link="sway.jpg" alt="Une capture d'écran prise lors de la rédaction de cet article." title="Un petit aperçu de la bête." >}}

Il faut dire que contrairement à X11, Wayland a une architecture complètement différente.
Alors que *sous X11, il suffit de peu de code pour implémenter un gestionnaire de fenêtre*, sous Wayland, le concept même de gestionnaire de fenêtre n'existe plus.
En plus de gérer les fenêtres, il faut gérer les entrés utilisateurs (claviers/souris/_), gérer les sorties (écrans), gérer la composition d'affichage, gérer les fenêtres…
Bref il faut faire implémenter tout le protocole Wayland et non juste apprendre à manipuler les fenêtre de X11.

À cause de cela, *le foisonnant écosystème de gestionnaires de fenêtres pour X11 ne migrera pas vers Wayland*.
Alors qu'avant c'était un ptit exercice de code pour un projet le temps d'un week-end pour les développeurs, implémenter l'équivalent pour Wayland est amplement plus compliqué et chronophage.
Mais heureusement certains projets existent pour faciliter la tâche aux autres devs.

## Bon ok mais du coup sur Wayland, il y a quoi ?

**WLC** a été dans les premiers frameworks pour aider les devs à créer de simples gestionnaires de fenêtres.
Il est arrivé assez tôt mais au fil du temps a été abandonné car le code a été bidouillé un peu dans tous les sens sans vision globale (pas étonnant pour un projet qui défriche une nouvelle techno).

**Wlroots** est le nouveau porte étendard et a donc la lourde tâche de simplifier l'écriture de "WM" pour Wayland.
Il est tout nouveau, tout beau pour le moment.
Il est développé par une communauté de devs issus de différents projets ayant monté un crowdfunding pour accélerer le projet.
Il sert de base à plusieurs projets comme **Sway** (un simili-i3) mais aussi **Way-cooler** (un simili-awesome), pour ceux qui suivent régulièrement mon blog, Purism s'en sert de base pour leur **Phosh** (interface pour téléphone portable sous Linux)…
Le projet a donc déjà beaucoup plus de recul grâce à l'expértise acquise via WLC, on peut donc espérer qu'il saura se montrer robuste dans le temps.

**Sway** est donc la suite spirituelle de **i3** au point où même le fichier de conf de i3 est compatible avec Sway (enfin partiellement, on vera plus loin).
On peut donc avoir un comportement identique entre Sway et i3.
La migration de l'un à l'autre est donc transparente et sans douleur.
Ou presque.

Au départ, Sway était basé sur WLC mais cette lib a vite montré ses faiblesses.
Maintenant (tout du moins les dernières beta) s'appuient sur wlroots et le projet atteint parfaitement son but d'être compatible avec i3.

## Du coup pour migrer il faut ?
Déjà, faut **<kbd>emerge sway</kbd>** en veillant à bien prendre les beta de la branche 1.x et non les versions en 0.1x qui sont basées sur wlc encore.
D'ailleurs quitte à migrer sur Sway, autant en profiter pour recompiler le plus de paquets possibles avec le support de wayland : dans */etc/portage/make.conf* on rajoute *<kbd>wayland</kbd>* dans les *<kbd>USE</kbd>*. Puis un ptit **<kbd>emerge -UDnav @world</kbd>** .
Une fois fait il vous reste plus qu'à démarrer votre sway !

Bon dans mon cas je n'utilise pas **systemd** ni **elogind** ni **policy-kit** et mon gestionnaire de session est **qingy**.
Donc pour rajouter sway, on crée */etc/qingy/sessions/sway*

{{< highlight "bash" >}}
#! /bin/sh

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
exec /usr/bin/sway >> /var/log/sway.log
{{< / highlight >}}

Bon ça fait rien de bien palpitant : ça crée le dossier temporaire qui va bien et après ça lance sway.

## Facile !
Ouai ouai.
Bon en vrai le fichier de conf i3 faut le compléter un peu.

Première chose, ajouter la conf du clavier dans *~/.config/sway/config* :

```
input 65261:24672:Lord_Corp_Kbd_0.1 {
  xkb_layout fr,fr,us
  xkb_variant bepo,,
}
```

Si ce n'est pas le cas, il faut passer tous les *bindsym* en *bindcode* c'est-à-dire virer tous les symboles et le remplacer par le keycode.
Pour avoir ça, il faut utiliser l'utilitaire **xev** et appuyer sur la touche correrspondante.
Exemple en bépo pour <kbd>é</kbd> :

```
KeyPress event, serial 34, synthetic NO, window 0x800001,
    root 0x39c, subw 0x0, time 15988577, (963,-103), root:(2190,1340),
    state 0x0, keycode 25 (keysym 0xe9, eacute), same_screen YES,
    XLookupString gives 2 bytes: (c3 a9) "é"
    XmbLookupString gives 2 bytes: (c3 a9) "é"
    XFilterEvent returns: False
```

Le keycode est donc 25.

Après la conversion c'est bon pour Sway.

## Quelques ajustements dans l'environnement ?

Bon premier truc à savoir, par défaut Sway (si configuré avec le use <kbd>X</kbd>) fera tourner vos applis X11 via XWayland sans rien faire à tel point que vous ne vous rendrez pas compte si une appli est native ou non.
Et c'est le cas même pour des applis qui semblerait difficilement compatible (genre **xclip** fonctionne bien) mais pourtant…

Bon par contre aurevoir **scrot**.
Le meilleur outil pour faire des captures d'écran ne fonctionne pas mais il existe [Grim](https://github.com/emersion/grim) qui s'en rapproche surtout lorsqu'on le couple avec [Slurp](https://github.com/emersion/slurp).

Concernant **mpv**, si vous aviez fait de la config particulière, il faut désormais faire en sorte d'utiliser la sortie vidéo *<kbd>gpu</kbd>*.

Concernant **QuteBrowser**… bha même s'il peut tourner nativement avec Wayland il a quelques soucis un poil chiant pour le moment, du coup je le fais tourner via XWayland.

## Mais à quoi bon ?

Bha c'est plus moderne.
Bon c'est aussi pour aider à essuyer les plâtres en reportant les bugs.

Mais il y a quand même un avantage non négligeable pour l'utilisateur de base : **Plus de processus tournant avec les droits root**.
D'un point de vue sécurité c'est excellent.
Qui plus est, il me semble que contrairement à X11, les risques de keylogger sont bien moindres.

## PS : et tout roule ?
Tout.
Sauf, les jeux.

  - **GzDoom** ne sait pas gérer la souris comme il faut.
  - **Quake3** ne sait pas locker la souris même avec des builds issues de git.
  - **RetroArch** tourne nickel.

## PS 2020 : petite update
Alors tout roule encore mieux.

Les applis Qt tournent vraiment bien mieux désormais.
Plus de ptits bugs relous, le copier/coller fonctionne comme on l'attend.

Concernant les jeux plus de soucis.
Les jeux natifs tournent bien et au final j'utilise de moins en moins XWayland.
