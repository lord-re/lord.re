+++
Author = "Lord"
Description = "Here is how to lock you /etc/resolv.conf in Openwrt"
Categories = ["tips", "adminsys","dns"]
menu = "main"
notoc = true
PublishDate = 2018-04-04T21:41:29+02:00
date = 2018-04-07T18:41:29+02:00
title = "Lock your /etc/resolv.conf in OpenWRT"
editor = "kakoune"
jdh = ""
+++
OpenWRT hate me and I hate it too !

Yes it's a weird intro but it's true.
Each time i need to edit any setting on their web interface i start cleaning the flat or find something else to do.
I'm used to managing classic Linux systems via SSH but I can't find anything in their system.

Even defining you DNS resolver is hard on their system.

Ma Internet connection is provided thanks to DHCP which means i get the IP settings _AND_ a DNS resolver.

Except, I don't need this service from my ISP as I already have my own resolver.
And this funny OpenWRT doesn't try to ease my pain.

<br>
So I SSH into the router and try the famous **chattr +i /etc/resolv.conf**.

    chattr: Operation not supported while reading flags on /etc/resolv.conf

O___o Dafuck !

Hoo it's a symbolic link to */tmp/etc/resolv.conf* .
Well … why not ?

So I try to chattr +i this file.

It fails too with the same error.

GRRRRRRRR I HATE NOT BEING ABLE TO DO WHAT I WANT ON MY DEVICES !

*Breathe*

**rm /tmp/etc/resolv.conf**

**rm /etc/resolv.conf**

*Breathe again*

**crontab -e**

    * * * * * printf "#SET VIA CRONTAB\nnameserver 10.2.0.1\nnameserver 10.2.0.2\n" > /etc/resolv.conf

We wait one minute.

If the file is right :

**chattr +i /etc/resolv.conf**

Here it is !

No more trouble.

As usual I fight against stranges choices from this linux distro but at least it's a Linux so you can fiddle with this !

This technique is « ceinture + bretelles » ( belt + braces ) but now I'm sure not to use my ISP's resolvers.
