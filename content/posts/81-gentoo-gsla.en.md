+++
Author = "Lord"
Description = "Small introduction to GLSA. It's a team from Gentoo, but also a command to patch your system against security breaches."
Categories = ["linux", "gentoo","sécu"]
menu = "main"
notoc = true
PublishDate = 2018-03-06T23:02:14+01:00
date = 2018-03-06T23:02:14+01:00
title = "GLSA from Gentoo"
editor = "kakoune"
+++
I realized I never talk about Gentoo on my blog.
It's by far the best Linux distribution.

Instead of trolling, Gentoo is good because (but not limited to) you can quickly check if your system is vulnerable to a known security breach.

## GLSA

Gentoo isn't a giant distro with lots of devs but is still pretty  well staffed.
There are multiple dev teams with different focus with one dedicated to security.
This team publish security reports called [GLSA](https://security.gentoo.org/glsa/) wich stands for Gentoo Linux Security Advisories.

These are regularly published and lets you being informed about new breaches in multiple softwares provided throught portage.
To read them their are multiple ways.
I follow [their RSS feed](https://security.gentoo.org/glsa/feed.rss) with [Nib]({{< ref "/posts/66-nib-irc-bot.en.md" >}}).

## GLSA-Check

But to be sure i use **glsa-check** which is a small tool in **gentoolkit** (a set of tools to use in Gentoo).

A little ```glsa-check -l``` (one a day) will list all the known vulnerabilities affecting your system. 
If it find anything, you can also get more info thanks to ```glsa-check -d XXXXX-XX```.
You'll know when this vulnerability was discovered, which packages are affected in which version, what's the impact and how to fix it.

Then you can directly ```glsa-check -f XXXXX-XX``` to fix the vulnerability by itself.
It will often just upgrade a package or two to the right version.

This small tool isn't very popular but it is very efficient and fast.
It won't replace a sane updating policy but it will let you get enough information on a running system.
Keep on **emerge -uDnav @world** regularly.

By the way, if you want to add another interesting feed to you rss aggregator, Debian publish their [DSA](https://www.debian.org/security/dsa).
