+++
Author = "Lord"
Description = "I just received a new computer at home : a little Odroid N2 which is an alternative to the famous Raspberry Pi while being way faster and more balanced."
Categories = ["sbc", "hardware","linux", "alpine"]
menu = "main"
notoc = true
PublishDate = 2019-08-01T17:48:08+02:00
date = 2019-08-02T09:48:08+02:00
title = "Adopting an Odroid N2"
editor = "kakoune"
+++
After the usual troubles with the french delivery services i now host a new board at home.


## Odroid N2
This little beast is a bit bigger than a Raspberry, but still cute.
Even if it's a small one, it's still powerful (way more than a raspi (even the 4 non-throttled).
With its 4GB of ram, a real Gigabit port and an eMMC slot, it doesn't have any performance hog and so can be a perfect home server.

It's so well made than they put a massive radiator on the backface which hosts the CPU.
It stays quite fresh and use no more than 5W at maximum.

|     |                               |
|-----|-------------------------------|
| SOC | AmLogic S922X                 |
| CPU | 4x 1.8GHz A73 + 2x 1.8GHz A53 |
| RAM | 4GB DDR4                      |
| NIC | Gigabit                       |
| Video Out | HDMI 2.0 4K/60Hz        |
| Stockage  | eMMC + MicroSD          |
| USB | 4x USB3.0 A + 1 Micro USB OTG |

You'll find more informations on [the official webpage](https://www.hardkernel.com/shop/odroid-n2-with-4gbyte-ram/).

Everything has a price… *you can find it at 120€* in Kubii.
It's more expensive than a raspi but the quality isn't the same and the perfs too.
I find it still quite reasonable.

I got an old eMMC module (from an odroid C2) to host the OS.

## ArchLinux
ArchLinux is a big one.
Lots of devs, big repos (especially if you count AUR).

ArchLinux supports many <abbr title="Single Board Computer à la Raspberry">SBC</abbr> like the [N2](https://archlinuxarm.org/platforms/armv8/amlogic/odroid-n2).
It may be the fastest linux distribution to support that many SBC.
Thanks to theme for all this work.

So, i followed their installation manual and 5 minutes later it worked.
I SSH into it and everything is smooth and all but it's a bit stained.
There is many dirty things like networkd, journald, dbus, … it wears the mark of the evil (L Tooting).

I start installing and setting up Knot to add a new slave DNS at home.
Then it's time to Postgres.
Then i remember to configure all the IP settings (i totally forgot).

EWWWWWWW, really ?
Networkd needs to run all the time to set a static IP ?!
Ok, time to wipe all this shit.

## Alpine Linux
Alpine is my crush du jour.
It's going to replace ArchLinux right fucking now.

As it's a smaller distribution with few devs and a way smaller community it doesn't natively support the N2…
Time to fiddle with this.

I got back the eMMC, i plug it in the microSD adapter.
I put the microSD adapter in the SD card adapter.
I plug the SD card in my workstation.
WCGW ?

I nuke the second partition (arch's rootfs) and I put a *mini root fs - aarch64*  from [Alpine](https://www.alpinelinux.org/downloads/).

I put back the eMMC in the board, i plug an HDMI, a "small" USB keyboard and the power cable.

{{< img src="board-in-the-wild.thumb.jpg" link="board-in-the-wild.jpg" alt="Picture of my desktop with lots of stuff lying around. A fat IBM model M keyboard modded to output to USB and the tiny N2 beside it." title="You could fit at least 5 N2 in the keyboard !" >}}

Well, if you ignore the fact that the keyboard isn't cooperating (vim in qwerty on an azerty keyboard where the left shift key doesn't work  and where there is no escape key, it gets a bit challenging).
So, here is the IP configuration :

  - **<kbd>ip a a 10.0.0.253/8 dev eth0</kbd>**
  - Setting the gateway : **<kbd>ip r a default via 10.0.0.254</kbd>**
  - and then the DNS resolver **<kbd>echo "nameserver 10.0.0.254" > /etc/resolv.conf</kbd>**

Once this is done, you'll be able to install everything you need.

  - **<kbd>apk update</kbd>**
  - **<kbd>apk upgrade</kbd>**
  - **<kbd>apk add alpine-base</kbd>**
  - **<kbd>setup-alpine</kbd>**
  - Just follow the guide from there :-)

And voilà !
We've got a flawless running Alpine !
Flawless ?
No, there is still a thing to work out :
When i copied the *alpine mini rootfs* like a noob so many commands requiring to switch to another user failed.
**PERMISSION DENIED ! PERMISSION DENIED**
Ok ok thanks but how to solve this ?
After half an hour i found it **<kbd>chmod o+rx /</kbd>** and now everything works fine.

I'm still running the Arch kernel and initramfs but it works fine.
By the way, *it can be handy to get arch modules and put them in Alpine*.

So, let's go to [in Arch's packages repos](https://archlinuxarm.org/packages) and search for <kbd>odroid-n2</kbd>.
There you'll find **linux-odroid-n2** and you download it.

You untar the file and you'll get three folders : *boot*, *etc* and *usr*.
Modules can be found is *usr/lib/modules/$kernel_version*.
You copy this in */lib/modules* in you n2 and it's good.
You can now modprobe any module (for example ipv6) and it's running. \o/

I didn't tested it but i think you'll be able to upgrade the kernel exactly like this (it won't be frequent as there won't be new kernel release before upstreaming (crossing fingers)) and move the *image* file from *boot* to the */boot* folder of the n2.

There there the beginning of N2's adventures.


