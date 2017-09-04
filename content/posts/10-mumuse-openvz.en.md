+++
Tags = ["virtu","tips","adminsys"]
Description = ""
menu = "main"
Categories = ["tips","virtu","adminsys"]
date = "2010-08-25T21:18:36+02:00"
title = "Playing with OpenVZ"
nodate = true

+++

OpenVZ is a virtualization system for linux different from the others. The host use a specialized linux kernel compiled wich is shared with all the guests. You can't virtualize any OS but with linux systems you'll have nearly natives performances. If you need more informations →→ wikipedia & google ←←

I wanted to play with my tiny Gentoo. It's a small headless machine used as a personal server. I had to use some graphical software while using my windows laptop. So i created an openvz container with a Debian lenny where i installed Xorg and tutti quanti.

On windows i installed Xming (an X11 server). I then used **ForwardX11** in Putty and there it is ! I can launch linux graphical applications and have them on my windows machine. Here are the required openvz commands to set this up ( i know you can find them elsewhere but hey ! This is my website ! I can do what the fuck i want!).

```
vzctl create 101 --ostemplate distrib-version-arch --config
vzctl set 101 --hostname bla --ipadd a.b.c.d --nameserver a.b.c.d --diskspace 2G:3G --cpulimit 125 --save
vzctl start 101
vzctl enter 101
vzctl exec 101 htop
```
With this you should be able to survive.

*PS 2017 :* Wow i feel like i was on the bleeding edge. 7 years later i still use containers but with LXC which is sensibly the same thing but in the mainline kernel. I no longer use windows nor X11 Forwarding. Actually i'm considering dropping X11 in favor of Wayland.
