+++
Author = "Lord"
Description = "Six months later here a little feedback about the reverse proxy on my blog."
Categories = ["meta","nginx", "www", "adminsys", "software"]
draft = false
menu = "main"
notoc = true
PublishDate = 2018-03-01T10:55:02+01:00
date = 2018-03-01T10:55:02+01:00
title = "Reverse proxy, 6 months later"
editor = "kakoune"
+++

Last september i wrote about [setting up an nginx micro-cache in reverse proxy]({{< ref "/posts/60-cache-proxy-nginx" >}}), so here i a little feedback.

Since then i didn't changed the settings excepting the caching duration which i increased to *10 minutes*.

On the maintenance side, nothing to do.
Everything works fine on its own.
Sometime I want to clear the cache manually to try some edits without waiting cache expiration.
In those case a little **rm /var/www/lecache/\*** and it's done.

I didn't mentionned it in the first post but the cache is on a *tmpfs* (so in RAM) instead of the disk.
It's a bit faster and it spares the NAND from the host.
I allocated only 100MB which is more than enough in my case to host my entire blog (i only need 12Mo for now).


## Little reminder on how it works

The **client** (you the reader) requests a webpage.

The **reverse proxy** receive the request and consults its cache.
If thea page isn't there or is outdated, it reaches the **upstream** to get the page.

The proxy receives the page from the upstream and transmits it to the client and stores it in its cache.

While the cache doesn't expire, the reverse proxy won't contact the upstream server.

## How do I collect stats from my site ?

You may have noticed my site is quite … minimalist.
*It displays well in console web browsers so i hope it also works well with screen readers.*
Excepting some rare blogposts with images, a page only need 3 requests to render properlx : one for the webpage, one for the CSS and a last one for the optionnal favicon.

Iç don't use javascript nor fake 1px images to track visitors.

I only read the logs from the webserver.
I use [GoAccess](https://goaccess.io) which gives a beautifull TUI with some stats.
It's way more basic than Google Analytics or Piwik but I don't need more.

It's just a personnal blog.
I only write for my own pleasure even if it's pleasing to learn that people read it.

## Reverse proxy impact on the upstream server

My upstream server is a small [Atom D510 from 2011]({{< ref "15-migration" >}}) which could take the load without troubles.

The reverse proxy is a smaller machine.
It's a LXC container on a Turris Omnia.

To see the impact of the reverse proxy, the easiest way is to compare the nginx logs from the upstream and proxy servers.

I see **clear difference** (it's even clearer since I changed from 1s to 10minutes).

During “little days” the difference is quite small but during “big days” **the proxy provides more or less two third of the traffic** without reaching the upstream. 

I now can stop the upstream server while the website keeps being served by the turris (the spof is now the turris).

## Numbaz !

Here is February :

|               | Upstream  | Proxy |
|---------------|----------:|------:|
|Total requests |      56389| 131813|
|Unique Visitors|      12848|  19894|
|Log Size       |     9.93MB|22.61MB|
|Bandwidth      |    4.35GiB|7.55GiB|
