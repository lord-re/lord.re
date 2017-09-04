+++
title = "Let's monitor our lan !"
Tags = ["adminsys","monitoring","meta"]
Description = "We will set up a small munin to watch network activity."
menu = "main"
Categories = ["meta","www"]
date = "2010-08-25T21:21:57+02:00"
nodate = true

+++
While i migrated from Debian to Gentoo i didn't reinstalled Munin. I'll do it now. Munin can make graphs about nearly anything… It's a client/server system relying on small scripts.

Let's start with a little **emerge munin**. And it's nearly done. You just need to add the clients in */etc/munin/munin-node.conf* by following the syntax you'll find in comments.

On the client side, you must choose the plugins you want to use by creating symbolic links. eg : **ln -s /usr/libexec/munin/plugins/if_ /etc/munin/plugins/in_eth0**

Some plugins may require an argument like this one, others don't. There is a windows client with some interesting plugins too. For unices, you should consider that plugins are just simples scripts outputting text in an easy format so you could consider creating your own. Good night, see you later.

*PS 2017 :* I don't use munin anymore. I don't monitor anymore in fact. I learned not to care. It leads me to a peaceful mind.
