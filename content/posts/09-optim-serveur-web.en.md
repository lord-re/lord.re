+++
date = "2010-08-25T21:15:25+02:00"
title = "Optimisation of the webserver"
menu = "main"
Categories = ["meta","www","tips"]
Tags = ["www","meta","tips"]
Description = "Some small optimisation to Lightty"
nodate = true

+++

As I only have a small basic french ADSL connection, my upload is very limited. So, when you visit this wonderful website, the page load time could hurt you. To try to mitigate this I enabled the gzip compression. In my case the difference is astonishing ! The file size decreased by 4 times. To do this i just had to edit */et/lighttpd/lighttpd.conf* . Just uncomment the line **mod_compress** and add these two lines :
```
compress.cache-dir = "/tmp/lighttpdcompress"
compress.filetype = ("text/plain", "text/css", "text/xml")
```
I also enabled it directly inside PHP. Add these two lines in */etc/php/cgi-php5/php.ini* and you're good :
```
zlib.output_compression = On
zlib.output_handler = On
```
There you have a lighter website. Enjoy all those spared KB !

*PS 2017 :* I don't use lightty anymore but I still use gzip to send every webpages. It's a small trick without side effects even on a bigger internet connection.
