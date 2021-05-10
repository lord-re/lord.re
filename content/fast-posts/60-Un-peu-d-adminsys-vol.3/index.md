+++
Author = "Lord"
Description = "Après un échec cuisant il y six mois, j'ai enfin pris le temps de retenter la migration de mon Turris Omnia vers Turris OS 5. Débug divers et variés."
Categories = ["turris", "openwrt","debug"]
menu = "main"
notoc = true
WritingDate = 2021-05-10T19:33:13+02:00
date = 2021-05-10T19:33:13+02:00
title = "Un peu d'adminsys vol.3 : Turris OS 5.x la revanche !"
editor = "kakoune"
TopWords= ["turris","omnia","routeur","snapshot","btrfs","dhcp","lxc","dtb"]
+++
Voilà l'épisode 2 de mon épopée pour mettre à jour mon routeur à la maison.
Il va y avoir du débug de réseau, de nunux un peu dans tous les sens.

## Résumé du précédent épisode
Dans [le premier épisode]({{< ref "/fast-posts/50-un-peu-dadminsys-vol2" >}}) j'ai mis à jour mon routeur et j'ai perdu la connexion aux grands Internets.
Forcément ça ne m'intéressait point de trop un routeur qui ne route plus en dehors de mon LAN.
Donc retour en arrière.

Merci les snapshots BTRFS !

## Recommençons et observons :
J'utilise comme routeur un fier [Turris Omnia]({{< ref "/posts/44-turris-omnia" >}}) qui est un routeur sous Linux avec du bon matos même si maintenant il est matériellement bien moins impressionnant que les nouveautés.
Il n'en reste pas moins une jolie bête vraiment fiable et surtout qui déborde de logiciel libre.

Tout d'abord un snapshot avant de tout casser : <kbd>schnapps create "Ça va péter"</kbd> et maintenant on a l'esprit libre.

Allez, je lance l'interface web et je lance l'upgrade vers Turris OS 5.1 .
Ça moulinne deux minutes et ça semble tout bon.

Je reboot, et là pas d'internet mais le lan fonctionne toujours.

C'est partie pour un ptit <kbd>ip a</kbd> et effectivement pas d'interface avec mon IP publique.
Je cherche un peu à comprendre pourquoi le DHCP n'est pas coopératif.

On avance de vingt minutes et là je commence à me demander si le problème ne serait pas une couche en dessous.
Et là je commence à découvrir un truc bizarre : les adresses MAC ne sont plus sur les mêmes interfaces qu'avant.
Et je ne vous cache pas que pour m'en rendre compte, j'ai fait un nouveau snapshot btrfs, j'ai rollback sur l'ancien, j'ai fait un <kbd>ip a</kbd> puis rollback sur le snapshot en 5.1 et un autre <kbd>ip a</kbd> pour comparer.

*eth1* est désormais *eth2* et *eth2* est devenu *eth0* ou vice versa je sais pas trop.
Bon bha pourquoi pas ?
Chiant mais pourquoi pas.

## Renumérotation des interfaces réseau
Bon j'adapte deux trois trucs dans le fichier */etc/config/network* pour me réaligner sur ces interfaces.
Un reboot.
Et c'est pas mieux.

Je remarque quand même quand même qu'il y a une interface qui reste constamment <samp>DOWN</samp>.
Visiblement l'intention ne compte pas suffisamment, j'arrive pas à la passer UP.
Je fous mon pc en direct sur ce port voir si les LED s'activent.
RIEN.

Bon, bha il va faloir encore descendre d'une couche !

## We need to go deeper !
Bon, visiblement l'interface réseau est complètement désactivée.
Un module kernel manquant ?
Une conf kernel étrange ?

C'est quand tout déconne qu'on fait quoi ?
Qu'on lit la doc !

Et une des nouveautés de cette version concerne le port SFP qui ne peut plus être désactivé au profit du port ethernet une fois booté.
Et pour passer de l'un à l'autre il faut modifier le bootloader pour le faire pointer soit sur un *DTB* pour le SFP soit un *DTB* pour le port PHY.

Bon bon bon.
Allons voir ce qui est mis par défaut.

<details><summary><kbd>ll /boot</kbd></summary>

<pre>
drwxr-xr-x    1 root     root           158 May 10 16:25 ./
drwxr-xr-x    1 root     root           176 May 10 14:58 ../
-rw-r--r--    1 root     root         18773 Mar  4 01:25 armada-385-turris-omnia-phy.dtb
-rw-r--r--    1 root     root         18809 Mar  4 01:25 armada-385-turris-omnia-sfp.dtb
-rw-r--r--    1 root     root          1199 Mar  4 01:25 boot.scr
lrwxrwxrwx    1 root     root            31 May 10 16:25 dtb -> armada-385-turris-omnia-sfp.dtb
-rwxr-xr-x    1 root     root       3351944 Mar  4 01:25 zImage*
</pre>
</details>

Bon bha voilà, déjà probablement une partie du mystère.
Je change le lien symbolique pour pointer vers l'autre *DTB* et je reboot et hourra \o/

Bon j'ai un port réseau qui est de nouveau *UP*, il reste à refoutre la conf d'aplomb pour le dhcp.

## Baston contre OpenWRT
Voilà ce que je craignais, ils ont modifié ce qu'ils considèrent le LAN, le WAN, avec les règles de firewall et tout.
Je passe donc un peu par l'interface web pour voir ce qu'il se trame.

J'assigne mon port *eth2* au *wan* sauf que moi ce que j'aimerai c'est y foutre le port *eth2.832* mais je ne peux point.
Je place les autres ports dans le lan, je me connecte en SSH pour éditer le */etc/config/network* pour y mettre vraiment la bonne interface réseau.
Je reboot et … bha ça route quedalle.

Pourtant l'interface est up, depuis ssh j'arrive à pinguer des trucs sur le net.
Bon bha c'est surement ma conf iptables qui a disparu :-/

Pourtant mon script est toujours dans */etc/init.d/iptables* .
Ha !
Mais oui !
Faut que je change et que j'y mette la bonne interface réseau pour le lan (pour une fois que j'ai utilisé des variables, une seule modif à faire !).

Allez, je relance le script est waouw j'ai du net sur mon lan.

## Baston contre LXC
Mais ce n'est pas la dernière étape.
Tous mes containers LXC sont au tas.

Je tente d'en lancer un manuellement <kbd>lxc-start -n nib</kbd> et ça me sort une des spécialités de LXC : les messages moches : <samp>lxc-start: nib: parse.c: lxc_file_for_each_line_mmap: 142 Failed to parse config file "/srv/lxc/nib/config" at line "lxc.net.0.ipv4 = 10.2.0.50/8"
Failed to load config for nib
lxc-start: nib: tools/lxc_start.c: main: 264 Failed to create lxc_container</samp>

Sérieux, on a rarement vu des messages d'erreurs aussi moche pour signaler que la syntaxe n'est pas la bonne.
D'ailleurs est-ce qu'ils s'amuseraient pas à changer la syntaxe à chaque version chez LXC ?
Je commence à me demander.

Deux trois coups de mojeek plus tard et je découvre que ce n'est plus <samp>lxc.net.0.ipv4 = a.b.c.d/e</samp> mais <samp>lxc.net.0.ipv4.address = a.b.c.d/e</samp> -___-
Bon bha c'est parti pour éditer les fichiers de conf de chaque container et je les lance.

C'est bon ça passe, on reboot pour tout tester.

Ha bha ils redémarrent pas.
Je repasse sur l'interface web d'OpenWRT vérifier que les containers y sont bien référencés.

Ils y sont mais éteint, ok c'est raccord.
Par contre, le service *lxc-auto* n'est visiblement pas activé au boot, je le coche et je reboot.

Yataaaaaa \o/

Tout remarche.

## Moralité
Lire la doc m'aurait évité de repousser ça de six mois et de le faire plus tôt.

Bon par contre dans l'histoire, j'ai changé d'IPv4 !
Ça ne m'était pas arrivé en cinq ans.
J'espère que ça ne va pas se reproduire, j'aime bien avoir une ip fixe.
J'imagine que j'ai libéré mon IP trop longtemps et qu'elle a été réattribuée pendant que mon routeur était down :-/

## update DNS
Là c'est rapide : un coup de ssh vers le DNS master.
Et là tout à base de **knotc** :
<kbd>knotc zone-begin lord.re.</kbd>
<kbd>knotc zone-unset lord.re. lord.re. 7200 A 92.167.84.9</kbd>
<kbd>knotc zone-set lord.re. lord.re. 7200 A 90.113.193.129</kbd>
<kbd>knotc zone-commit lord.re.</kbd>

Et voilà, plus qu'à patienter que les deux heures de cache expirent pour que tout le monde puisse me joindre.

