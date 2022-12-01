+++
Author = "Lord"
Description = "Je ne supporte plus Kodi et je me fait mon bidouillage pour le remplacer par mpv."
Categories = ["mpv", "linux"]
menu = "main"
notoc = true
WritingDate = 2022-10-23T13:13:22+02:00
date = 2022-10-23T13:13:22+02:00
title = "Exit Kodi Enter MPV"
editor = "kakoune"
+++
Bon j'ai craqué, j'ai dégagé **Kodi**.

TL;DR
*J'ai viré Kodi de mon Odroid C2 que j'ai remplacé par un ptit pc x86 avec Alpine linux et MPV.
Je le gère via une page web et un tout ptit soft fait-maison pour lui envoyer des vidéos que ce soit via windows ou linux.*

## Je crache sur le Chromecast
J'ai un Chromecast.
Oui je sais, j'ai un appareil made in Google à la maison.

Ce ptit truc est une source de frustration complète.
Le principe est cool : un ptit appareil branché en HDMI et alimenté par l'USB de la téloche qui peut lire des vidéos.

Sauf que c'est noyauté à la merde par Google.
Il faut des applis ayant signé un contrat avec le diable pour accepter de fonctionner avec cet appareil.

Le truc est super tatillon sur les formats de vidéo qu'il prend en charge.
Un fichier MKV ? Nope, faut du MP4.

Un sous-titre ? Houlla ça va dépendre de plein de trucs comme l'encodage, le codec de sub, est-ce que c'est intégré à la vidéo ?
Que des conneries du genre.

Bref, sortie de l'utilisation pensée par Google (c'est-à-dire avec leurs applications à eux dans leur écosystème) point de salut.

De la merde.

## Je crache sur Kodi
Du coup en plus du Chromecast j'ai investi il y a fort longtemps dans une ptite **Odroid C2** avec **LibreElec**.

J'ai jamais vraiment compris l'engouement pour Kodi.
Ce logiciel a des bons côtés, mais il a une expérience utilisateur diamétralemment opposée à ce que je cherche.

Kodi a l'avantage d'avoir une interface commandable avec la télécommande de la téloche (via le protocole HDMI CEC) et ça c'est un avantage énorme.
Il a un gros écosystème d'extensions toussa.

Mais tout ça est contrebalancé par un système de bibliothèque qui me gonfle.
Déjà, tout ce qui est utilisation un peu avancé c'est compliqué.
Pour ajouter une appli, il faut ajouter un zip, qui va ajouter un dépot et ensuite on va pouvoir ajouter des applis depuis le dépot.
Hein quoi ?
Oui oui, faut ajouter un zip pour ajouter un dépot.
Et puis, ajouter des sources vidéos c'est bien plus chiant qu'il n'y parait.

Et le pire c'est que même pour l'utilisation plus basique du quotidien ça vient toujours m'emmerder.
Je me bats contre le logiciel !

J'ai déjà rangé mes fichiers comme il faut, avec un nom qui va bien et tout.
J'ai pas envie que le truc scan pour ajouter des infos dont j'ai rien à péter.
J'ai pas envie qu'il aille chercher une affiche qui correspond pas au bon film.
J'ai pas envie que le truc m'affiche des popups pendant que je mate une vidéo.
Changer de piste de sous-titre en cours de lecture demande cinq/six manipulations !

J'ai l'application **Kore** sur le téléphone pour pouvoir contrôler le bousin et en plus pouvoir lui envoyer des flux.
J'arrive à lui faire lire une vidéo en provenance de Youtube (enfin NewPipe) mais pas une vidéo sur le web.
Une simple vidéo en provenance d'une page web, ça ne passe pas.

Ha et en plus **LibreElec** a décidé de ne plus supporter ma ptite <abbr title="Single Board Computer - Une sorte de raspberry bi">SBC</abbr> du coup je suis coincé sur une vieille version de kodi.
Pas bien grave à la base mais du coup tout un tas d'extension ne peuvent plus être installées.
C'est la goutte.

Allez hop !
Ça dégage !
J'en ai plein le cul de ce soft.

## J'encense MPV
Bon, c'est le lecteur vidéo le mieux foutu à mon goût.
Il n'a quasiment pas d'interface graphique, il s'appuie sur **ffmpeg** et sait donc à peu près tout faire.

Il se marie très bien avec **Yt-Dlp** ce qui permet de lui faire lire des vidéos en provenance de tout un tas de sources sur le web.
Que ce soit le classique Youtube, le franco FranceTV, l'intello Arte ou le streamo Twitch, il sait se démerder de tout.

En plus il peut être complémenté par des scripts en Lua qui lui apporte des fonctions plus ou moins dispensables.
Dans ces scripts Lua il y a **SponsorBlock** et on est plus trop emmerdé par les pubs.

Là on obtient un player vidéo proche de la perfection.

## Cahier des charges

  1. Pouvoir lire des vidéos (mpv)
  2. Pouvoir lires des flux réseaux (yt-dlp + sponsorblock)
  3. Pouvoir être commandé (simple-mpv-webui + totv)
  4. Être 0 maintenance (openrc)

## Réalisation

### 1 Lire des vidéos
J'ai depuis quelque temps un ptit ordi acheté d'occase sur ebay qui est un ordi d'entreprise tout petit (presque un NUC) qui a une sortie HDMI.
J'y ai foutu **Alpine Linux** (bien entendu) et ma supervision à base d'Influx et compagnie comme je vous en ai déjà parlé.
Mais faut avouer que la bête se tourne un peu les pouces, du coup je stoppe la C2 et je remplace par cette machine et j'y connecte le câble HDMI de la téloche.

Bon du coup j'installe **alsa-lib**, **intel-media-driver**, **libva-intel-driver**, **lua5.2-socket**, **mpv**, **yt-dlp**.

Ensuite je lance **mpv** et je vois (enfin j'entends) qu'il n'y a pas de son.
Je tente un ptit coup de <kbd>alsamixer</kbd> qui ne fait que sortir un message d'erreur incompréhensible.

Après quelques recherches je me jette sur <kbd>aplay -l</kbd> qui me liste mes cartes sons dont :
<pre><samp>
**** List of PLAYBACK Hardware Devices ****
card 0: PCH [HDA Intel PCH], device 0: ALC3234 Analog [ALC3234 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: PCH [HDA Intel PCH], device 3: HDMI 0 [SAMSUNG]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
…
</samp></pre>

Bon, donc on va avoir des options à donner à **mpv**.

<details><summary>~/.config/mpv/config</summary>

```
# Pouvoir monter le son bien plus haut
volume-max=300

# Avoir du son qui sort sur le HDMI
audio-device=alsa/hdmi:CARD=PCH,DEV=0

# Faire en sorte d'avoir un son pas trop trop dégueu quand on lit des sources autres que stéréo
audio-channels=stereo
af=drc

# Faire en sorte d'ouvrir MPV même quand on a pas de vidéo à lui faire lire
idle=yes
keep-open=no
keep-open-pause=no
force-window

# Limiter yt-dlp au 1080p max
ytdl-format=bestvideo[height<=1080]+bestaudio/best

# socket pour les commandes externes
input-ipc-server=/tmp/mpvsocket 
```

</details>

Ce que j'aime bien c'est que même si je n'ai ni wayland ni X11, mpv parvient parfaitement à tourner en plein écran sans faire chier.
Ça limite grandement le nombre de trucs à installer.

### 2 Support des flux et blocage des pubs
Bon bha pour **yt-dlp** rien de plus à faire que de l'installer comme vu à l'étape 1.

Pour **SponsorBlock** il faut simplement télécharger [sponsorblock_minimal.lua](https://codeberg.org/jouni/mpv_sponsorblock_minimal) et le coller dans *~/.config/mpv/scripts/* et c'est tout ça fonctionne.

### 3 Pouvoir être commandé
Bon j'ai un peu regardé du côté de CEC mais … bha j'ai pas trop vu si c'était possible.
Du coup j'ai vite capitulé et je me suis tourné vers deux solutions : pouvoir contrôler mpv via une page web qui serait donc disponible sur le téléphone + un ptit script pour envoyer des URL à ouvrir.

### 3.1 simple-mpv-webui
**mpv** a une option pour écouter des commandes sur un socket.
C'est pile poil ce qu'il me faut !

Bon j'ai commencé à faire mumuse avec, c'est chouette comme tout.
Le premier souci c'est ça n'écoute que sur un socket unix, pas un vrai port TCP en écoute.
Donc si je m'oriente vers ça il va faloir faire une ptite passerelle (à base de netcat ça se fait sans trop de souci).
Le second souci qui m'a fait reconsiderer le truc c'est que … bha … va faloir coder une interface web et faire en sorte de pouvoir recevoir et émettre des commandes avec ça.

Hmm c'est clairement faisable mais … pas trop envie de me faire trop chier non plus.
Ça reste une option envisageable plus tard.

J'ai un peu fouillé et je suis tombé sur un script lua qui semble faire ce que je veux : [Simple mpv Webui](https://github.com/open-dynaMIX/simple-mpv-webui).
C'est pas très joli mais c'est vraiment pensé pour être utilisé au téléphone avec des gros boutons.
Le seul reproche c'est que … bha il n'y a rien pour entrer un flux réseau à lui faire lire.
C'est juste pour controler une vidéo qui tourne déjà.

Bon je m'en contenterai pour le moment.
Pour l'installer il suffit de télécharger la release et de la coller dans *~/.config/mpv/scripts/* .
Une fois mpv démarrer, on peut se rendre sur http://adresse_ip:8080 et pouf.
Pas mal du tout.

### 3.2 totv
Bon j'ai maintenant un moyen d'envoyer des vidéos au bousin.
**Simple-mpv-webui** a sa propre petite api pour envoyer des commandes à mpv.
L'avantage c'est que du coup lui écoute déjà sur le réseau, donc plus besoin de passerelle pour accéder au socket.
Et d'ailleurs son api est au final un décalque de celle de mpv.

Je fais déjà des tests avec **curl** et ça tourne bien, mais il me faut un truc utilisable sur windows sans avoir à me faire chier avec des dépendances, des mises à jour, des trucs à installer.
Du coup, j'opte pour un ptit soft en golang qui soit capable d'envoyer de simples requêtes à la curl.

Bon j'ai pondu un truc minuscule et super mal foutu mais fonctionnel.
Je verai à l'usage s'il faut polir ou pas.

<details><summary>totv.go</summary>
{{< highlight "golang">}}

package main

import "os"
import "net/http"
import "net/url"

func main() {
	url := "http://adresse_ip:8080/api/loadfile/" + url.QueryEscape(os.Args[1])
	resp, err := http.Post(url, "", nil)
	if err != nil {
		panic(err)
	}
	defer resp.Body.Close()
}

{{< /highlight >}} 
</details>

Et c'est là qu'intervient la magie de Go.
Pour compiler il suffit d'un ptit <kbd>go build totv.go</kbd> qui me sort un ptit binaire que je vais coller dans */usr/local/bin* .
Maintenant il me faut faire une version pour windows avec <kbd>GOOS=windows GOARCH=amd64 go build totv.go</kbd> et pouf j'ai un exe \o/

La cross compile est un plaisir avec Go.
Yapuka coller l'exe dans le PATH sur windows.

### 4. Être 0 maintenance
Bon c'est très vague ça mais en gros je veux que le truc démarre seul au boot.
J'aimerais aussi qu'en cas d'emmerde il se relance tout seul.

Bon bha tout ça c'est le boulot de l'init.
Et comme je suis sous **Alpine**, c'est le boulot d'**OpenRC**.

Allez je m'attèle à la création d'un fichier init pour **mpv**.
N'ayez crainte c'est pas dur.

<details><summary>/etc/init.d/mpv</summary>
{{< highlight "shell" >}}
#!/sbin/openrc-run

supervisor="supervise-daemon"
command="/usr/bin/mpv"
command_background=yes
command_user=lord
{{< /highlight >}}
</details>

La ptite subtilité est le *supervisor* qui permet de vérifier que **mpv** ne quitte pas et de relancer si jamais.

On ajoute le service au boot avec <kbd>rc-update add mpv</kbd> et c'est torché.

## Enjoy
Et hop, j'ai donc **mpv*** qui se lance au boot et qui tourne continuellement.

J'ai une ptite interface web pour le manipuler et j'ai un ptit programme nommé **totv** qui permet de lancer des vidéos.

Ma femme avait déjà l'habitude de lancer des vidéos dans mpv depuis son windows, maintenant elle commence à prendre le réflexe de faire pareil mais à remplacer **mpv** par **totv** pour que ça soit lancé sur la téloche.

## Futur ?
Mon bricolage est mignonnet mais il est loin d'être parfait.
Il y a quelques pistes qui mériteraient d'être explorées.

### CEC
Ça permettrait par exemple de démarrer la téloche quand une vidéo est lancée.
Ça serait également chouette de pouvoir faire pause et compagnie avec la télécommande de la téloche comme avec Kodi.

Je n'ai malheureusement aucune idée de comment faire cela.

### Appli Android
J'aimerai beaucoup une ptite appli (même sans interface) qui permettrait depuis le menu "partage" de balancer une url à mon système.
Un appui long sur un lien dans le navigateur, partager, totv.
Et pouf.

Ça serait sacrément chouette.

### Support de Netflix
Bon je rêve mais quand même des fois, le Chromecast me sert encore un peu pour regarder du contenu issu de Netflix.
C'est anecdotique mais bon je vais garder le bestiau pour les deux fois par an où on se sert de Netflix…
