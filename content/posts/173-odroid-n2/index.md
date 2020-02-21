+++
Author = "Lord"
Description = "J'accueille désormais une nouvelle venue à la maison : une petite Odroid N2 qui est une alternative au Raspberry Pi en étant beaucoup plus performante et plus équilibrée."
Categories = ["sbc", "hardware","linux", "alpine"]
menu = "main"
notoc = true
PublishDate = 2019-08-01T17:48:08+02:00
date = 2019-08-02T09:48:08+02:00
title = "Adoption d'une Odroid N2"
editor = "kakoune"
TopWords = [  "arch", "usb", "clavier", "emmc", "modules", "odroid", "archlinux", "board", "alpine", "n2","sbc"]
+++
Après les galères habituelles de livraison Made in Colissimo (grrrrr) j'ai enfin pû recueillir une ptite nouvelle à la maison.

## Odroid N2
La bête est un peu plus grande qu'un Raspberry, mais elle est toute mimi quand même.
Pour sa petite taille elle est tout de même très puissante (bien plus que les raspi (même 4 non-throttlé).
Avec ses 4Go de ram, son vrai port Gigabit et son slot de mémoire eMMC elle n'a aucun goulot d'étranglement pour les perfs et fera donc un ptit serveur redoutable à la maison.

En plus niveau conception ils ont foutu le CPU sur la face inférieure du PCB où réside un radiateur enveloppant toute la board.
Elle est donc très bien refroidie d'autant plus qu'apparemment elle ne consomme que 5W au max.

|     |                               |
|-----|-------------------------------|
| SOC | AmLogic S922X                 |
| CPU | 4x 1.8GHz A73 + 2x 1.8GHz A53 |
| RAM | 4Go DDR4                      |
| NIC | Gigabit                       |
| Video Out | HDMI 2.0 4K/60Hz        |
| Stockage  | eMMC + MicroSD          |
| USB | 4x USB3.0 A + 1 Micro USB OTG |

Si vous voulez plus d'info, [le site officiel](https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram/) pourra vous aider.

Bon tout ça se paye… *elle vaut 120€* chez Kubii par exemple.
C'est plus cher que du Raspi mais c'est pas la même qualité ni les mêmes perfs.
Ça reste tout de même raisonnable.

J'ai récupéré un module d'eMMC que je n'utilisais plus et il reste plus qu'à y coller un OS dedans.

## ArchLinux

ArchLinux c'est l'artillerie lourde.
Beaucoup de main d'œuvre, des repos très bien fournis (surtout si on compte AUR).

ArchLinux existe pour beaucoup de <abbr title="Single Board Computer : les ordinateurs qui tiennent dans une seule petite carte comme les raspberry pi">SBC</abbr> dont la [N2](https://archlinuxarm.org/platforms/armv8/amlogic/odroid-n2).
Mine de rien c'est probablement la distro qui rush le plus pour proposer le support d'autant de board.
Merci à eux pour ça, beau boulot.

Bref, je suis leur méthode d'install et pouf au bout de 5 minutes ça marche.
Je SSH dessus et voilà ça tourne mais c'est tout tâché.
C'est rempli de saletés comme networkd, journald, dbus, … bref cet OS porte la marque du malin (L Pouet).

Je commence à confer Knot pour me faire un nouveau [slave DNS]({{< ref "/posts/143-slave-server-dns" >}}) à la maison.
Ensuite je passe à Postgres.
Et là je me dis qu'il serait ptet bon de faire la conf IP (oupsss j'y pensais plus).

BEURK mais quelle horreur networkd.
Non c'est bon j'en peux plus de cette merde.

## Alpine Linux
Alpine est ma ptite chouchou du moment.
Elle va remplacer Arch et fissa.

Le souci c'est que c'est une distro bien plus petite avec beaucoup moins de main d'œuvre et une communauté rikiki (mais super sympatique).
Bref le problème c'est qu'il ne propose pas d'install spécifique pour ma ptite N2…

Bon, on va filouter.
Je récupère l'eMMC, je l'enfiche dans l'adaptateur vers microSD.
Lui je le fous dans l'adapteur carte SD.
Et la carte SD je la fous dans le PC.
WCGW ?

Hop, je jarte la seconde partoche que je remplace par un *mini root fs* en *aarch64* de [chez Alpine](https://www.alpinelinux.org/downloads/).

J'enfiche l'eMMC sur la board, je branche un câble HDMI, un ptit clavier USB et le câble d'alim.

{{< img src="board-in-the-wild.thumb.jpg" link="board-in-the-wild.jpg" alt="Photo de mon bureau en bazar avec la N2, un clavier IBM Model M moddé en USB et tout un tas de trucs qui trainent" title="On pourrait en mettre cinq dans le clavier" >}}

Bon, bha en dehors du fait que le clavier est un poil handicapant (vim en qwerty sur clavier azerty où la touche shift gauche ne fonctionne pas et où il n'y a pas de touche échap ça devient folklorique).
Bref, faut faire la conf réseau à base de 

  - **<samp>ip a a 10.0.0.253/8 dev eth0</samp>**
  - la route avec **<samp>ip r a default via 10.0.0.254</samp>**
  - et ensuite les DNS avec **<samp>echo "nameserver 10.0.0.254" > /etc/resolv.conf</samp>**

Une fois tout ça fait on peut installer alpine-base qui permet d'installer à peu près ce qu'il faut. 

  - **<samp>apk update</samp>**
  - **<samp>apk upgrade</samp>**
  - **<samp>apk add alpine-base</samp>**
  - **<samp>setup-alpine</samp>**
  - Il suffit de suivre le guide désormais :-)

Voilà !
On a une alpine pleinement fonctionnelle !
Pleinement ?
Non, il reste une petite bidouille à régler: 
Il s'avère que j'ai copié *mini rootfs* d'alpine comme un sagouin et du coup toutes les commandes qui nécessitent de changer d'utilisateur déconnent !
**PERMISSION DENIED ! PERMISSION DENIED**
Ouai ouai on a compris.
Bref il m'a fallu faire un petit **<samp>chmod o+rx /</samp>** et tout est rentré dans l'ordre.

C'est quand même avec le kernel et l'initramfs d'Arch mais ça fonctionne.
D'ailleurs *il peut être sympa de récupérer les modules d'Arch pour les foutre sur l'Alpine*.

Pour ça, on va aller chercher [direct chez Arch](https://archlinuxarm.org/packages) avec les termes <samp>odroid-n2</samp>.
Là on choisit le paquet **linux-odroid-n2** et on le télécharge.

On détar le fichier ce qui va nous donner un *boot*,*etc* et *usr*.
Les modules sont planqués dans *usr/lib/modules/$version_du_kernel*.
On copie ça dans */lib/modules* de la n2 et c'est bon.
On peut modprobe l'un des modules (par hasard ipv6) et ça fonctionne \o/

D'ailleurs j'imagine que pour mettre à jour le kernel (ça sera rare tant qu'il n'y aura pas de kernel mainline (on croise les doigts, ça arrivera peut-être)), il suffira de récupérer le fichier *image* qui se trouve dans *boot*.

Voilà voilà pour le début des aventures de cette ptite SBC.


---------
**PS :** On me signale dans l'oreillette qu'ArchLinux ARM et ArchLinux sont en fait [deux projets proches mais distincts](https://wiki.archlinux.org/index.php/ARM).
Merci Breizh pour la remarque ;-)
