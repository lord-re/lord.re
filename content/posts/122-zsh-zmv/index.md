+++
Author = "Lord"
Description = "Améliorer son niveau de ZSH avec quelques utilisations plus avancées. ZMV permet de renommer en masse ou selon des critères."
Categories = ["cli", "shell"]
menu = "main"
notoc = true
PublishDate = 2018-08-23T17:43:55+02:00
date = 2018-08-26T21:43:55+02:00
lastedit = 2018-08-26T22:17:32+02:00
title = "ZSH plus loin : ZMV"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/ofg2pc/zsh_plus_loin_zmv"
+++
Les petites gens utilisent un environnement de bureau mais en tant que rustre, je préfère largement l'austérité d'un sombre terminal.

Vous connaissez probablement la commande **<samp>mv</samp>** qui permet de **m**o**v**e un fichier.
C'est bien dans 90% des cas, mais il arrive des fois que vous ayez plein de fichiers à bouger avec juste une partie à renommer.
Et là c'est pas mal galère.

Vous allez pouvoir renommer les fichiers en masse avec quelques options sympatoches grâce à notre cher **ZMV** !

vous voulez changer un motif récurrent en début de nom par un autre (souvent je préfixe les fichiers) :
<figure>

| Original | ▶ | Renommé |
|:-:|:-:|:-:|
|XXX-fichier1.jpg| ▶ |YYY-fichier1.jpg|
|XXX-fichier2.jpg| ▶ |YYY-fichier2.jpg|
|XXX-fichier3.jpg| ▶ |YYY-fichier3.jpg|

<figcaption><h4>zmv 'XXX(\*)' 'YYY$1'</h4></figcaption>
</figure>
<p> </p>

Tout simplement.

**<samp>zmv 'le_motif_quon_change(*)' '$1-cequonchange'</samp>**


Pour être safe, on peut rajouter **<samp>-n</samp>** qui affichera les modifs devant être effectuées sans les faire.
Et sinon il y a le mode interactif avec **<samp>-i</samp>** qui nécessitera que vous validiez chacune des modifs.

Bien entendu il y a d'autres options qui sont [documentées](http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#index-zmv) mais celles-là devraient vous suffire.

L'extra-bonus vient du support des *modifiers* et du *globbing* de ZSH mais ça c'est pour une prochaine fois.
Avec ces deux bidules supplémentaires, il est possible d'ajouter des critères pas mal du tout.
ex : **<samp>zmv '* *' '$f:gs/ /_'</samp>** pour remplacer les espaces par des <abbr title="ça → _">underscores</abbr>.
Bon j'arrive jamais à m'en rappeler, hein, mais au moins je sais où le retrouver.


PS : Pour pouvoir l'utiliser il faut ajouter **<samp>autoload -U zmv</samp>** dans votre *~/.zshrc*.
