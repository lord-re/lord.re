+++
Tags = ["virtu","tips","adminsys"]
Description = ""
menu = "main"
Categories = ["tips","virtu","adminsys"]
date = "2010-08-25T21:18:36+02:00"
title = "Mumuse avec OpenVZ"
nodate = true

+++

OpenVZ est un système de virtualisation pour linux particulier. En bref la machine hôte possède un kernel spécifiquement compilé et partage ce kernel avec les machines virtuelles. On est donc limité dans les OS mais par contre on obtient des performances impressionnantes. Pour plus de renseignements →→ wikipedia & google ←←
Bon en fait j'ai voulu faire mumuse avec ma ptite gentoo. C'est une machine qui me sert typiquement de serveur. C'est une machine headless. Mais j'avait besoin d'application graphiques nunux pendant que j'utilise des softs uniquements windows sur mon laptop. J'ai donc créé un container openvz (machine virtuelle) avec une bonne vieille lenny où j'ai installé un Xorg. Sur le windows j'ai installé Xming (un serveur X11 très bien foutu). Puis un simple ForwardX11 dans putty et le tour est joué. Le but de ce ptit article c'est surtout de mettre les commandes nécessaires à l'utilisation d'OpenVZ (ouai je sais on le trouve un peu partout mais c'est mon site, je fait ce que je veux).
Donc dans **/vz/template/cache** on fout le template qu'on veut.
```
vzctl create 101 --ostemplate distrib-version-arch --config
vzctl set 101 --hostname bla --ipadd a.b.c.d --nameserver a.b.c.d --diskspace 2G:3G --cpulimit 125 --save
vzctl start 101
vzctl enter 101
vzctl exec 101 htop
```
Bon je crois que c'est à peu près tout. Avec ca on peut bien faire mumuse.
