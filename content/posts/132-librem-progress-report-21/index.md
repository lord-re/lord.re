+++
Author = "Lord"
description = "21ème article d'avancement du Librem 5. Ça parle de … tout. Ouai c'est un bon résumé."
PublishDate = 2018-10-16T18:16:47+02:00
date = 2018-10-16T21:16:47+02:00
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
title = "21ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = ""
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-21/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logicielles opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref, voilà l'article :

----------------------------------

Bonjour tout le monde !
Et bhé, ces dernières semaines fûrent bien remplies.
Voilà un rapport détaillé des avancées faites sur les différents fronts du Librem 5.

## Conférences

Diverses collaborations in situ ont eu lieu.
Il y a eu un hackfest en Allemagne où une grande partie des membres de l'équipe Librem 5 s'est rendu pour bidouiller (hacker), travailler et renforcer l'esprit d'équipe.
Nous avons également participé au [Libre Application Summit](https://las.gnome.org/conferences/LAS) où nous avons donné [une conférence au sujet du Librem 5](https://twitter.com/LASGNOME/status/1038536036501086209).
C'était aussi génial d'avoir pu participer au [XDC](https://xdc2018.x.org/) où nous avons pu avoir des discussions utiles concernant [wlroots](https://swaywm.org/) et [Pengutronix](https://www.pengutronix.de/de/).

## Design

Le design logiciel avance et s'améliore afin que les devs puissent avancer.
Voici certains de ces derniers designs :

  - [Les dernières maquettes de Shell](https://gitlab.gnome.org/Teams/Design/os-mockups/tree/master/mobile-shell)
  - [Les dernières maquettes de Messages](https://gitlab.gnome.org/Teams/Design/app-mockups/tree/master/messages)
  - [Les dernières maquettes des réglages mobiles](https://gitlab.gnome.org/Teams/Design/settings-mockups/blob/master/cellular/cellular-panel-adaptive.png)

## Travail logiciel

### Les images
Les images sont toujours basées sur Debian Buster, mais elles peuvent maintenant [se baser sur PureOS](https://source.puri.sm/Librem5/image-builder/merge_requests/26).
Pour décrouter un peu les images, quelques [scripts SSHd pour la génération des clés ont été ajoutés](https://source.puri.sm/Librem5/gen-sshd-host-keys) à l'image et des dépendances ont été déplacés dans le paquet [librem5-base](https://source.puri.sm/Librem5/librem5-base).

Comme à la fois les kits de devs et les téléphones se baseront sur des cartes i.MX 8M SoM, beaucoup de travail a été fait pour rendre le kernel 4.18 compatible et [construire les images](https://source.puri.sm/Librem5/librem5-base) pour ces cartes.

### Phosh
Dans [phosh](https://source.puri.sm/Librem5/phosh), de nombreux bugs ont été corrigés et le code a été nettoyé.
Des efforts ont également été fait concernant les traductions : l'allemand et le français ont été mis-à-jour, les [entêtes po ont été standardisés](https://source.puri.sm/Librem5/phosh) pour simplifier le travail pour de nouveaux traducteurs.

Un [premier app switcher a été ajouté](https://source.puri.sm/Librem5/phosh/merge_requests/109) ainsi [qu'un premier app switcher tactile](https://source.puri.sm/Librem5/wlroots/merge_requests/16).

{{< img src="app-switcher.thumb.png" alt="Capture d'écran de l'app switcher" link="app-switcher.png" >}}

Le [panneau de tête a été nettoyé](https://source.puri.sm/Librem5/phosh/merge_requests/129) ce qui le rend plus joli et le rapprochant un peu plus des maquettes.

{{< img src="top-panel.thumb.png" link="top-panel.png" alt="Capture d'écran montrant le fameux panneau ainsi que des terminaux." >}}

Si cela ne suffisait pas, la [première version (0.0.1) de phosh a été libellé](https://source.puri.sm/Librem5/phosh/tags/v0.0.1) !

### GNOME Settings
L'application [GNOME Settings](https://wiki.gnome.org/Design/SystemSettings/) [commence à être porté](https://twitter.com/KekunPlazas/status/1042805914946990080) au Librem 5 et continue d'être travaillé.

### gnome-session/gnome-settings-daemon
Un bug upstream concernant le démarrage de gnome-session en mode débug [est résolu](https://gitlab.gnome.org/GNOME/gnome-session/merge_requests/7/diffs).

Sur le plan des plugins il y a eu des avancées.
Un [premier plugin WWAN](https://gitlab.gnome.org/GNOME/gnome-settings-daemon/merge_requests/43) a été proposé upstream pour prendre en charge le déverrouillage de la SIM par code PIN.

Ce gnome-settings-daemon a [été ajouté aux images](https://source.puri.sm/Librem5/deb-build-jobs/merge_requests/25) en attendant qu'il soit intégré upstream afin de déjà pouvoir gérer le déverrouillage de la SIM.

{{< img src="unlock.thumb.png" link="unlock.png" alt="capture d'écran du vérrouillage de l'OS demandant un code PIN" >}}

### Wlroots/Keyboard
De nombreuses améliorations ont eu lieu au niveau de [virtboard](https://source.puri.sm/Librem5/virtboard).
Parmis les nombreuses corrections de bugs, il y a notamment eu celui concernant [l'affichage et la mise à l'échelle](https://source.puri.sm/Librem5/virtboard/issues/2).
L'input-method-v2, la text-input-v3 et le liant ~~[ont été ajoutés](https://source.puri.sm/Librem5/wlroots/tree/input)~~ à virtboard et input-method-v2 est [en cours d'adoption upstream](https://github.com/swaywm/wlroots/pull/1203).
Virtboard apparait désormais et démarre par défaut sur les images et le clavier a été amélioré pour se comporter comme on l'attendrait.

<video class="wp-video-shortcode" id="video-61143-1" width="640" height="427" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/10/keyboard6.webm?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/10/keyboard6.webm">https://puri.sm/wp-content/uploads/2018/10/keyboard6.webm</a></video>

Dans le même ordre d'idée, des changements ont été adoptés upstream dans wlroots et GTK+ en plus de tout ça.
Nous avons [corrigé des problèmes concernant les claviers virtuels dans GTK+](https://gitlab.gnome.org/GNOME/gtk/merge_requests/302).
Il est important que les mouvements du curseur soit traités relativement aux surfaces et pas uniquement à l'écran.
Nous avons donc codé [un patch](https://github.com/swaywm/wlroots/pull/1196) à ce propos.
Il y avait aussi [un problème sur la génération de tag](https://github.com/swaywm/wlroots/issues/725) qui est [corrigé et soumis upstream](https://github.com/swaywm/wlroots/pull/1196).

### Calls
L'application [Calls](https://source.puri.sm/Librem5/calls) a connu de nombreuses améliorations récemment avec de nombreuses corrections de bugs, des avancées audio et un ravalement de façade de l'interface utilisateur.
On peut désormais [ouvrir le GTK+ Inspector sur la version flatpak de Calls](https://source.puri.sm/Librem5/calls/merge_requests/5).

Pour préparer les kits de développement, un driver dérivé de QMI pour ModemManager pour les modems SIMCom a été complété pour mélanger QMI et les commandes AT pour le streaming audio et ajouter le support des appels audio.
Un [paquet Debian de ModemManager a été créé](https://source.puri.sm/Librem5/ModemManager/tree/debian/sid) et contient ces patchs pour les appels.

Puisque les modems utilisés sur les téléphones seront potentiellement différents de ceux des kits de devs, des tests sont faits sur le [Gemalto PLS8](https://www.gemalto.com/m2m/solutions/modules-terminals/industrial-plus/pls8).

Il y a aussi eu une [refonte partielle de l'interface utilisateur](https://source.puri.sm/Librem5/calls/merge_requests/11) avec de nombreux changements intéressants à venir !

Il y a un nouveau daemon, [Hægtesse](https://source.puri.sm/Librem5/haegtesse) pour convoyer le flux de données audio entre le modem et PulseAudio.
Le daemon est intégré dans nos images et se lance au démarrage.

### Libhandy
La bibliothêque [libhandy](https://source.puri.sm/Librem5/libhandy) a aussi eu droit à son lot d'avancées depuis la dernière fois.
En plus des corrections de bugs mineurs, deux widgets ont été ajoutés.
Un [widget HdyTitleBar a été ajouté](https://source.puri.sm/Librem5/libhandy/merge_requests/105) pour contourner les glitches de la barre de titre et un [widget HdyHeaderGroup a aussi été ajouté](https://source.puri.sm/Librem5/libhandy/merge_requests/119) pour mettre à jour automatiquement tous les entêtes des barres.
Le widget existant [HdyLeaflet a reçu une nouvelle propriété pour plier](https://source.puri.sm/Librem5/libhandy/merge_requests/120).
Pour aider la communauté à jouer avec libhandy, [l'application d'exemple de libhandy a été mise à jour avec des corrections de style](https://source.puri.sm/Librem5/libhandy/merge_requests/101).

[Libhandy 0.0.3 est sortie](https://source.puri.sm/Librem5/libhandy/tags/v0.0.3) et [envoyée à Debian unstable](https://packages.debian.org/source/sid/libhandy) mais une nouvelle [version 0.0.4 est sortie entre-temps](https://lists.puri.sm/pipermail/librem-5-dev/2018-October/000020.html).

C'est d'autant plus excitant de voir libhandy utilisé dans la nature.
[Podcasts](https://wiki.gnome.org/Apps/Podcasts) est la première application tiers à recourir à libhandy !
Voilà une courte vidéo démontrant les avancées de libhandy et le comportement actuel.

<video class="wp-video-shortcode" id="video-61143-2" width="640" height="360" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/10/libhandy-bug-fixes.webm?_=2" /><a href="https://puri.sm/wp-content/uploads/2018/10/libhandy-bug-fixes.webm">https://puri.sm/wp-content/uploads/2018/10/libhandy-bug-fixes.webm</a></video>

### GTK+
Notre collaboration rapprochée avec l'équipe GTK+ a amené de nombreux changements dans les séparateurs entre autre.
Un [bug de style sur les séparateurs selection-mode](https://gitlab.gnome.org/GNOME/gtk/issues/1286) a été rapporté et [l'apparence des séparateurs a été amélioré](https://gitlab.gnome.org/GNOME/gtk/merge_requests/309) lorsqu'on sépare deux barres d'entête en mode sélection.
Des corrections supplémentaires pour Adwaita concernant les séparateurs, les problèmes de barre de titre et la simplification des réglages de sélection de mode [ont été intégré upstream](https://gitlab.gnome.org/GNOME/gtk).

D'autres corrections et des modifications de la documentation ont été intégrés upstream.
Par exemple, une correction à propos de l'entrée des [numéros de séries lorsque text-input est en cours](https://gitlab.gnome.org/GNOME/gtk/merge_requests/339] \(c'est un pré-requis pour le clavier\).

Et si vous ne l'avez point encore lu, jetez un œil à [l'article de blog de Guido Gunther à propos de GTK+ et des application id](https://honk.sigxcpu.org/con/GTK__and_the_application_id.html).
Cela vous sera d'une aide précieuse si vous prévoyez d'écrire des applications flatpak pour le Librem 5.

### Upower
[Upower](https://upower.freedesktop.org/) est un bon candidat pour devenir l'API que les autres applications utiliseront pour par exemple obtenir des informations concernant la batterie donc de [nombreuses améliorations de la documentation ont été ajouté](https://gitlab.freedesktop.org/upower/upower/merge_requests/10).

### Contacts
L'application Contacts doit être rendu adaptive grâce à libhandy donc voilà [le fork adaptif de Contacts](https://gitlab.gnome.org/Community/Purism/gnome-contacts/tree/wip/aplazas/adaptive).
Des modifications ont été apportées upstream pour pouvoir être potentiellement fusionné.
Une simple [correction du style de séparateur](https://gitlab.gnome.org/GNOME/gnome-contacts/merge_requests/31) et une simple [correction des conditions de taille](https://gitlab.gnome.org/GNOME/gnome-contacts/merge_requests/32) ont été soumis upstream.
L'[application de menu](https://gitlab.gnome.org/GNOME/gnome-contacts/merge_requests/33) et de [raccourcis des comptes online](https://gitlab.gnome.org/GNOME/gnome-contacts/merge_requests/34) devaient également bouger.

### Messaging
L'application [Chatty](https://source.puri.sm/Librem5/purism-chatty) apporte de nombreuses améliorations et changements.
Chatty peut également être empaqueté dans un flatpak désormais.

La vue "en bulle" est en train d'être transformé en widget et une version basique du widget msg-list est en train d'être completée et sera prochainement inclue dans libhandy.
Quelques modifications dans GTK+ étaient requis pour afficher les conversations libpurple dans des chat-lists séparées et la liste d'amis est désormais fonctionnelle !

Un plugin libpurple est à l'essai pour la conservation des messages dans une base de données SQLite.
Mais pour rendre cela utilisable, il faut d'abord remplacer les fonctionnalités de journalisation de libpurple avec un sous-système capable de gérer la signalisation des SMS (envoyé/lu…).
Un parser pour les fichiers de log purple a été créé pour que l'historique de conversation soit affiché dans msg-bubbles.
Le parser est la solution temporaire pour afficher l'historique des conversations dans message-view pour le moment.

Nous travaillons actuellement sur la gestion des comptes.
Quelques écrans de configuration ont été ajoutés pour la création de comptes XMPP et pour les activer/désactiver séparémment.
Il y a aussi eu des avancées sur l'interface utilisateur Blist (formattage des entrées, icônes rondes, passer la police en gras lorsque les messages sont non lus, ajout d'un horodatage) pour améliorer l'esthétique.

### Kernel/mesa/etnaviv/libdrm
Comme mentionné plus tôt, un nouveau CPU (i.MX8) sera dans les devs kits et les téléphones en lieu et place des I.MX6 initialement prévus.
Du coup, il faut redoubler d'effort pour faire tourner un nouveau kernel sur ce nouveau CPU ainsi que sur etnaviv et mesa.
Voilà les principaux points.

Puisque les dev kits et les téléphones auront un USB type-C avec Power Delivery, [un patch a été soumis upstream](https://lkml.org/lkml/2018/9/11/614) pour supporter cela.

Etnaviv [fonctionne quasiment](https://twitter.com/GuidoGuenther/status/1032898450180980736) avec notre couche drm (direct rendering manager, pas digital right management) sur arm64 avec un kernel 4.18.
Etnaviv a été [activé sur la version Debian de libdrm](https://salsa.debian.org/xorg-team/lib/libdrm/merge_requests/1).
Plus de décalages vers les états sensibles ont été [ajouté](https://lists.freedesktop.org/archives/etnaviv/2018-September/001953.html) à etnaviv pour éviter les alertes et un patch a été [intégré upstream](https://github.com/etnaviv/etna_viv/pull/7) pour permettre au parser de commandes de travailler.

[Notre arbre mesa](https://source.puri.sm/guido.gunther/mesa) est disponible en attendant que les patchs soient intégrés upstream.
Les compilations aarch64 de mesa ont été [amélioré](https://lists.freedesktop.org/archives/mesa-dev/2018-August/203532.html).
Un patch pour une vérification d'alignement a été [proposé](https://lists.freedesktop.org/archives/mesa-dev/2018-September/205347.html) et des problèmes de mappage non mis en cache sur arm64 furent [corrigés](https://lists.freedesktop.org/archives/mesa-dev/2018-October/206131.html).

Nous aimerions remercier les mainteneurs d'etnaviv, du kernel linux, libdrm et mesa pour leur support puisque nous nous appuyons fortement sur ce qu'ils ont déjà construis au préalable et qu'ils sont d'une grande aide pour l'intégration upstream de ces patchs.

### Fractal
Puisque nous investissons également dans l'effort de fractal pour le chiffrement de bout-en-bout (E2E pour end-to-end), nous sommes contents d'annoncer que le module E2E en développement supporte les fonctionnalités basiques désormais.
Nous pouvons déjà commencer à l'intégrer et travailler dessus.
Il reste beaucoup de travail à faire, mais on y arrive petit à petit.

## Côté matériel
Nos ingénieurs matériel et Nicole travaillent étroitement avec l'équipe d'assemblage des devkits.
Pour cela, les fichiers finaux de prototypage (de fabrication de prototype et les dessins d'assemblage de KiCad) ont été envoyé a l'équipe d'assemblage.
Nicole s'est rendu à Carlsbad (Californie) pour les assister pour la fabrication, l'assemblage et les tests d'un premier ensemble de devkits pour vérifier la qualité de notre design électronique.
Nous avons eu quelques soucis, comme par exemple des composants perdu lors de la livraison qu'il a fallu se re-procurer mais tous les obstacles ont été surmontés !
Si tout se passe bien avec les tests sur ces prototypes, la première fournée de devkits (qui sera livré aux backers) devrait commencer incessement sous peu.

## Côté communauté
L'équipe Librem 5 continue de collaborer avec l'équipe Plasma afin de créer une image utilisable avec les devkits.
Pour l'instant, [des tâches Jenkins sont nécessaires pour construire les paquets Plasma nécessaires](https://arm01.puri.sm/job/debs/view/Plasma%20Mobile/) et les membres de l'équipe Plasma travaillent avec nous pour corriger les soucis.

La [documentation pour devs](https://developer.puri.sm/) a vu [des mise-à-jour concernant GTK+](https://developer.puri.sm/Apps/GNOME/Gtk+.html) et de nouveaux exemples de code.

Puisque nous avons reçu des offres d'aide pour la traduction du système d'exploitation, nous avons [monté une instance Zanata publique](https://translate.zanata.org/) pour permettre à la communauté de collaborer.
Pour l'instant, le [projet phosh est disponible sur Zanata](https://translate.zanata.org/project/view/phosh), les autres projets suivront (libhandy, calls, chatty, virtboard).

Un grand "Merci !" pour toutes les équipes externes qui nous ont aidé à évaluer et intégrer nos modifications dans les différents projets upstream.
Le temps et les contributions de chacun sont grandement appréciées !

Merci pour tout, les gens.
Continuer de nous suivre pour le prochain rapport à venir.

------------
Heather Ellsworth


Encore un article qui résume pas mal tout ce qu'ils font un peu partout.
C'est pas mal du tout, surtout d'un point de vue kernel.

Mine de rien c'est sympa de voir qu'un produit commercial va permettre à tout un écosystème libre d'avancer et de bien progresser.

