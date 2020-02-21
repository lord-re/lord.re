+++
Author = "Lord"
Description = "Mes démêlés avec qtwayland ont duré mais du coup j'en profite pour vous faire un ptit coucou et expliquer comment ranger les variables d'environnement sous Gentoo."
Categories = ["gentoo", "qutebrowser","sway"]
menu = "main"
notoc = true
PublishDate = 2019-04-16T18:12:17+02:00
date = 2019-04-16T18:12:17+02:00
title = "Les variables d'environnement chez Gentoo"
editor = "kakoune"
TopWords = [  "sway", "qt", "variables", "bug","gentoo","qutebrowser"]
+++
## Pourquoi j'ai eu besoin d'y toucher ?
TL;DR passez au chapitre suivant

Je suis passé sur [Sway]({{< ref "/posts/144-sway" >}}) depuis six mois environ et franchement tout se passe bien.
La migration depuis i3 a été vraiment douce et tout fonctionnait vraiment bien.
Mais si j'utilise du passé c'est parcequ'il y a eu un hic.

Qutebrowser (mon navigateur) tourne à base de Qt5 et un bug a fait surface récemment.
*Lorsqu'au moins une fenêtre de l'application n'est pas visible, alors ça rame énormément au point de ne plus être utilisable.*

Ce bug ne touche que les applications Qt tournant sur Wayland et ce que ce soit nativement ou via XWayland.
Sauf que bon avant d'arriver à définir aussi bien ce bug ça a été compliqué : il m'a fallu deux semaines pour y arriver.

Premièrement, il a fallu comprendre pourquoi des fois je le ressentais pas du tout et pourquoi des fois ça se trainait à mort.
Naturellement pour tester j'ai vidé le cache, utilisé un profil vierge et là… ça fonctionne nickel.
Pareil pour Falkon que je n'utilise pas du tout, là ça fonctionne nickel.
Du coup le premier réflexe c'est de me dire, que c'est mon profil avec tous mes réglages qui font chier.

Allez tant pis, on sauvegarde puis dégage le profil.
Ça fonctionne nickel, mais du coup naturellement qu'est-ce qu'on fait dans ces cas-là ?
Bha on se retape la config habituelle : modification de la taille des fonts, dégageage de l'UI, suppression des onglets, quelques raccourcis claviers customisés.
Bon bha là ça déconne.
**Arg !**
(Ça va parler Gentoo et variables d'environnement bientôt.)

Bon je refous l'UI, je vire tout ce qui est modif des zooms et taille des fonts.
Pareil.
Je reteste Falkon, non ça marche du coup là j'ouvre une nouvelle fenêtre Falkon dans un autre workspace pour avoir le bugtracker Qt d'un côté et là étrangement ça commence à merder pour lui aussi.

Merde c'est un souci de Qt !

Bon bha *<samp>emerge qtwebengine</samp>*, c'est parti pour trois quarts d'heure.
Pendant ce temps, je fais des tests et là je commence à penser que c'est le fait d'avoir deux fenêtres différentes.
Je magouille et en fait bha non.
J'ai beau ouvrir deux pages web côte-à-côte bha ça rame pas.

Je me dis que c'est ptet une saloperie du côté de *XWayland* donc je tente en le faisant tourner nativement mais non rien à faire, ça change pas le comportement.
La compilation se termine, ça n'a rien changé du tout.

Je vais faire un tour sur IRC pour discuter de mes déboires avec le chan de #qutebrowser où je fais quelques magouilles supplémentaires sans grand succès, je vais voir du côté de chez #qt-labs où c'est … calme.
Pas grand-chose à en tirer.
J'en discute brièvement avec l'un des devs de *Sway* et là !
Ho Miracle !
Ça fait tilt, ça serait probablement un bug dans QtWayland qui serait déjà répertorié sur une histoire de "callback de surface"…

Après cinq minutes de fouilles effectivement c'est tout à fait ça et c'est un bug connu avec un patch en test.
(Bon j'ai rarement fait une intro aussi hors-sujet et aussi longue mais vous allez voir ça va venir.)
Bref [le bug est connu](https://codereview.qt-project.org/#/c/251380/) et presque fixé ça devrait pas tarder à arriver.
Mais j'ai vraiment envie de le tester.

Actuellement j'étais revenu à *i3* mais j'avoue désormais préferrer *Sway*.
Du coup, je me suis compilé le ptit *qtwayland avec le patch qui va bien*.
Je me le suis **<samp>make install</samp>** et yapukatester.

Je lance *Qutebrowser* et ça déconne tout pareil :-(
*All hope destroyed.*
Bon en fait si : il s'est lancé via XWayland ce couillon, je rajoute quelques variables à la main pour le lancer nativement et là pouf !
C'est tout fluide comme au bon vieux temps.

## Comment rajouter des variables d'environnement proprement dans Gentoo ?
Il y a un joli dossier */etc/env.d/* contenant plein de fichiers textes pour les variables d'environnement spécifiques à différents logiciels.

Du coup dans mon cas j'ai créé un ptit *42qutebrowser* et dedans j'y ai mis :

    QT_QPA_PLATFORM="wayland"
    QT_WEBENGINE_DISABLE_WAYLAND_WORKAROUND="1"
    QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

Remarquez les guillemets !
Sans ça, ça fonctionne pas…
Me suis fait avoir.

Et là un **<samp>reboot</samp>**
Ouai j'avais la flemme.
D'habitude je ne fais jamais ça mais là, vraiment, la fatigue, toussa toussa.
Mais ça m'a laissé le temps d'aller voir un peu les semis sur le balcon.

Voilà.

Bon bha heureusement que j'ai brodé sinon ça allait se voir que c'était un article que pour me rappeler où j'avais planqué ces variables à la con…
