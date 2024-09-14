+++
Author = "Lord"
Description = ""
Categories = ["mpv", "software"]
menu = "main"
notoc = true
WritingDate = 2024-08-18T11:29:41+02:00
date = 2024-09-14T09:29:41+02:00
title = "Ma config MPV 2024"
editor = "helix"
Audio = ""
Soustitre = "Probablement la meilleure !"
+++
J'aime beaucoup [MPV](https://mpv.io).
C'est à mon sens le meilleur lecteur vidéo toutes plateformes confondues (oui il tourne sous windows et android aussi).
Il a une interface graphique très limitée mais fonctionnelle et suffisante.

Il y a toujours le débat « Oui mais VLC ! ».
Mais j'ai jamais vraiment accroché à VLC.
Son interface est naze depuis toujours, il est lourdingue.
Oui il sait tout lire mais … c'est pas le seul.
Ha et puis il sait pas afficher la frame précédente (ouai je m'en sers régulièrement).

MPV sait lui aussi tout lire.
Il est très lié à **FFMPEG** qui est depuis longtemps le projet de référence pour la vidéo.
On pourrait presque dire qu'il n'est qu'une UX pour ffmpeg.

C'est un fork de mplayer2 lui-même fork de mplayer.
Et il a tout un ptit écosystème plein de vie.
Il y a des [plugins pour lui ajouter des fonctionnalités]({{< ref "posts/138-mpv-et-les-scripts">}}) et tout.

Je vous en ai déjà parlé pour vous présenter des scripts mais là j'ai remis au propre ma config.
Il y a eu des évolutions de ce côté là donc tant qu'à se replonger dedans, autant tout refaire au propre.
Je suis arrivé à un setup plutôt satisfaisant.

## Décodage et stack vidéo à la pointe
Alors c'est toujours un peu mouvant surtout ces derniers temps.

Le décodage hardware de vidéo est bien entendu quelque chose de quasi indispensable.
Sous Linux il y a plein de façon de le faire plus ou moins bien avec certaines techniques obsolètes et tout.
C'est en voulant remettre ça d'aplomb que je me suis dit que ça mériterait d'être partagé.

Donc le but ça va être de forcer l'utilisation de la sortie **gpu-next** qui apporte plein de changements non directement visibles pour l'utilisateur.
Mais en gros c'est ce qui permet la meilleure qualité avec la possibilité d'avoir des shaders (pas indispensable) et autre joyeusetés.

Ensuite on active le décodage hardware via vulkan.
C'est très récent mais il y a de forte chance que ça devienne le standard cross-platform (sauf Apple m'enfin).
Et enfin on active le contexte wayland vulkan (si vous êtes sous linux avec wayland).

Pour que le décodage matériel via vulkan marche il faut forcer une ptite variable avec les cartes AMD pour le moment.

<details><summary>/etc/env.d/00aaperso</summary>

{{< highlight bash >}}
## Décodage hw via vulkan
RADV_PERFTEST="video_decode"
{{< / highlight >}}

</details>

Et pour que ça soit pris en compte, un ptit <kbd>env-update</kbd>.

Ça nous donne donc :

<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}
# =====CONFIG VIDÉO=====
vo=gpu-next                                        # Utilisation du nouveau backend le plus moderne
gpu-api=vulkan                                     # Décodage hw via vulkan
hwdec=vulkan                                       # Décodage hw via vulkan
gpu-context=waylandvk                              # Utilisation d'un contexte vulkan pour la fenêtre
{{< / highlight >}}

</details>


## Après la vidéo, l'audio
Bon, j'avais deux griefs à la conf de base.
Déjà le volume est trop bas sur certaines vidéos de merde et je veux pouvoir booster un peu plus même en dégradant la qualité avec de la saturation si nécessaire.

Aux grands maux les grands remèdes : j'augmente le volume max à 600%.
Si vous restez en dessous, ça n'altère rien, bien entendu.
C'est un usage exceptionnel mais parfois nécessaire.

Ensuite, ce sont les emmerdes de volume qui varie trop.
La fameuse scène de dialogue tranquille suivi de coups de feu qui pète les tympans.
Bref, la solution nécessite de faire un mix audio en stéréo (oui pas de 5.1 pour moi) puis de foutre des filtres pour de la compression afin de limiter l'amplitude entre les sons faibles et les sons forts.

<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}

# =====CONFIG AUDIO=====
volume-max=600                                     # possibilité de booster le son au-delà du max
audio-channels=stereo                              # Forcer la sortie en stéréo
af=lavfi=[pan=stereo|c0=FC+LFE+FL+BL+SL|c1=FC+LFE+FR+BR+SR,dynaudnorm=g=3:f=250:r=0.9:p=0.9:m=10] # Normalisation du volume et passage en stéréo
{{< / highlight >}}

</details>

## Maintenant les langues
C'est tout bête et très facultatif mais ça fait plaisir quand on démarre une vidéo et que le lecteur se démerde tout seul à choisir les bonnes pistes audio et de sous-titre.

<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}

# =====CONFIG LANGUES=====
alang=en,eng                                       # Passer par défaut en audio anglais
slang=fr,fre,en,eng                                # Passer si possible en français et sinon en anglais
sub-auto=fuzzy                                     # Rechercher les subs plus intelligemment
{{< / highlight >}}

</details>

Voilà c'est rapide.

## Les sous-titres
J'ai un peu pimpé les subs pour être un poil plus jolis.
Un chouilla de transparence et une ptite ombre portée font des miracles.

<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}

# =====CONFIG SUBS======
sub-color=1/1/1/0.9                                # Blanc légèrement transparent pour le sub
sub-border-color=0/0/0/0.9                         # Avec un contour noir légèrement transparent           
sub-border-size=2                                  # De petite taille
sub-shadow-offset=1                                # Et une légère ombre portée
sub-blur=0.1                                       # Et bien entendu un peu blurrée
sub-shadow-color=0.4/0.4/0.4/0.7                   # grise mais elle aussi transparente
sub-font='Noto Sans'                               # Soyons fou

{{< / highlight >}}

</details>

## Lecteur youtube
Je ne regarde plus youtube depuis le site ouaib mais quasi exclusivement via mes RSS en filant les vidéos à traiter à mpv.
Histoire de choisir la bonne qualité sans non plus aller au-delà de la 4k, on peut le guider.


<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}

# =====CONFIG POUR YOUTUBE=====
ytdl-format=bestvideo[height<=2160]+bestaudio/best # Se limiter au 4k maximum
{{< / highlight >}}

</details>

Rien de bien méchant.
D'ailleurs, pensez à utiliser [SponsorBlock]({{< ref "fast-posts/57-sponsorblock-:-sépargner-du-temps-sur-youtube">}}) pour vous éviter les pubs de vous influenceurs favoris.

## Les restes principalement pour du stream
Je mate du twitch également dans MPV (et parfois en me connectant au chat via weechat mon client irc favoris, mais c'est une toute autre histoire).
On peut tweaker un peu mpv pour rendre l'expérience encore meilleure.

Notamment j'ajoute énormément de cache pour pouvoir revenir en arrière ou bien faire pause.
La conso ram explose, à vous de mettre des valeurs adaptées à votre machine.

J'ai également créé un profil spécialisé pour la faible latence.
Ça permet de minimiser la latence mais forcément il y a des compromis.

Le fait de faire ça dans un profil permet de n'utiliser ces réglages qu'en l'utilisant explicitement.
J'ai nommé ce profil "stream" du coup pour l'utiliser faut lancer mpv de la sorte : <kbd>mpv --profile=stream url_du_stream</kbd>

<details><summary>~/.config/mpv/config</summary>

{{< highlight bash >}}

# =====CONFIG POUR STREAMS=====
cache=yes                                          # Activer le cache
demuxer-max-back-bytes=2000M                       # Conserver du cache pour retourner en arrière
demuxer-max-bytes=3G                               # Provisionner du cache juste pour aller en avant
#demuxer-readahead-secs=20                         # Mettre en cache au moins 20s d'avance (augmente la latence)
hls-bitrate=max                                    # Prendre la meilleure qualité possible
user-agent=Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36

[stream]
# Profil minimisant au max la latence. Utiliser avec mpv --profile=stream
cache=no
demuxer-lavf-o-add="fflags=+nobuffer+fastseek+flush_packets"
deband=no
dither-depth=no
scale=bilinear
cscale=bilinear
dscale=bilinear
scale-antiring=0
cscale-antiring=0
dither-depth=no
correct-downscaling=no
sigmoid-upscaling=no
{{< / highlight >}}

</details>

## Input
Bon là aussi bien entendu c'est une question de goût.

<details><summary>~/.config/mpv/input.conf</summary>

{{< highlight bash >}}

ctrl+left sub-step -1
ctrl+right sub-step 1

5 multiply speed 1.1
4 multiply speed 1/1.1

MBTN_BACK cycle mute

MUTE        ignore
VOLUME_UP   ignore
VOLUME_DOWN ignore
{{< / highlight >}}

</details>

<kbd>Ctrl-Left</kbd> et <kbd>Ctrl-Right</kbd> permettent de synchroniser un sous-titre pas bien calé.
<kbd>4</kbd> et <kbd>5</kbd> permettent d'accélérer/ralentir la lecture plutôt que le truc par défaut inaccessible.

<kbd>MBTN_BACK</kbd> est le bouton 3 de la souris pour couper le son.

Et j'ai ensuite désactivé les touches multimédia du clavier (que j'utilise direct dans sway).
Je me dis même qu'à terme, je vais désactiver TOUS les bindings par défaut et ne mettre que ceux que j'utilise réellement.

## Les scripts du moment
Bon je vous ai déjà fait un article dédié à ce sujet mais j'ai comme l'impression que tout le monde ne lit pas tout et encore moins qui s'en souviennent !
Bref, je vous en tiens pas trop rigueur et je vous en remets une couche.

Il existe des plugins pour mpv.
Voilà.

Non je déconne.
Voici la liste de ceux que j'utilise.

  - [autosave.lua](https://gist.github.com/CyberShadow/2f71a97fb85ed42146f6d9f522bc34ef) : sauvegarde la progression dans la vidéo toutes les trente seconde pour reprendre où on en était.
  - [fix-sub-timing.lua](https://github.com/wiiaboo/mpv-scripts/blob/master/fix-sub-timing.lua) : m'en sers très rarement mais c'est pour resynchro des subs qui n'ont pas la bonne fréquence.
  - [modernx.lua](https://github.com/cyl0/ModernX) : une interface graphique plus moderne. Je l'ai utilisé mais au final, bof.
  - [sponsorblock_minimal.lua](https://codeberg.org/jouni/mpv_sponsorblock_minimal) : pour virer les segments de pubs des vidéos youtube.
  - [thumbfast.lua](https://github.com/po5/thumbfast) : pour avoir une ptite preview au survol de la barre de progression. Je l'ai arrêté. J'adore le concept de preview sur la barre de progression mais faut pas devoir le générer (faudrait que ce soit dans les metadata des fichiers imho).

Vous trouverez ces scripts avec votre moteur de recherche favoris.
Il suffit de les placer dans *~/.config/mpv/scripts*

## Les Shaders
J'en utilise pas !

C'est plutôt un truc pour regarder les animes pour en améliorer la qualité visuelle avec de l'upscale, deband, antiringing et tout mais je n'en mate quasiment plus donc…
D'ailleurs quand on cherche des infos concernant MPV, on voit que la communauté des utilisateurs est très orienté autour de cela. ^__^

## Voilà tout
Et hop une config tout moderne et propre.
