+++
Author = "Lord"
Description = "Explorons un peu l'utilisation de BTRFS avec du multi devices."
menu = "main"
date = "2014-02-16T23:28:35+02:00"
title = "Multi devices BTRFS"
Categories = ["linux","software","adminsys","tips"]
Tags = ["linux","software","adminsys","tips"]

+++
Étant malade ce week-end, quoi de mieux qu'un peu de machines virtuelles de BTRFS et de temps pour guérir ? Donc voilà en vue de la rénovation de mon système de stockage actuel j'ai commencé à faire mumuse avec BTRFS en mode multi-devices. Ce terme étrange signifie que l'on va avoir un système de fichier réparti sur plusieurs partitions/disque durs. Ça permet d'utiliser tous les raffinements de BTRFS. :-)

## LVM RAID à la poubelle
Ouai c'est provocateur mais j'ai pas peur de le dire. Cette nouvelle génération de système de fichier risque de rendre les quelques technos de transitions assez obsolètes. Le RAID logiciel a été inventé pour mimer le comportement des cartes hardware et au fur et à mesure a quelque peu évolué mais se retrouve pleins de défauts (vérifier la parité d'une grappe de disque de 4To c'est un poil long). LVM a été inventé pour apporter un peu de dynamisme dans la gestion des partitions afin de déplacer/modifier à la volée ces dernières. BTRFS mime ces deux technologies et même apporte des nouveautés bien sympas. Concernant le RAID : BTRFS permet de passer d'un mode (0, 1, 5, 6, 10) à un autre sans interruption (juste perte de perf passagère), il évite également le soucis du bitrot (je l'aborde plus loin) et se permet d'optimiser la vérif de parité en ne checkant que les partie utilisées ce qui permet d'énormément écourter le process. Pour LVM, là encore BTRFS fait tout pareil en permettant d'ajouter de nouveaux sous-volume, de passer de l'un à l'autre, ajouter de nouveaux disque-durs/partitions à la volée. Bon il est encore marqué comme experimental mais si personne ne se jette à l'eau il le sera ad vitam æternam.

## Multi-device : d'un RAID à l'autre
Commençons à faire mumuse. Dans la VM, on boot sur un liveCD qui va bien (sysrescueCD par exemple avec son kernel tout récent). On créer une partoche sur le skeudur puis on s'amuse à rajouter le second skeudur pour voir ce que ça fait.
```
mkfs.btrfs /dev/sda
mount /dev/sda /mnt/test
btrfs device add /dev/sdb /mnt/test/
btrfs filesystem show
… devid 1 … devid 2 …
```
Et hop là vous voyez vos deux devices pour un seul fs \o/. Bon ça n'émoustille pas grand monde en dehors de moi. Jusque là rien de bien magique. Commençons à raider ! Un ptit **btrfs filesystem df**.
Cet outil sert en théorie à voir l'espace disponible (df a quelques soucis avec btrfs). Il vous affichera également l'occupation du disque par les données, les metadata, le système (?) mais également comment sont stockées ces données (type de raid).
**btrfs balance start -dconvert=raid1 /mnt/test**

Et c'est parti pour la touillette magique. Donc là les données sont désormais en raid1 mais bon si on le fait pas pour les metadata, c'est pas terrible.

**btrfs balance start -mconvert=raid1 /mnt/test**

**btrfs filesystem df**
Et là ça y est on vérifie que tout est bien en RAID1
Et maintenant pour le fun on reboot avec un disque manquant.

En tentant de mount vous aurez une belle erreur vous poussant à regarder le dmesg. Donc on va monter manuellement en rajoutant l'option degraded et là ça se mount gentiemment. Donc le but du jeu ça va être de fouttre un nouveau disque dur pour reconstruire le raid. On remet un disque dur vierge, on boot, on mount manuellement.

**btrfs device add /dev/sdc /mnt/test**

**btrfs device delete missing /mnt/test**

Et voilà :-) On pourrait même s'amuser à le transformer en RAID0 en changeant les options. La modif est transparente (peut-être interrompue et relancée) et n'impacte que les perfs pendant la touillette magique.

## Bitrot
Le bitrot est l'altération des données par le système de fichier, l'appareil ou le bombardement cosmique. Le RAID traditionnel n'est pas protégé par cela. Dans un RAID classique si la donnée est altérée, rien ne le remarquera. Pire encore, l'erreur a de fortes chances de fouttre la merde et conduira probablement à un fichier merdouillé. BTRFS dans sa grande mansuétude vérifie l'intégrité des données et peut généralement corriger les erreurs. En VM c'est assez simple à tester. On choisit un des disques virtuel, on y change quelques bits par-ci par-là. Au boot, tout roulera. Dans dmesg on vera apparaître les erreurs qui seront alors corrigées.

