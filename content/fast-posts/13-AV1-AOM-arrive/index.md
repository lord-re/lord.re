+++
Author = "Lord"
Description = "Et voilà enfin la sortie d'un nouveau codec vidéo. L'AV1 par AOMedia sonne le glas pour H265 et la mpeg-la."
Categories = ["actu", "codec"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-03-28T15:48:38+02:00
date = 2018-03-28T15:48:38+02:00
title = "AV1 est de sortie"
editor = "kakoune"
+++
Vous l'attendiez pas et pourtant [il arrive](https://aomedia.org/the-alliance-for-open-media-kickstarts-video-innovation-era-with-av1-release/) quand même.
AV1 est un nouveau codec vidéo.
Un de plus sauf que lui est fait par [AOMedia](https://aomedia.org/).

## AOMedia : Alliance for Open Media
AOMedia est un organisme assez récent qui a pour but de créer un codec sans royalties.
Ça peut paraître con mais jusqu'à présent la grande majorité des codecs vidéos étaient sous la houlette de MPEG-LA, une entreprise faisant son beurre sur la revente de licence pour ses codecs.
AOMedia regroupe de très nombreuses entreprises ayant ras-le-cul de payer pour ça.

On y retrouve Google, VideoLan, Nvidia, Netflix, Mozilla, Xiph, Facebook, Cisco, Arm, AMD, Microsoft, Intel et bien d'autres.

## AV1
Il s'agit donc d'un nouveau codec puisant des technologies dans différentes tentatives précédentes.

Xiph avec Mozilla étaient en train de bosser sur [Daala](https://wiki.xiph.org/Daala).

Cisco bossait sur [Thor](https://blogs.cisco.com/collaboration/world-meet-thor-a-project-to-hammer-out-a-royalty-free-video-codec).

Google était sur [VP10](https://www.webmproject.org/vp9/) (désolé c'est le lien pour VP9 mais croyez-moi, c'était un successeur à vp9).

Et donc, ils se sont tous entendu pour foutre la nique à MPEG-LA.
Ce codec peut donc être utilisé sans débourser un radis gratuitement partout dans le monde.

Si tout se passe bien ça va se démocratiser assez vite (vu les noms derrière ça devrait se faire sans trop de soucis).
Les performances devraient être au moins du niveau de H265.
Il y a fort à parier que ça devienne le codec pour le web également dans une prochaine révision de html5 pour remplacer le vp8 et vp9.

Le code source vient d'arriver [ici](https://aomedia.googlesource.com/) et Gstreamer 1.4 a déjà un support expérimental ainsi que le récent VLC3.

Il me tarde de le tester un peu voir s'il tient ses promesses et si c'est utilisable sans (en|dé)codeur hardware.

**PS :** Ha bha je viens de tomber sur [cette galerie](https://people.xiph.org/~tdaede/av1stilldemo/) qui permet de tester sur des images fixes.
Le rendu est effectivement à la hauteur si ce n'est meilleur que celui d'h265.

D'ailleurs en théorie, Firefox Nightly est en mesure de lire les vidéos en AV1 mais pas de bol chez moi ça ne fonctionne pas.
