+++
Author = "Lord"
Description = "Comment configurer Xorg pour avoir un layout de clavier différent pour de multiples claviers simultanément ?"
Categories = ["linux", "xorg", "clavier", "keyboard", "bépo"]
menu = "main"
notoc = true
PublishDate = 2018-01-31T21:18:40+01:00
date = 2018-01-31T21:18:40+01:00
title = "Multi layout claviers simultanés pour Xorg"
+++
J'aime beaucoup les claviers. Et il m'arrive régulièrement d'en brancher plusieurs sur l'ordinateur… en même temps. Ça n'a que peu d'intérêt mais j'aime bien. Ma petite collection grandit petit à petit. Mon clavier principal est en bépo légèrement trafiqué tandis que la plupart de mes autres bestiaux sont en azerty plus traditionnel voir quelques-uns en qwerty. Du coup j'ai configuré *Xorg* pour avoir une configuration un peu hors du commun :

  - Mon clavier traditionnel est en bépo, azerty et qwerty
  - Les autres claviers sont en azerty, bépo, qwerty
  - La touche Ctrl droite sert de touche **Compose**
  - Ctrl-Alt-Backspace tue la session Xorg
  - Maintenir Shift-droite et Shift-gauche simultanément change de disposition

Voilà le cahier des charges que je voulait.

Bon du coup pour faire ça on va éditer le fichier */etc/X11/xorg.conf* . Certaines distributions ont remplacées ce fichier par un dossier contenant plusieurs fichiers. Dans ce cas cherchez quel fichier contient ce qui a attrait à evdev…

	Section "InputClass"
        Identifier "evdev keyboard catchall"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        Option "XkbLayout"      "fr,fr,us"
        Option "XkbVariant"     "oss,bepo, "
        Option "XkbOptions"     "compose:rctrl,terminate:ctrl_alt_bksp,grp:caps_toggle"
	EndSection

	Section "InputClass"
        Identifier "Custom Keyboard"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        MatchVendor "Lord_Corp"
        Driver "evdev"
        Option "XkbLayout"      "fr,fr,us"
        Option "XkbVariant"     "bepo,oss, "
        Option "XkbOptions"     "compose:rctrl,terminate:ctrl_alt_bksp,grp:caps_toggle"
	EndSection
	
Voilà tout.

## Comment ça marche ?

Et bien Xorg est composé de multiples *"drivers"* ou modules, dont un nommé **evdev** qui est chargé de scanner tous les appareils d'entrées et de les configurer. Du coup il va piocher dans */dev/input/* et va regarder chacun des fichiers présents correspondants à tous les appareils d'entrée détectés par votre kernel.	

En fonction du type d'appareil (clavier/souris/tablette tactile/…), il va appliquer des configurations différentes. Il fait cela via les règles de type **catchall**.

Par chance on peut lui dire d'appliquer des règles différentes à des appareils spécifiques en rajoutant des conditions pour *match*. Dans mon cas, il recherche *Lord_Corp* dans le champs *Vendor* fourni par l'appareil. Donc vous pouvez mettre le petit nom de votre appareil à vous.

### Comment je trouve le Vendor de mon appareil ?

Facile : ***xinput --list --long***
