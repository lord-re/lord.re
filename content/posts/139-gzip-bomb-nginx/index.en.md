+++
Author = "Lord"
Description = "Tired of seeing thousands of 404 erros in my access.logs of users trying to find php files to hack my server I wanted to fight back. I set up a Gzip bomb. Let's see how to set this up with Nginx but without PHP."
Categories = ["nginx", "adminsys"]
menu = "main"
notoc = true
PublishDate = 2018-11-09T15:29:10+01:00
date = 2018-11-11T15:29:10+01:00
title = "Setting a Gzip bomb in Nginx without PHP"
editor = "kakoune"
+++

I was browsing GoAccess to see which *404* errors i was serving.
There is more than 18.000 connections to *wp-admin.php* which is the webadmin of WordPress.
There is also many other attempts to different other php things, nothing very legit.

It's a chance i use **Hugo** which is a static site generator.
On this webserver there is no **PHP** or any other dynamic language.
Webpages here are only simple plain text files without any logic, the server just read the files and send them.

It's about time i wanted to block these attemps.

## Gzip Bomb
It's a pretty old and simple technic.
You create a fake file filled of zeros.
But it must be a _BIG_ file.
Big like multi-gigabyte file.
You compress your file with gzip and you'll have a way smaller file.

Web servers and clients can use compression natively (browsers at least can and most of scanners).
So *the main goal here is to serve this tiny compressed file so that the client (a scanner) will decompress this file which will use a lot of cpu power and/or a lot of RAM*.


## Setting it up in NGINX
There are a lot of examples for these kind of gzip bombs in **Nginx** but most of them relies on PHP.
A quick search in your favorite search engine and you'll find many results.
But I won't install PHP just for this.

You'll have to be smart.

### 1. Making the bomb
So let's create a 10GB file of zeros.
Then we will compress it in a 10MB file.

**<kbd>dd if=/dev/zero bs=1M count=10240 | gzip -9 > 10G.php</kbd>**

It can take a while (but not much).
Then you put it in the root of your webserver.

### 2. Setting the trap
Now let's edit our vhost in nginx : */etc/nginx/conf.d/lord.re.conf*

{{< highlight nginx >}}
location ~* \.php(/|$) {
	root /home/nginx/lord.re;
	try_files $uri /10G.php;
	types { text/html php; }
	add_header Expires "Wed, 11 Jan 1984 05:00:00 GMT";
	add_header Content-Encoding gzip;
}
{{< / highlight >}}

Here we add two HTTP headers mimicking Wordpress.
The second one tells the client the file should be decompressed.

The types line tells the client the file sent is just an html file so if it's a web browser, it will try to show you the file instead of just downloading it.

### 3. Profit !


## Wanna try ?

Just [see](https://lord.re/wp-login.php).
Web browsers don't react the same.
Web browsers don't react the same.
Some use a lot of CPU but not a lot of RAM, some will eat 10GB of RAM.

---------
Thanks to Fol for the changes to have a prettier nginx config.
