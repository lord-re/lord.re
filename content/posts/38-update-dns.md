+++
menu = "main"
Categories = ["adminsys","réseau","tips","dns"]
Tags = ["adminsys","réseau","tips","dns"]
Description = "Comment mettre à jour dynamiquement ses enregistrements DNS sans trifouiller le fichier de zone en local ou à distance"
date = "2015-03-31T12:10:30+02:00"
title = "Updater dynamiquement ses zones DNS"

+++

Bon un court article à mon intention. Comment updater ses zone DNS dynamiquement avec cette syntaxe de merde que j'oublie constamment ? Donc pour mettre à jour un champs A c'est simple :
```
server 127.0.0.1
zone lord.re.
delete lord.re A
update add lord.re. 600 A a.b.c.d
send
```
et voilà c'est pas compliqué mais toujours chiant à retrouver. C'est possible de fouttre le tout dans un fichier texte et de le donner à bouffer direct à knsupdate. Et si on le fait pas en local il est même possible de fournir une clé pour authentifier le truc.
Pour les autres champs chiants à gérer voilà la syntaxe : les NS
```
server 127.0.0.1
zone lord.re.
update add lord.re. 3600 NS zapp.lord.re
```
et pour le SOA
```
server 127.0.0.1
zone lord.re.
update add lord.re. 3600 SOA zapp.lord.re. lord.lord.re. 2015033100 3600 7200 3600 180
```
Et voilà ;-)
