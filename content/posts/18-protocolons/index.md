+++
Author = "Lord"
date = "2011-08-25T21:58:33+02:00"
title = "Protocolons !"
menu = "main"
Categories = ["adminsys", "tips", "réseau", "smtp", "imap", "irc", "mail", "tls" ]
Description = "Tentons de parler à la mano dans quelques protocoles usuels du net."
nodate = true

+++

Bon et si nous faisions du lol ? On va parler quelques protocoles usuels à la main à travers un socket (type netcat ou telnet). R2R ? (Ready to rock)

## SMTP

Parlons SMTP : Envoyons un mail comme un vrai hacker.
**nc monserveursmtpfavoris.com 25**
```
EHLO monserveursmtpfavoris.com
MAIL FROM: monidentité@monserveursmtpfavoris.com
RCPT TO: mondestinataire@sonsmtp.com
DATA
Un supayr mail
.
```

## IMAP

Et voilà vous avez envoyé un mail à la mano. comme quoi SMTP c'est facile. Et si on faisait son pote IMAP ?
**nc monimapfavoris.com 143**
```
. login monuser monpass
. status INBOX (messages)
. status INBOX (unseen)
. fetch monnumérofavoris full
. logout
```

Encore une fois c'était facile mais c'est moins intéressant tout de même…

## IRC

Bon pour la prochaine un peu d'irc ?
**nc monserveurircfavoris.com 6667**
```
user monpseudo monhost monserveurircfavoris.com :monident
nick monpseudo
privmsg monami : Telnet saytrolol !
pong monserveurircfavoris.com
```

Bon c'est déjà pas mal non ?

## TLS

La petite astuce pour faire pareil en chiffrant pour se connecter sur du ssl: remplacer netcat par openssl avec
**openssl s_client -connect host:port**
