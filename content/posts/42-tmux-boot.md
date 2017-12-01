+++
Author = "Lord"
date = "2016-03-08T14:52:04+02:00"
title = "Démarrer des applis dans tmux au boot"
menu = "main"
Categories = ["adminsys","software","linux","tips","cli"]
Tags = ["adminsys","software","linux","tips","cli"]
Description = "Une ruse de sioux pour bypasser l'init et démmarrer des applis dans tmux. Super pratique. Mieux qu'un init classique"

+++
En voilà une chose triviale mais qui n'est pas si simple que ça. Démarrer une appli au boot, généralement c'est le boulot de l'init, ça devrait être easy (hein systemd). Mais démarrer une appli dans tmux n'est pas geré par les init existants. Donc je vais vous expliquer comment le faire.

Déjà on va commencer par le script d'init pour openRC (vous croyiez vraiment que j'allait aborder systemd ?). Donc dans */etc/init.d/tmux* on met le shebang qui va bien puis dans le start() on place
```
start-stop-daemon -u lord -S -b -x /home/lord/tmuxboot.sh -d /home/lord > /var/log/tmuxboot.log 2>&1
```
Voilà, on dit à openrc de le lancer au boot et c'est bon.
Il ne reste plus qu'à gerer ce fameux *tmuxboot.sh* pour dire à tmux que faire. Il s'agit tout simplement d'un script shell ce qu'il y a de plus basique. Tout l'astuce réside dans le fait que tmux peut recevoir des ordres provenant de l'extérieur.
```
#! /bin/sh
tmux new-session -d -n rtorrent '/usr/bin/rtorrent'
tmux new-window -n Htop '/usr/bin/htop'
```
Et voilà je pense que vous avez saisi l'idée. C'est plutôt simple et vraiment rapide à mettre en place. Enfin un article concis \o/.

