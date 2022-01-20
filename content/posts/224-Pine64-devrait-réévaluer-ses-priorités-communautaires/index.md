+++
Author = "Lord"
Description = ""
Categories = ["linux", "téléphonie","traduction"]
menu = "main"
notoc = true
WritingDate = 2022-01-19T21:38:08+01:00
date = 2022-01-20T16:38:08+01:00
title = "Pine64 devrait réévaluer ses priorités communautaires"
editor = "kakoune"
TopWords = [  "appareils", "téléphonie", "linux", "téléphone", "distributions", "pine64","librem"]
+++
*Drew Devault* est un contributeur du monde du libre avec une place assez importante dans la communauté.
Il est à l'initiative de pas mal de projets et participe notamment à **Sway**, **Wayland** en général mais aussi des projets plus petits comme **Openring** (que j'utilise pour vous suggérer des blogs à droite).
Il a lancé également l'entreprise **SourceHut** qui est une forge logicielle auto-hébergeable qui est en concurrence avec github.
Bref, c'est un gars qui connait pas trop mal tout cet écosystème.

Je vous propose ici une traduction de [son article datant du 18 Janvier 2022](https://drewdevault.com/2022/01/18/Pine64s-weird-priorities.html) qui parle de la stratégie de Pine64 concernant le financement des projets Libre pour leurs gamme d'appareils.

Pine64 est une entreprise proposant des appareils peu chers principalement à destination des devs.
Ils ont deux téléphones, une montre connectée, une tablette et bien d'autres appareils.

-------------------

Pine64 a une idée vraiment intéressante : faire du matériel pas cher avec de faibles marges, le rendre disponible pour la communauté du Libre et la laisser s'occuper de la partie logicielle.
Ça n'a pas été tenté auparavant, tout du moins pas à cette échelle et c'est une vraiment bonne idée !
Pine64 œuvre beaucoup pour aider la communauté du Libre à faire tourner son matériel, mais ils pourraient faire autrement pour de meilleurs résultats.

Plusieurs points pourraient être abordés pour améliorer cet écosystème.
Du plus important au moins important :

  -1 Implémenter et upstreamer les drivers kernel, le support d'u-Boot, etc
  -2 Créer une pile logicielle robuste pour la téléphonie sur Linux
  -3 Construire une interface utilisateur adaptée au mobile pour Linux
  -4 Supporter les distributions qui incorporent le tout

Je me répète, c'est du plus important au moins important, mais en pratique, l'écosystème est priorisé dans l'autre sens.
Pine64 ne contribue pas de code sur aucun de ces points.
Cependant, ils contribuent financièrement en partie sur ces points du bas vers le haut.
La majorité des fonds vont donc dans les distributions et à contrario très peu de cet argent sert à l'élaboration de drivers.
C'est bien mais… pourquoi financer les distributions ?
Les distributions ne produisent pas de code pour améliorer l'écosystème mobile sous Linux.
Leur boulot est de distribuer les résultats de ces améliorations communautaires.

Je ne nie pas leur importance et je suis conscient qu'elles ont besoin d'aide financière mais financer de multiples distributions Linux participe à la fragmentation de l'écosystème.
Par exemple, il serait préférable de pouvoir installer une distribution Linux de son choix sur le Pinebook Pro en utilisant une ISO d'installation standardisée pour aarch64 UEFI, comme on le fait pour n'importe quel ordinateur portable.
Cela nécessiterait qu'un dev dédie quelques semaines à coder et contribuer au kernel les quelques patchs nécessaires ainsi qu'une payload u-Boot à flasher sur la puce SPI.
Mais au lieu d'une solution fonctionnelle pour tout le monde, on se retrouve avec une vingtaine de distributions Linux publiant des images spécialement taillées pour le Pine64 à flasher sur la carte microSD.

La distribution la plus populaire, qui s'avère être Manjaro est en compétition pour une part du financement et ensuite dépense l'argent à leur guise pour s'atteler au même problème que les autres.
Si à la place, le financement était alloué sur les points prioritaires évoqués plus haut, toutes les autres distributions bénéficieraient de ces avancées.
La couche de téléphonie est toute aussi importante et pourrait tout aussi bien être partagée entre toutes les distributions mais ne bénéficie d'aucun financement.
Vous ne pouvez pas vendre un téléphone dont la fonctionnalité de téléphonie n'est pas au point.
L'interface mobile est toute aussi importante mais il s'agit du point le plus simple à construire et quand bien même, un téléphone fonctionnel avec une interface merdique est meilleur qu'un téléphone avec une bonne interface mais sans téléphonie.

À vrai dire, il y a des progrès sur ces points mais ça progresse très lentement.
Plusieurs distributions visant les appareils mobiles dédient de la main d'œuvre sur ces points mais uniquement par nécessité : c'est uniquement pour atteindre leurs objectifs, elles ont dû monter en compétence et diviser leur temps disponible entre la maintenance de la distribution et le développement logiciel.
De ce fait, ces personnes sont devenues expertes avec certaines affinités et quelques arrangements et bien qu'il y ait du partage de patch et de la collaboration entre les distributions, ce n'est généralement qu'informel entre une douzaine de structures organisationnelles indépendantes.
Dans un système aux ressources particulièrement limitées (financièrement, temps de cerveau, etc), ces inéfficiences sont réellement handicapantes.

Après avoir reçu mon PineNote, j'ai vite réalisé que j'allais souffrir de ces soucis.
Il est nécessaire que Pine64 revoit sa façon de faire pour maximiser leurs chances de réussir avec leur gamme actuelle et future.
Je pense que la meilleure stratégie serait d'engager à temps plein juste un dev pour travailler spécifiquement sur le kernel mainline, u-boot mainline, ModemManager, etc, la rédaction de documentation, collaborer avec les autres projets et compagnie.
Cette personne aurait à charge de trouver comment s'interconnecter avec des briques logicielles génériques afin d'utiliser le matériel, en veillant à ce que les résultats soient upstreamés et distribués ces solutions dans tout l'écosystème.

C'est génial que Pine64 accepte de contribuer financièrement à la communauté du Libre grâce à leurs appareils et étant donné que ce sont les vendeurs de ces appareils, ils sont la seule entité de l'équation avec les moyens de le faire.
Pine64 fait un travail extraordinaire !
Cependant une meilleure stratégie concernant le financement serait préférable.
Réflêchissez-y !

------------------------

Voilà, je trouve cet avis très intéressant et particulièrement pertinent.

Il y a maintenant fort longtemps, je suivais de près les aventures de *Purism* concernant leur téléphone sous Linux le **Librem5**.
Il leur est très souvent reproché de proposer un téléphone hors de prix et on les met en concurrence avec le **PinePhone** qui effectivement n'est qu'à un cinquième du prix.
La différence majeure c'est que *Purism* ne se limite pas à l'aspect matériel du téléphone, ils ont également des devs en interne qui bossent sur les différentes couches logicielles nécessaires, que ce soit au niveau kernel, au niveau téléphonie, au niveau UX, au niveau des différentes applications…
Et tout ce boulot, bha ça se paye.
Bon après ce sont deux approches différentes avec chacun leurs avantages.

Pour l'instant je dois avouer que Pine64 a réussi à sortir maintenant deux téléphones à des prix bien plus abordables alors que Purism … bha en vrai ils ont pas trop sorti de téléphone et les prix sont tellement montés et le hardware est resté inchangé du coup c'est de moins en moins intéressant.
Mais même si le **Librem5** a de moins en moins d'intéret, ils poursuivent quand même tout leur boulot qui au final va probablement bénéficier à tout l'écosystème : les applis de messageries qu'ils développent sont disponibles pour les autres, leur stack de téléphonie aussi, le boulot sur l'intégration de Gnome sur mobile et compagnie, tout le monde en profite.
Enfin, tout le monde qui utilise Gnome sur mobile (donc potentiellement aussi les utilisateurs du PinePhone).
