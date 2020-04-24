+++
Author = "Lord"
Description = "Après une première partie consacrée à l'installation de tout le nécessaire, on va aborder ici la manipulation du logiciel OBS. On va créer des scènes, mixer le tout, appliquer des filtres."
Categories = ["audio", "vidéo","stream","linux"]
menu = "main"
notoc = true
WritingDate = 2020-04-02T23:13:18+02:00
date = 2020-04-21T13:13:18+02:00
title = "Setup pour streamer vol.2 : Mixer des sources avec OBS"
editor = "kakoune"
TopWords = [  "appli", "capture", "plugin", "v4l2sink", "webcam", "scènes", "audio", "sources", "obs","stream","remote","télétravail"]
+++
Suite de l'[épisode précédent]({{< ref "posts/198-mon-setup-pour-streamer-vol1" >}}).

Dans la première partie j'ai configuré et installé des logiciels pour créer des sources de contenu (vidéo ou audio).
Maintenant on va s'atteler à touiller tout ça telle une régie vidéo.

## Open Broadcaster Software : OBS
Le logiciel le plus populaire est **obs** aussi appelé **Open Broadcaster Studio**.
C'est un logiciel libre tournant grâce à Qt avec une interface graphique vraiment pas pourrie.

Ce logiciel repose sur le principe des *scènes*, *sources* et *transitions*.

En gros une source ça peut être un fichier vidéo ou audio, une image, une caméra, la capture de l'écran ou la capture d'une fenêtre, un micro, un flux vidéo issu du réseau…
Un peu tout et n'importe quoi.

Une scène, c'est un ensemble de sources avec leur configuration et des filtres.
Les filtres permettent de traiter en live les sources.
Ça peut être un filtre audio permettant de la suppression du bruit ambiant par exemple ou bien des filtres vidéos permettant de retoucher l'image.
On peut par exemple retailler une image pour n'en garder qu'une partie, altérer les couleurs, créer un filtre de fond vert…
C'est une des grandes forces de ce logiciel.

Et enfin les transitions c'est ce qui va animer un peu les changements entre les différentes scènes.
Ça peut être un fondu au noir ou des trucs un peu plus kikoo.
Tout est configurable.

Bref, ce logiciel est une perle qui fonctionne avec des plugins permettant de lui ajouter de nombreuses fonctions.
Le seul petit truc, c'est qu'il faut le lancer via X11 avec <samp>QT_QPA_PLATFORM=xcb obs</samp>, sinon pas de preview et autres petits soucis d'interface avec Wayland (encore qu'il existe un ptit fork que je n'ai pas testé).

### Plugins pour obs
J'ai utilisé plusieurs plugins : 

  - **wlrobs** : pour capturer de la vidéo issue de wayland
  - **obs-v4l2sink** : pour alimenter une webcam
  - **tuna** : c'est du bonus très facultatif afin d'afficher ce que diffuse actuellement MPD

Bon il y en a tout un tas de disponible, mais je me suis contenté de ça.

Tout d'abord j'ai installé **[wlrobs](https://hg.sr.ht/~scoopta/wlrobs)** qui permet de capturer des flux vidéo issus de Wayland et est compatible avec tous les compositors s'appuyant sur **wlroots** (donc **sway** entre autre).
Une fois installé, quand vous ajouterez des sources vous aurez de nouvelles options.
Mais je ne vous cache pas qu'au final j'ai tout fait sous xorg, je n'ai trouvé le plugin qu'après en avoir eu besoin.
Donc je détaille pas plus, c'est très dispensable.

Ensuite, **[obs-v4l2sink](https://github.com/CatxFish/obs-v4l2sink)** qui permet de balancer le flux vidéo (pas audio) dans un "device v4l2" ou plus communément dans une webcam virtuelle.
En gros, la sortie OBS sera considéré comme une webcam et pourra donc être envoyé dans n'importe quelle appli s'attendant à utiliser une webcam.
Une fois installé vous n'avez qu'à lui donner le nom de device */dev/video5* (que vous avez choisi lors du modprobe de v4l2-loopback) et c'est parti.

  - D'abord les sources d'obs nécessaires pour compiler le plugin : <samp>git clone --recursive https://github.com/obsproject/obs-studio.git</samp> 
  - Les sources du plugin : <samp>git clone https://github.com/CatxFish/obs-v4l2sink.git</samp>
  - <samp>cd obs-v4l2sink</samp>.
  - <samp>mkdir build && cd build</samp>
  - <samp>cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX="/usr"</samp>
  - <samp>make -j16</samp>
  - <samp>mkdir -p ~/.config/obs-studio/plugins/v4l2sink/bin/64bit</samp>
  - Il ne reste plus qu'à foutre le plugin dans obs : <samp>cp build/v4l2sink.so ~/.config/obs-studio/plugins/v4l2sink/bin/64bit</samp>

Voilà, normalement le plugin sera utilisable.

## Découverte de l'interface OBS

{{< img src="obs.png" link="obs.png" alt="Capture d'écran du logiciel OBS" title="OBS dans toute sa splendeur" >}}

Donc en plein centre on a la **preview du flux final**, c'est ce que les gens vont voir.
Sur cette preview, vous pouvez modifier le placement et la taille des sources vidéos.
Et vous pouvez le faire même pendant le live.

En bas à gauche la **liste de scènes** que l'on a créées.
Vous pouvez passer de l'une à l'autre juste en cliquant.
Vous êtes le chef de la régie !

Ensuite la **liste de sources de la scène actuelle** avec pour chacune la possibilité de l'afficher ou non et de la vérouiller sur son placement.
C'est ici que vous allez en rajouter/enlever.
Et sur chacune des sources vous pouvez y appliquer des filtres (via le clic droit).

Vient, l'**Audio Mixer** qui vous affichera les différentes sources audio avec le volume en temps réel.

Maintenant, on trouve les **transitions**, bon dans mon cas c'est juste pour me la péter, on peut se contenter d'un cut banal.

Et pour finir les **controls** qui permet de démmarrer/arrêter le stream ou l'enregistrement.
C'est pas la partie la plus intéressante.

## Création de scènes

### Le basique webcam + micro
On va commencer par une scène simple avec une webcam et le micro.
La base de la base.

Donc on clique sur le <samp>+</samp> dans les scènes et on lui donne un nom.
Ensuite, on va ajouter le micro comme première source.

Donc dans la liste des sources possibles vous devriez avoir *Audio Input Capture (PulseAudio)*, vous lui donnez un ptit nom original comme par-exemple… <samp>micro</samp>.
Ensuite dans la fenêtre qui s'ouvre vous choisissez le bon device (le nom de votre carte son selon PulseAudio).
Ça devrait donc apparaitre dans la partie *Audio Mixer* et réagir à votre voix déjà.
On va y ajouter un filtre : clic droit sur votre source, *filters* et là vous allez pouvoir faire mumuse avec tout un tas de trucs.
Perso, j'ai mis un *Noise Gate* avec ces paramètres :

  - *Close Threshold* à -15dB
  - *Open Threshold* à -5dB
  - *Attach Time* à 25ms
  - *Hold Time*  200ms
  - *Release Time* 150ms

Bien entendu tout ça c'est à adapter à votre cas, ça prend pas mal d'essais pour arriver à un résultat pas pourri.

Bon, maintenant que l'audio est bon, ajoutons une webcam.
Ajoutez encore une source mais de type *Media Source*.
Bon, j'espère que vous avez suivi la première partie, parceque là on va récupérer un flux en provenance de l'appli **DroidCam** d'un smartphone.
Donc il faut avoir démarré l'appli sur le téléphone qui vous indique une URL.
Sur OBS, dans votre source vidéo, il faut décocher *Local File* et dans *Input* entrer l'url de la forme <samp>http://ip.du.smart.phone:4747/video</samp>.
Tout le reste peut être laissé par défaut, ça devrait fonctionner.

Vous devriez désormais voir le flux arrivé.
Il faudra ptet tourner et tout pour que ça s'affiche à votre convenance.
Pour cela, il faut faire clic droit dessus pour y trouver toutes les options possibles.

Dans les filtres vous pourrez aussi cropper la vidéo (couper pour ne garder qu'une partie intéressante).
Mais dans les filtres un peu plus poussés, vous avez les *Chroma Key* et *Color Key* qui vous permettent de créer la fameuse technique du *fond vert* mais avec la couleur que vous voulez.
Ça marche pas mal mais c'est très dépendant de votre éclairage, s'il varie un peu (genre éclairage naturel d'une fenêtre) ça devient vite galère.

Voilà vous avez votre première scène.

### Une scène d'attente
Souvent on a besoin de faire une pause ou bien on a pas encore démarré vraiment le stream tout en commençant à émettre pour que les gens puissent rejoindre.

Là du coup, j'ai créé une scène très simple : une image en fond, la capture d'un terminal où je peux écrire un message comme "Je reviens" ou "Ça commence à 2h".
Un fond musical en boucle.

Donc dans les sources, on ajoute une *Image*.
Il vous suffit d'aller piocher une image dans votre skeudur et hop c'est bon.

On ajoute une autre source de type *Media Source* où l'on fout le morceau de musique qui vous plait.
Si possible du libre de droit, un morceau assez long pour pas que les gens deviennent fous, on coche *Loop* histoire que ça soit en boucle.
Voilà c'est pas mal.

Et pour le terminal, on rajoute une source de type *Window Capture (XComposite)*.
Là il vous listera toutes les fenêtres tournant actuellement.
Ça ne liste que les applis X11, donc si vous êtes sous Wayland, pensez à lancer votre appli via XWayland.
Pour rendre le truc un peu plus kikoo, on peut s'amuser à supprimmer le fond de votre terminal pour voir le texte en transparence.
Ajoutez un filtre de type *Color Key* avec comme couleur le fond de votre terminal et voilà.

D'ailleurs maintenant que vous avez au moins deux scènes vous pouvez passer de l'une à l'autre pour vérifier que ça fonctionne bien.

Bon avec ces deux exemples on a un peu tout vu, vous pourrez créer d'autres types de scènes à votre convenance sans trop de soucis.
Ça ne sera que des variations de ça.

## Mix Audio
Vu que vous avez votre **PulseAudio**, dans les sources audio, vous allez pouvoir ajouter un *Audio Output Capture (PulseAudio)* qui sera tout ce que vous entendez.

Hmmm je vais pas trop pouvoir vous aider plus que ça, je me suis contenté du minimum syndical.

Dans les ptites infos à savoir : il faut viser le volume audio dans le jaune et éviter d'aller dans le rouge.

Vous pouvez faire en sorte de baisser le volume d'une source automatiquement lorsqu'une autre source diffuse (pratique pour baisser le volume d'une musique lorsque vous parlez).
Ça se fait via un filtre *compressor* avec le *sideducking*.

## Diffuser le titre de ce qui passe sur MPD
Habituellement j'écoute ma musique via [MPD](https://www.musicpd.org/) qui est un serveur tournant en fond sans interface graphique directe mais avec des clients pour le manipuler.

Il existe un plugin [tuna](https://github.com/univrsal/tuna) pour obs se chargeant de récupérer les infos et vous permettant d'afficher une ptite barre de progression ainsi que le titre et compagnie.

Une fois le plugin installé, il faut se rendre dans le menu *Tools/Tuna Settings*.
Là dans *Basics* vous pourrez choisir quel texte exactement afficher, choisir la source (parcequ'il gère également Spotify et VLC).
Donc dans mon cas on choisit *MPD* et dans l'onglet éponyme, on coche *Local connection* et c'est tout.

**Tuna** va en fait créer un fichier texte, qu'il va mettre à jour continuellement avec les infos que vous voulez.
Vous devez donc définir son emplacement (je le mets dans /tmp) et indiquer quel texte y coller (je me contente du titre et de l'artiste).

Vous avez maintenant *Tuna progress bar* dans les sources possibles.
C'est … bha une barre de progression qui se remplira en fonction de l'avancement dans le morceau de musique.
Pour le texte, il faut ajouter une source de type *Text (Freetype2)*.
Dans ses propriétés, choisissez le fichier que vous avez défini tout à l'heure et il ne vous reste plus qu'à déplacer ça où vous voulez.

D'ailleurs comme le texte sera de taille variable, il peut être pas mal de lui coller un filtre *Scroll* pour faire défiler horizontalement le texte.

## Les transitions
Bon, je ne vais pas trop m'attarder sur ce chapitre.
C'est très facultatif.

Perso j'aime bien l'aspect de *Luma Wipe* avec le preset *cloud*.
Le tout reglé sur *1000 ms*.


--------
Voilà maintenant vous devriez être à peu près en maîtrise de votre OBS avec vos scènes et compagnies.

Si jamais vous avez vraiment pas mal de scènes et que passer de l'une à l'autre est vraiment très important dans votre façon de travailler, **OBS** propose un espace de travail dédié appelé *Multiview* que vous pouvez démarrer en passant par le menu *View*.
Là ça vous ouvrira une fenêtre où vous visualiserez toute vos scènes simultannément et vous pourrez passer de l'une à l'autre en cliquant dessus.
C'est plus visuel, vous aurez encore plus l'impression de gérer une région vidéo !

**Petite astuce pour lancer une appli sous X11 au lieu de Wayland :**
Il faut déjà que l'appli sache tourner sous X11.
Ensuite pour une appli utilisant Qt, vous pouvez la forcer lors du lancement avec <samp>QT_QPA_PLATFORM=xcb nom_de_votre_soft</samp>, comme ça elle sera directe envoyée sur XWayland.

Pour d'autres applis, vous pouvez tout simplement le faire en leur enlevant la variable d'environnement *WAYLAND_DISPLAY*.
Par exemple pour lancer **Alacritty** il faut faire <samp>WAYLAND_DISPLAY= alacritty</samp> .
Voili voilou.

Bon dans le prochain article j'aborderai enfin la partie diffusion.
Donc une partie dédiée à la partie diffusion webcam et une seconde plus pour le streaming plus classique.

L'épisode suivant est là : [Setup pour streamer Vol.3]({{< ref "posts/200-mon-setup-pour-streamer-vol3" >}})
