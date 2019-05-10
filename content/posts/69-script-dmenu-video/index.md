+++
Author = "Lord"
Description = "Mon ptit script qui permet de lancer des vidéos rapidement depuis i3. C'est basé sur dmenu, mpv et un peu de shell"
Categories = ["shell", "script","ux","dmenu"]
menu = "main"
notoc = true
PublishDate = 2018-01-27T12:57:33+01:00
date = 2018-01-27T12:57:33+01:00
title = "Filmmenu, un ptit script pour lancer un film"
jdh = "https://www.journalduhacker.net/s/fjailj/filmmenu_un_ptit_script_pour_lancer_un"
+++
Un ptit article rapide aujourd'hui pour vous présenter **filmmenu**. J'ai un NAS à la maison avec pas mal de disques durs et du coup pas mal de partitions. J'ai pas fait de RAID dessus (pas besoin) ce qui fait que mes données sont éparpillées entre les différentes partitions.

Toutes les données sont bien rangées dans un disque différent sauf les films qui sont répartis sur plusieurs partitions. Du coup quand je cherche un fichier particulier je sais jamais trop où le chercher. Je me suis donc fait un ptit script.

{{< highlight "bash" >}}
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
{{< / highlight >}}

Je lance ce script avec un ptit <samp>**Alt-è**</samp> dans i3. Voilà ce qu'il fait :

*Mountpoint* vérifie tout d'abord que le NAS est bien mount au bon endroit. Si c'est pas le cas il pond un *i3-nagbar* qui est un programme lié à i3 qui met une barre en haut de l'écran contenant le message qu'on lui donne.

Ensuite on teste l'existence du fichier contenant la liste des films. S'il existe on teste voir s'il a été mis à jour il y a plus de 45 jours.

En fonction de ça on créer le fichier ou bien on le met à jour en lançant un simple *find* qu'on balance dans un fichier texte sinon, on le donne à manger à *dmenu* qui créer une barre permettant de sélectionner le film à lire. Et enfin *mpv* récupère lit le fichier voulu.

Rapide & Simple
