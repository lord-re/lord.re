+++
date = "2011-08-25T21:58:33+02:00"
title = "Let's Protocol !"
menu = "main"
Categories = ["adminsys","tips","network"]
Tags = ["adminsys","tips","network"]
Description = "We are gonna talk different network protocols by hand"
nodate = true
+++
So, what if we played a bit ? We will speak some network protocols by hand through a socket (netcat or telnet). Ready ?
Gogo SMTP : Sending an email like a tru3 h4ck4r.
**nc monserveursmtpfavoris.com 25**
```
EHLO myfavoriteserver.com
MAIL FROM: mylogin@myfavoriteserver.com
RCPT TO: myrecipient@hissmtpserver.com
DATA
One supa mail
.
```
Ok you've just sent a slick mail by hand. Now that you are convinced that SMTP is easy, what about IMAP ?
**nc myfavoriteserver.com 143**
```
. login myuser mypass
. status INBOX (messages)
. status INBOX (unseen)
. fetch myfavoritenumber full
. logout
```
Once again it was easy but less interesting…
Next : IRC ? ok !
**nc myfavoriteirc.com 6667**
```
user mynick myhost myfavoriteirc.com :myident
nick mynick
privmsg myfriend : Telnet is so fresh !
pong myfavoriteirc.com
```
So… not my bad for this timee, no ?
A small hint : if you want to do the same thing but with a bit more privacy thanks to ssl/tls : replace ***netcat*** with ***openssl*** :
**openssl s_client -connect host:port**
Maybe we will learn more protocols later
