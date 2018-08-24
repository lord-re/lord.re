+++
Author = "Lord"
Description = "My small wishlist of features or my dream softwares"
Categories = ["software", "cli"]
Tags = ["software", "cli"]
menu = "main"
notoc = true
PublishDate = "2017-11-22T15:08:53+01:00"
date = 2017-11-22T15:08:53+01:00
title = "My software wishlist : Vol1"
+++

Here's my 2017 letter to Santa Code. I don't think all my wishes will be answered but we never know…
<!--more-->

## ||| : Le magic pipe
You know what really grinds my gear ? I frequently open many terminal emulators. Often i connect to various remote boxes. Sometimes with multiple jumps. Even sometime on machines without Internet access (containers and VM accessed from the hypevisor).

Well. You just want to transfer a file between two of your terms… it's only spaced by some pixels on your screen but they can't connect each other !

*GRRRRRRRRRRR*

*Close your eyes.*

*Breathe slowly.*

*Hold back your tears.*

*Open a new tmux session.*

*Curse yourself.*

*Reconnect to your machines.*

*Struggle with tmux to write the scrollback buffer while praying it's big enough to fit everything you need.*

You see the mess. What I propose is : **cat my file |||** in one term and in another one **||| > my file**. It looks unrealistic, I know. But frankly : who wouldn't want this ? I could be done on **tmux's layer** or below, directly on the **terminal's level** (with a daemon or something else).

## OpenSSH Escape Sequence to initialize file transfert
As seen above i often connect to multiple remote machines with SSH. You are deep in you filesystem tree and you need to transfer a file. I keeps bugging me to have to open a new term to launch a *SCP* command.

My simple solution would be to create a new escape sequence in OpenSSH (you know ? Commands beggining with **~.** to disconnect or **~?** to see all commands available). For now, you can create a new tunnel or close one but that's more or less all you can do.

Adding **~u** and **~d** for example to upload or download a file in the actual connexion (it's permitted by the protocol itself). This feature exist in some obscure ssh client elsewhere but who doesn't use openSSH ?

## Learn to the linux kernel to scan devices before mounting a Raid BTRFS
I'm now a happy user of a RAID6 BTRFS (I am the DANGER, I am the one who loose all its data) but i had to create an initramfs to be able to mount the root filesystem. To mount a multi devices btrfs you must scan all the devices before doing it (**btrfs device scan**) and then you can mount your fs. The linux kernel could do it by itself but no :-(

