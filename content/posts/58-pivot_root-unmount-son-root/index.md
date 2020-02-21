+++
Author = "Lord"
date = "2017-09-16T17:01:10+02:00"
lastedit = "2019-06-10T13:44:23+02:00"
title = "Unmount son root sans reboot"
notoc = true
menu = "main"
Categories = ["software","tips","linux","cli","adminsys","fs","btrfs"]
Description = "Comment faire pour démonter sa partition racine alors que votre OS tourne dessus ? Allez suivez le guide."
publishDate = "2017-09-16T17:03:12+02:00"
jdh = "https://www.journalduhacker.net/s/bq5ezx/unmount_son_root_sans_reboot"
TopWords = [  "ramdisk", "mkdir", "pivot_root", "mount", "oldroot", "partition", "proc", "racine", "ram", "ramroot"]
+++

Vous avez jamais voulu démonter la partition racine de votre ptit nunux ? Non ? Pourquoi faire ?! Bhaa je sais pas moi, par exemple faire des opérations sur votre partition racine (redimensionner/changer le filesystem/réparer le fs). Sauf que bon en temps normal vous ne pouvez pas démonter la partition racine puisque votre OS est sur cette partition.

Par chance, nous vivons dans une époque merveilleuse où l'on possède tous pas mal de Giga de ram ce qui rend l'opération possible et même assez simple. Allez on y va !

## Couper tout ce qui tourne
Pour pouvoir démonter votre partoche il va falloir couper tous les processus faisant des accès disques (lsof va être votre ami). Cette étape peut être faite au tout dernier moment avant le grand saut pour impacter le moins possible l'uptime de vos services.

Si vous avez suffisamment de ram vous pouvez même vous débrouiller pour ne pas couper ou juste relancer les processes mais c'est un poil plus touchy. Surtout si vous avez des données qui sont susceptibles d'être modifiées pendant que ça tourne.

## Recréer son userland en ram
Bon donc le but du jeu ça va être de se créer une partition racine mais dans la ram. Donc déjà première étape, on se créer un point de montage **mkdir /ramroot** et ensuite on y monte du tmpfs avec **mount -t tmpfs none /ramroot** .

Là ça y est, tout ce que vous collerez dans */ramroot* ne sera pas sur votre skeudur mais dans votre ram.

Là, deux choix s'offrent à nous : votre partition racine peut être contenue dans votre ram (c'est le plus simple) ou bien vous n'avez pas assez de ram et du coup va falloir recréer de 0 ( j'aborderai pas ce point mais en gros soit vous ne prenez que le strict nécessaire de votre rootfs, soit vous n'avez qu'à pécho un rootfs sur les interwebz ).

Bon donc **cp -ax /{bin,etc,sbin,lib32,lib64,lib} /ramroot** puis pour s'économiser de la ram **mkdir /ramroot/usr** suivi de **cp -ax /usr/{bin,sbin,lib32,lib64} /ramroot/usr** . Voilà on a tout l'userspace !

Tout ? Non. Il manque plus que les montages "bizarres".

Bon bah **mkdir /ramroot/dev /ramroot/sys /ramroot/proc** pour créer les points de montage. Par contre là vu que ça existe déjà sur votre disque dur,  on va juste "binder" avec **mount --rbind /dev /ramroot/dev** puis **mount --rbind /proc /ramroot/proc** et **mount -t proc none /ramroot/proc** et là c'est tout bon.

## Le grand saut
Bon bah vous avez un bien bel userspace de dispo dans votre ramdisk. On peut donc se décider à migrer dedans.

Premièrement **mkdir /ramroot/oldroot** va accueillir notre skeudur. Et maintenant la commande miraculeuse.

**pivot_root /ramroot /ramroot/oldroot**

Et là votre racine est désormais votre ramdisk. Maintenant vous pouvez **umount /dev/sda2** et admirer votre dur boulot.

Vous pouvez faire ce que vous vouliez faire désormais. C'est beau, hein ? Au final c'est diablement simple et super efficace.

## Revenir
Vous voulez revenir sans rebooter ? Easy vous n'avez qu'à **mount /dev/sda2 /oldroot** et enfin **pivot_root /oldroot /oldroot/ramroot** et pouf vous voilà hors de votre ramdisk de retour sur votre partoche.

## Troubleshoot
Il est possible que le **pivot_root** échoue en sortant un maigre *invalid argument*.
Cela peut venir non pas de la commande elle même mais du montage de votre racine initiale.

Pour voir si ça vient bien de là un petit <samp>grep -iP '/ /\s' /proc/$$/mountinfo</samp>.
Si vous voyez un petit *shared* qui apparait, il faut lancer la commande **<samp>unshare -m</samp>** et c'est bon le pivot_root passera.
