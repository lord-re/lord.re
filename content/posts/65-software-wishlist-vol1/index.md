+++
Author = "Lord"
Description = "Une petite liste de logiciels qui me font défaut et qui me plairait."
Categories = ["software", "cli"]
Tags = ["software", "cli"]
menu = "main"
notoc = true
PublishDate = "2017-11-22T15:08:53+01:00"
date = 2017-11-22T15:08:53+01:00
title = "Ma Wishlist logicielle : Vol1"
jdh = "https://www.journalduhacker.net/s/j5kurd/ma_wishlist_logicielle_vol1"
TopWords = [  "btrfs", "devices", "monter", "ssh"]
+++

Ma liste au père nowel 2017 niveau logiciel. Je sens que ça va pas être exaucé mais qui ne tente rien…
<!--more-->

## ||| : Le magic pipe
Il y a un truc qui me gonfle. Et ça me gonfle sévère : constamment, j'ouvre pleins de terminaux. Et souvent ça se fini en ssh à droite à gauche. Avec parfois des rebonds. Parfois sur des machines qui n'ont même pas accès au net (des vm toussa toussa). 

Bref. Et là vous devez transferer un fichier entre deux terminaux… c'est espacé de juste quelques pixels et pourtant c'est injoignable ! 

*FRUSTRATION*

*On ferme les yeux.*

*On inspire.*

*On retient ses larmes.*

*On lance une session tmux.*

*On se maudit.*

*On se reconnecte aux différentes machines.*

*On en chie pour enregistrer le scrollback buffer en priant que tout rentre dedans.*

Vous voyez le topo. Donc en gros le fonctionnement : **cat mon fichier |||** et dans une autre console ailleurs **||| > mon fichier** . Ça parait super irréaliste. Mais franchement ce serait pas la joie ? Ça pourrait être geré au niveau de **tmux** par exemple ou encore un poil en dessous au niveau du terminal (s'il a un fonctionnement avec un daemon).

Ce serait tellement pratique de pouvoir faire ça.


## Escape Sequence OpenSSH avec transfert de fichiers
Il m'arrive régulièrement de me connecter à une machine via SSH et là paf faut que je lui transfère un fichier. Je trouve ça dommage de devoir ouvrir un nouveau term, une nouvelle connexion pour le SCP. 

Ma solution serait d'utiliser les *fameuses* séquences d'échappements d'OpenSSH (mais si vous savez ! Par exemple **~.** pour déconnecter. Allez voir le man.). Actuellement on peut modifier les tunnels existants sur la connexion mais guère plus intéressant. 

L'ajout de la possibilité d'engager un transfert de fichier dans la connexion existante (c'est permis par le protocole en lui même) serait vraiment classe. Genre **~u** qui vous permet d'uploader un fichier vers le serveur SSH et **~d** pour downloader un fichier. J'en demande pas plus ;-)

## Apprendre au kernel linux à scanner les devices via BTRFS
Désormais heureux propriétaire d'un Raid6 BTRFS (ouai j'aime vivre dangeureusement), j'ai malheureusement dû me faire un initramfs pour pouvoir monter la partition racine. Tout ça parcequ'il faut que BTRFS scanne tous les *devices* avant de pouvoir monter le raid. Bon j'en ai profité pour ajouter quelques fonctionnalités supplémentaires mais bon ça fera un prochain article.

Bref si le kernel pouvait effectuer un scan de tous les devices avant de monter une partoche, ça serait parfait.
