+++
Author = "Lord"
Description = "Let's play with btrfs snapshots"
date = "2013-04-02T23:09:14+02:00"
title = "BTRFS snapshots"
menu = "main"
Categories = ["software","adminsys","fs","btrfs"]

+++
My shiny Gentoo runs on BTRFS for some time now. This Filesystem is fun with all its features. One of its best features is the snapshotting system. It's my favorite :-) . An on-the-fly free instant backup. Isn't it a dream on this day of *World Backup Day* ? (it's been three days i know).

You should know that btrfs works with *subvolumes* (a bit like lvm) and you can snapshot a subvolume which will be a subvolume ! Yes it's awesome. So what you have to do is creating a partition whith btrfs on it and instead of installing your system on it, you should create a subvolume containing your system. As an example on my */dev/sda2* i have my btrfs partition. Inside i created a folder *gentoo* which is a subvolume. So my root is on */dev/sda2/gentoo*. I set the default subvolume of the fs to be the */gentoo* one, so when i tell grub to boot the btrfs partition it automagically boots the good one. No need to change grub or anything else.

Where the real fun begins is that now we will snapshot everytime we try something touchy. So you must **mount /dev/sda2 /mnt/btrfs -o subvolid=0**.  We now go to */mnt/btrfs/* and you can create a snapshot in one command : **btrfs subvolume snapshot gentoo gentoo02042013**.

Easy. Fast. Clean. It's why everyone loves this. If you want to go back to your snapshot you must first know which one you want to revert back. **btrfs subvolume list /** and now **btrfs subvolume set-default XX/.** And you're done you reboot and you can remove the original subvolume.

As simple as that. It can even be applied to other subvolumes like */home/* …
