+++
Author = "Lord"
Description = "TSMPCD est un ptit script bash fait maison pour avoir une playlist infinie sur MPD et des notifs"
Categories = ["software", "script"]
menu = "main"
notoc = true
PublishDate = 2018-08-27T17:16:54+02:00
date = 2018-08-28T17:19:54+02:00
title = "Client MPD : TSMPCD"
editor = "kakoune"
+++
Il y a trois mois je vous parlait de ma migration de Groovebasin vers MPD dans [cet article]({{< ref "/posts/103-remplacer-groovebasin"  >}}).
Et je vous avait parlé de mon Frankenscript qui me sert de *client MPD*.
Entre temps il a changé de nom, maintenant c'est **TSMPCD** pour *Tiny Shell Music Player Client Daemon*.

C'est donc un script bash (pas pur sh)
Il est basique mais avec trois objectifs.

  1. Son job est donc de *faire en sorte que la playlist ne s'assèche jamais* en rajoutant des morceaux aléatoires à la suite.
  2. *Faire des notifs* avec le titre du morceau qui démarre.
  3. *Permettre de contrôler MPD avec des raccourcis* basiques.

Tout repose sur **mpc** qui est le client mpd basique en ligne de commande.
Pour les notifs c'est du **dmenu** avec un [ptit patch](../../posts/103-remplacer-groovebasin/103-dmenu-4.8-nograb.patch) pour pas qu'il prenne le focus.
Le reste c'est du *shell classique* (en dehors du read qui n'est pas posix).

{{< highlight bash "linenos=table">}}
#! /bin/bash
#Tiny Shell Music Player Client Daemon

CheckMPD(){
  if [ ! "$(pgrep -x mpd)" ]; then
    timeout 3 i3-nagbar -m "MPD n'est pas lancé"
    exit 1
  fi
}

Loop(){
  while true
  do
    CheckMPD
    if [ "$(mpc playlist | wc -l)" -lt 30 ]; then
      mpc findadd Title "$(mpc list Title | shuf -n 1)"
    fi
    if [ "$(mpc current -f %position%)" -gt 15 ]; then
      mpc del 1
    fi
    printf "\033[0;32m%s\033[0m\n" "$(mpc -w -f "[%title%] [by %artist%]  [from %album%] [ :  %time%]" current)"
    flock -F /tmp/mpdnotif.lock -c 'mpc current -f "%title% - %artist% [%track%] %album% - %date% | %time% |" | timeout 6 dmenu -g -b' &
  done
}

Input(){
  while true
	do
    read -s -n 1 input
    if [ "$input" = "n" ]; then
			mpc -q next
		elif [ "$input" = "p" ]; then
			mpc -q prev
		elif [ "$input" = "" ]; then
			mpc -q toggle
		elif [ "$input" = "h" ]; then
			Intro
		fi
	done
}

Intro(){
  printf "TSMPCD !\n-------\nSPC : play/pause\tN : next\tP : previous\tH : help\n"
}
Intro
Loop&
Input
{{< / highlight >}}

Bon bha maintenant j'ai tenu ma promesse de le publier.
Je doute qu'il intéresse grand monde cela dit.
Ça monopolise un terminal rien que pour ça.

{{< img src="capture.png" alt="capture d'écran du script" title="Il gagnera pas un concours de beauté ce script" >}}
