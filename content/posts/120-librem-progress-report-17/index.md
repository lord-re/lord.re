+++
Author = "Lord"
Description = ""
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-08-04T13:39:56+02:00
date = 2018-08-04T13:39:56+02:00
title = "17ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/eityvw/17_me_article_davancement_du_librem_5"
TopWords = [  "sécurité", "upstream", "calls", "implémentation", "support", "librem", "wlroots", "merge_requests", "phosh"]
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-17/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logicielles opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>
L'équipe du Librem 5 a été pas mal occupée par le GUADEC avec de nombreuses avancées dans le dev.
Voilà un petit récap de ce qu'il s'est passé ces dernières semaines.

## GUADEC
Récemment, la majorité des membres de l'équipe étaient au GUADEC.
Certains ont même donné des conférences.
Même si certaines ne sont pas encore montées, en voilà certaines à regarder :

  - [Input methods, wayland and upstreams](https://www.youtube.com/watch?v=bPF5j56gaic) par Dorota Czaplejewicz
  - [Designing GNOME Mobile](https://www.youtube.com/watch?v=b1PVepoAxxw) par Tobias Bernard
  - [Making a Phone Call with GNOME](https://www.youtube.com/watch?v=3Zd_pYu-1r4&feature=youtu.be) par Bob Ham (aller directement à [la démo](https://www.youtube.com/watch?v=3Zd_pYu-1r4&t=17m31s)
  - [Librem 5 BoF session notes](https://wiki.gnome.org/GUADEC/2018/Hacking%20days/Librem5BoF/Notes)

D'autres confs ont eu lieu concernant la sécurité et l'implémentation de l'interface de téléphonie avec GTK+.
Nous vous fournirons les liens lorsque leurs montages seront terminées.

## Design
Le Librem5 sera beau mais cela ne se fait pas sans effort.
Dernièrement, notre équipe design s'est acharné sur la création d'un nouveau pack d'icônes pour GNOME 3.30 qui sera utilisé par le téléphone.
Ils ont aussi créé de nouvelles maquettes pour les réglages propres à la téléphonie avec plus de réglages avancées en peaufinant également le shell.

## Travail logiciel

### Images
Les images prenaient trop de temps à être créées, mais nous sommes parvenus à accélérer la procédure en faisant quelques ajustements.
Cela simplifie le dev et les tests.
Les images ne sont pas encore complètement basées sur PureOS (toujours sur Debian buster) mais ça arrivera bientôt.
Si vous avez utilisé la [machine virtuelle x86_64](https://developer.puri.sm/Boards/qemu.html), vous serez heureux d'apprendre que les nouvelles images permettent de [redimensionner la partition racine](https://source.puri.sm/Librem5/image-builder/issues/8) pour s'accommoder de plus d'espace (31Go).
Il sera donc plus simple de dev puisqu'auparavant elles étaient limitées à 3.6Go.
Il y a encore certains aspects à peaufiner mais c'est déjà fonctionnel.

### Phosh
[Phosh](https://source.puri.sm/Librem5/phosh) a connu de nombreuses améliorations sous le capot sous forme de corrections de bugs tels que [de nombreux crashs potentiels](https://source.puri.sm/Librem5/phosh/merge_requests/86/commits) et des initialisations manquantes.
Le bouton de luminosité est également réparé pour [se comporter normalement lorsqu'il bouge](https://source.puri.sm/Librem5/phosh/merge_requests/90).

Le <abbr title="pas trop sû traduire celui-là, désolé">Wayland global handling</abbr> a été [bougé dans un GObject séparé][https://source.puri.sm/Librem5/phosh/merge_requests/84).
Le gestionnaire de verrouillage a été [ajouté](https://source.puri.sm/Librem5/phosh/merge_requests/85) pour désencombrer (il récupère la tempo de timeout depuis GSettings maintenant) et tous les Layersurfaces ont été converties en [PhoshLayerSurfaces](https://source.puri.sm/Librem5/phosh/merge_requests/87).

Ce sont tous ces petits nettoyages de code qui permettront d'obtenir des contributions de la communauté car plus le code est bien organisé, plus est simple à comprendre et donc y contribuer.

L'intégrité de phosh est capitale puisque ce sera l'interface du téléphone donc [un smoketest gitlab a été mise en place](https://source.puri.sm/Librem5/phosh/merge_requests/80) pour passer phosh dans [Valgrind](http://valgrind.org/).
Il y a également un début du support de l'internationalisation du coup des traductions [espagnole](https://source.puri.sm/Librem5/phosh/merge_requests/77) et [allemande](https://source.puri.sm/Librem5/phosh/merge_requests/94) ont été ajouté.

Quelques bugs ont également été éradiqués de phosh.
Comme mentionné lors du [dernier article d'avancements](https://puri.sm/posts/librem5-progress-report-15/), des avancées ont été faites pour le support de [redshift](https://www.gnome.org/news/2017/03/gnome-3-24-released/attachment/night-light/).
Le code est [inclus dans la branche principale](https://source.puri.sm/Librem5/phosh/merge_requests/58) ainsi qu'un correctif de bug concernant des <abbr title="situation de compétition selon wikipedia mais franchement…">races conditions</abbr> lors de l'énumération des modes vidéos.
[Phosh/wlroots peuvent être démarrés par gnome-session](https://source.puri.sm/Librem5/phosh/merge_requests/83) et un [bouton accueil (logiciel) a été créé](https://source.puri.sm/Librem5/phosh/issues/27) en bas de l'écran.

### Wlroots
Du côté de wlroots de nombreux changements ont eu lieu.
Quelques [patchs pour le support de modes vidéos personnalisés a été inclus upstream](https://github.com/swaywm/wlroots/pull/1095).
Puisque le Librem5 ne supportera pas <abbr title="Le protocole X11 utilisé depuis des lustres sur les Unix">X</abbr>, nous devions virer les dépendances à xwayland.
Désormais [wlroots est compilé avec ET sans le support de xwayland](https://source.puri.sm/Librem5/wlroots/merge_requests/11).
Un [freeze de wlroots](https://source.puri.sm/Librem5/wlroots/issues/6) s'avère être causé par la déconnexion de la session ssh ayant lancé wlroots ce qui est [débattu upstream](https://github.com/systemd/systemd/issues/9674) pour savoir comment gérer ce cas.

### Clavier
Le clavier ([virtboard](https://source.puri.sm/Librem5/virtboard)) bénéficiera de l'important travail ayant lieu sur le protocole text-input.
Le [patch text-input-v3 a été mis à jour et envoyé upstream à Wayland](https://lists.freedesktop.org/archives/wayland-devel/2018-July/039131.html) pour revue.
Une [implémentation du protocole text-input pour GTK3 a été envoyé upstream](https://gitlab.gnome.org/GNOME/gtk/merge_requests/272) et est en cours.
Pour le support wlroots, [une implémentation a été prototypé](https://source.puri.sm/Librem5/wlroots/commits/text_input_rebase) et sera bientôt envoyé pour revue.

### Calls
Afin d'intégrer [Calls](https://source.puri.sm/Librem5/calls) dans gnome-settings-daemon et gnome-control-center, il nous est apparu évident lors des discussions au GUADEC que la meilleure façon de faire est d'utiliser [ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/) au lieu d'[oFono](https://01.org/ofono).
Bien que jusqu'à présent tous les essais a été fait pour l'implémentation d'oFono, c'est un changement inévitable.
L'implémentation initiale du backend ModemManager pour Calls est complète et les tests ont commencé.

L'interface de Calls s'est grandement amélioré pour ressembler aux maquettes de l'équipe design.
En dessous vous pouvez voir l'implémentation (gauche) et sa maquette (droite).

{{< img src="*120-calls-call-display.thumb.png" link="120-calls-call-display.png" alt="La maquette et l'application se ressemble comme deux gouttes d'eau" >}}

### Libhandy
Quelques bugs ont aussi été corrigés dans [libhandy](https://source.puri.sm/Librem5/libhandy/) ainsi que du travail pour préparer l'arrivée prochaine de GTK+4.
Un des problèmes réglé est une [fuite de mémoire](https://source.puri.sm/Librem5/libhandy/merge_requests/83).
Également, un [bug trouvé et corrigé dans HdyColumn](https://source.puri.sm/Librem5/libhandy/merge_requests/82) où une mauvaise largeur était utilisée pour les calculs de la hauteur de colonne.

Si vous suivez la [mailing-list librem-5-dev](https://lists.puri.sm/listinfo/librem-5-dev), vous avez probablement vu passer la sortie de libhandy v0.0.2.

### Epiphany/GNOME Web
Personne n'aime les pubs donc [Better](https://better.fyi/) le bloqueur de pub [a été suggéré pour inclusion upstream](https://gitlab.gnome.org/GNOME/epiphany/issues/77) pour être utilisé dans [epiphany](https://gitlab.gnome.org/GNOME/epiphany). 

### Messaging
Les technologies de messagerie vont être séparées en deux applis distinctes.
Une dédiée aux conversations à deux personnes ou pour les petits groupes (Chatty) et l'autre pour les discussions publiques comme sur les salons IRC (Fractal).

L'application Chatty est développé par Purism, s'appuie sur libpurble et permettra des communications E2EE par messages XMPP via OMEMO dès la sortie (lorsque les Librem seront livrés en janvier), ainsi que les SMS non chiffrés.
Puisque nous nous sommes rendu compte qu'il nous fallait utiliser ModemManager en lieu et place d'Ofono, un handler D-BUS a été créé pour le backend ModemManager de l'application.
Avec cette installation de ModemManager, envoyer et recevoir des SMS fonctionne.

Le client Fractal ne permettra pas forcément les communications E2EE dès la sortie, mais nous travaillerons pour que cela arrive.

### Sécurité
La sécurité est l'un de nos aspects favoris (vous l'avez peut-être remarqué) donc des recherches ont été commencés à propos de TrustZone, TPM et autres.
Nous avons eu quelques discussions internes à propos d'un boot anti-sabotage, Heads et la sortie vidéo par les modes alternatifs de l'USB.
Nous envisageons sérieusement l'implémentation de mesures de sécurité dans le Librem 5.

### Kernel
Avoir un kernel fonctionnel pour l'i.MX8M n'est pas une mince affaire.
Après de gros efforts, nous sommes parvenus à avoir l'ethernet fonctionnel.
Afin de faire marcher le <abbr title="Direct Rendering Management, rien à voir avec les Digital Rights Management">DRM</abbr> et l'affichage, nous avons d'abord porté le support du PCIe.
Le second port SD fonctionne mais pas SDIO (la carte SDIO étant alimenté par USB), il va falloir le support de l'USB en premier.
Plus d'appareils i2c ont été activés.
La carte nécessitera également un chargeur de batterie et donc nous testons actuellement le BQ25896 de TI, mais un [driver d'alimentation électrique a été ajouté et soumis upstream](https://lkml.org/lkml/2018/7/23/760).

Il reste un important chemin à parcourir avant d'avoir un kernel pleinement fonctionnel avec tous les drivers en ordre, particulièrement pour tout ce qui concerne l'affichage.
S'il y a des experts en drivers graphiques prêt à filer un coup de main, merci de nous contacter sur [le salon de discussion Matrix](https://developer.puri.sm/Contact.html#matrix-chat-rooms).

## Travail matériel
Nous travaillons toujours d'arrache-pied avec le potentiel fabricant des cartes de dev pour évaluer les schémas développés par nos ingénieurs matériel et faire les changements suggerés.
Cependant, certaines choses sont maintenant gravés dans le marbre et de nombreux composants ont déjà été commandés.
Voici donc ce que vous trouverez à coup-sûr sur les cartes de devs :

  - SoM : [EmCraft’s i.MX 8M System-On-Module](https://www.emcraft.com/products/868)
  - Écran : LCD de 5.7 pouces en 720x1440 pixels
  - Modem : [SIMCom 7100A](http://simcomm2m.com/En/module/detail.aspx?id=84)(version USA) ou [SIMCom 7100E](http://simcomm2m.com/En/module/detail.aspx?id=86)(version Europe) en fonction de votre lieu d'habitation.
  - module Wifi+BT : [module Redpine RS9116 M.2](http://www.redpinesignals.com/Products/Embedded_Connectivity/Wi-Fi_SoCs_&_Modules/RS9116_SoCs_&_Modules/). Il supporte les bandes 2.4GHz et 5GHz pour le wifi mais pas le 802.11AC
  - Capteur photo : la puce du capteur CMOS est la [Omnivision OV5640](https://cdn.sparkfun.com/datasheets/Sensors/LightImaging/OV5640_datasheet.pdf)

## Communauté
Il y a une nouvelle [FAQ](https://developer.puri.sm/FAQ.html) sur le site de documentation basés sur les questions reçues sur [le salon de discussion matrix community/librem-5](https://matrix.to/#/%23community-librem-5:talk.puri.sm).
Nous n'y mettrons pas TOUTES les questions car cela nécessiterait trop de temps mais certainement les plus fréquentes.

Un grand merci à toutes les équipes externes qui ont évalué et inclus les patchs dans les différents projets upstreams.
Le temps et les contributions de tout le monde sont fortement appréciées.

C'est tout pour le moment les amis.
Restez branchés pour plus de mises à jour à venir !

<hr>
Original par Heather Ellsworth

Bon on sent que cet article a été rédigé en parallèle du précédent car il y a un peu de redites.
D'un point de vue logiciel ça progresse vraiment bien dans tous les projets connexes.
C'est agréable de voir plusieurs communautés collaborer (plus ou moins indirectement) vers un but commun : les joies du libre.

D'un point de vue matos ils ont l'air d'avoir la majeure partie des composants arrêté, ce qui est bon signe.

Ils semblent toujours confiants pour janvier 2019.

Ils commencent à aborder les aspects de sécurité et ça semble plutôt encourageant.
On peut s'attendre à avoir un truc qui les différencie des habituels Android/IOS.
Ça pourrait être un argument de vente pour certaines personnes pas spécialement touchées par le Libre mais plus pour la sécurité.
