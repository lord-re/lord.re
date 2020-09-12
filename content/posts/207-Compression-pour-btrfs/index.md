+++
Author = "Lord"
Description = ""
Categories = ["btrfs", "linux","adminsys"]
menu = "main"
notoc = true
WritingDate = 2020-09-12T11:14:13+02:00
date = 2020-09-12T11:14:13+02:00
title = "Compression BTRFS"
editor = "kakoune"
TopWords = ["zstd","btrfs","compression","zlib"]
+++

Coucou les gens, ça fait longtemps qu'on a pas causé linuxeries !
Aujourd'hui on va parler un ptit peu **BTRFS**.

Ça fait 8 ans que j'utilise ce système de fichiers maintenant malgré les mauvaises langues qui continuent de colporter que ce n'est pas stable/utilisable blabla.
C'est pas le plus rapide, mais il a tout un tas d'atout dans sa poche.
Il permet d'avoir du [raid]({{< ref "posts/34-multi-devices-btrfs" >}}) ou bien de faire des [snapshots]({{< ref "posts/30-snapshots-btrfs" >}}) ou bien (et c'est ce qui m'intéresse aujourd'hui) de compresser les fichiers à la volée.

Je me sentais un poil à l'étroit ces derniers jours, car je fait un peu mumuse avec des données qui prennent pas mal de place.
Donc allez pourquoi pas enfin m'y mettre.

Donc pour activer la compression il suffit de modifier votre fichier */etc/fstab* pour ajouter à votre point de montage l'option de compression <code>-o compress=zstd</code>.
<details><summary>exemple de /etc/fstab</summary>
/dev/nvme0n1p2		/		btrfs		noatime,ssd,compress=zstd,subvolid=258	0 1
</details>

Dans mon cas c'est un poil particulier, je monte ma partition directement dans mon initramfs.
J'ai donc modifié mon script d'init et regénérer mon initram et c'est bon.
Si ça vous intéresse j'ai [tout détaillé dans cet article]({{< ref "posts/176-creer-initramfs-manuellement" >}})

Voilà merci de votre attention, à dans six mois pour un prochain article d'adminsys.
Ha merde cette blague ne marche pas en texte… vous voyez déjà la suite :-/

Bref, si vous ne faites que ça, seuls les nouveaux fichiers seront compressés mais pas les existants.
Il y a cependant moyen de forcer la compression des anciens fichiers en défragmentant et en indiquant qu'on veut compresser.
On peut faire ça avec <kbd>btrfs fi defragment -r -v -czstd /</kbd> et hop c'est parti pour un moment.
Pour info sur ma machine avec 486Go de fichiers ça a pris environ 30minutes.

Ensuite, vous aurez très probablement envie de savoir combien de place vous avez gagné.
Et c'est là que le ptit programme **compsize** vous aidera avec <kbd>compsize / -x</kbd>

<details><summary>Voilà ce que ça va vous pondre</summary>
<pre>
Processed 3122501 files, 3855886 regular extents (3889347 refs), 1632215 inline.
Type	   Perc	    Disk Usage	 Uncompressed Referenced
TOTAL	    77%	     376G	  486G	       490G
none	   100%	     221G	  221G	       222G
zlib	    41%	      21M	   52M		52M
zstd	    58%	     154G	  264G	       268G
</pre>
Vous remarquerez que j'ai des fichiers en zlib et d'autres en zstd.
Et surtout on voit que mes 486Go ne font désormais plus que 376Go… belle économie, hein ?
</details>

Bon ça bouffe un peu de CPU mais c'est assez minime et il parait que c'est un poil plus rapide quand même vu qu'il y a moins de données à lire.
À l'œil nu, j'ai pas senti la différence mais j'imagine qu'un benchmark révèlerait des différences.
