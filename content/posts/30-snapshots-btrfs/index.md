+++
Author = "Lord"
Description = ""
date = "2013-04-02T23:09:14+02:00"
title = "Les snapshots BTRFS"
menu = "main"
Categories = ["software","adminsys","fs","btrfs"]
TopWords = [  "ouais", "partoche", "sda2", "subvolume", "snapshot", "dossier", "gentoo", "btrfs", "volume"]

+++

Voilà un petit moment que ma petite Gentoo perso est sur BTRFS.
Ce système de fichier est très sympathique de part toutes ses fonctionnalités.
Une que j'affectionne tout particulièrement est le *snapshot*.
Une sauvegarde à chaud, instantanée et qui ne bouffe quasiment pas de place.
C'est ti pas la panacée en ce *world backup day* (ouais bon c'était il y a trois jours je sais) ?

Donc le truc à savoir avec BTRFS c'est qu'il fonctionne en sous-volume (un peu comme LVM) et qu'il permet donc de faire un snapshot d'un sous-volume qui sera lui-même un sous-volume !
Ouais ça en jette.
Donc typiquement le truc à faire c'est de se créer une partoche BTRFS, et au lieu d'y foutre son système, c'est d'y créer un sous-volume avec son système.
Par exemple sur mon /dev/sda2 j'ai ma partoche BTRFS.
Dedans j'y ai créé un dossier «gentoo» qui est en fait un sous-volume.
Donc en vrai ma racine est */gentoo* et non */* .
Je définis le dossier */gentoo* comme étant le sous-volume par défaut.
Donc si l'on ne spécifie rien et que l'on **<kbd>mount /dev/sda2</kbd>** on montera en réalité le dossier gentoo.
Comme ça, même pas besoin de tripoter grub ou autre (bien que ce soit tout de même recommandé).

Bon jusque-là, rien de bien terrible.
Mais là où ça devient fun c'est qu'on peut maintenant snapshotter comme un petit goret.
Pour cela il faut monter la partoche BTRFS et non un sous-volume (ni même celui défini par défaut).
Donc un petit **<kbd>mount /dev/sda2 /mnt/btrfs -o subvolid=0</kbd>** fera l'affaire.
On va dans le dit dossier pour y retrouver un bête dossier Gentoo.
Et là on snapshot avec **<kbd>btrfs subvolume snapshot gentoo gentoo_02042013</kbd>**.
Bon, bha voilà.

Ouai vous vous dites ça fini un peu vite cette histoire.
C'est justement pour ça que c'est beau.
C'est simple, rapide et ça marche.
Enfin ça marche… Il faut être capable de l'utiliser.
Pour cela rien de particulier à faire à part éventuellement le foutre par défaut avec deux commandes.
Il faut d'abord trouver quel est son numéro **<kbd>btrfs subvolume list /</kbd>** et ensuite **<kbd>btrfs subvolume set-default XX /.</kbd>** Ouais c'est super simple aussi.
Et ensuite pour supprimer le sous-volume un <kbd>rm</kbd> suffit ou alors passer par la commande prévue pour…

Donc voilà, c'est quand même bien simple.
Là j'ai parlé du cas particulier du sous-volume par défaut mais ça marche pour n'importe quel sous-volume pour un montage séparé comme par-exemple */home* .
Sur ce, bonne léthargie.
