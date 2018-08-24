+++
Author = "Lord"
date = "2017-09-16T17:01:10+02:00"
title = "Unmount your root without reboot"
notoc = true
menu = "main"
Categories = ["software","tips","linux","cli","adminsys","fs","btrfs"]
Description = "How to unmount your root filesystem when your os runs on it ? Follow the guide"
publishDate = "2017-09-16T17:03:12+02:00"

+++
Don't you ever need to unmount your linux's root partition ? No ? Why ? hummmm I don't know ? maybe to do special things on the FS like resizing it or moving it to a new device ? You can't unmount it while you running OS resides on it. If you can't boot on a livecd (no more optical disk player) nor a thumbdrive (you've lost all of them like me) you're doomed ! If only we could unoumnt this shitty partition.

What if you can ? We live in wonderful times. It's possible and not so hard. Let's go !

## Turn off everything
To unmount your partition you'll first have to close any process using it. **lsof** will be your friend to find them. You can do this later but if downtime isn't a concern do it now.

If you have enough RAM you'll be able to restart services before it's done but it's a bit hackish especially if it alters your datas.

## Recreating a userland in your ram
You have to create a new working userland in a ramdisk. So we create a mount point (**mkdir /ramroot**) then we will create the ramdisk in (**mount -t tmpfs none /ramroot**).

Everything you'll put in */ramroot* won't be in your hard drive but in your ram.

Now there is two options : you can fit all your root partition in your ram (the easier) if not, you have to create a working userland from scratch (i won't tackle this part but you can help yourself with tools like debootstrap or using a stage3 from gentoo or any trustable userland from the internet).

So wee  **cp -ax /{bin,etc,sbin,lib32,lib64,lib} /ramroot** then to spare some ram **mkdir /ramroot/usr** then **cp -ax /usr/{bin,sbin,lib32,lib64} /ramroot/usr** . And voilà you have everything you want in your userpace !

Everything ? No. You need the "special mounts".

**mkdir /ramroot/dev /ramroot/sys /ramroot/proc** you will have your mounting folders. Now you have to populate them. You already have them on your hard drive so you can just bind them here. Just **mount --rbind /dev /ramroot/dev** then **mount --rbind /proc /ramroot/proc** and **mount -t proc none /ramroot/proc**. Perfect !

## Leap of faith
You have your marvelous userspace available in your ramdisk. We can now migrate ther.

First **mkdir /ramroot/oldroot** will be the new home to our hard drive root partition. We can now do the magic trick :

**pivot_root /ramroot /ramroot/oldroot**

It's okay ? You're still here ? Ok so it's done. You are inside you ramdisk. You can **unmount /dev/sda1** and admire your hard work.

You can do anything you want on the partition. You can take a break. It's relatively easy if you think about it.

## Coming back
You want to get back to your main partition without rebooting ? Easy : you **mount /dev/sda2 /old/root** and you **pivot_root /oldroot /oldroot/ramroot** and you're back.
