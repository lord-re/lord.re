+++
Author = "Lord"
Description = "J'aimerai avoir comme sur youtube la prévisualisation des vidéos au survol de la barre de progression dans MPV. Et j'aimerai qu'elle soit inclue dans le fichier mkv pour pas les calculer à chaque fois."
Categories = ["vidéo", "mpv"]
menu = "main"
notoc = true
WritingDate = 2021-03-24T22:20:14+01:00
date = 2021-03-24T22:20:14+01:00
title = "Aperçu sur la barre de progression dans MPV"
editor = "kakoune"
TopWords=["mpv","vidéo","mkv","thumbnail","progression","chapitre","youtube","feature"]
+++
Faisait longtemps que j'avais pas posté une idée à la con.

Un truc qui est génial avec Youtube, c'est que leur lecteur vidéo, il affiche une ptite prévisualisation quand on passe la souris sur la barre de progression.
Et autant être honnête avec vous : j'adore cette fonctionnalité !
*Le lecteur vidéo de Youtube est super chouette dans son interface* mais malheureusement gavé de pub, n'a pas beaucoup de presets pour la vitesse de lecture (1.25, 1.50, 1.75, 2 uniquement alors que MPV a bien plus de choix).
C'est ultra pratique.

Franchement les chapitres dans les films c'est pas mal mais ça aide pas des masses non plus.
Et j'aimerai vraiment mais alors vraiment beaucoup que cette technologie se démocratise.

Il existe un ptit script lua pour **mpv** qui permet de faire cela : [MPV Thumbnail](https://github.com/TheAMM/mpv_thumbnail_script).

{{< img src="fargo.jpg" alt="exemple de ce que ça donne à l'utilisation" title="Chouette, non ?" >}}

Le seul souci de ce script c'est qu'il vous crée un dossier avec toutes les miniatures qu'il génère (de l'ordre de ~10/15Mo pour un film).
Mais voilà, vous vous retrouvez avec un dossier avec tout cela et ça me gêne.
Bon un autre souci mais c'est lié, c'est que forcément ça créé les thumbnails à chaque fois (sauf si vous gardez le dossier (contrairement à moi qui le jarte au reboot)) et donc ça bouffe au taquet de CPU pendant la lecture.

Ce qui serait vachement cool ce serait de pouvoir intégrer toutes ces miniatures dans le fichier vidéo.
J'ai regardé un peu mais je ne trouve pas grand-chose, j'ai l'impression que ce n'est pas possible.
C'est dommage parceque le format **mkv** est ultra flexible.

Donc voilà mon idée : **Avoir un moyen d'ajouter des thumbnails timestampées dans les fichiers MKV et que ce soit reconnu par MPV**.
Ça serait chouette si ça pouvait gérer des formats d'images assez moderne voir carrément le même format que le codec vidéo lui-même.
Ça permettrait que ça bouffe encore moins de place (encore que 10Mo sur fichier de plusieurs Go c'est assez anecdotique).

D'ailleurs tant que j'y suis, **ça serait cool que MPV affiche les noms des chapitres comme le fait le player youtube** (soit au-dessus de la barre de progression, soit carrément par-dessus celle-ci au survol de la souris).
Et aussi (ouai j'abuse) **ça serait chouette d'afficher les méta-données contenu dans le fichier** (année, titre, ce genre de trucs quoi).

*(Ouai je suis toujours en quête des fichiers vidéos parfait avec les métadonnées, plusieurs pistes audio et sous-titre, les prévisualisation et les chapitres nommés…)*
