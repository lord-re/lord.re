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
Hi everybody, it's been a while since i wrote about linux-thingies !
Today lets's talk about **BTRFS**.

I migrated to this filesystem 8 years ago even if every websites claimed it was unstable and probably dangerous to use it.
It's not the fastest fs but it's packed with many exciting features.
It can used as [multi devices RAID]({{< ref "posts/34-multi-devices-btrfs" >}}), you can create [snapshots]({{< ref "posts/30-snapshots-btrfs" >}}) or what's interesting me today : compressing your files on the fly.

I felt a bit constrained those last days because i played with a lot of data.
My SSD was getting quite full so i decided to enable compression.

To enable it you just have to edit you */etc/fstab* to add the right flag with <code>-o compress=zstd</code>.

<details><summary>/etc/fstab</summary>
/dev/nvme0n1p2		/		btrfs		noatime,ssd,compress=zstd,subvolid=258	0 1
</details>

On my computer i use a special trick where i mount my partition directly in my initramfs so i edited my init script and regenerated a new initram and it was ok.
If you are interested in this trick I wrote [an article (in french)](https://lord.re/posts/176-creer-initramfs-manuellement/) 

Thanks for your attention see you in six months for a new blogpost about sysadmin.
Ho crap, this joke doesn't work on text… you can see the following :-/

If you only do this, only new files will be compressed not those already here.
Still, it's possible to force compress your existing file by defragmenting and specifying the compression algorithm.
To do this just type <kbd>btrfs fi defragment -r -v -czstd /</kbd> and wait.
On my good old machine with ~500GB of random files it took half an hour.

You probably wonder how many GB you won.
You can use **compsize** with <kbd>compsize / -x | col</kbd> .

<details><summary>Here's what you'll see</summary>
<pre>
Processed 3122501 files, 3855886 regular extents (3889347 refs), 1632215 inline.
Type	   Perc	    Disk Usage	 Uncompressed Referenced
TOTAL	    77%	     376G	  486G	       490G
none	   100%	     221G	  221G	       222G
zlib	    41%	      21M	   52M		52M
zstd	    58%	     154G	  264G	       268G
</pre>
Some files are still in zlib but most of them are in zstd format.
My 486GB only take 376GB… good savings !
</details>

It eats a tiny bit of CPU but it's a bit faster (can't really tell the difference honestly) because your disk needs to work a bit less.
The difference would probably appear on a benchmark but i don't really care, what's matter is my feeling(s).
