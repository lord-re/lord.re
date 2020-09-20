+++
Author = "Lord"
Description = "Migration de mon routeur Turris Omnia de Turris OS 3 vers Turris OS 5. Quelques soucis avec LXC et le dhcp mais rien d'insurmontable (il parait)."
Categories = ["adminsys", "weekend","turris"]
menu = "main"
notoc = true
WritingDate = 2020-09-20T20:35:58+02:00
date = 2020-09-20T20:35:58+02:00
title = "Un peu d'adminsys vol.2 : Turris OS 5.X"
editor = "kakoune"
TopWords=["turris","omnia","routeur","backup","snapshot","btrfs","dhcp","schnapps","lxc"]
+++
Pour cette fin de week-end j'ai voulu mettre à jour un peu mon routeur/serveur.
Ça fait quelques mois maintenant que les versions 5 et 4 d'ailleurs sont sorties.
Mais je n'ai jamais pris la peine d'upgrader.

## 1. Snapshotter
Mon routeur est un **Turris Omnia** (je vous en ai [déjà parlé il y a maintenant 4 ans]({{< ref "posts/44-turris-omnia" >}})) il tourne donc sous un dérivé d'**OpenWRT**.
Mais avec les versions à partir de la 4 ils sont revenus sur le vrai OpenWRT au lieu de leur fork.
La migration contrairement aux sous-versions n'est donc pas automatique et peut poser quelques soucis.

Du coup dans ce genre de cas la première chose à faire est un backup.
Mais comme c'est super bien foutu, le système se trouve sur une partition BTRFS sur laquelle on peut faire des snapshots.

Donc on se connecte en SSH, et on lance <kbd>schnapps list</kbd> qui vous listera tous les snapshots.

<details><summary>voilà ce que ça vous sort</summary>

root@turris:~# schnapps list
    # | Type      | Size        | Date                        | Description
------+-----------+-------------+-----------------------------+------------------------------------
   60 | rollback  |   795.57MiB | 2018-03-13 19:15:40 +0000   | Rollback to snapshot 59
  222 | pre       |    16.09MiB | 2020-04-08 05:29:36 +0200   | Automatic pre-update snapshot
  223 | post      |     9.98MiB | 2020-04-08 05:29:51 +0200   | Automatic post-update snapshot
  232 | pre       |     9.98MiB | 2020-06-04 13:51:57 +0200   | Automatic pre-update snapshot
  233 | post      |     9.99MiB | 2020-06-04 13:54:47 +0200   | Automatic post-update snapshot
  241 | pre       |    10.00MiB | 2020-07-23 20:34:07 +0200   | Automatic pre-update snapshot
  242 | post      |     9.99MiB | 2020-07-23 20:35:47 +0200   | Automatic post-update snapshot
  247 | time      |     9.99MiB | 2020-08-23 01:05:02 +0200   | Snapshot created by cron
  248 | time      |     9.99MiB | 2020-08-30 01:05:03 +0200   | Snapshot created by cron
  249 | pre       |     9.98MiB | 2020-08-31 20:05:38 +0200   | Automatic pre-update snapshot
  250 | post      |     9.98MiB | 2020-08-31 20:07:02 +0200   | Automatic post-update snapshot
  251 | time      |    10.00MiB | 2020-09-06 01:05:02 +0200   | Snapshot created by cron
  252 | pre       |     9.98MiB | 2020-09-07 16:11:27 +0200   | Automatic pre-update snapshot
  253 | post      |     9.97MiB | 2020-09-07 16:11:37 +0200   | Automatic post-update snapshot
  254 | time      |     9.99MiB | 2020-09-13 01:05:02 +0200   | Snapshot created by cron
  255 | time      |     9.99MiB | 2020-09-20 01:05:02 +0200   | Snapshot created by cron
  256 | single    |   128.00KiB | 2020-09-20 17:02:53 +0200   | avant update to 5
  257 | pre       |   112.00KiB | 2020-09-20 17:20:05 +0200   | Automatic pre-update snapshot
  258 | rollback  |   146.29MiB | 2020-09-20 17:51:07 +0200   | Rollback to snapshot 257
  259 | pre       |   136.00KiB | 2020-09-20 17:55:21 +0200   | Automatic pre-update snapshot
  260 | rollback  |   146.14MiB | 2020-09-20 18:13:19 +0200   | Rollback to snapshot 259
  261 | pre       |   132.00KiB | 2020-09-20 18:43:07 +0200   | Automatic pre-update snapshot
  262 | single    |     4.00KiB | 2020-09-20 19:09:32 +0200   | tos 5 mais non fonctionnel
  263 | rollback  |     4.00KiB | 2020-09-20 19:09:50 +0200   | Rollback to snapshot 261
  264 | rollback  |   132.00KiB | 2020-09-20 19:12:21 +0200   | Rollback to snapshot 262
  265 | rollback  |   196.00KiB | 2020-09-20 19:20:44 +0200   | Rollback to snapshot 261

</details>


La première colonne donne un numéro d'ID qui sert à identifier un snapshot.
Ensuite on a le type : 

  - <samp>rollback</samp> : c'est un retour arrière
  - <samp>pre</samp> : c'est avant une update
  - <samp>post</samp> : c'est après une update
  - <samp>time</samp> : un snapshot automatisé à telle date
  - <samp>single</samp> : un snapshot créé manuellement par l'utilisateur

Enfin on retrouve la taille du snapshot en lui-même (vous voyez que ça ne bouffe pas grand-chose) et enfin la date et une description.

Donc pour créer un snapshot on fait un ptit <kbd>schnapps create "Mon snapshot favoris"</kbd> et voilà quelques secondes plus tard c'est bon.

## 2. Mettre à jour

Bon pour lancer l'upgrade on peut soit passer par l'interface web et se rendre dans le menu qui va bien et cocher la mise à jour en version 5.x .
Ou alors vu qu'on est déjà connecté par ssh lancer <kbd>pkgupdate</kbd> et ensuite confirmer à chaque montée de version.

Ça prend moins de cinq minutes.

## 3. Update syntaxe LXC

Sur le routeur j'ai quelques containers LXC.
Lors du changement de version LXC a aussi été mis à jour et la syntaxe a légèrement changé.
Par chance, un script est venu et a touillé la conf et a créé des nouveaux fichiers de configs avec la bonne syntaxe.

Il faut donc se rendre dans */srv/lxc/$NOM/* et là vous trouverez votre fichier *config* ainsi qu'un *config.lxc1* .
Je vous conseille de garder le *config* en backup en le renommant *config.BAK* par exemple et de renommer avec <kbd>mv config.lxc1 config</kbd> et hop.

Ça va c'est facile.

## 4. Pourquoi j'ai plus accès au net ?
Au reboot, je n'ai plus accès au net sur ma machine.
Je ping bien le routeur mais pas plus loin.

Ma connexion à la maison est en fibre de chez Orange avec donc du DHCP avec quelques options un peu exotiques.

Visiblement au changement de version le client dhcp a connu quelques modifs.
J'ai vérifié le fichier de config */etc/config/network* et tout semble bon.

En listant les processus avec <kbd>ps | grep dhcp</kbd> j'obtiens un 
<samp>udhcpc -p /var/run/udhcpc-eth1.832.pid -s /lib/netifd/dhcp.script -f -t 0 -i eth1.832 -x hostname:turris -V sagem -C -B -O 0x01 -O 0x15 -O 0x28 -O 0x51 -O 0x58 -O 0x59 -O 0x90 -x 0x4D:2b46535644534c5XXXXXXXXXXXXXXXXXx -x 0x5a:00000000000000XXXXXXXXXXXX -O 212 -O 121</samp> (j'ai planqué les parties sensibles).

Pas de bol pour moi je ne sais pas exactement quelle était la commande lancée sur l'ancienne version.
Mais visiblement je n'ai pas de réponse de la part du serveur DHCP même en lançant manuellement sur la bonne interface réseau.
Faut vraiment que j'aille voir ce qu'il y avait avant.

Je fais un ptit snapshot via <kbd>schnapps create "Turris 5 sans net"</kbd>

## 5. Rollback
Bon bha pour aller voir je fais un retour en arrière avec <kbd>schnapps rollback XXX</kbd> puis <kbd>reboot</kbd>.
Trente seconde plus tard, pouf !
J'ai accès au net.

Ça rassure instantannément.
Je regarde la commande et je compare et effectivement ce n'est pas la même !
<samp>udhcpc -p /var/run/udhcpc-eth1.832.pid -s /lib/netifd/dhcp.script -f -t 0 -i eth1.832 -V sagem -C -B -O 0x01 -O 0x15 -O 0x28 -O 0x51 -O 0x58 -O 0x59 -O 0x90 -x 0x4D:2b46535644534c5f6c697665626fXXXXXXXXXXXXXXXXXXXX -x 0x5a:000000000000000000000XXXXXXXXXXXXXXXXXXXX -O 212</samp>

On voit qu'il n'envoie pas son *hostname*, et il n'envoit pas non plus l'*option 121*.

Bon bha me reste plus qu'à retourner sur le snapshot en Turris OS 5 !

<kbd>schnapps rollback XXX</kbd> suivi d'un <kbd>reboot</kbd>

## 6. Avec l'ancienne ça marche
Une fois de retour sur Turris OS 5, je copie colle la commande issue de Turris OS 3.
Et …

…

… bha ça marche pas o__O.

## 7. Savoir capituler
J'ai passé près de deux heures à chercher un peu pourquoi ça déconnait mais j'ai pas trouvé.
Du coup bha je suis toujours en version 3 et tant pis pour le moment.

