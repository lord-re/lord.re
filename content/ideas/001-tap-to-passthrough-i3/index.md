+++
Author = "Lord"
Description = "Quand la mémoire musculaire est trop costaude, il faut la feinter"
Categories = ["idée", "i3","ui"]
menu = "main"
notoc = true
draft = false
PublishDate = 2018-08-03T09:58:28+02:00
date = 2018-08-20T09:58:28+02:00
title = "#1 Tap to Passthrough I3"
editor = "kakoune"
+++
J'utilise des gestionnaires de fenêtres pavants (je me force mais c'est clairement pas naturel… arg je tiens plus) enfin des tiling WM quoi depuis des années.
J'ai utilisé principalement **wmii** et depuis 2009 je suis sur **i3**.

Le souci c'est que wmii utilisait la touche *<kbd>Alt</kbd>* pour toutes les commandes et je l'ai donc naturellement réutilisée sur i3.
Du coup chaque commande i3 nécessite d'utiliser <kbd>Alt</kbd>.
Bon jusque-là rien de bien méchant.

Sauf que <kbd>Alt</kbd> est souvent utilisée par d'autres logiciels pour des raccourcis.
Du coup, si le raccourci existe pour i3, bha le logiciel avec le focus ne le reçoit pas.
L'idée à la noix du jour serait de *pouvoir tout de même envoyer le raccourcis si par exemple on lui faisait un petit tap au préalable*.

Donc en gros **<kbd>Alt</kbd> <kbd>Alt+t</kbd>** et pouf i3 n'interprête pas le keybinding et transmet ça à l'appli ayant le focus.

Alors oui je pourrai remapper, mais ma mémoire musculaire est trop bien implantée désormais, j'ai pas envie de réapprendre les raccourcis d'i3.
Et puis remapper chaque appli qui utilise <kbd>Alt</kbd>… arg la flemme.

