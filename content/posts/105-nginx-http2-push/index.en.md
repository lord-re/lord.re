+++
Author = "Lord"
Description = "How to benefit from HTTP2 new features from nginx ?"
Categories = ["www", "nginx","adminsys"]
menu = "main"
notoc = true
PublishDate = 2018-06-01T16:10:17+02:00
date = 2018-06-01T16:10:17+02:00
title = "Using HTTP2 and PUSH in nginx"
editor = "vi"
jdh = "https://www.journalduhacker.net/s/ph2eh1/utiliser_http2_et_le_push_avec_nginx"
+++
HTTP2 is a new revision of the famous <abbr="Hyper Text Transport Protocol">HTTP</abbr> wich improves many points from it's first version.

The first feature of HTTP2 is security as most of its implementations only works on top of <abbr title="Transport Layer Secure">TLS</abbr> which was only the case with HTTPS.

But on top of that, its performance were greatly increased.
HTTP was used for nearly 20 years before the work on its sucessor started which gives enough time to see where things were faulty and how to improves this.

## Optimizations

### Header compression
Some optimizations created lots of discussions and header compression was one of the main contributor to this.
PRO : you send less header datas
CON : you don't transfer text anymore but binary data

For informations, *a text protocol transmit only text-data* which is easy for a human to read and handle but harder for a computer.
Many people think a text-protocol isn't required anymore whereas other people continue thinking it's still a benefit.


### Multiplex
Another big point optizimed in HTTP2 is *data multiplexing*.

Before, each ressource fetched by the browser needed a request sent by the browser in a new TCP connection.
HTTP1.1 brought **PIPELINING** which allowed a browser to reuse an existing TCP connection to transmit multiple requests.
It was a huge gain.
But each ressource needed a new request from the browser with each time a new response.
Still better than before but sadly it wasn't used everywhere.

HTTP2 bring **Multiplex** which lets your browser ask for multiple ressources in only one request and the server can send them in only one response.

This new feature deprecated some hacks which became common good practices like *sharding* (using multiple subdomain to force the browser to create multiple parallel connections to speed up things).
Now, only one connection will be faster than multiple parallel connections (less TCP/IP overhead).

But there is more, it's the **PUSH**.

### Push-toi de là !
When a client ask for a ressource, the web server can now send the desired file but can also send other files the client will need.

The client will receive the files before even asking for them which will prevent the need for new requests.

But beware, if the server send useless files to the client, the client will drop the file and you would then consume more bandwith than what's required.

## And in the Engine X ?
### H2
To enable HTTP2, not much to do in you config.
In the <kbd>*server*</kbd> block you should have a <kbd>*listen*</kbd> line (or more).
Look for the port 443 and add <kbd>http2</kbd>.

That's all.
### PUSH
Nginx knows how to push since version *1.13.9* out in February 2018.

In a <kbd>*location*</kbd> block, where you want to push your content, you'll have to add a simple :

Bon du coup dans bloc de type <kbd>*location*</kbd>, depuis l'endroit où vous voulez pusher votre contenu, il va falloir rajouter un simple :

    http2_push /css/neodark.css;
    http2_push /favicon.ico;

And now your css file and your favicon will be pushed to every client.

If your website is simple it will be easy to implement, but you have a more complex one it can become very hard to manage.
But the great [vbrandl](https://github.com/vbrandl) will save you with its mighty [nginx conf generator](https://github.com/vbrandl/nginx-http2-push-generator).
You give him a webpage, which type of ressources you want to push and it will generate an nginx conf you just need to copy/paste it.

And to now make sure your nginx push ressources to your clients you can use chromium devtools which will show you (in performance) if the ressource comes from a request or a push.
Another way to test it is to go to [http2-push](https://http2-push.io) which let you enter an url and see what's pushed.

-----------
You can now reduce your loading times by some ms with this.
I use it since a few days and i didn't noticed any bandwith increase.

-----------
## PS :
Someone ( [Buzut](https://buzut.fr/)) signaled that with this simple config, nginx will push ressources to every clients even those who already have the ressources in their local cache.
It's possible to use a more complex config relying on a cookie to only push ressources when the cookie doesn't exist as shown on [this nginx article](https://www.nginx.com/blog/nginx-1-13-9-http2-server-push/#selective-push).
