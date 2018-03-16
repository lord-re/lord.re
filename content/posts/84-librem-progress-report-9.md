+++
Author = "Lord"
Description = "Suivons toujours les avancées de Purism pour créer le Librem 5. Début du travail sur KDE Plasma Mobile."
menu = "main"
notoc = true
PublishDate = 2018-03-13T16:12:07+01:00
date = 2018-03-13T16:12:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "9ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/jbnk4d/9_me_article_davancement_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-5/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Comme nombre d'entres vous le savent, le Librem 5 proposera [deux options](https://puri.sm/posts/gnome-and-kde-in-pureos-diversity-across-devices/) d'environnement de bureau, un basé sur Gnome phone shell et un sur Plasma Mobile.
En travaillant étroitement avec la communauté KDE, nous sommes parvenus à installer, faire tourner et même parvenu à voir le fournisseur de réseau fonctionner sur Plasma Mobile !
Le but de cet article est de vous montrer nos progrès avec Plasma Mobile sur la dev board Librem 5 actuelle.
Voyons, les étapes nécessaires et les challenges que nous avons surmontés.

## The Setup
La carte i.MX6 commençait par faire tourner [PureOS](https://pureos.net) (qui est basé sur Debian Testing) avec un environnement basé sur Weston.
Plusieurs paquets KDE et Qt ont été nécessaires pour l'environnement Plasma Mobile dont certains n'étaient pas dispo sur PureOS et ont donc été buildé manuellement : plasma-phone-components, kpeople-vcard et plasma-settings.
Pour une liste complète des étapes nécessaires pour installer Plasma Mobile sur la dev board, rendez-vous sur https://developer.puri.sm/PlasmaMobile.html . 

Une fois tout installé, lancer Plasma Mobile se fait via la commande : 
```
$ kwin_wayland --drm plasma-phone
```

## Challenge a surmonter n°1 : Le problème d'affichage mesquin
Lorsqu'on a lancé l'interface pour la première fois, le rendu n'était pas … correct.
En plus de cela, la pop-up de KDE wallet apparait (voir l'image).
 
{{< figure src="/static/84-glitch.jpg" link="/static/84-glitch.jpg" title="Léger bug d'affichage" alt="Photo de l'écran qui bug de partout." >}}

Séance de débuggage en perspective en dégainant gdb.
On s'est vite rendu compte qu'en commentant la ligne *QT_QPA_PLATFORM=wayland* dans le script plasma-phone, que le soucis disparaissait.
Mais la variable QT_QPA_PLATFORM est nécessaire pour que la plateforme soit wayland.
La question devîent donc *"Pourquoi le driver graphique, etnaviv, ne fonctionne pas sous wayland ?"*

Il s'est avéré que la pièce manquante du puzzle se situé dans le protocole *zwp_linux_dmabuf* qui n'était pas encore supporté par Plasma.
Pour savoir pourquoi zwp_linux_dmabuf est nécessaire au driver Etnaviv, je vous invite à lire [cette annonce](https://www.pengutronix.de/en/2017-09-28-etnaviv-weston-mainline.html).

Il existait déjà un rapport de bug upstream à ce sujet, avec des patchs pour kwin et kwayland. Merci à Fredrik Höglund pour son travail sur zwp_linux_dmabuf.

Nous avons incorporé les patchs upstreams sur notre version de kwin et kwayland et voilà !
Nous sommes désormais capable d'exporter la variable QT_QPA_PLATFORM et d'avoir un joli Plasma tout propre.

{{< figure src="/static/84-display-full.jpg" link="/static/84-display-full.jpg" alt="Capture d'écran de Plasma Mobile sans son bug" title="Plasma Mobile sans son bug" >}}
{{< figure src="/static/84-screenlock.jpg" link="/static/84-screenlock.jpg" alt="Capture d'écran de l'écran de verrouillage de Plasma Mobile" title="L'écran de verouillage de Plasma Mobile" >}}

## Challenge à surmonter n°2 : La souris invisible
Il était évident que le clavier fonctionnait, puisque nous avons pu taper notre mot de passe pour se connecter depuis l'écran de verrouillage.
La souris, par contre, était introuvable.
Par contre, en bougeant la souris à l'aveugle et en cliquant, il était possible d'ouvrir des applications.

Le problème vient du fait que le driver DRM (Direct Rendering Manager, interne au kernel) ne fournit pas de plan de curseur.
Il existe déjà un impressionnant rapport de bug à ce sujet.

Par contre, dans un premier temps, on peut contourner le soucis en appuyant sur Ctrl+Super pour afficher des cercles autour du curseur, comme vous pouvez le voir sur la vidéo :
<video class="wp-video-shortcode" id="video-49252-1" width="100%" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/03/plamo_on_l5.webm?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/03/plamo_on_l5.webm?_=1"></a></video>

C'est suffisant pour nos besoins actuels, puisque nous recevrons l'adaptateur tactile manquant pour l'écran de dev et nous n'aurons donc plus besoin d'un curseur traditionnel.

## Challenge à surmonter n°3 : Opérateur mobile
Naturellement, le prochain challenge est de passer un appel téléphonique.
D'abord, la carte SIM doit être reconnue et les informations de l'opérateur mobile.
Ceci nécessite des paquets supplémentaires dont certains ont dû se compiler hors dépôt.
Pour que le Sierra Wireless MC7455 reconnaisse la carte SIM, il a fallu envoyer un code PIN, connecter le modem, raccorder les antennes.
Puis, quand Plasma Mobile a démarré, on a pu voir le nom de l'opérateur et la force du signal dans le coin en haut à gauche !
{{< figure src="/static/84-operateur.jpg" link="/static/84-operateur.jpg" alt="Photo de l'écran montrant l'opérateur et la puissance du signal affiché dans le coin" title="La fierté d'afficher le nom de l'opérateur et la puissance du signal dans le coin !" >}}

À cause du modem installé actuellement sur notre board i.MX 6, nous n'avons pas pu passer d'appels.
Mais pas de panique, le Librem 5 aura un modem capable de téléphoner ;-)

## Une étape de franchie, 9000 restantes
Avec la communauté, Purism a progressé dans le support de Plasma Mobile sur le Librem 5.
Il reste de nombreux efforts et la collaboration avec la communauté Plasma permettra d'avoir un environnement fonctionnel lors de la sortie du Librem 5.

Du 27 Février au 1er Avril, Todd et Nicole seront à l'Embedded World Electronics Supplier Trade Show à Nürnberg en Allemagne pour rencontrer de potentiels fournisseurs et tout particulièrement des représentants de chez NXP et du distributeur EBV Elektronik.
En plus, nous avons eu de nombreux meetings avec des fournisseurs de composants WiFi, BlueTooth et de capteurs et nous avons également discutés avec des fabricants et designers de boards.

Cet évènement et ces discussions nous préparent pour notre prochain voyage à Shenzhen, le Silicon Delta de la Chine.
Nous avons des rendez-vous avec différents fournisseurs intéressés pour collaborer avec nous sur le Librem 5 ainsi que d'autres de nos projets matériels.
Nous aurons deux semaines intensives sous forme de marathon de rendez-vous pour définir nos choix matériels et le choix de fournisseurs pour notre projet.

---------------
Ha bel avancement ce coup-ci.
Les avancées sur Plasma Mobile sont encourageantes.
Encore et toujours des rendez-vous à droite à gauche pour trouver les fournisseurs.
