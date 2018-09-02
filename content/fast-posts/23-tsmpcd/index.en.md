+++
Author = "Lord"
Description = "TSMPCD is my tiny bash script to have an infinite playlist in MPD and some notifications."
Categories = ["software", "script"]
menu = "main"
notoc = true
PublishDate = 2018-08-27T17:16:54+02:00
date = 2018-08-28T17:19:54+02:00
title = "Client MPD : TSMPCD"
editor = "kakoune"
+++
Three months ago i talked about my move from Groovebasin to MPD in [this article (fr)]({{< ref path="/posts/103-remplacer-groovebasin" lang="fr" >}}).
I already talked about my Frankenscript i used as an *mpd client*.
Since last time, its name changed to **TSMPCD** which stands for *Tiny Shell Music Player Client Daemon*.

So it's a bash script (not pure posix sh).
It's basic but has three objectives :

  1. It's in charge to *have an infinite playlist which never runs out* by adding random songs to the end.
	2. *Send notifications* with the title of the starting song.
	3. *To control MPD with shortcuts*.

Everything stands on **mpc** which is the basic cli mpd client.
For notifications it's **dmenu** with a [tiny self-made patch](../../posts/103-remplacer-groovebasin/103-dmenu-4.8-nograb.patch) not to take focus when starting.
The rest is *classic shell* (except the read which is not posix).

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

And voilà.
I don't think it will be interesting for others but at least it's published now.
It uses a terminal just for this.

{{< img src="capture.png" alt="screenshot of the script" title="Not the prettiest script for sure." >}}
