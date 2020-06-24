+++
Author = "Lord"
Description = "Découverte du Turris Omnia et configuration pour remplacer une livebox avec fibre"
date = "2016-10-10T15:02:09+02:00"
title = "Nouveau routeur Turris Omnia"
menu = "main"
Categories = ["hardware","software","réseau","tips"]
jdh = "https://www.journalduhacker.net/s/mgijdu/retour_dexp_rience_routeur_turris_omnia"
TopWords = [  "cz", "nic", "résolveur", "turris", "wifi", "dhclient", "dns", "routeur", "dhcp", "openwrt"]
+++

Après pas loin d'un an d'attente le kickstarter du **Turris Omnia** est arrivé à la maison \o/.
Ce routeur est particulier car il est fait par les braves gens de [nic.cz](https://www.nic.cz/), l'organisme qui s'occupe entre autre des noms de domaine tchèques.
Ce sont les même gens qui développent **knot** un super serveur DNS qui héberge de plus en plus de domaine (dont au moins un root server à l'heure actuelle).
Ce sont également eux qui dev **Bird** un daemon de routage alternative de quagga.
Bref des mecs qui s'y connaissent pas trop mal.

Ils ont décidé de construire un routeur tout sympatoche et pas trop cher.
Le bestiau est dual core, avec 1Go de RAM (minimum) mais surtout trois minipcie pour le wifi et un modem LTE par exemple.
À cela on rajoute une tripotée d'ethernet Gbps et on emballe le tout dans un boitier en feraille avec de jolies leds programmables et paf.
Le dernier point qui fait craquer c'est que niveau soft c'est livré sur openwrt avec en bonus une petite surcouche supplémentaire made in nic.cz.

Franchement matériellement à part le fait que les antennes wifi avaient tendances à tourner lorsqu'on les vis (on vire les 6 vis du capot, on ressert un peu avec une pince et hop, pas de perte de garantie), rien à redire.
Par contre niveau logiciel… pouarf.

OpenWRT c'est bien gentil mais c'est quand même un poil relou et sur-compliqué pour pas grand chose.
On se connecte en ssh et on reluque vite fait les règles iptables présentes :  O M G .
Il y en a des kilomètres ! L'interface web pour configurer les trucs, bon autant des fois c'est mignon et fonctionnel, autant quand on est habitué à tout confer soi-même à la mimine en console on en voit très vite les limitations : des bouts de conf qui apparaissent de nul part, des réglages qui ne parsent pas, des choix logiciels pas facilement modifiables.
La partie config Wifi par contre est vraiment bien foutue (j'en attends ptet pas grand-chose), mais quel dommage que parfois les réglages soient pris en compte que la seconde fois.

Tout cela je l'avais déjà rencontré sur l'AP wifi sous OpenWRT, donc c'est pas directement le Turris.

## OpenWRT c'est rigide mais flexible
Une chance qu'une fois abandonnée l'interface web, finalement OpenWRT reste une vraie distro nunux avec son gestionnaire de paquets, son init toussa toussa.
Ce qui veut dire que c'est flexible !

Établissons un plan d'attaque pour cette machine.
Je veux qu'il remplace mon vieillissant Atom D510 qui me sert de routeur, donc faire une jolie gateway.
Dans ce but je veux qu'il fasse également serveur NTP, résolveur DNS local, serveur DHCP.
Bref des services de bases d'une passerelle.

Bon commençons par le faire chopper du net.
À la maison c'est fibre Orange.
Donc jusqu'à peu c'est PPP par-dessus un VLAN.
Désormais c'est plus moderne : dhcp par-dessus un vlan.
Easy !
Pas de bol le client DHCP doit envoyer des options non conventionnelles pour avoir le précieux ternet.
Le client de base d'OpenWRT (qui est en fait celui de busybox) ne semble pas le faire.
Tant pis, on jarte et on installe le bon vieux dhclient.

On planque le fichier de conf qui va bien où on veut (ça peut être malin de le planquer dans /etc/dhcp, par exemple).
Et on créer un script init simpliste genre

{{< highlight "sh" >}}
#!/bin/sh /etc/rc.common
START=35
STOP=85
SERVICE_USE_PID=1
start() {
service_start /usr/sbin/dhclient -cf /etc/dhcp/dhclient4.conf eth1.832 -lf /var/run/dhclient.leases -pf /var/run/dhclient.pid -nw
}
stop(){
service_stop /usr/sbin/dhclient
}
{{< / highlight >}}
et on le fout au boot (voir dans /etc/rc.d).
Là normalement une fois le service lancé le Turris se retrouvera propulsé sur les autoroutes de l'information.

Bon ensuite le résolveur DNS local, par défaut c'est *kresd*, le pendant résolveur de knot.
Au bout de deux minutes d'essai… bha ça marche mais c'est lent.
C'est balot je voulais le tester depuis quelque temps mais ça coupe l'envie.
Bref je le testerai plus tard au calme.
Donc on le désactive du boot et on s'installe le bon vieux *unbound* et on le fout au boot.
En deux minutes c'est réglé.

Le serveur DHCP, allez celui-là on le laisse géré via l'interface web d'OpenWRT.
C'est un *dnsmasq* classique.
Par contre je sais pas si c'est moi qui n'ais pas de bol ou autre mais ce couillon me pousse pas de DNS… c'est un peu dommage pour un serveur DHCP.
Il a fallu tripoter la conf manuellement dans <kbd>/var/etc/dnsmasq.conf</kbd> pour rajouter l'option de balancer du DNS… étrange mais soit.
Ptet juste un ptit bug.
Passons.

Le serveur de temps.
Encore une fois laissons gérer OpenWRT.
Wow ça marche en dehors de la boîte !

## Des containeurs dans ton routeur
L'avantage d'avoir pas mal de stockage (8Go tout de même) et pas mal de RAM (1Go tout de même aussi), c'est qu'on peut faire un peu plus que routeur.
Typiquement on peut faire des containers pour y héberger deux trois trucs de façon à peu près sécure.

OpenWRT m'a bluffé par l'intégration de LXC direct dans l'interface web et le pire c'est que c'est pas trop mal foutu (simpliste mais fonctionnel).
Bref de base ça propose pas mal de distro classique mais surtout Gentoo mais encore plus surtout Alpine Linux !
J'ai pu démarrer en trente seconde un container alpine et rentrer dedans en console via un **<kbd>lxc-attach -n alpine</kbd>**.
Pour l'instant rien à redire

Pour l'instant appart quelques déconvenues d'interfaces/intégration made in OpenWRT c'est vraiment tout bon.
Ce routeur en a suffisamment dans le ventre pour atteindre les 500Mbps que mon abonnement me permet en consommant moins que mon ancien.
