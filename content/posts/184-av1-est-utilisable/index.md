+++
Author = "Lord"
Description = ""
Categories = ["web", "codec","vidéo"]
menu = "main"
notoc = true
WritingDate = 2019-11-06T23:12:52+01:00
date = 2019-11-07T16:12:52+01:00
title = "AV1 est utilisable !"
editor = "kakoune"
+++
Hey vous avez vu ?!
Dans mon précédent post j'ai mis des vidéos !

Je les ai faites moi-même toussa toussa.
Bon il n'y a pas de montage, ni audio et elles sont ultras basiques.
Je vous rassure je vais pas en refaire de si tôt (tout du moins pas sans raison valable).
C'est pas un format de contenu que je consomme et je suis pas du tout outillé pour en faire.
Et je vous avoue que je suis pas spécialement à l'aise en vidéo, bref je transformerai pas ce blog en chaîne youtube demain.

Je me suis dit que tant qu'à poster de la vidéo en 2019 autant le faire comme quelqu'un de moderne.
Et puis que ce soit avec un format libre.
Donc comme vous l'avez deviné (merci le titre de spoiler le reste de l'article), j'ai utilisé de l'AV1.

## AV1 ?
Je vous en ai parlé [il y a longtemps]({{< ref "/fast-posts/13-av1-aom-arrive" >}}) à l'annonce de sa sortie.

Il s'agit d'un nouveau codec récent issu de la collaboration de très nombreuses boîtes.
C'est une sorte d'hybride de différents codecs pré-existants (ou presque).

Son but est d'avoir des perfs au moins similaires à celles du poids lourd du secteur *h265*.
Mais contrairement à ce dernier, il est libre et ne nécessite pas de se payer des licences hors de prix.

Bref un codec très performant, libre et gratuit.
Mais ce qui fait la force d'un codec c'est aussi en grande partie son adoption qui dépend directement de son support par les logiciels.

AOM (le regroupement de compagnies qui se sont alliées pour pousser ce codec) est composée entre autre de tous les livreurs de navigateur web.
Le support dans les navigateurs web a donc été assez rapide.

## 70%
Donc dans le précédent article j'ai posté les vidéos en deux formats : 

  - mp4 : la vidéo d'origine toute droit sortie du téléphone en h264
  - webm : la vidéo recompressée en av1

La page web propose les deux formats et c'est au navigateur de choisir la version qu'il préférre.
Et bha selon les logs du serveur, *70% des visiteurs ont eu le droit aux versions en av1*.

Bref, c'est déjà un codec avec un bon taux d'adoption.

## 1/3
Alors je sais que c'est pas fiable du tout comme méthodologie.
Mon ensemble de vidéo est absolument pas représentatif (vidéo globalement fixes et trop similaires les unes des autres).
Qui plus est les vidéos d'origines ont été encodées par un téléphone, il y aurait très probablement moyen de les réencoder sur pc avec d'autres réglages.

Mais dans mon cas présent, l'ensemble des vidéos pèse 35Mo en mp4 pour seulement 10Mo pour les webm en av1.
J'ai donc des fichiers qui ne font qu'un tier du poids des fichiers d'origine.

## Comment encoder en av1 ?
Il existe plusieurs encodeurs déjà.

  - La libaom : c'est l'implémentation officielle qui n'a pas vraiment d'intéret pour les utilisateurs
  - Rav1e : qui est l'implémentation de Xiph (organisation qui pousse ogg, opus, theora et daala entre autre) qui se veut rapide et sûre
  - SVT-AV1 : qui est l'implémentation made in Intel qui se veut la plus rapide.

J'ai éliminé directement libaom car je l'avais testé quelques mois auparavant et ça peinait à travailler à plus de 2fps (ce qui est vraiment affreusement long même pour de courtes vidéos).

Je me suis tourné vers SVT-AV1 car … heu chsais pas trop.
Et wow, ils déconnent pas quand ils disent que c'est rapide.

Au premier essai ça m'a fait du 48fps.
Wow !

Bon, en fait en changeant un peu les paramètres ça descend un peu mais ça reste quand même très élevé.
Il y a un paramètre permettant de changer la vitesse qui est par défaut réglé de façon à être le plus rapide possible, en le baissant, le poids du fichier est grandement diminuée.

J'ai donc fait des tests d'encodage avec la vitesse max (8), mais pour l'encodage final j'ai baissé à la vitesse 2.
Et je suis tombé aux alentours de 3fps.
Donc ouai je suis retombé probablement au niveau de la libaom…

Bon et pour la pratique voilà comment j'ai fait :

  1. chopper les sources sur le repo github
  2. les compiler
  3. mouliner le truc à base de ffmpeg et envoyer ça à SVT
  4. muxer le fichier obtenu dans du webm

Alors pour l'étape 3 j'ai utilisé une commande de ce style :
<samp>ffmpeg -i ./partie7.mp4 -nostdin -f rawvideo -pix_fmt yuv420p - | /home/lord/githuberies/SVT-AV1/Bin/Release/SvtAv1EncApp -i stdin -fps 60 -q 63 -w 720 -h 1496 -enc-mode 2 -b ./partie7.av1</samp>

La commande est particulière parcequ'actuellement le compresseur ne sait se débrouiller que si on lui envoie les images dans un format bien particulier (ce que fait ffmpeg).
Mais bon rassurez-vous, il existe déjà un patch pour intégrer ça directement dans ffmpeg pour que ça soit bien plus simple à l'avenir.

Et concernant l'étape 4 il suffit d'un simple <samp>ffmpeg -i partie7.av1 -c:v copy partie7.webm</samp> et vous voilà avec un fichier webm à placer où_vous le souhaitez.

------------
Bon par contre héberger des vidéos ça bouffe beaucoup de bande passante (je suis loin de saturer, hein).
Certains mois je transfère dans les 10Go de données et bha je les aie atteints en quatre jours :-)
