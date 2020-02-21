+++
Author = "Lord"
Description = "Le drama de fin d'année de Firefox à propos de l'extension SpyGlass"
Categories = ["actu", "firefox","drama"]
Tags = ["actu", "firefox","drama"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2017-12-17T10:43:22+01:00
date = 2017-12-17T10:43:22+01:00
title = "Le drama Firefox de la fin 2017 : SpyGlass"
jdh = "https://www.journalduhacker.net/s/fwjhmj/le_drama_firefox_de_la_fin_2017_spyglass"
TopWords = [  "firefox", "extension", "navigateur", "mozilla"]
+++
Mozilla aura eu une sacrée année. Depuis l'arrivée de Chrome et son marketing sauvage (rappelez vous les spots vidéos, les pubs physique dans tous les coins un peu civilisés, sans parler des pubs sur toute la panoplie de site ouaib de Google…) les parts de marché de Firefox se sont peu à peu étiolées. Mais *Mozilla commence visiblement à se réveiller et ses efforts portent leurs fruits*.

Désormais *Mozilla sort des versions “oxydées” de Firefox* (ça veut dire avec de plus en plus de morceaux écrits en rust (rouille… oxydé… bref, ce terme n'est pas de moi et il est semi-officiel)) et *bouscule l'architecture de son navigateur pour le meilleur* mais forcément avec un peu de casse. Bref les anciennes API pour les extensions sont dégagées ce qui va permettre *une meilleure stabilité des nouvelles extensions*. Qui plus est ça permet une *meilleure sécurité globale du navigateur* et permet de *virer les vieilles rougnes d'addons* pas vraiment à jour potentiellement pleines de failles. C'est un drama certains car pas mal d'utilisateurs se retrouvent le bec dans l'eau sans leur extension chérie (et certains ont pris la décision de quitter Firefox pour un autre navigateur utilisant la même nouvelle api que Firefox ([ironic](https://media.tenor.co/images/231e2f67bc42bbfcff592d58f0e9517e/raw)). Moi le premier j'ai plus [vimperator](http://vimperator.org/vimperator.html) et j'ai du coup fui sur un [autre navigateur]({{< relref "/posts/64-qutebrowser" >}}) permettant de garder ces fonctionnalités. Mais au final le drame ultime de la fin 2017 n'est pas ça !

## SpyGlass

Mozilla a installé, dans le dos de ses utilisateurs, une extension qui par défaut ne fait rien. Mais si par mégarde, les utilisateurs modifiaient le **about:config** alors cette extension peut commencer à ajouter des headers et autres références à [Mr Robot](https://fr.wikipedia.org/wiki/Mr._Robot_(s%C3%A9rie_t%C3%A9l%C3%A9vis%C3%A9e)). Un drame sans commune mesure ! 

Sérieux, si vous paniquez parce qu'une extension a été installée mais non activée sans votre consentement il faudrait prendre un peu de recul et voir que ***vous avez installé un navigateur qui (dans la majeure partie des cas) se met à jour tout seul, donc en ajoutant du code que vous pouvez probablement pas voir (contrairement à l'apparition d'une extension), probablement pas virer (contrairement à une extension).***

Pire encore, si votre réaction dans ce cas est d'aller vers un navigateur non opensource vous vous exposez à exactement la même chose à chaque nouvelle version et que personne ne peut vérifier en regardant le code…

Certe le comportement de Mozilla n'est pas clean. Faire ça sans en parler c'est pas la meilleure idée qui soit. Mais c'est franchement sans conséquence et sans commune mesure avec du logiciel proprio.

 


------

***PS*** 

Mozilla a apparemment commencé à communiquer [dans sa base de connaissances](https://support.mozilla.org/en-US/kb/lookingglass).
