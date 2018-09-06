+++
Author = "Lord"
date = "2010-08-25T21:15:25+02:00"
title = "Optimisation du serveur web"
menu = "main"
Categories = ["meta","www","tips"]
Tags = ["www","meta","tips"]
Description = "Quelques petites optimisations pour Lighttpd"
nodate = true

+++

N'ayant qu'une tite connexion ordinaire de français en ADSL, mon upload est très limité.
Du coup, lors de la visite de ce merveilleux site web, le chargement des pages est assez long.
Pour tenter d'améliorer la situation je viens d'activer la compression gzip des pages.
Pour mon site web la différence est ahurissante.
Je diminue par 4 la taille de la page.
Donc pour cela j'ai édité le fichier **/etc/lighttpd/lighttpd.conf** .
J'ai décommenté la ligne de *server.modules* pour *mod_compress*. Puis j'ai rajouté deux lignes :
```
compress.cache-dir = "/tmp/lighttpdcompress"
compress.filetype = ("text/plain", "text/css", "text/xml")
```
J'en ai également profité pour activer la compression pour les fichiers générés par php.
Donc dans /etc/php/cgi-php5/php.ini il faut ajouter ces lignes:
```
zlib.output_compression = On
zlib.output_handler = On
```
Et voilà vous avez un site tout alegé en Ko.
