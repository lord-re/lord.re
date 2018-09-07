+++
Author = "Lord"
Categories = ["libre","ux","software","linux"]
Tags = ["libre","ux","software","linux"]
Description = "Pistes de réflexion pour faire un init"
date = "2015-09-12T12:19:40+02:00"
title = "Une idée d'init"
menu = "main"

+++

Ces derniers temps, les inits ont la côte.
L'invasion de Systemd sur un bon paquet de banquises en est la principale cause.
Il faut dire qu'avant lui il n'y avait pas eu autant de débat et peu de concurrence.
Il y a pas mal d'inits différents mais la plupart sont quasiment pas utilisés en dehors des cadors du secteur.
Systemd fait parlé de lui à cause de son initiateur (haha) à la réputation sulfureuse mais également pour certains choix techniques parfois étranges mais aussi (et surtout à mon goût) pour sa capacité à changer l'ordre établis.
Comme beaucoup de secteur, le ptit monde de nunux n'aime pas être bousculé dans ses ptites habitudes.
Donc quand le ptit nouveau se retrouve adopté par la majorité des grosses distros, un problème s'impose : il va peut-être falloir choisir son init (ça c'est quand on a de la chance, diront certains) ou bien il va carrément falloir apprendre comment ça marche.
Et d'ailleurs peu de personne ne savaient ce qu'était un init avant ce drame.

## Ha bha ouai tiens, c'est quoi un init ?
L'init, c'est le programme qui sera lancé par votre kernel.
Petit rappel du démarrage d'un ordi : on appuie sur un bouton.
Le firmware de la carte mère (le bios ou l'UEFI ou le Coreboot ?) va devoir démarrer tout le matos et faire des tests (de la RAM, du CPU, des skeudurs…).

Ensuite celui-ci va regarder dans ses réglages sur quel support il est censé booter.
Il regarde ce support (skeudurs, réseau, cd (non en 2015 faut pas déconner, on ne fait plus ça (ce message est destiné aux archéologues qui découvriront ce blog et s'en serviront pour comprendre notre civilisation, ne me remerciez pas les gars)), USB).
Sur ce support il va démarrer ce qu'il se trouve au début.
Et ce qui se trouve au début de ce support a intéret à être un bootloader sans quoi il vous crachera une jolie erreur.

Ensuite le bootloader va faire son office : il va vous permettre de choisir l'OS que vous voulez démarrer.
En gros, il va regarder là où il a été configuré pour trouver un kernel, un initram éventuellement et pousser des options à destination du kernel et de l'initram.
Il s'est passé plein de trucs pour l'instant mais en fait pas tant que ça, car on a toujours pas commencé à booter ! Bref.

Ensuite c'est donc le kernel qui va faire sa petite soupe, il s'initialise, il mount l'initram en tant que / et lance l'init qu'il y a dedans.
Généralement celui-ci est minimal et sert surtout à pouvoir booter dans de bonnes conditions (il contient des modules pour le matos, de quoi monter la vraie partition root donc éventuellement de quoi déchiffrer, de quoi supporter des fs exotiques…) et ensuite une fois tout ça fait, un ptit coup de switch_root qui dégagera l'initram qui était en / et y mettra votre vraie partition racine.
À ce moment-là, le vrai init sera lancé.

Pfiouuuuu.
Enfin !

Il va avoir pour but d'initialiser votre OS (et non le kernel).
Il va donc appliquer vos réglages, démarrer les différents logiciels, monter les partitions.
Et c'est là que les avis commencent à diverger.
Certains pensent que le taff de l'init s'arrête là, d'autres pensent que ce serait balot de pas s'occuper d'autres aspects du système comme gérer le branchement des différents périphs, de gérer la mise en place du réseau, de s'occuper des logs, d'en profiter pour gérer les conteneurs car en 2015 on conteneurise tout ce qu'on peut si on veut pas avoir une passoire.

Voilà c'est une nouvelle zone logicielle.
Avant on distinguait le kernelland de l'userland, maintenant on peut rajouter le systemland.
Et franchement c'est pas forcément complètement incongru comme point de vue.

## Systemland
Vous aurez reconnu que cet avis est celui adopté par les devs de systemd.
Systemd n'est pas un init, c'est un systemland complet.
On utilise plus du GNU/Linux (un userland GNU sur un kernel linux) mais du GNU/systemd/Linux.
Ça a certains avantages comme une base commune pour pas mal d'outils qui adoptent donc un comportement et une philosophie proche.
Plein de ptits modules qui gèrent tous les aspects du système : vous installez systemd, vous avez tout ce qu'il vous faut pour initialiser/confer un système.
Qui plus est son adoption par la majorité des distro apportent une uniformisation pas désagréable dans la façon de gérer le système : si vous savez confer votre Debian utilisant systemd, vous saurez confer votre Gentoo utilisant systemd… On réduit un peu les écarts entre les distros… Les outils marchent particulièrement bien ensembles et pour la plupart sont prévus pour marcher à travers le réseau et prennent en compte les technos actuels (à savoirs la virtu, les ssd, les namespace…).

Jusque-là j'ai tenté de rester à peu près impartial et je m'en tiens au fait et ne rentre pas trop dans les choix techniques.
À vraie dire ces points pour la plupart me semble pas être négatifs mais plutôt positifs.
Surtout quand en plus ça fait tout ça de manière très rapide et que lorsque c'est bien intégré bha mine de rien ça marche.
Par contre quand c'est mal intégré, ça déconne de partout.
Heureusement les plus grosses distros n'auront pas de soucis à faire cette intégration proprement, surtout lorsque celles-ci disposent d'énormément de contributeurs, d'une très importante communauté et d'un cycle de release particulièrement lent et qui du coup adopet le bousin après les autres.
Hé bien non c'est pas vrai.
Debian s'est planté comme une merde.
À intégrer Systemd à reculons bha ça chie de partout.
Et pas qu'un peu.
Et du coup pas mal de powerusers Debian qui n'ont pas tâté ailleurs se font un avis très négatif du bestiau.
Et on ne peut pas les blâmer.
Mais c'est pas grave.
Au contraire c'est ptet une bonne nouvelle.

## A new hope
Systemd s'est imposé partout (enfin pas vraiment, il a été adopté partout mais bon c'est plus marrant d'un point de vue complotiste).
Et du coup, comme je le disais précédemment, a uniformisé pas mal de chose dont les fameux fichiers ".unit".
Et franchement c'est une bonne chose : les scripts init de type sysV sont quand même un gros truc dégueulasse qui ont fait leur temps.
Faut arrêter de déconner.
Critiquer la complexité de Systemd pour les adminsys est une vaste blague.
L'adminsys qui doit créer un script d'init pour systemd aura six/sept lignes à foutre dans un fichier .ini alors que sous sysV il aura plusieurs centaines de lignes.
Certe d'un côté c'est que des commandes shell "basiques" qu'il connaitra d'ailleurs et qu'il aura déjà utilisées des centaines de fois et de l'autre c'est une "nouvelle syntaxe" où il va devoir se taper trois mans et demi relativement concis.
Donc oui il y a apprentissage nécessaire mais c'est pas forcément un mal.
Et puis surtout les fichiers unit sont réutilisables d'une distro à une autre avec très peu d'ajustement à faire (à peine modifier certains chemins de fichiers et hop).
Du coup on se retrouve avec une nouvelle syntaxe de conf relativement concise et très répandue.
Pas mal de choix techniques de Systemd ne font clairement pas l'unanimité et sont parfois carrément absurde (really Dbus partout ?).
Bref.
Maintenant que l'init est devenu un sujet à la mode j'espère beaucoup l'arrivée d'alternatives modernes repiquant certaines idées de Systemd avec des choix techniques différents.

## C'est dans les vieux pots qu'on fait les vieilles soupes
Et si l'on imaginait un nouvel init.
Par exemple… heuuu chsépa.
init2 ?
mouai c'est nul comme nom mais j'ai vraiment pas d'inspiration.
Bref.
On repart de 0.
On décide de ne faire qu'un init pour le moment, tous les outils manquants seront ceux d'un GNU userland classique.
Donc imaginons déjà un init compatible avec les fichiers .unit de systemd.
On a déjà de conf pour démarrer à peu près tous les services existants, notre futur base d'utilisateurs est contente.
Bon donc en gros il va falloir parser de l'ini, c'est pas bien dur.
Il va donc falloir implémenter toutes les features de Systemd propre à l'init.
En même temps qui voudrait d'un nouvel init qui ne sache pas fournir un /tmp isolé pour chaque unit ?
qui voudrait d'un init qui ne gère pas finement l'ordre de lancement des unit (After/Before/Require/Need).
Dans un premier temps si toutes les features ne sont pas implémentées ce n'est pas bien grave bien entendu.
Déjà dans les choix techniques : ne pas utiliser cette daube de systemd que personne ne comprend.
Le truc est à peine documenté foire dans tous les sens (et dire qu'ils veulent le voir dans le kernel !).

Ensuite, faut une interface en ligne de commande mieux foutue.
Systemctl c'est clairement pas possible.
C'est nul à chier, ça en chie pour autocompléter les units, c'est super verbeux (tellement que ça passe quasiment tout le temps via un pager, c'est dire).
Et puis putain ! Les mecs te foutent un nom super chiant à autocompléter ! systemctl.
Il faut appuyer combien de fois sur Tab pour le sortir cet immondis ?
Surtout quand la moitié de tes commandes commencent toutes par systemd-trucmuche.
Obligé de foutre un alias sur toutes les machines qui l'utiisent.
Sérieux les mecs sont des vicieux qui se martellent les parties génitales avec des martifouettes en regardant Joséphine ange gardien.
C'est pas possible c'est énervant au plus haut point.
Donc là, pour notre init on cherchera un nom de commande qui n'a pas cinquante résultats proches dans l'auto-complétion des distros majeures.

Le reste de l'environnement doit pouvoir être utilisé mais ne doit surtout pas être forcé.
Aucune dépendance sur logind, journald, networkd.
Là plupart de ces outils ont déjà des alternatives pas forcément aussi modernes ou intégrées mais qui ont largement fait leur preuve ou sont suffisamment KISS pour être conservées.

## One more thing
Et pour l'interface, c'est là où j'ai le plus d'idée quant à l'usabilité du truc.
J'imagine une TUI (bha quoi ?
Une text-user-interface mon cher !) toute classouille.
Un truc basé sur une session tmux avec plusieurs onglets.
Un premier onglet à la htop avec tous les units démarrés où l'on peut en choisir un spécifiquement et une fois appuyé sur entrée ou espace ou autre, ouvre un nouvel onglet spécifique à cet unit.
Avec dedans les infos le concernant : les différents pid, le cgroup, son uptime, et surtout le shell du process en cours en foreground.
Les process ne seraient pas vraiment daemonisés mais dans un tab de tmux.
Avec des raccourcis adaptés pour pouvoir stop/relancer le bousin.
Ce serait à la fois léger, rapide et surtout on peut relancer le process sans quitter son shell avec le log qui s'affiche en même temps.
Et puis tous les sysadmins savent utiliser tmux (ou le devrait).
Je pense que ce pourrait être une killer feature.

## Tout ce vent pour rien
Et ouai.
Je sais pas coder.
Surtout un projet de cette criticité et de cette envergure.
Et c'est bien dommage.
J'imagine que de toute façon chacun à sa ptite idée de l'init idéal.
Mes principales préoccupations (conf simples, conf "universelle" vis-à-vis des distros, interface utilisateur rapide et simple) ne seront pas celles d'autres et je le conçois.
Mais je ne conçois pas qu'il y ait autant de râleurs vis-à-vis de systemd et aussi peu de vraies propositions d'alternatives.
Les propositions consistent généralement à rester coller à sysV et du coup rajouter un peu de papier mâché dessus pour combler les nouvelles dépendances de nouveaux softs.
C'est bien gentil mais tout n'est pas mauvais dans systemd et sysV a quand même pas mal vieilli et pêche par certains aspects.
OpenRC est une alternative intéressante mais qui est quand même un peu trop proche de sysV.
Bref je suis pas meilleur que les autres et n'apporte rien à l'édifice si ce n'est que quelques ptites idées qui n'ont rien de bien inédit mais bon.

