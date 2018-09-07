+++
Author = "Lord"
description = "20ème article d'avancement du Librem 5."
PublishDate = 2018-09-07T10:03:26+02:00
date = 2018-09-07T10:03:26+02:00
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
title = "20ème article d'avancement du Librem 5, le vrai"
editor = "kakoune"
jdh = ""
+++

*Ouai je me suis merdé la fois d'avant, c'était pas le 20ème… mais je vous jure, ce coup-ci c'est le cas !*

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-20/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logicielles opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

## Conférences
Une partie de l'équipe Purism s'est retrouvée à l'Akademy 2018 à Vienne.
Cette conférence a simplifié le contact avec les devs KDE et c'était sympa de se rencontrer en personne !

> We would like to express our gratitude to @Puri_sm, not only for sponsoring #Akademy2018, but also for working with our developers so we can have a Plasma Mobile-based smartphone soon.
> 
> — Akademy (@akademy) August 20, 2018

Certains membres sont également allés au [FrOSCon](https://www.froscon.de/en/).
Prochainement, [Todd tiendra une conférence au AllThingsOpen](https://allthingsopen.org/speakers/todd-weaver/) et aussi au [Capitole du Libre](https://2018.capitoledulibre.org/) où François et Adrien tiendront un stand (n'hésitez donc pas à aller leur dire bonjour si vous y êtes).

> We're excited to have Todd Weaver, Founder & CEO of @puri_sm, presenting at #AllThingsOpen! https://t.co/FXc3M9ENwi pic.twitter.com/piFRSZ5WOL
> 
> — All Things Open (@AllThingsOpen) August 29, 2018

## Design
De nombreuses améliorations ont été apportées au prototype du shell.
Ils seront bientôt finalisés !
De nouvelles icônes pointeront bientôt leur nez et nous les utiliserons dans nos builds de devs et dans les applications livrées avec le téléphone.
Les nouvelles icônes de GNOME sont prévues pour la 3.32 courant 2019.

## Côté logiciel

### Images
Les [images qcow2 sont archivées](https://source.puri.sm/Librem5/image-builder/merge_requests/40) ainsi que les images brutes.
Cela rend les images de machines virtuelles x86_64 plus accessible pour les plus impatients ou pour ceux n'ayant pas commandé le devkit.
Vous pouvez retrouver les builds les plus récents [ici](https://arm01.puri.sm/job/Images/job/Image%20Build/).
Ci-dessous vous pouvez voir une démo de la rotation sur l'image qcow2.
Égalemement, [quelques paquets ont été ajoutés aux images](https://source.puri.sm/Librem5/image-builder/merge_requests/39) pour permettre le redimensionnement de la partition racine pour occuper tout l'espace partitionné.

<video class="wp-video-shortcode" id="video-57997-1" width="642" height="800" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/08/L5-qcow2-rotation.webm?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/08/L5-qcow2-rotation.webm">https://puri.sm/wp-content/uploads/2018/08/L5-qcow2-rotation.webm</a></video>

Nous [transformons le paquet Debian de Plasma Mobile](https://arm01.puri.sm/job/plasma-debs/) en un [dépot Git convenable pour notre système de build](https://source.puri.sm/Librem5/Plasma) et [nous le buildons](https://arm01.puri.sm/job/debs/view/Plasma%20Mobile/).
Ces paquets seront éventuellement inclus dans l'image Plasma Mobile du Librem 5.
Nous collaborons actuellement avec les devs Plasma pour résoudre les problèmes de build restants.

### Phosh
De nombreuses corrections et modifications ont été apportées à Phosh ces dernières semaines.
[Les calculs de la taille ont été corrigé](https://source.puri.sm/Librem5/phosh/merge_requests/93) (et par la même occasion la position du menu) sur les affichages redimensionnés avec des modes personnalisés.
La [traduction allemande](https://source.puri.sm/Librem5/phosh/merge_requests/94) a été mise à jour.
[Désormais, un login shell est utilisé lorsqu'on démarre gnome-session](https://source.puri.sm/Librem5/phosh/merge_requests/96), ce qui s'assure que XDG_* est correctement initialisé, du coup les icones des applications flatpak sont correctement reconnues par phosh.
Pour assurer la robustesse de phosh, plus [d'alertes de compilations ont été activées](https://source.puri.sm/Librem5/phosh/merge_requests/100) et une partie de celles-ci ont été corrigées. 

### gnome-settings-daemon
Pour préparer le terrain concernant la configuration du modem, une [discussion avec l'upstream](https://gitlab.gnome.org/GNOME/gnome-settings-daemon/issues/70) a débuté afin de débattre sur la façon dont gnome-settings-daemon doit se comporter vis-à-vis des modems.

### Wlroots
Wlroots crashait lorsque phosh se reconnectait mais c'est maintenant [corrigé](https://source.puri.sm/Librem5/wlroots/issues/11).
Nous continuons de garder wlroots à jour avec les versions upstreams.

### GTK+ 4 et libhandy
Puisque le compositor et GTK+ doivent travailler main dans la main, un bug a été corrigé pour [faire en sorte que le app_id de xdg-shell corresponde à l'application-id de GApplication](https://gitlab.gnome.org/GNOME/gtk/merge_requests/284).
C'est donc plus simple pour le compositor de faire correspondre les applications avec les fichier .desktop dans Wayland.

Parmis les nombreuses et récentes corrections dans libhandy, il a été fait en sorte que le build soit plus fiable en [échouant en cas d'alerte](https://source.puri.sm/Librem5/libhandy/merge_requests/86).
Il y a trois bugs dans GTK+ qui affectent la possibilité de créer des interfaces utilisateurs adaptive : un [souci de coin non-rond](https://source.puri.sm/Librem5/libhandy/issues/21), un [problème d'affichage hors de l'écran](https://source.puri.sm/Librem5/libhandy/issues/22) et un bug qui [rend parfois le séparateur transparent](https://gitlab.gnome.org/GNOME/gtk/issues/1231).
Un [correctif a été proposé](https://gitlab.gnome.org/GNOME/gtk/merge_requests/268) pour le bug du séparateur.
Upstream, ils continuent de travailler sur le séparateur pour [ajouter un mode sélection alternatif](https://gitlab.gnome.org/GNOME/gtk/issues/1286) et [simplifier l'inclusion d'un séparateur](https://gitlab.gnome.org/GNOME/gtk/issues/1265) ce qui est nécessaire pour avoir des panneaux proprement définis dans HdyLeaflet.
En plus de ça, le runtime pour libhandy flatpak (org.gnome.Platform) a été [mis à jour depuis 3.26 vers master](https://source.puri.sm/Librem5/libhandy/merge_requests/92) afin d'être sur la toute dernière version.

### Clavier
Concernant l'<abbr title="On-Screen-Keyboard : le clavier virtuel">OSK</abbr>, l'ensemble de patch text-input-v3 a été ajouté à [wayland-protocols](https://cgit.freedesktop.org/wayland/wayland-protocols/commit/?id=db152d7c6f53adb60db8dfc046604a487002d927) et [gtk-3.24](https://gitlab.gnome.org/GNOME/gtk/commit/77b4c4432effe889d3dd7b54c58be7adaae445af).
Le support préliminaire de text-input-v3 a également été [ajouté dans wlroots](https://source.puri.sm/Librem5/wlroddots/commits/text_input_rebase).
En plus, un patch pour le protocole virtual-keyboard a été mis-à-jour et [est en cours d'évaluation](https://lists.freedesktop.org/archives/wayland-devel/2018-August/039239.html).
Une [RFC pour le protocole input-method-v2](https://lists.freedesktop.org/archives/wayland-devel/2018-August/039255.html) a été posté.
Préparrez-vous donc à taper sur votre clavier virtuel !

### Appels et messagerie
Puisque la décision d'implémenter un backend ModemManager à l'application Calls a été prise, quelques modifications dans cette appli sont nécessaires.
Pour donner plus de droits à ModemManager, [des fichiers policy kit ont été créés](https://source.puri.sm/Librem5/librem5-themes/merge_requests/3).
Pour améliorer l'interface de Calls, [une partie du code de l'affichage de Calls a été nettoyé](https://source.puri.sm/Librem5/calls/merge_requests/7) et [l'interface s'approche plus du design final](https://source.puri.sm/Librem5/calls/merge_requests/11).

De nouvelles fonctionnalités devraient bientôt voir le jour dans l'application Messaging.
Un nouveau plugin libpurple pour les SMS est en cours de dev et des tests avec la fenêtre debug de Pidgin pour vérifier que l'interface avec ModemManager fonctionne.
Des progrès ont lieu concernant l'interfaçage entre les objets Chatty GTK+ et les structures et signaux de libpurple UiOps.
Un [article concernant Chatty](https://puri.sm/posts/librem5-progress-report-19/) − complet avec une démonstration vidéo − a été publié donc lisez-le si vous ne l'avez pas déjà fait !

### Kernel
D'importants efforts ont été faits pour faire tourner le kernel 4.18 sur le devkit SoM.
Afin de simplifier le débuggage des freezes du kernel, nous avons contribué à [openocd](http://openocd.org/) pour ajouter la configuration de la carte pour le devkit and [alerter quand le CPU n'est pas stoppé par l'appel phys2virt](http://openocd.zylin.com/#/c/4647/).
Les gens d'OpenOCD nous ont grandement aidés pour cela !

Les efforts continuent dans le kernel concernant les autres morceaux.
Nous continuons le travail sur le driver de l'alimentation électrique et du chargeur de batterie avec les devs upstreams du kernel, ce qui mènera à son inclusion prochaine.
L'USB2 a été testé et fonctionne.
Il y avait quelques soucis d'horloge résolu depuis et le SDMA et le RTC fonctionnent correctement maintenant.

## Côté matériel
L'équipe hardware de Purism a envoyé à fabriquer les fichiers pour la fabrication des PCB et l'assemblage des prototypes.
Les fichiers sont en cours d'évaluation.

## Coté communauté
Un patron de rapport de bug a été ajouté aux projets phosh, libhandy, calls, chatty, docs et virtboards afin de guider les utilisateurs pour qu'ils fournissent les informations nécessaires.
Pour plus d'information à ce propos, lisez [notre page de doc sur les rapports de bugs](https://developer.puri.sm/Issues.html).

Un grand merci à toutes les équipes externes qui nous ont aidé en évaluant et incluant les modifications dans les projets upstreams.
Le temps et les contributions de chacun sont grandement appréciés.

C'est tout pour le moment.
Restez connectés pour plus de nouveautés à venir !


<hr>
Original par Heather Ellsworth.

Ha bha enfin ça parle un peu plus de Plasma Mobile !

Bon sinon pas grand-chose à dire.
Encore une fois désolé, je pensais que le précédent article était l'avancement 20 mais non c'était un hors-série…
