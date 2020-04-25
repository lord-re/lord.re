+++
Author = "Lord"
Description = "Troisième et dernier article pour streamer du contenu vidéo live avec du logiciel libre. Ce coup-ci on s'attarde à configurer Nginx comme il faut pour bosser avec OBS. Et création d'une ptite page pour diffuser la vidéo."
Categories = ["", ""]
menu = "main"
notoc = true
WritingDate = 2020-04-02T23:13:18+02:00
date = 2020-04-24T08:13:18+02:00
title = "Setup pour streamer vol.3 : Diffuser"
editor = "kakoune"
TopWords = [  "latence","x264", "webcam", "obs", "lecteur", "hls", "rtmp", "flux", "live", "nginx","v4l2sink","stream","remote","pulseaudio","v4l2","droidcam"]

+++
Précédemment :

  - [Comment enregistrer l'audio de l'ordi, transformer des android en webcam et balancer le flux vidéo dans une webcam virtuelle]({{< ref "posts/198-mon-setup-pour-streamer-vol1" >}}).
  - [Comment mixer, touiller, filtrer, retoucher tout ça avec OBS]({{< ref "posts/199-mon-setup-pour-streamer-vol2" >}})

Maintenant on va s'atteler à pousser ce contenu à vos spectateurs.

--------------


Pour la sortie j'en ai au final deux.
La première c'est le plugin v4l2loopback qui émule une webcam, mais j'en ai aussi profité pour créer un flux rtmp que je donne à **nginx**.

Comme ça *je peux à la fois avoir ma fausse webcam, mais je peux également streamer plus classiquement si l'envie m'en prend comme vers Twitch ou Youtube mais auto-hébergé*.

## Nginx
Nginx c'est un super serveur web qui possède pas mal de modules dont un spécialement adapté au stream de vidéo portant le doux nom de **rtmp**.
Il peut également faire du *hls* pour rendre ça plus accessible.

Donc **OBS** va produire un flux vidéo qu'il va envoyer à l'adresse que vous voulez.
**Nginx** récupère ce flux et le redistribuera, mais également le transformera en hls.

### RTMP
Bon à la base c'est un protocole fait par les vilains d'**Adobe** pour leur lecteur **Flash** à l'époque.
Bon ça fait plus de dix ans que les specs sont désormais ouvertes et du coup quelques implémentations de droite et de gauche sont apparues dont ce module pour nginx.

Selon votre distribution linux, soit vous allez pouvoir installer le module rtmp de nginx comme un paquet classique, soit vous allez devoir vous taper la compilation à la main.
Une fois fait il s'agira uniquement de configuration à faire.
Bon du coup je vous laisse l'installer par vous-même, passons à la configuration.

Donc première chose à faire, créer un dossier temporaire qui va contenir les fragments de vidéos.
Perso j'ai pas envie d'utiliser du disque pour ça et étant donné que ça sera pas bien gros (une dizaine de Mo au plus), je fais ça direct en ram.
Le dossier /tmp étant un montage de type tmpfs ça n'écrira rien sur le disque, par contre ça sera purgé à chaque reboot.

Donc <samp>mkdir -p /tmp/hls/live</samp> et maintenant on édite la conf nginx.

<details open><summary>/etc/nginx/nginx.conf</summary>
{{< highlight "nginx" >}}
rtmp {
        server {
                listen 1935;
                chunk_size 4096;

                application live {
                        live on;
                        record off;
                        meta copy;

                        allow publish votre.ip.a.vous;
                        deny publish all;

                        hls on;
                        hls_path /tmp/hls/live;
                        hls_fragment 2s;
                        hls_playlist_length 4s;
                }
        }
}
{{< / highlight >}}
</details>

Bon ça, ça vous permet juste de recevoir le flux en provenance d'OBS, que personne d'autre n'envoie de vidéo mais aussi de créer du *hls*.

Avec ça en place, vous pouvez déjà pointer votre lecteur vidéo favori (ça veut dire **mpv**) vers le flux avec <samp>mpv rtmp://l.ip.du.nginx/live/$stream_key_dans_obs</samp> .
Si tout se passe bien ça devrait s'afficher et voilà.

Voilà ?!
NON !

### HLS
Je veux streamer à des gens qui n'ont pas forcément de lecteur vidéo ou qui ne savent pas forcément le trifouiller comme ça.
Du coup, il me faut créer une mini page web avec un lecteur vidéo.

Déjà pourquoi le HLS ?
Hé bien, parceque le rtmp c'est cool mais ça utilise un port exotique (en 2020 exotique ça veut simplement dire que c'est pas du web) du coup c'est bloqué assez régulièrement.
*Si on veut que ça passe-partout (huhu), il faut que ça soit du web et c'est ce que fait hls*.
C'est un protocole fait par **Apple** (ouai un autre gros vilain proprio) qui consiste à découper le flux vidéo en tout petits morceaux et de créer une playlist qui indique quels sont les morceaux suivants.

On va commencer par créer un vhost http pour accueillir notre lecteur vidéo et tout.
Je m'empresse de me créer une entrée *live.lord.re* au niveau de ma zone DNS.
Ensuite je me crée le fichier de conf nginx qui va bien.

<details open><summary>/etc/nginx/conf.d/live.lord.re.conf</summary>
{{< highlight "nginx" >}}
server {
  listen 80;
  listen [::]:80;
  #listen 443;
  #listen [::]:443 http2 ssl;

  server_name live.lord.re;
  #include ssl.conf;
  #ssl_certificate …;
  #ssl_certificate_key …;

  add_header 'Access-Control-Allow-Origin' '*' always;
  add_header 'Access-Control-Expose-Headers' 'Content-Length';

  location /.well-known/acme-challenge {
    alias /var/www/acme;
  }

  root /tmp/hls;
  location /live {
    add_header Cache-Control no-cache;
  }
}
{{< / highlight >}}
</details>

Une fois fait on <samp>/etc/init.d/nginx reload</samp> ensuite on génère les certificats avec <samp>acme.sh --issue -d live.lord.re --ecc --nginx</samp> et une fois fait on décommente les quelques lignes qui le sont dans le fichier de conf que l'on vient de créer et on reload encore nginx.

Voilà, notre vhost est tout prêt.

### Ptite page web
Bon maintenant, la dernière pièce de ce puzzle c'est la création d'une simple page web avec un lecteur vidéo.
Bon je sais pas vous, mais moi, vu l'heure, j'ai pas trop envie de me faire chier.
Donc je récupère un player vidéo et son ptit css et je crée une page web le plus basique possible, c'est moche mais fonctionnel.

<samp>wget vjs.zencdn.net/7.3.0/video-js.min.css</samp> et <samp>wget vjs.zencdn.net/7.3.0/video.min.js</samp> voilà ça, ça devrait aller.
Et maintenant on place ça dans une page des plus basiques.

<details open><summary>/tmp/hls/index.html</summary>
{{< highlight "html">}}
<html>
  <head>
    <title>Le ptit stream</title>
    <link href="video-js.min.css" rel="stylesheet">
    <script src="video.min.js"></script>
  </head>

  <body style="background-color:#222;color:white;">

    <video controls data-setup='{}'>
      <source src="//live.lord.re/live/ssh.m3u8" type="application/x-mpegURL" >
    </video>
  </body>
</html>
{{< / highlight>}}
</details>

Voilà, maintenant on peut ouvrir https://live.lord.re et ça fonctionne \o/

## Configuration d'OBS

### Envoi du flux vers la webcam
Donc pour que le flux d'OBS soit envoyé dans un flux de webcam, il faut se rendre dans *Tools/V4l2sink* ce qui vous ouvrira une petite fenêtre où il vous faudra sélectionner dans quel device vidéo envoyer le flux.

Si vous avez bien suivi les épisodes précédents, j'ai utilisé le <samp>/dev/video5</samp> et concernant le format vidéo, je me suis contenté du <samp>YUV420</samp> par défaut.
Si ça se trouve les autres formats sont meilleurs, mais je ne me suis pas attardé.

Si vous cochez l'*Autostart* vous n'aurez plus besoin de vous préocupper de cela.

### Envoi du flux vers Nginx
Là on va trifouiller les *Settings* d'**OBS**.
Dans l'onglet *Stream* vous allez choisir le service *Custom* et dans l'adresse du serveur, il faudra donner l'adresse du serveur rtmp de nginx précédemment créé.
Dans mon cas c'est <samp>rtmp://ip.de.mon.nginx/live</samp> .
Pas besoin de spécifier le port 1935 car … c'est le port par défaut de rtmp.

En dessous, on vous demande la *Stream Key* qui n'est en fait que le nom du flux vidéo.
À vous de définir ce que vous voulez, j'ai choisi *ssh* et c'est ce que j'ai mis dans l'url source du lecteur vidéo de la ptite page web.
Vous pouvez mettre ce que vous voulez du moment que c'est en cohérence.

Ensuite dans *Output/Streaming* c'est là où vous allez avoir tous les réglages concernant la qualité vidéo.
Ça va dépendre de votre connexion et aussi de la puissance de votre processeur.
La qualité obtenue dépendra également du contenu que vous allez diffuser : s'il s'agit d'image globalement fixe et calmes un plus faible Bitrate n'impactera pas trop la qualité.
À l'inverse si vous diffusez du jeu vidéo assez réactif où ça bouge pas mal la qualité va en souffrir et il vous faudra augmenter le bitrate.

Pareil, ça va également dépendre de la taille de l'image de sortie.
Un flux 1080p assez réactif, il faudra taper au minimum dans le 5Mbps pour avoir un truc pas trop baveu.

En sachant que dans la configuration actuelle de nginx (mais c'est possible), il n'y a pas de recompression ni rien, donc le flux sera dupliqué autant de fois que vous aurez de spectateur.
Donc si vous visez les 20 spectateurs, votre flux de 5Mbps se transformera en 100Mbps sortant.

Ça chiffre vite.

Si vous souhaitez réduire autant que possible la latence, il faut veiller à mettre les *Keyframe* à <samp>1/s</samp> et penser à mettre le *Tune* sur <samp>zerolatency</samp> ce qui permettra de grapiller quelques secondes.
On reste cela dit sur une latence minimale de 7 secondes dans mes tests (même en local).
Les lecteurs vidéos ayant une tendance à toujours avoir des buffers de marge.
Et surtout ça pourra facilement monter dans les 30 secondes.

Bref, c'est pas fait pour du live le protocole rtmp à très faible latence mais pour la majorité des cas, ça fait le café.

## Tout roule
*Ça a été un sacré voyage*.
J'y ai passé quelques aprems afin de démêler tout ça.
Et à ça on rajoute quatre jours d'emmerdes avec Alsa et PulseAudio.

C'est un mix de quelques tutos, de docs de-ci de-là, d'essais et compagnie.

Le placement du smartphone m'a pas mal occupé aussi.
J'ai fini par coller avec de la loctite des ptites baguettes de bois sur l'écran pour faire un mini-support pour le smartphone.

J'en ai pas parlé ici, mais j'ai également fait un ptit script shell qui lance un tmux avec deux trois shells prêt à être streamer.
Le but étant de donner des noms spécifiques aux fenêtres histoire qu'OBS les retrouve facilement pour les capturer.
