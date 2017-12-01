+++
Author = "Lord"
title = "Monitorons ce qui traîne sur son réseau"
Tags = ["adminsys","monitoring","meta"]
Description = "On va poser un ptit munin et reluquer le réseau"
menu = "main"
Categories = ["meta","www"]
date = "2010-08-25T21:21:57+02:00"
nodate = true

+++

Lors de mon passage de Debian vers Gentoo, je n'ai pas réinstallé Munin. Je ne m'y prends que maintenant. Munin permet de faire de petits graphs très pratique concernant à peu près tout et n'importe quoi… C'est encore une fois un système de clients/serveur. Commençons par un petit emerge munin. Et là c'est quasiment finit pour le serveur. Il ne reste qu'à ajouter les clients à interroger dans **/etc/munin/munin-node.conf** selon la syntaxe décrite en exemple.
Sur la partie cliente, il faut définir les plugins utilisés par le biais de liens symbolique. Par exemple : *ln -s /usr/libexec/munin/plugins/if_ /etc/munin/plugins/if_eth0*
Certains plugins nécessite un argument comme celui-ci dessus mais pour d'autre non… Il existe un client windows avec quelques plugins intéressants. Pour les unix, sachez que les plugins ne sont que de simples scripts renvoyant des valeurs dans une syntaxe relativement simple. Sur ce bonne nuit et à la prochaine.

