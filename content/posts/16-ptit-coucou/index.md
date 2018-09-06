+++
Author = "Lord"
Categories = ["tips","hardware"]
Tags = ["tips","hardware"]
Description = "Démerdouillage de bug audio sur laptop asus g50"
date = "2010-08-25T21:49:08+02:00"
title = "Un ptit coucou"
menu = "main"
nodate = true

+++
Non je ne suis pas mort !
Et d'ailleurs je viens de résoudre un problème que j'ai depuis toujours sur ce laptop : faire sortir du son depuis la prise jack.
En fait c'était tout con !
Il suffisait de rajouter dans le **modprobe.conf** : **<samp>options snd-hda-intel model=m51va position_fix=0</samp>**
Bon j'avoue ce message est destiné à mon moi du futur qui réinstallera surement un nunux et se fera chier avec ce bug à la con.

