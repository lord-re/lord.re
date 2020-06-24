+++
Author = "Lord"
Description = "Petite séance de démerdage d'un Proxmox viandé. La partition contenant /etc/pve n'était plus montée suite à un redémarrage. Voyons ça !"
Categories = ["adminsys", "linux"]
menu = "main"
notoc = true
PublishDate = 2019-06-03T12:42:30+02:00
date = 2019-06-03T12:42:30+02:00
title = "/etc/pve vide sur Proxmox"
editor = "kakoune"
TopWords = [  "cluster", "erreur", "pve","proxmox","adminsys","linux","container"]
+++
J'ai filé un ptit coup de main aujourd'hui sur une ptite install Proxmox un peu à l'agonie.

Après un reboot, *le dossier /etc/pve était vide*.
C'est le dossier qui contient un peu toute la conf de l'hyperviseur, c'est donc pas super pratique.

Je suis pas vraiment expert Proxmox, j'utilise presque pas ce truc et ma première réaction été un ptit "O___O une partoche séparée pour /etc ?!"
Bon pourquoi pas.

Bon, le *fstab* n'est pas d'une grande aide vu que ce n'est pas mentionné.
J'imagine que c'est vraiment de la tambouille interne à leur truc.
Va falloir se renseigner un poil sur leur système.

…

À première vue, un ptit coup de **<kbd>pvecm status</kbd>** m'indique *pve configuration filesystem not mounted*.
Thanks Cpt Obvious !

Allez, tentons de redémarrer le service de cluster **<kbd>service pve-cluster restart</kbd>**.
Systemd comme d'hab te dit que ça marche pas sans te sortir le message d'erreur… merci j'adore.
Allons voir **<kbd>journalctl -xe</kbd>**.

Hmmm bizarre tiens j'ai une ligne intrigante.
*/etc/pve/local/pve-ssl.key: failed to load local private key (key_file or key) at /usr/share/perl5/PVE/APIServer/AnyEvent.pm line 1626.*
À première vue comme ça je vois pas trop le rapport mais bon, allons voir ce fichier et surtout cette ligne…

Bon je vous épargne mon habilité naturelle à lire le Perl… le problème vient pas réellement de là.
Enfin je pense pas.

Refaisons un ptit tour sur le moteur de recherche (DDG, pas Google, hein !).
…
…

…

Ha tiens, apparemment il y aurait ptet une autre erreur planquée.
**<kbd>journalctl -e</kbd>**
Je fouille pour vérifier.

HA.mp4 

*balou pmxcfs[12300]: [main] crit: Unable to get local IP address*

Il pouvait pas le dire plus tôt ?!

**Un ptit tour dans le */etc/hosts* pour commenter les lignes commençant par *<kbd>127.0.0.1</kbd>*.**
Redémarrage via **<kbd>service pve-cluster restart</kbd>**.
Et là plus d'erreur.

*/etc/pve a récupéré ses fichiers \o/*

Bon, en fait visiblement, Proxmox sachant fonctionner en cluster, cette partition est potentiellement partagée/distribuée/synchronisée avec les autres nœuds.
Cela explique pourquoi cette partition est un peu particulière.

Bref, vingt minutes de perdu à cause de messages d'erreur pas raccords ou planqués.
Heureusement, ça marche plutôt bien habituellement.

Bref, voilà si ça peut vous aider tant mieux et surtout **faites un backup des fichiers de conf en plus de vos containers !**.
