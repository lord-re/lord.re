+++
Description = "How to set microcaching on an nginx reverse proxy."
PublishDate = "2017-09-24T22:01:38+02:00"
notoc = true
menu = "main"
date = "2017-09-24T22:01:38+02:00"
title = "Leveraging nginx microcaching to boost your perf and prevent downtime"
Tags = ["www","software","adminsys","tips"]
Categories = ["www","software","adminsys","tips"]

+++
As I have a dedicated router now, find myself shutting down my server from time to time. My website (hosted on the server) keep on being accessible. On the router side, i installed a container with an nginx proxy server. Connections to the website goes throught it. It acts as a cache when the upstream server is down. But to always have up to date content I only use 1 second of cache.

## 1s cache
Yes yes, only one second is enough. In my use case it's a bit overkill but on heavier website with dynamic content and way more traffic it's clearly an excellent way to lessen the burden of your upstream server and to enhance your performances (more requests per seconds). In most use cases, serving a 1s old content won't be noticed so it's a good tradeoff.

If on top of that you add two/three options more you'll be able to prevent downtime (what i was looking for).

So, on the proxy server let's define **le_cache** which will be where we will store cached content : ```proxy_cache_path /var/www/cache keys_zone=le_cache:1m max_size=20m inactive=10d use_temp_path=off;```

Now on the proxy nginx we add the vhost in */etc/nginx/nginx.conf* :
```
server {
        listen 80;
        listen 443 ssl http2;
        server_name www.lordtoniok.com lordtoniok.com bender.lordtoniok.com www.lord.re lord.re bender.lord.re _;
        include ssl.conf;
        ssl_certificate /etc/ssl/acme/lord.re/fullchain.pem;
        ssl_certificate_key /etc/ssl/acme/private/lord.re/privkey.pem;
        location /.well-known/acme-challenge {
            alias /var/www/acme;
        }
        location / {
                proxy_cache le_cache;
                proxy_pass http://10.0.0.1;
								proxy_cache_lock on;
                proxy_cache_use_stale updating error timeout http_502 http_503;
                proxy_cache_valid 200 1s;
                add_header X-Cache-Status $upstream_cache_status;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
							#	proxy_buffering off;
        }
}
```
All the magic happens in ***proxy_cache_use_stale** which tolds your proxy to serve cached content when the upstream server is down or updating.

Now i can shut nginx off from the upstream server without no one noticing it. A bit liberating. The performance boost on dynamic site can also be measured with your favorite http load tester.


```proxy_buffering off;```  may be not suited for you but here is why i use it : when a fellow internet user try to download a big file from my server (more than a couple MB) it just doesn't work because the container is very ram constrained. If the file can't fit in ram, with proxy_buffering, it will write the file on disk. But my container is also heavily space constrained so it won't fit on the 20MB storage… So nginx can't work. By disabling it, nginx will just stream it on the fly, it won't be cached. I use it only on some part of my website.

