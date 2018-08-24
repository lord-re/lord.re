+++
Author = "Lord"
title = "Contrôler son écran via l'ordi"
Categories = ["hardware","software","linux","tips","cli"]
Description = "Il est possible de commander son écran via l'ordi. C'est super pratique si vous êtes flemmard ou si vous voulez scripter."
menu = "main"
date = "2017-08-04T15:42:01+02:00"
jdh = "https://www.journalduhacker.net/s/ugvwin/controller_son_cran_depuis_lordi"

+++

Rhaaa ce que c'est chiant de devoir tripoter les boutons de son écran pour y modifier les règlages. Vous voulez voir ce qu'il se passe sur une autre entrée vidéo sans pour autant décoller votre dos de votre cher siège ? Et bha en fait c'est pas si compliqué. Toutes les sorties vidéos depuis le VGA dispose de plusieures broches dont cernaines servent non pas à envoyer le signal vidéo mais plutôt des données. On va utiliser ça. C'est facile et rapide.

## I2c et DDC
En gros i2c est un bus de données à faible vitesse (enfin pas tant que ça) assez répandu. Il a été utilisé pour créer le DDC par VESA pour transferer de l'EDID via VGA, HDMI, DVI ou (e)DP bref le paradis de l'alphabet. Le DDC est donc un protocole permettant à des appareils vidéos (écran, carte graphique principalement) de communiquer afin que l'un et l'autre puisse s'accorder. L'écran transmet la résolution maximale qu'il supporte à telle fréquence toussa toussa. Mais il est en fait possible d'utiliser cette fonctionnalité pour parler à l'écran et lui faire savoir ce que l'on désire ! DDC est standardisé mais après les capacités de chaque écran diffère et parfois la façon de leur parler aussi. Ne perdons pas de temps en palabres et commençons à bidouiller.

## DDCControl et DDCUtil
Je connais deux softs qui savent faire le taff. DDCControl est le plus ancien. Il repose sur une base de données des écrans pour connaître leurs capacités. Et pas de bol le soft est plus trop mis à jour. Il est hébergé chez Sourceforge. Ouai c'est un gros point négatif en 2017. Bref il est à l'agonie mais il fonctionne quand même. Il est packagé sous Gentoo.


DDCUtil est le ptit nouveau qui débarque et croyez moi, les parts de marché de DDCControl vont en pâtir (au moins dans mon cas). Il se base pas sur une base de données mais plus par le standard plus ou moins implicite qui s'est établit au fil des années chez les constructeurs. Pas dispo chez Gentoo mais sur github. Il a pas trop de dépendances donc pas de soucis à craindre.

Une fois compilé/installé pour pas trop se faire chier on vérifie que son user est dans le groupe video et maintenant on va donner des droits d'écriture dans le device i2c qui va bien pour pouvoir gérer l'écran sans être root. Donc on se rend dans */etc/udev/rules.d* et on rajoute un nouveau ptit fichier contenant :
```
KERNEL=="i2c-[0-9]*", GROUP="video", MODE="0660"
```
et hop. Si on veux pas se faire chier on reboot (sinon on se relog et on reload eudev). Et maintenant à nous les joies de la flemmardise pour modifier les règlages.

Allez on commence pépère par un ptit **ddcutil detect** qui, si tout se déroule comme prévu, vous affichera quelques infos concernant votre écran. Bon du coup on va voir ce que vous pouvez tripatouiller via **ddcutil getvcp KNOWN**. Il est à noter qu'il est possible que certains règlages ne soient pas trouvés mais la liste s'agrandit à chaque nouvelle update de ddcutil. Dans la liste vous trouverez pleins de lignes comme par exemple
```
VCP code 0x10 (Brightness ): current value = 5, max value = 100
```
Ça veux dire que la luminosité à comme code 0x10 (ou juste 10), que sa valeur actuelle est de 5 et que le max est de 100. Donc si on veut augmenter la luminosité on fait **ddcutil setvcp 10 25** et hop votre écran se câle sur 25 de luminosité.

Voilà vous devriez être à même de vous débrouiller. La petite astuce du tuxiste flemmard est de se créer plusieurs scripts : jour, jour+, jour++, nuit, nuit+, nuit++ qui ne font qu'invoquer ddcutil qui balancent des valeurs différentes de brighness et hop. Invoqué vite fait bien fait depuis dmenu et c'est la classe.

