+++
Author = "Lord"
Description = "Avec le confinement actuel, on peut être amené à donner des cours à distance. Voici ce que j'ai mis en place pour produire streamer et controler le flux webcam."
Categories = ["audio", "vidéo","android","linux"]
menu = "main"
notoc = true
WritingDate = 2020-04-02T23:13:18+02:00
date = 2020-04-18T10:13:18+02:00
title = "Setup pour streamer vol.1 : capture audio et vidéo"
editor = "kakoune"
TopWords = [  "webcam", "kernel", "v4l2", "loopback", "droidcam", "audio", "vidéo", "alsa", "pulseaudio","linux"]
+++
Bon, je vais donner des cours à distance.
J'ai jamais fait ça et j'aimerai faire ça avec du logiciel libre uniquement.
J'ai pas envie de reposer sur un GAFAM ou un Zoom assez douteux ni même sur une quelconque plateforme privée comme Discord ou Slack.
Du coup, j'ai tâtonné pour tout mettre en place.
Mais ça fonctionne plutôt bien et ça m'a coûté 0€

Cela dit c'est un peu de boulot à mettre en place, car il n'y a pas une seule grande doc unifiée.
Donc voilà je m'y lance dans ce double article.

Cette première partie abordera **la capture audio et vidéo**.
La seconde partie, elle, abordera **le mix et la diffusion**.

## On part de quoi ?
J'ai à peu près 0 matos.
J'ai un pauvre casque avec micro, des téléphones Android pour faire webcam et c'est tout.

Niveau logiciel je fais ça sous Gentoo mais n'importe quel Linux fera l'affaire.

Comme la plupart des trucs que j'écris, faut pas le prendre pour argent comptant ni comme un tuto.
C'est ce que j'ai réussi à mettre en place et qui à mon niveau fonctionne.
Il y a très probablement pleins de points à améliorer.
Et je suis d'ailleurs preneur de toutes remarques en ce sens dans les commentaires.

## La webcam depuis un Android
Bon j'ai pas de vraie caméra mais j'ai deux téléphones Android pas trop dégueux, donc je pensais pouvoir m'en sortir facilement.

Il s'avère qu'il existe des applis sur le Play Store qui font bien le boulot comme par-exemple la plus connue **[DroidCam](http://www.dev47apps.com/)** mais c'est pas très libre.
J'ai un peu fouillé dans Fdroid mais je n'ai rien trouvé de libre équivalent.
Le truc qui s'en rapprochait le plus était **SpyDroid** mais c'est un peu à l'abandon et pas totalement fonctionnel.
La mort dans l'âme j'ai capitulé et via **Aurora Store** j'ai chopé **DroidCam** qui est ultra simple et fonctionnel.

En gros, on active le wifi, on lance l'appli et hop, elle balance un flux vidéo en http.
Il ne reste plus qu'à s'y connecter directement via http://ip.du.smart.phone:4747/video et hop on a notre flux vidéo.
C'est dommage de pas avoir d'appli libre pour ça…
Et c'est aussi dommage de pas pouvoir l'acheter sans passer par le Store Google du coup je me contente de la version gratos.
J'aurai pas été contre filer quelques deniers pour cette appli.

Cette appli marche très bien et se contente de permissions normales pour tourner et n'a pour tracker que ses pubs Google.
Bref, c'est relativement clean et semble être de bonne foi.

Dans sa version gratuite elle n'a pas trop de réglage.
On la démarre, à ce moment-là, elle affiche à quelle adresse on peut chopper le flux vidéo et c'est tout ça tourne.

Pas besoin de plus, c'est rapide, simple et efficace.

## La capture audio
Le loopback audio est ce qui permet d'enregistrer ce qui en théorie sort de la carte son.
Enregistrer ce qu'elle diffuse quoi.

Ça sert pour streamer le son de vos applis par exemple.


### Alsa : un échec cuisant
**Alsa** est le système audio "classique" (faussement) basique sous Linux.
Contrairement à JACK et PulseAudio, il n'a pas la réputation d'être très flexible.
Et c'est quand même à peu près vrai et surtout la doc trouvable sur le web est assez moyenne on va dire et surtout pas mal dispersée.

De base, pas besoin de configuration, Alsa est fourni avec une conf par défaut fonctionnelle.
Par contre si on souhaite diffuser le son qui en théorie sort des enceintes il faut commencer à ruser.
Il faut créer une carte son virtuelle qui recevra le flux audio de sortie dans un *capture device*.

Voilà ce que j'ai fait et abandonné au bout de quelques jours.

Première étape : compiler le module kernel qui va bien : il faut donc chopper **SND_ALOOP** (que j'ai foutu en module).
Une fois chargé, il faut configurer Alsa et là franchement c'est de la magie noire avec une syntaxe assez particulière.

Bref, je sais pas exactement comment ça marche mais ça marche.

<details><summary>/etc/asound.conf</summary>
{{< highlight "nginx" >}}
pcm.!default {
  type asym
  playback.pcm "LoopAndReal"
  #capture.pcm "looprec"
  capture.pcm "hw:0,0"
}

pcm.looprec {
    type hw
    card "Loopback"
    device 1
    subdevice 0
}


pcm.LoopAndReal {
  type plug
  slave.pcm mdev
  route_policy "duplicate"
}


pcm.mdev {
  type multi
  slaves.a.pcm pcm.MixReale
  slaves.a.channels 2
  slaves.b.pcm pcm.MixLoopback
  slaves.b.channels 2
  bindings.0.slave a
  bindings.0.channel 0
  bindings.1.slave a
  bindings.1.channel 1
  bindings.2.slave b
  bindings.2.channel 0
  bindings.3.slave b
  bindings.3.channel 1
}


pcm.MixReale {
  type dmix
  ipc_key 1024
  slave {
    pcm "hw:0,0"
    rate 48000
    #rate 44100
    periods 128
    period_time 0
    period_size 1024 # must be power of 2
    buffer_size 8192
  }
}

pcm.MixLoopback {
  type dmix
  ipc_key 1025
  slave {
    pcm "hw:Loopback,0,0"
    rate 48000
    #rate 44100
    periods 128
    period_time 0
    period_size 1024 # must be power of 2
{{< / highlight>}}
</details>

Il ne vous restera ensuite qu'à choisir la bonne entrée audio dans OBS qui se nommera *hw:Loopback,1,0* .

Voilà voilà, le château de carte est en place.

### Pulseaudio à la rescousse
Bon après plusieurs jours je me résigne à installer **PulseAudio**.
Alsa c'est cool en utilisation habituelle mais là ça se pète la gueule tout seul au reboot mais pas à chaque fois.
Il y a une part d'aléatoire et ça c'est pas acceptable.
Donc au bout de quelques jours de galères j'ai craqué pour installer une Lennarterie.

Allez, je me force pour faire l'installation de PulseAudio, suppression du module kernel **snd_aloop** parceque ça fout la grouille.
Suppression de toute la conf du asound.conf et recompilation des paquets avec <samp>USE="pulseaudio" emerge -UDnav @world</samp> .

Et là, ça passe direct.
Plus de surprise, ça marche à chaque reboot sans rien configurer de plus.
Voilà, je ne peux que m'incliner : ᵐᵉʳᶜᶦ ᴸᵉⁿⁿᵃʳᵗ

Il n'y a pas de conf à faire ni rien, tout est assez intuitif.

Voilà, mainentant dans les entrées audio il y aura le micro branché sur le jack de la carte son et aussi le *monitor* de la carte son.
Tout ce qu'il fallait.

Il suffira de choisir la bonne entrée audio en fonction de ce que vous voudrez.

## Loopback vidéo
Alors là, mon but c'est de parvenir à simuler une webcam pour y diffuser un peu tout ce que je veux.
Là c'est pas vraiment pour du stream mais lorsqu'on utilise un site de visioconférence, c'est pour manipuler ce que j'envoie.
Si vous voulez uniquement streamer vous pouvez sauter cette étape.

Pour Linux, ça veut dire faire mumuse avec le système **v4l2** (Vidéo For Linux 2).
Il faut donc installer [v4l2-loopback](https://github.com/umlaeute/v4l2loopback) qui est un module kernel.
Leur doc fonctionne très bien sur un kernel tout récent.

Il faut donc tout d'abord vous assurez que vous avez le support de **v4l2** dans votre kernel.
Pour ça un ptit <samp>grep V4L2 /usr/src/linux/.config</samp> afin de vérifier qu'il est bien à *yes* .
Si ce n'est pas le cas ajoutez-le, compilez le kernel et bootez dessus.

Une fois fait, on installe **v4l2-loopback** qui est dans les packages de quelques distros.
Si ce n'est pas le cas, un simple <samp>make</samp> dans le dossier des sources que vous avez préalablement téléchargé et hop il est compilé.
Ensuite en tant que root, un ptit <samp>make install</samp> et le tour est joué.

Une fois installé, il suffira de l'activer quand vous en avez besoin avec <samp>modprobe v4l2loopback devices=1 video_nr=5 card_label="OBS Cam" exclusive_caps=1</samp> et voilà.
Vous avez désormais une webcam virtuelle en tant que /dev/video5 que vous pourrez envoyer à n'importe quelle appli.

Mais il faudra tout de même fournir un flux à cette webcam, ça sera le boulot (entre autre) d'**obs**.

--------------

Voilà pour cette première étape, on a pas mal préparé le terrain.

