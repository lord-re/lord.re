+++
Author = "Lord"
Categories = ["software","tips","www"]
Tags = ["software","tips","www"]
date = "2013-10-27T23:21:23+02:00"
title = "IP Proxy Logs Nginx Reverse"
Description = "How to have the real Client IP Address in nginx logs when you are behind a reverse proxy ?"
menu = "main"

+++
The most explicit title ever ! Have you noticed that when you use nginx as a reverse proxy, your web backend ? It's 100% logic but not so convenient. So how to change this behavior ?

## Dura lex sed lex
You should know that as a web service provider you legally must keep connection logs. The law isn't really clear about wich informations you must log but we know for sure that date and time, IP and the asked ressource is the bare minimum. We are so lucky ! It's exactly the default behavior of most of webservers. We just have to edit the nginx proxy config file to add a new header with the IP address.
```
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```
You place these two lines in the *server block* or *location block* of your reverse proxy.

Now you must explain to the upstream nginx server to use this header as the real client ip.
```
set real_ip_from A.B.C.D;
real_ip_header X-Forwarded-For;
real_ip_recursive on;
```
Inside you *server block* and it's okay.

You reload your webservers and you're good to go. 


