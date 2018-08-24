+++
Author = "Lord"
Description = "Encore une fournée de nouvelles infos sur la conception du Librem 5 principalement logiciel ce coup-ci."
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-07-17T15:36:26+02:00
date = 2018-07-17T15:36:26+02:00
title = "15ème article d'avancement du Librem 5"
editor = "kakoune"
jdh="https://www.journalduhacker.net/s/njnljn/15_me_article_davancement_du_librem_5"
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-15/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>


Ces dernières semaines, l'équipe du Librem 5 a bossé d'arrache-pied pour améliorer la pile logicielle ainsi que pour finaliser les schémas du kit de dev.
Voici les progrès les plus marquants réalisé.

## Côté logiciel
### Images
Les images produites pour la carte i.MX6 utilisent désormais [phosh](https://source.puri.sm/Librem5/phosh) en shell par défaut et nous [expérimentons](https://source.puri.sm/Librem5/image-builder/merge_requests/26) sur PureOS comme OS de base (en lieu et place de Debian Buster).
Il y a désormais une image de machine virtuelle en architecture x86_64 en cours de création.
Vous pouvez suivre [ces instructions](https://developer.puri.sm/Boards/qemu.html) pour en avoir une copie et la faire tourner.
Cette machine virtuelle utilise la même résolution qu'utilisera le Librem5.

Alors que les images pour i.MX6 ont été faites pour le matériel actuellement en possession de l'équipe, elle continue d'être modifiées pour être utilisée sur la carte de dev i.MX8 et le téléphone.
Soit dit en passant, lors de nos investigations concernant le CPU du i.MX8, des soucis concernant la liberté du code ont été repérés et devront être résolus.
Pour en savoir plus à ce sujet, consultez l'article de blog [Résoudre les premiers soucis de FSF RYF pour le Librem5](https://puri.sm/posts/librem5-solving-the-first-fsf-ryf-hurdle/) (FSF RYF signifie Free Software Foundation - Respect Your Freedom).

L'image construite pour l'i.MX8 peut désormais booter un [kernel mainline très basique](https://source.puri.sm/Librem5/linux-emcraft/tree/imx8-4.18-wip) (au lieu du kernel du constructeur).
La prochaine étape est de faire fonctionner plus de composants ( comme l'affichage) et de reverser à la communauté ces changements.
Avec tout cela, l'image pour l'i.MX8 s'annonce plutôt bien.

### Phosh / Wlroots
À un moment ou à un autre, les utilisateurs seront sur leur Librem5 la nuit, donc avoir [redshift](https://www.gnome.org/news/2017/03/gnome-3-24-released/attachment/night-light/) fonctionnel permettra d'amoindrir l'impact de l'écran sur nos yeux.
Du boulot a été fait afin d'implémenter certaines API DBUS de [Mutter](https://developer.gnome.org/meta/stable/) dans Phosh afin, par exemple, de gérer la configuration de l'affichage ou bien de supporter redshift.
Désormais, phosh peut détecter les sorties vidéos, les modes vidéo supportés et les communiquer comme le fait mutter/gnome-shell afin que nome-settings et gnome-settings-daemon soit content.
C'est la base pour le futur [support du gamma (redshift)](https://source.puri.sm/Librem5/phosh/merge_requests/58).
Cela dépend d'un [patch pour wlroots](https://github.com/swaywm/wlroots/pull/1059) en cours de discussion.

D'autres améliorations ergonomique pour phosh ont été apportées.
La temporisation  de l'écran de verrouillage a été augmentée pour accorder [plus de temps pour se connecter](https://source.puri.sm/Librem5/phosh/merge_requests/59).
Également, les favoris et l'écran d'accueil ont été corrigés pour correctement [placer les colonnes et ajouter des barres de défilement quand nécessaire](https://source.puri.sm/Librem5/phosh/merge_requests/64).

Puisque phosh est le shell et qu'il travaille étroitement avec wlroots, ils sont tout deux des éléments centraux des images.
Il y a eu des mises à jour fréquentes afin que wlroots soit sur la dernière version upstream existante.
Un [bug mineur](https://github.com/swaywm/wlroots/pull/1034) a été corrigé sur wlroots afin d'améliorer la gestion des erreurs de compilations sur l'architecture armhf.
En sus, le support des modes vidéos personnalisés a été [ajouté à wlroots](https://github.com/swaywm/wlroots/pull/1095).
Les devs sur phosh travaillent sur [l'intégration des prompts-systèmes Gcr](https://source.puri.sm/Librem5/phosh/merge_requests/67).
Cela permettra de résoudre une foultitude de problèmes avec les fenêtres modales pour les authentifications comme par exemple pour le code PIN, le PUK, les mots de passe, les smart-cards et le porte-clef en utilisant ce qui est déjà intégré à Gnome.

### Clavier
Des avancées ont aussi été faites sur le clavier visuel ([virtboard](https://source.puri.sm/Librem5/virtboard)) ce qui fait que désormais il est intégré aux images.
Afin que virtboard soit affiché/caché lorsque nécessaire, l'intégration d'[une méthode d'entrée dans wlroots](https://lists.freedesktop.org/archives/wayland-devel/2018-May/038071.html) était un pré-requis et l'équipe GTK+ a été contactée concernant l'intégration du code de cette méthode d'entrée.
Nous travaillons a l'élaboration d'un patch pour sécuriser la méthode d'entrée dans notre compositeur.
Il y a eu des retours continus pour l'intégration du protocole de clavier virtuel.
En plus, le clavier s'adapte beaucoup mieux maintenant !

### Calls
L'application [calls](https://source.puri.sm/Librem5/calls) a également été ajoutée dans les images pour un accès simplifié.
Dans l'appli, l'envoi des [fréquences DTMF](https://en.wikipedia.org/wiki/Dual-tone_multi-frequency_signaling) a été ajouté comme cela il est possible d'entendre les fameux bips lors de la composition des numéros.

<video class="wp-video-shortcode" id="video-55414-1" width="960" height="540" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/07/Calls.webm?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/07/Calls.webm">https://puri.sm/wp-content/uploads/2018/07/Calls.webm</a></video>

Afin de rendre calls plus robuste,la possibilité de faire des tests unitaires, dans [oFono](https://en.wikipedia.org/wiki/OFono) le backend de l'appli, en utilisant [phonesim simulator](https://github.com/jpakkane/ofono-phonesim) a été envisagé.
Cependant, faire tourner ofonod nécessite les privilèges root pour réquisitionner le nom org.ofono, ce qui rend les tests quasiment infaisable.
Cependant, des tests unitaires ont été créés pour le fournisseur d'interface de Calls en utilisant l'implémentation dummy, ainsi que des test pour l'interface Origin et Call.

### Libhandy
Le widget GTK+ [libhandy](https://source.puri.sm/Librem5/libhandy) a grandi également.
HdyColumn a été ajouté afin d'ajouter le redimensionnement dynamique de colonne.
Des tests unitaires ont fait leur apparition pour HdyArrows (utilisé pour le balayage directionnel).
Une toute première version de libhandy est sortie et la version v0.0.1 a même été [envoyée sur Debian experimental](https://ftp-master.debian.org/new/libhandy_0.0.1-1.html) !

<video class="wp-video-shortcode" id="video-55414-2" width="960" height="540" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/07/HdyColumn.webm?_=2" /><a href="https://puri.sm/wp-content/uploads/2018/07/HdyColumn.webm">https://puri.sm/wp-content/uploads/2018/07/HdyColumn.webm</a></video>

### Epiphany / Gnome Web
Le navigateur web du Librem5 sera [Epiphany](https://wiki.gnome.org/Apps/Web) donc les modifications pour le rendre adaptifs ont été [implémentés upstream](https://gitlab.gnome.org/GNOME/epiphany/merge_requests/6) pour améliorer l'utilisation sur de petits écrans.
Un menu interne a [commencé a être implémenté](https://gitlab.gnome.org/GNOME/epiphany/merge_requests/11) mais n'est pas encore finalisé.

### Messaging
Une [application de démo](https://source.puri.sm/Librem5/purism-chatty) s'appuyant sur [libpurple](https://developer.pidgin.im/wiki/WhatIsLibpurple) a été esquissé afin qu'une conversation [XMPP](https://xmpp.org/about/technology-overview.html) soit établie vers [Dino](https://github.com/dino/dino).
Pour le chiffrement, une conversation [OMEMO](https://conversations.im/omemo/) tournant sur libpurple et le [plugin Lurch](https://github.com/gkdr/lurch) a pu être faite.
La récupération et l'affichage d'avatar et d'information de compte depuis une liste stockée en xml a été réussie.
L'interface ofono pour les SMS et XMPP a été implémentée dans l'application de démo également.

## Côté matériel
Des facteurs extérieurs ont causé des retards reposants la date initiale de livraisons de Juin concernant les kits de devs.
Lorsque nous établissions les schémas pour les cartes de devs, toutes les infos n'étaient pas disponibles ce qui nous a poussés à investiguer plus concernant de nombreux composants ( ex : les caméras, WLAN+BT, les batteries, les interrupteurs, les boutons, etc).
En plus des circuits devaient être ajoutés avant que les schémas puissent être considérés comme prêts par l'équipe de validation externe en charge de leur impression.
L'équipe matériel du Librem5 a donc finalisé tout ça et en est à la phase de commande des composants pour envoi chez le fabricant des cartes.

Notre estimation au doigt mouillé actuelle pour l'envoi des cartes de dev est d'Août 2018, nous vous tiendrons au courant plus en détail dans un futur article de blog plus détaillé.

## Communauté
Le [salon de discussion matrix](https://developer.puri.sm/Contact.html#matrix-chat-rooms) du Librem 5 a explosé avec de nombreux retours et questions.
Certains membres de la communautés se sont même mis en quête de bugs à corriger et d'ajout de documentation.
Suite aux demandes de la communautés, il y a désormais une [image de machine virtuelle en x86_64](https://developer.puri.sm/Boards/qemu.html) disponible qui ressemble comme deux gouttes d'eau à ce qu'utilise notre équipe sur les cartes i.MX6.

La collaboration entre Purism et la communauté Plasma se poursuit également.
Il y a désormais des version arm et aarch64 des [flatpaks de Plasma](https://community.kde.org/Guidelines_and_HOWTOs/Flatpak).
L'équipe Purism réfléchie activement à la création d'image Plasma pour les cartes i.MX6.

[La documentation pour dev](https://developer.puri.sm/) a connu d'important modifications pour mieux guider tout le monde au bon endroit :
    
    - La [page volontaire](https://developer.puri.sm/Volunteering/HowTo.html) a été mise à jour avec des instructions plus claires sur comment participer.
    - Quel que soit le type de carte (physique ou virtuelle), des étapes communes ont été ajoutées à [la page des premières étapes](https://developer.puri.sm/Boards/First-Steps.html)
    - Il y a dorénavant des [instructions](https://developer.puri.sm/Boards/qemu.html) sur la mise en route de l'image x86_64
    - [Un référentiel de contribution](https://developer.puri.sm/Contributing.html) a été posté afin d'établir une charte des process de communication
    - Une [page GTK+](https://developer.puri.sm/Apps/GNOME/Gtk+.html) a été ajoutée avec des exemples d'applications et l'ajout de documentation sur les labels adaptatifs.
    - Une page des [contraintes de téléphone](https://developer.puri.sm/Apps/Constraints.html) a été ajouté pour souligner quelques contraintes spécifiques à prendre en compte lors du dev d'applications pour le Librem 5.

Nous étions récemment au GUADEC en Espagne où nous avons pu interagir avec beaucoup de personnes attendant le Librem 5.
Nous communiquerons plus sur cet évènement lors d'un prochain article de progression.

{{< img src="*115-guadec.jpg" link="guadec.jpg" alt="Photographie de tous les participants au Guadec 2018" >}}

Un grand Merci à toutes les équipes extérieures nous ayant aidé en révisant et intégrant nos modifications dans les différents projets upstreams.
Le temps et les contributions de chacun sont grandement appréciés.

C'est tout pour le moment.
Restez-là pour de prochaines mises-à-jour à venir !

Heather Ellsworth


--------------------

Cela fait plusieurs fois que je ne sais pas comment traduire *upstream* donc je vais l'expliquer ici une bonne fois pour toute.

Dans le monde du libre, les codes sources sont disponibles et peuvent être modifiés/adaptés par chacun.
Cependant ces modifications ne sont pas forcément répercutées dans le projet d'origine.
Si un dev fait des modifs dans un logiciel, ce nouveau logiciel basé sur un autre s'appelle ça *un fork*.
Mais ce dev peut tout à fait avoir l'intention que ces modifs soient intégrées au projet d'origine, il va donc les soumettre à l'équipe du projet.
Cette équipe peut choisir d'intégrer ou non ces modifs.

Si elle accepte, tout va bien dans le meilleur des mondes.
Si elle refuse (parceque le code est moche, buggé, dans un autre langage, ajoute des dépendances non voulues, la façon de faire ne convient pas, le dev en question n'est pas en odeur de sainteté, le code en question n'est pas forcément très légal, le projet ne veux tout simplement pas de ces modifs, l'équipe est aux abonnés absents, bref pour n'importe quelle raison), le dev peut soit laisser tomber et pouf ça tombe dans l'oubli, soit son projet devient un fork et peut alors soit devenir complètement indépendant soit continuer à suivre le projet d'origine en y intégrant ses modifs.
Cela peut être uniquement temporaire et peut également être à l'initiative du dev en question qui ne désire pas forcément fusionner son travail avec le projet d'origine.
Il existe désormais deux projet, le projet d'origine et son fork.
Le projet d'origine est appelé upstream et l'autre le fork.

Dans le cas présent, les équipes de Purism créer des forks de plusieurs projets existants pour ajouter les nouvelles fonctionnalités nécessaires, il les testent et compagnie.
Quand le résultat est acceptable, ils soumettent leur fork aux projets upstreams en espérant que ce soit acceptés histoire de ne pas avoir à continuer leur fork pour que les projets fusionnent.

---------------------

Bref niveau logiciel ça a l'air de pas mal avancer sur tous les plans.
Cela dit côté matos, on voit les premiers retards se confirmer.
Bon c'est pas trop trop étonnant mais bon ça jette toujours un léger froid.

On sent quand même que la collaboration vis-à-vis de Plasma semble assez légère.
J'espère qu'à la sortie, l'équipe de KDE saura proposer un truc suffisamment stable et utilisable et pas juste un proof-of-concept bâtard.
