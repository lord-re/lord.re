+++
date = "2016-03-08T14:52:04+02:00"
title = "Start services in tmux at boot times"
menu = "main"
Categories = ["adminsys","software","linux","tips","cli"]
Tags = ["adminsys","software","linux","tips","cli"]
Description = "Une ruse de sioux pour bypasser l'init et démmarrer des applis dans tmux. Super pratique. Mieux qu'un init classique"
Description = "A trick to bypass your init in order to start applications in tmux at boot times. Really handy and better than a classic init."

+++
It's a trivial thing to automatically start application during the boot. But in fact not that much. It's your init's job to do this. It should be something easy (huh systemd ?). Starting a command inside tmux isn't native to current inits. Here's how to do it.

First we will start with OpenRC init file (sorry i won't tro^wtalk about systemd). So in */etc/init.d/tmux* you put the right shebang and in the start() section you put :
```
start-stop-daemon -u lord -S -b -x /home/lord/tmuxboot.sh -d /home/lord > /var/log/tmuxboot.log 2>&1
```
Here we've just told openrc to launch the */home/lord/tmuxboot.sh* script from */home/lord/* with the *lord* user.

Now we have to populate *tmuxboot.sh* to instruct tmux what to do. It's a simple shell script. The trick is that tmux can take commands from outside the session.
```
#! /bin/sh
tmux new-session -d -n rtorrent '/usr/bin/rtorrent'
tmux new-window -n Htop '/usr/bin/htop'
```
It's self explanatory. You can put many things in this script. It's really nice to be able to get the full output and backlog from commands launched inside this.

