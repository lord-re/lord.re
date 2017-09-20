+++
Description = "Managing Gentoo's overlay without using the good old layman"
date = "2016-10-06T14:58:02+02:00"
title = "Managing Gentoo's overlay without layman"
menu = "main"
Categories = ["adminsys","software","linux","gentoo","cli"]
Tags = ["adminsys","software","linux","gentoo","cli"]

+++
Gentoo's overlays are portage's tree extensions. Portage is the big repository of ebuilds of Gentoo to installs all your favorite softwares. Gentoo is pretty well stuffed on this side. But sometime you need an exotic soft unavailable in portage. Some people provide overlay containing softwares that you can add in your Gentoo. To add an overlay, the official way is to use **layman**. But let's be honest, it can be done without it quite easily. So let's see how to do it.

You just have to edite */etc/portage/repos.conf/gentoo.conf*. And add your repo like this :
```
[nom de l'overlay]
priority = 50
location = /where/you/want/to/store/it
sync-type = git (or svn or …)
sync-uri = git://url.of/overlay.git
auto-sync = yes
```
And now **emerge --sync** or better **eix-sync**. You're done

You don't need layman anymore. Isn't this beautiful ?

