+++
Author = "Lord"
Description = "Here is my little script to quickly launch videos from i3. It uses dmenu, mpv and a bit of shell"
Categories = ["shell", "script","ux"]
Tags = ["shell", "script","ux"]
menu = "main"
notoc = true
PublishDate = 2018-01-27T12:57:33+01:00
date = 2018-01-27T12:57:33+01:00
title = "Filmmenu, a little script to launch movies"
+++
Here is a quick blogpost to show you **filmmenu**. I use a NAS at home with many hard drives and many partitions. I don't have a RAID (no need) so my files are scattered in all partitions.

All my datas are well sorted except for movies which are in multiple partitions. So when I'm looking for a specific movie, I never know where to look at. So I wrote this think :

	#! /bin/sh
	DB="/var/db/filmmenu"
	if [ $(mountpoint -q /mnt/bender) ]
	then
	        timeout 3 i3-nagbar -m "/mnt/bender n'est pas mount ! Un ptit coup de sshfs au préalable"
	        exit
	fi
	if [ -r $DB ]
	then
	        if [  $(date -r "$DB" +%s) -lt $(date +%s --date '45 days ago') ]
	        then
	                timeout 4 i3-nagbar -t warning -m "DB de plus de 45 jours, update !"
	        fi
	                exec mpv "$(cat "$DB" | dmenu -i -l 10 -lh 40 -fn 'Droid Sans Mono-15')"
	  exit
	else
	        printf "Création de la DB\n"
	        timeout 3 i3-nagbar -t warning -m "Création de $DB, on vous prévient quand c'est fini"
	        find /mnt/bender/stockage/*/films/ > "$DB"
	        timeout 3 i3-nagbar -t warning -m "$DB créé, c'est tout bon. Vous pouvez relancer la commande"
	fi

I launch it with ***Alt è*** in i3. Here what it does :

*Mountpoint* checks that the NAS is mounted on the right place. If it's not it spits an *i3-nagbar* which is a small utility from i3 displaying a bar with a configured message.

Then we test if the database exists and if it's not older than 45 days. If it's not we create the file with a basic *find* redirected to a file (the database).

We then give the file to *dmenu* which prompts the user to select which movie to watch. Then *mpv* gets the movie path and plays it.

Quick & Easy
