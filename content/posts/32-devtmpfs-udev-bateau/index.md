+++
Author = "Lord"
Description = "Post-Mortem suite à une coupure de courant. Une gentoo maladouille qui doit se faire réparer."
date = "2013-07-07T23:16:41+02:00"
title = "Devtmpfs et Udev sont dans un bateau"
menu = "main"
Categories = ["meta","www","gentoo","linux","software"]
Tags = ["meta","www","gentoo","linux","software"]
TopWords = [  "kernel", "openrc", "udev"]
+++
Et voilà qu'une coupure de courant m'a réveillé de mauvais poil ce matin.
Un dimanche à 6h entendre le gazouillis des onduleurs.
Toujours plus oppressant.
Chaque bip indiquant une mort de plus en plus proche.
Et là c'est on commence à tenter de s'égayer les idées.
Une épreuve de résistance pour onduleur : lequel tiendra le plus longtemps ? Celui de l'équipe téloche (ONT, lecteur multimédia, téléviseur), l'équipe serveur (serveur huhu) ou bien l'équipe ordis (les ordis, le switch et la borne wifi).
Malheureusement à 6h du matin c'est l'équipe serveur qui tombe en premier, les autres glandant allégrement en écoutant le bruit des cigales commençant à s'éveiller.
Bon trêve de poésie.
L'onduleur serveur est tombé.
Faisant passer son uptime de 200 à 0 d'un coup d'un seul.
Et c'est là que les ennuis commencent.
Pendant ces deux cents jours j'ai fait quelques update de la Gentoo dont une dont j'aurai pu me passer.

## Docteur Root
Après avoir réussi à me rendormir une fois le ventilateur décidé à redémarrer grâce à l'acharnement d'EDF.
Voilà que je me lève et tente innocemment de me connecter au net en me doutant que j'aurai quelques emmerdes.
Et là comme convenu ça ne marchait pas.
Un petit ping sur le net.
NOPE.
Un petit ping sur le serveur.
YEP.
Bon ça restreint le champ d'action.
Ni une ni deux je déballe le brave chevalier ssh.
Mais celui-ci ne parvient pas à passer le pont levis.
J'envoie mes deux espions en renfort.
Un avec le chevalier ssh du nom de -v et le second plus en retrait qui regarde de loin (tcpdump).
Manifestement le pont-levis ne s'ouvrira pas.
Il faut donc passer à l'arme lourd.
Brancher un clavier et un écran.

## Diagnostic : Udev capricieux
Au boot le kernel fait ses petites affaires gentiment.
Vient ensuite le brave Openrc qui commence gentiment lui aussi à faire son office jusqu'à ce qu'il se fasse poignarder dans le dos par le vil udev.
Vous savez, Udev, c'est ce petit logiciel magique qui gère un peu trop de truc niveau matos tout ça.
Et ce petit couillon nécessite désormais une option du kernel DEVTMPFS.
Je pensais bêtement que je l'avais depuis un bail mais manifestement non.
Donc là le bon sens voudrait qu'on boot sur un livecd ou autre.
Le souci c'est que j'ai plus de net, pas de lecteur optique et pas de clé usb.

## Opération à OpenRC ouvert
Bon, donc on boot, puis on bourrine la touche I.
Et là on arrive dans le mode interactif d'OpenRC.
Le mode interactif demande à l'utilisateur quelles actions entreprendre pour chaque service devant être démarré.
Sachant qu'Udev est un composant assez critique et que sans lui ça risque de chier un peu, je me fais pas chier: au premier service, je lui dis de laisser tomber et de me filer un shell.
Ceci fait, on passe le clavier en petit azerty (**<samp>loadkeys fr</samp>**).
Étrangement ça semble de plutôt bien fonctionner, même si bien entendu rien n'est démarré.
Je remonte la partoche en rw (**<samp>mount -o rw /</samp>**), puis on va se faire une petite compil kernel des familles et on boot dessus.
Si ça c'est pas un joli dimanche d'été…

