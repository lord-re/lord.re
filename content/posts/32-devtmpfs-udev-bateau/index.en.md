+++
Author = "Lord"
Description = "Post-Mortem following an electricity outage."
date = "2013-07-07T23:16:41+02:00"
title = "Devtmpfs and Udev are on board of a boat"
menu = "main"
Categories = ["meta","www","gentoo","linux","software"]
Tags = ["meta","www","gentoo","linux","software"]

+++
I've been awakened this morning by an electricity outage. A sunday morning at 6'o'Clock listening to Uninterruptible Power Supply (UPS) babbling. Each beep more and more oppressing. One beep closer to death. An interesting race : which UPS will last longer ? Suspens ! **Team TV** (ONT, media player, TV) or **Team Server** (server) or **Team Computers** (two computers, switch, wifi AP). Sadly **Team Server** fell first. The two other teams are waiting silently while listening to awakening cicadas. Well enough poetry. The server's uptime fell from 200 to 0. And here comes troubles. These 200 days where full of upgrades… maybe of on them was too much.

## Doctor Root
After getting two more sleeping hours thanks to the fan's hardwork (thanks EDF) i wake up and try naively to connect to the server. **NOPE**. A little ping. **YEP**. So I'll have to ssh myself in. **NOPE**. Well. I'm out of my own server. Let's send two spies : knight *ssh -v* and knight *tcpdump*. **NOPE** nothing. I have to plug a keyboard and monitor.

## Diagnostic : fickling Udev 
When the kernel boots it does a lot of thing. Then the trusty OpenRC does its jobs until the perfid udev stabs it in its back. You know, udev, the magic software which does too much things concerning the hardware. Udev now complains about the lack of **DEVTMPFS** in the kernel. I really thought i had it in place for a long time. I must boot a livecd. But i don't network anymore, nor any CD/DVD player and no thumbdrive.

## Open Openrc surgery
So you boot, you then spam the **I** key. You'll be in the *interactive mode* on OpenRC. You'll be prompted what to do about each service. I promptly ask to get a shell. Once done, i switch the keyboard layout to azerty (**loadkeys fr**). It strangely works nicely, even if nothing is started. I **mount -o rw /** to be able to write on the filesystem then i rush to */usr/src/linux* and compile a new kernel with **DEVTMPFS support**. And a last reboot to enjoy a sunny summer sunday…

