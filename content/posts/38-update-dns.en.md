+++
Author = "Lord"
menu = "main"
Categories = ["adminsys","réseau","tips","dns"]
Tags = ["adminsys","réseau","tips","dns"]
Description = "How to dynamically update your DNS records without editing the zone file. Locally or remotely."
date = "2015-03-31T12:10:30+02:00"
title = "Dinamycally updating your DNS zones"

+++

A small blog post to me. How to dynamically update DNS zones with this shitty syntax i forget everytime ? To change a A record :
```
server 127.0.0.1
zone lord.re.
delete lord.re A
update add lord.re. 600 A a.b.c.d
send
```
Easy but so forgettable. You can put all this in a file and take **nsupdate** to eat it or type it interactively. To do it remotely you'll have to generate and use crypto keys.
Other examples for NS
```
server 127.0.0.1
zone lord.re.
update add lord.re. 3600 NS zapp.lord.re
```
Example for SOA records
```
server 127.0.0.1
zone lord.re.
update add lord.re. 3600 SOA zapp.lord.re. lord.lord.re. 2015033100 3600 7200 3600 180
```
And voilà ;-)
