+++
Author = "Lord"
Description = "7ème avancement du Librem 5"
Categories = ["traduction", "hardware","software","librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-03-04T10:39:02+01:00
date = 2018-03-04T10:39:02+01:00
title = "7ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/yfi0zb/7_me_article_davancement_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-7/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org) et le projet [Matrix](https://matrix.org).
Ils sont assez transparent sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Librem 5 est un gros projet.
Comme vous le savez, les gros projets semblent insurmontables jusqu'à ce qu'on les décomposent en de multiples briques logiques.
Comme s'il s'agissait d'un puzzle, notre équipe s'est organisée pour commencer à assembler les pièces.
C'est enivrant de partir d'un morceau initial, de travailler dessus et soudain… après un peu de temps, une solution apparait et tout s'aligne presque magiquement.

Dans nos précédents articles nous avons décrit ce que nous avions commencé à faire et ces premiers efforts portent déjà leurs fruits lors de notre *hackfest* d'une semaine à Siegen en Allemagne où notre équipe logicielle s'est rendue.
En plus de moi même (Nicole Faerber - Mobile Development Lead), nous ont rejoins Bob, Heather, Pedro, Dorota, Adrien, Guido et Todd.

{{< img src="*0-photo1.thumb.jpg"  alt="Photographie de l'équipe travaillant sur leurs ordinateurs" link="80-photo1.jpg" >}}
{{< img src="*0-photo2.thumb.jpg"  alt="Photographie de l'équipe discutant" link="80-photo2.jpg" >}}

## Compositor et Shell

L'un des composants le plus importants de l'interface utilisateur du téléphone est le compositor Wayland et le shell.
Le compositor coordine l'affichage des surfaces, qui se trouvent être les fenêtres des applications et le shell fournie une interface utilisateur simple pour démarrer cet applications comme par exemple le widget de contrôle du réseau, la luminosité, la rotation etc.
Pour plusieurs raisons après avoir évalués de nombreuses options avec les mainteneurs upstreams (amonts), nous avons pris la décision de développer un compositor basé sur *Wlroots* et *Rootston*.
Guido travaille ardemment sur ce point et les résultats obtenus durant cette semaine sont bluffant.

Nous avons donc désormais un compositor complet fonctionnant sur la dev board à base de i.MX6 basé sur Wlroots et Rootston avec un embryon de shell pour téléphone ([Phosh](https://code.puri.sm/Librem5/phosh)) permettant de manipuler les fenêtre, mise en plein écran, un début de menu de contrôle permettant la rotation de l'écran en redimensionnant les fenêtre à la volée.

<video class="wp-video-shortcode" id="video-49252-1" width="100%" preload="metadata" controls="controls"><source type="video/webm" src="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip3.webm?_=1" /><a href="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip3.webm">https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip3.webm</a></video>


Tout cela fonctionne sur une [SBC](https://fr.wikipedia.org/wiki/Ordinateur_%C3%A0_carte_unique) i.MX6 qui est suffisamment performante pour ce dont on a besoin.
Cela permet également de valider nos choix fonctionnels.
Le shell, Phosh, n'est qu'à l'état de “preuve de concept” mais permet déjà de lancer quelques applications.
On peut donc déjà lancer de multiples applications via notre shell.
Nous pouvons désormais nous atteler à compléter le shell et appliquer le travail fait par notre équipe de designers.

## Applications GTK+ adaptives (“responsives”)

Un des challenges majeurs d'écrire des applications graphiques est de designer une UI de sorte à ce qu'elle puisse s'adapter à différentes tailles d'écran, géométries et résolutions.
Le téléphone est un cas extrême car il a un grande résolution dans un tout petit format (environ 5 pouces) et est principalement utilisé en mode portrait "mais tu peux l'utiliser en paysage” et tu peux y raccorder un écran externes bien plus grand… mais tu veux utiliser les mêmes applications dans tous ces cas de imgs. *la, les interfaces graphiques doivent s'adapter à leur environnement.
On a vu ces principes adoptés dans le design des sites web ces dernières années sous le terme de “responsive design”.

Cependant nous appelons ça **adaptive design**, ou **applications adaptives**.
Non pas pour se démarquer mais parce que “responsive” est un terme avec de nombreuses significations, particulièrement dans le domaine des logiciels ou ce terme signifie parfois «performant».
Un logiciel responsive est un logiciel qui réagis quasi instantanément contrairement à un logiciel classique qui ne répond plus.

Pour le moment, la grande majorité des applications ne sont pas faites pour cette utilisation.
Nous nous sommes donc penché sur le sujet et Adrien commença à développer un widget [GTK+](https://en.wikipedia.org/wiki/GTK%2B) qui devrait solutionner ce problème tout du moins simplifier grandement la création d'applications adaptives et le portage d'applications existantes vers cette technologie.
Le widget d'Adrien permet d'afficher/cacher d'autres widgets en fonction de la taille de la fenêtre et de sa géométrie.
Pour tester son système, Adrien a modifié [Gnome Contact](https://wiki.gnome.org/Apps/Contacts) pour qu'elle utilise sa nouvelle "boîte responsive" et il s'avère que cela marche bien comme vous pouvez le constater sur cette vidéo :

<video class="wp-video-shortcode" id="video-49252-2" width="100%" preload="metadata" controls="controls"><source type="video/webm" src="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip1.webm?_=2" /><a href="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip1.webm">https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip1.webm</a></video>

L'application contacts est simple dans sa conception tout du moins pour son interface.
La prochaine étape pour Adrien sera de tester son widget sur un client email.
Stay tuned!

## Méthodes d'entrées (Input methods)

En dehors du compositor, du shell et de l'agencement de l'UI, un des points les plus critiques d'une suite logicielle pour téléphone est la *gestion des méthodes d'entrées*.
Presser un bouton et lire du texte est une chose mais vous voulez être capable d'entrer du texte et ceci requièrent quelques composants logiciels complexe à faire communiquer entre eux mettant en scène le compositor ainsi que le toolkit graphique utilisé par les applications.
Dorota a planché sur cela et a connectés les différents protocoles et plugins et a désormais un prototype basé sur le protocole d'Input Method de Wayland, le clavier virtuel de Weston, un plugin GTK ainsi qu'une application de test recevant le texte :

<video class="wp-video-shortcode" id="video-49252-3" width="100%" preload="metadata" controls="controls"><source type="video/webm" src="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip6.webm?_=3" /><a href="https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip6.webm">https://videos.puri.sm/librem_phone/dev/180223-hackfest/2018-02-23-clip6.webm</a></video>

Vous pouvez voir voir le texte entré sur le clavier virtuel s'affichant dans l'application de test.
En plus de cela, Dorota est parvenu à établir une méthode pour afficher/cacher le widget d'entrée de texte en fonction du focus etc.
Tout devrait fonctionner aussi bien avec une application Qt mais ce n'est pas le cas.
Dorota s'affaire donc à régler cela.
Nous sommes confiant quant au fait de faire fonctionner cela avec Qt.

Le protocole utilisé n'est pas lié au clavier virtuel de Weston, il peut être utilisé avec d'autre méthode d'entrée ce qui permettra donc de développer/adapter d'autres méthodes facilement.

## Téléphonie

La dernière fois nous vous présentions le premier SMS envoyé depuis la dev board via le modem à une autre appareil mobile et nous vous promettions de bosser sur les appels téléphoniques.
Bob a donc poussé les recherches à ce sujet et commencent à comprendre les entrailles d'oFono et Télépathy.
Nous n'y sommes pas encore complètement mais le chemin nous apparait de plus en plus clairement.
L'avantage de rechercher et de prendre le temps de comprendre l'interface et le code est que nous serons plus à même d'y brancher notre dialer (composeur de numéro de téléphone) et établir une communication.

## Documentation, SDK

Maintenant que notre pile applicative est moins confuse, il est important de centraliser les connaissances et de documenter le tout.
Ces dernières semaines, Heather s'est attelé à cette tâche.
Non seulement elle documente les efforts de dev actuels, mais en plus elle intègre les bribes de développement dans ce qui deviendra à terme un émulateur et SDK pour les nouveaux devs.
Nous voulons fournir un IDE pour les nouveaux devs qui dans un futur pas si lointain devrait permettre de développer pour tous les appareils Purism, laptop ou téléphone.
Nous souhaitons être ouverts à différentes technologie de programmation, que ce soit des langages comme le C, C++, Python ou bien des toolkits comme Qt ou GTK+.
Nous savons pertinemment que tout ne fonctionnera pas à 100% lors du lancement mais c'est notre but et nous nous employons en posant les fondations.
Heather travaille actuellement avec Gnome Builder car il supporte une grande variété de langages et toolkits et permet de lui même de créer des paquets [Flatpak](https://flatpak.org).
Elle travaille également sur des stratégies de déploiement accessibles pour que les devs puissent déployer directement une application du Builder vers une machine virtuelle pour le Librem 5 ou directement sur un kit de dev ou bien le téléphone ou bien vers un Flatkpak qui puisse être partagé.

Ce travail est capital pour les utilisateurs du SDK qui recevront les SBC en Juin.
Avant ça nous lanceront un site web complet dédié à PureOS et au Librem 5.

## Hardware

Alors que notre équipe hardware n'a pas pu nous rejoindre à Siegen, nous avons reçus nos premiers kits d'évaluation à base d'i.MX 8M la semaine dernière et avons pu commencé à tester avec les logiciels et pilotes.
Nous avons également une prometteuse source pour la fabrication, nous aurons une visite d'usine d'ici à la fin Mars.

{{< img src="*0-photo3.thumb.jpg"  alt="Photographie d'une dev board reliée à un oscilloscope." link="80-photo3.jpg" >}}


## Les pièces s'assemblent les unes aux autres

De nombreuses pièces de notre immense puzzle s'emboitent pour prendre forme.
Nous avons les bases de notre UI (compositor, shell), nous avons prouvé une technique pour adapter les applications aux challenges que posent les différents écrans (boite responsive), nous pouvons entrer du texte, la pile téléphonique devient moins confuse et nous avons une toute une plateforme naissante pour les devs d'application PureOS.

Nous sommes exaltés de la quantité de progrès faits en si peu de temps.
Restez branchés, de nombreuses choses arrivent…

<hr>
Comme dit dans leur conclusion, en si peu de temps les progrès sont remarquables.
Surtout du côté de l'interface utilisateur.
C'est assez bluffant.
Cependant la partie téléphonie parait tellement abscons pour le moment que ça en devient un peu inquiétant.
Je trouve la date de juin pour les devs boards assez optimiste également mais bon.

Au fait, j'héberge les images sur mon serveur mais pas leurs vidéos qui seraient trop volumineuses pour chez moi, désolé.
