+++
Author = "Lord"
Categories = ["adminsys","réseau","tips"]
Tags = ["adminsys","réseau","tips"]
Description = "Tutorial pour virer une livebox pour la remplacer par un vrai routeur. Le but du jeu est de conserver le service de télévision fonctionnel"
date = "2012-12-09T22:45:36+02:00"
title = "Dégager une livebox tout en conservant le service de téloche"
menu = "main"

+++

***UPDATE 2017 :*** *Ce tuto est plus vraiment d'actualité, désormais le PPP n'est plus obligatoire, il est d'ailleurs préferrable de passer par le DHCP (qui nécessite malheureusement des options exotiques).*

Ça y est ! Le Saint-Graal est arrivé à la maison ! Le FTTH.
La fibre.
Cette petite merveille de plastoc qui me fait rêver depuis des lustres.
Je l'ai youhou youpi yata.
J'ai donc un joli 100M symétrique chez l'agrume-opérateur.
Une bien jolie connexion.
Un débit symétrique ça vous change la vie de geek.
Par contre plus d'ip fixe, ni de reverse DNS personnalisable… C'est d'ailleurs fort dommage.
Et le port 25 est à oublier également.
M'enfin il faut savoir faire des concessions dans la vie.
Et la Livebox, quelle horreur.
Heureusement ce dernier détail est réglable.
Par contre pour conserver le service de télévision il va falloir se retrousser les manches.

## Petit rappel sur l'architecture FTTH d'un particulier en 2012
Clémentine a choisi une architecture de type GPON.
C'est-à-dire qu'une fibre dessert plusieurs clients.
Quelle idée saugrenue ! Après s'être fait chier à faire la même connerie sur le cuivre, ils refont pareil sur la fibre.
En cuivre pour faire des économies les PTT ont tirés de nombreuse lignes multiplexées.
Pour le téléphone c'était parfait cependant avec l'arrivée du net pour tous ça a très vite montré ses limites.
Le débit RTC traditionnel est déjà assez bas mais sur une telle ligne on ne dépasse pas les 30kbps (bits pas bytes).
Et on peut direct oublier de faire passer de l'asdl sur les lignes multiplexées.
J'ai encore des restes de ce traumatisme.
Avec la fibre ils refont la même.
Ils multiplexent plusieurs clients sur une seule fibre.
Pour l'instant c'est absolument pas génant mais qui sait ce qui se passera dans quelques années… Une bonne petite fibre individuelle n'aurait pas coûté beaucoup plus cher m'enfin.

Donc dans les parties communes de l'immeuble la fibre est amenée par un opérateur.
Puis il faut une intervention dans chaque appartement pour y amener ce câble magique.
En fait d'une fibre c'est bien 4 qui sont réellement tirées.
On peut donc être raccordé à 4 réseaux opérateurs différents.
Un petit boitier est posée avec les 4 prises colorées.
Cette partie-là devient fixe : en cas de changement de FAI cette partie restera toujours.
Un changement de FAI consistera à brancher le reste de l'installation sur l'une des quatre prises.
Ce boitier n'est pas alimenté, c'est juste une prise toute bête.

Maintenant on passe à la partie appartenant au FAI : le modem ! Dans le cas de Mandarine il s'agit d'un boitier faisant le lien entre la box et la fibre.
C'est plus un transceiver à vrai dire.
On lui met un peu de courant, la fibre et il vous pond un ethernet.
C'est à lui qu'on doit une bonne partie de la magie.
Cette boiboite est parfois intégrée dans les box (pour les futures livebox il parait, ou bien dans li freebox…).
Par chance j'y ais eu droit.

Il y a ensuite la box qui récupère l'Ethernet.
Celle-ci s'occupe de gérer le ppp (oui oui -___- ) et de faire le routage et toutes les saloperies que font les box.
Elle permet de raccorder le décodeur TV et le téléphone.
C'est bien la seule chose d'intéressant qu'elle fasse à vraie dire.
En bon petit geek tout le reste est déjà fait maison et en mieux.

## Que fait réellement la Livebox ?
Bon alors la box sur le port 4 récupère la connexion internet.
Elle s'occupe de la session PPP.
Elle fait son boulot de passerelle.
Elle récupère le flux TV et le déverse sur n'importe lequel de ses trois ports restant.
Elle récupère la téléphonie en H323 (ou SIP je ne sais pas trop et je m'en fous royalement).

Donc pour la partie PPP c'est comme sur du bon vieux ADSL.
Donc notre routeur va devoir gérer la session PPP avec les identifiants.
Là où il y a une subtilité, c'est que c'est dans un VLAN numéroté 835.
Hahaha qu'est-ce qu'on se marre.
Non content de ne pas fournir un joli Ethernet des familles mais du PPP, il est VLANisé.
Et pour la petite blagounette on retrouve les VPI/VCI ATM.
Du coup notre petit internet on le retrouve au bout de combien d'empilement de couches ?
Bon j'imagine que maintenant vous vous doutez de la suite… Non ?
Bon bha en fait on va aussi avoir du VLAN pour la téléphonie mais bon j'ai déjà dit qu'on s'en foutait (de toute façon j'imagine qu'on a pas les infos concernant le login H323 ou SIP (une petite sonde entre le transceiver et la box serait du plus bel effet, mais je m'en fous)).
Et pareil pour la téloche on va avoir droit à une belle collection de VLAN.
Prêt ?

## Faisons mieux !
Matériellement il va nous falloir trois interfaces réseau :
```
eth0 pour le transceiver
eth1 pour notre LAN
eth2 pour le décodeur téloche
```
Et pleins de câbles pour les lier.

Logiciellement il va nous falloir une Gentoo, brctl, iproute2, vconfig, ppp, rp-pppoe et un kernel qui mange du ppp.
Faites un petit **<samp>ip l</samp>**, vous ne reverrez plus comme ça.

Le but va être de tout automatiser bien entendu.
Et on va se la jouer Gentoo-style.
Donc le gros du boulot va se trouver dans le fameux /etc/conf.d/net .
On va commencer en douceur pour avoir juste un peu de net pour pouvoir retourner au plus vite sur IRC.
```
#eth0 à poil
config_eth0=noop

#config ppp
config_ppp0="ppp"
link_ppp0="eth0.835"
plugins_ppp0="pppoe"
username_ppp0="fti/1234567"
password_ppp0="1234567"
pppd_ppp0="
defaultroute
noauth
usepeerdns
holdoff 3
child-timeout 60
lcp-echo-interval 15
lcp-echo-failure 3
noaccomp noccp nobsdcomp nodeflate nopcomp novj"
#on ne monte pas ppp0 tant que eth0 n'est pas prête
rc_need_ppp0="net.eth0"

#on ajoute qu'un vlan pour l'instant, on en rajoutera après
vlans_eth0="835"

#et une jolie eth2
config_eth1="10.0.0.1/16"
```

Là vous avez donc votre interface eth0 qui se retrouvera à poil, le vlan 835 qui lui sera greffé dessus (création d'une interface eth0.835) et ppp0 qui se greffera par dessus votre interface eth0.835.
Vous avez donc lo, eth0, eth0.835, ppp0 et eth1.
À ce moment vous êtes à deux doigts d'avoir du net sur votre LAN.
Sur la passerelle ça devrait déjà être bon.
Il va falloir un peu d'iptables genre un petit : **<samp>iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE</samp>**
Et voilà, le tour est joué.
Votre LAN est inondé de chatons boobs et autre memes.
Sauf que ça coince un peu partout.
Il va falloir faire mumuse avec la MTU grâce à toutes ces couches crasseuses.
On gère ça encore avec **<samp>iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu</samp>**.
On respire.

Une seconde fois.

## Télochons
On passe à la partie téloche, autrement appelée l'invasion des interfaces réseau.
Bon, donc il faut savoir que la téloche est encapsulée dans plusieurs VLANs :
```
835 : Internet
838 : Négo et HTTP pour le décodeur TV
840 : streaming des chaînes
841 : VoD il paraît mais bon, on s'en fout
```
Retournons dans le */etc/conf.d/net* :
```
#on modifie les vlans sur eth0:
vlans_eth0="835 838 839 840 841"

#on prépare eth2
config_eth2="noop"

#on bridge nos VLANs et eth2
bridge_tv="eth2 eth0.838 eth0.839 eth0.840 eth0.841"
config_tv="192.168.1.1/24"

#on ne monte l'interface tv que lorsque eth2 est prêt
rc_need_tv="net.eth2"
```
C'est bon, vous avez completé votre fichier comme un boss ?
Vous êtes prêt à vous lancer dans un reboot de la mort ?
Le seul souci de cette install c'est que chaque interface VLAN va avoir la fâcheuse manie de balancer une requête DHCP avec son timeout qui va avec.
Vue le nombre d'interface qu'il y a vous êtes pas arrivé.
Si quelqu'un trouve une solution, je suis preneur.

Un petit coup de polish : dans */etc/local.d/votrenomdescriptfavoris*
```
#réparation des bridges
echo "0" >/proc/sys/net/bridge/bridge-nf-call-arptables
echo "0" >/proc/sys/net/bridge/bridge-nf-call-ip6tables
echo "0" >/proc/sys/net/bridge/bridge-nf-call-iptables
echo "0" >/proc/sys/net/bridge/bridge-nf-filter-pppoe-tagged
echo "0" >/proc/sys/net/bridge/bridge-nf-filter-vlan-tagged
```
Je détaillerai pas cette partie mais il faut se faire un ptit serveur DHCP pour le décodeur TV.
En sachant que ce couillon est peu capricieux : en cas de modif IP faut le redémarrer électriquement.

Bon bha voilà, vous pouvez dégager votre livebox et la rendre à Orange tout en pouvant profiter de la téloche.

