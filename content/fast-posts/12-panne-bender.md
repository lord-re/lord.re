+++
Author = "Lord"
Description = "Mon pauvre petit serveur/nas est HS."
Categories = ["actu", "meta"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-03-24T21:09:30+01:00
date = 2018-03-24T21:09:30+01:00
title = "Panne de ce bon vieux Bender"
editor = "kakoune"
+++
Vous l'avez peut-être remarqué mais le site a eu des ptits soucis : certaines pages étaient inaccessibles.

*Mon pauvre [Bender]({{< ref "posts/15-migration" >}}) (mon serveur/nas) était HS vendredi en rentrant du boulot.*

L'onduleur couinait du fond du placard.
Étrangement je vais voir le disjoncteur qui effectivement a fait son boulot.

Bon dans le doute je remonte le disjoncteur. Je rebranche le serveur à l'onduleur et pouf pareil…

Well well well. Je le branche en direct sans passer par l'onduleur et relève le disjoncteur.

Ça tient mais pas pour autant que ça démarre.
Bon bha la machine est HS.

J'imagine que l'alim est en cause et que le reste de la machine va bien ou alors c'est de la faute de Systemd ? (c'était le seul systemd de la maison)
Le soucis c'est que c'est une alim à la con au [format SFX](https://en.wikipedia.org/wiki/Atx#SFX).

Bref après environ 7 ans et demi de fonctionnement l'alim flanche.

Du coup j'ai remonté le bastringue sur un ptit odroid c2 moins énergivore et bien plus petit.
Mais par contre j'ai pu y foutre que le skeudur de backup en usb dessus…

J'espère que les autres disques durs sont intacts.
D'ailleurs j'hésite à chopper une nouvelle alim pour refaire fonctionner Bender ou bien trouver un moyen de foutre les skeudurs sur le ptit odroid qui est largement suffisant niveau perfs…
Je trouve pas grand chose pour branche 5 skeudurs (voir 6) sur un seul USB et qui ne fasse pas de trucs chelou genre du RAID et autre.

Bref j'y pense et je vous tiens au courant.:w


