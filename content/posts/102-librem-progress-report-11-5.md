+++
Author = "Lord"
Description = "Suivons toujours les avancées de Purism pour créer le Librem 5. Présentation de l'appli Calls pour faire les appels téléphoniques."
menu = "main"
notoc = true
PublishDate = 2018-05-18T18:22:07+01:00
date = 2018-05-18T18:22:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "Présentation de Calls. L'appli du Librem 5 pour les appels"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/7laje4/pr_sentation_de_calls_lappli_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/introducing-calls/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

## Introduction
De loin, la fonctionnalité la plus critique d'un téléphone est la possibilité d'émettre et recevoir des appels via le réseau téléphonique publique en utilisant des numéros de téléphones.
Même si chez Purism nous souhaitons implémenter des systèmes de communications permettant plus de sécurité et un meilleur respect de la vie privée que ce que l'on peut attendre via le réseau téléphonique publique, ce moyen est le plus utilisé pour le moment et nous ne pouvons nous permettre de vendre un téléphone ne pouvant pas téléphoner. [⁰]({{< relref "#⁰" >}})

Mon boulot a été de coder un dialer (numéroteur) et la gestion des appels.
Comme tous nos développements sur le Librem 5, le but est de réutiliser le plus de code existant possible et de viser l'intégration dans la plateforme Gnome qui est utilisée par défaut par notre PureOS.
Il n'y a pour le moment pas de dialer dans le projet Gnome donc nous pousserons son adoption.

## Idées initiales
Après quelques recherches, le but initial était de réutiliser le framework [Telepathy](https://telepathy.freedesktop.org/), l'idée étant que nous pourrions un numéroteur utilisant le réseau publique et d'utiliser le dialer [SIP](https://en.wikipedia.org/wiki/Session_Initiation_Protocol) car Telepathy possède déjà un gestionnaire de connexion PSTN (réseau publique téléphonique) et SIP.
Qui plus est, le gestionnaire de connexion PSTN [telepathy-ring](https://git.merproject.org/mer-core/telepathy-ring) est déjà utilisé dans des téléphones sur le marché.
Et même si il possède quelques soucis, je trouve Telepathy vraiment génial :-)

Pour aller plus loin, mon collègue François Téchené a écrit [un article]({{< ref "/posts/83-librem-progress-report-8" >}}) décrivant un approche basé sur les fonctionnalité plutôt que sur les applications concernant l'expérience utilisateur.
Telepathy pourrait fournir les fondations d'une telle approche.

Il est bon de noter cependant que Telepathy n'est pas en odeur de sainteté.
De nombreuses voix parmi le projet Gnome préferraient sa mort.
Telepathy est un système complexe où le moindre changement est difficile à apporter.
Pour se faire, il faut synchroniser ces changements dans les spécifications de l'API D-Bus et dans une multitude de composants divers.
Une longue discussion à propos de Telepathy et de son éventuel remplacement a eu lieu dans la mailing-list Gnomes's desktop-devel en [Aout](https://mail.gnome.org/archives/desktop-devel-list/2017-August/thread.html#00112) et [Septembre](https://mail.gnome.org/archives/desktop-devel-list/2017-September/thread.html#00047) 2017.

## Élargissement du débat
Après avoir commencé quelques travaux préliminaires sur le code de Telepathy, étant donné que notre but est que ça devienne le dialer de Gnome, et que notre intention est d'utiliser le framework contesté qu'est Telepathy, [j'ai contacté](https://mail.gnome.org/mailman/listinfo/desktop-devel-list) la fameuse mailing-list pour voir ce qu'ils en pensaient.

La discussion s'est penché sur les soucis généraux et la consolidation des différents systèmes de communication.
La première conclusion a été que créé un système à base de fonctionnalité est pour le moins compliqué.
Comme lors de la première discussion de 2017, un Telepathy-NG (nouvelle génération) serait la meilleure solution.
C'est une future tâche que nous envisageront une fois les fonctions basiques déjà en place.
Pour l'instant, il n'y avait aucune réticence à propos d'un dialer PSTN reposant sur Telepathy.

J'ai aussi discuté via IRC avec Robert McQueen, l'un des auteurs originels de Telepathy.
Le gestionnaire de connexion telepathy-ring utilise le framework de téléphonie mobile [oFono](https://01.org/ofono).
Étant donné la difficulté d'écrire un client Telepathy, Robert suggera qu'il serait probablement plus simple de créer une interface utilisateur (UI) avec une fine couche d'abstraction implémentant d'abord un backend oFono puis, plus tard, un backend plus complexe sur Telepathy.
Nous avons suivi son conseil et notre dialer adopte donc cette approche.

## Bienvenue Calls

{{< figure src="/static/102-call-screenshot-phone-0-small.png" link="/static/102-call-screenshot-phone-0-small.png" alt="Capture d'écran montrant l'interface du dialer.">}}

Notre programme s'appelle *Calls*.
Il a une interface utilateur (UI) en GTK +3 et utilise oFono à travers une fine couche d'abstraction.
Nous utilisons également notre [libhandy](https://code.puri.sm/Librem5/libhandy) pour le widget du numéroteur.

**« Peut-il téléphoner ?! »**
Oui, il peut ! 🙂

<video class="wp-video-shortcode" id="video-52730-1" width="960" height="540" preload="metadata" controls="controls"><source type="video/webm" src="https://puri.sm/wp-content/uploads/2018/05/calls-demo-01-04.webm?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/05/calls-demo-01-04.webm">https://puri.sm/wp-content/uploads/2018/05/calls-demo-01-04.webm</a></video>

## Les rouages internes
Le diagramme est représentation à la UML de la couche d'abstraction dans Calls :

{{< figure src="/static/102-provider-abstraction-02.png" link="/static/102-provider-abstraction-02.png" alt="Diagramme UML de la couche d'abstraction" >}}

Les classes sont des GInterfaces.
Pour vous donner une meilleure idées de la sémantique derrière chaque interface, voici un tableau des objets que les implémentations pourront utiliser :

|**Interface**|  **objets d'implémentation**                   |
|-------------|------------------------------------------------|
|Provider     |oFono Manager, Telepathy Account Manager        |
|Origin       |oFono Modem/VoiceCallManager, Telepathy Account |
|Call         |oFono VoiceCall, Telepathy Channel              |

Le nom “Origin” a été choisi puisqu'il s'agit de l'objet à l'origine d'un appel.

La super-interface MessageSource est utilisée pour traiter les messages de l'utilisateur.
La couche d'abstraction est une fine couche pour l'UI donc l'implémentation est amenée à afficher des informations, comme des erreurs ou des warnings ou autre, d'une manière appropriée pour l'utilisateur.
Même si les méthodes ne renvoient pas d'erreurs d'information mais à la place s'attendent à ce que l'implémentation fournissent des signaux de type *messages*.

Le [code source](https://gitlab.gnome.org/Community/Purism/calls) est disponible dans gitlab Gnome de notre repo community.

## Modems, oFono et ModemManager
La démo d'en haut utilise un [modem SIM7100E](http://simcomm2m.com/En/module/detail.aspx?id=86) de chez SIMCom que vous pourrez voir monter sur notre board prototype avec la bordure rouge en bas à droite de l'écran.
Comme la plupart des modems cellulaires, il supporte à la fois les [commandes AT](https://en.wikipedia.org/wiki/Hayes_command_set) ainsi que les [QMI](https://osmocom.org/projects/quectel-modems/wiki/QMI).

Lorsque le SIM7100E a été branché pour la première fois, oFono ne le reconnaissait pas.
Cependant, il existe un second framework de téléphonie mobile, [ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/) qui l'a reconnu et pouvait passer des appels, envoyer des SMS et faire des connexions de données out of the box.
Nous avons alors considérer de l'utiliser à la place d'oFono mais malheureusement, le [support des appels audio](https://www.freedesktop.org/software/ModemManager/api/latest/gdbus-org.freedesktop.ModemManager1.Call.html) est rudimentaire et ne supporte pas les services additionnels comme la mise en attente ou les conférences.

Alors que QMI est préferrable aux commandes AT, oFono ne supporte pas les appels via QMI.
Donc pour pouvoir faire des appels vocaux, nous avons besoins d'un nouveau driver pour le SIM7100E utilisant les commandes AT.
Ce drive a été [upstreamé](https://lists.ofono.org/pipermail/ofono/2018-April/018144.html) (partagé à la communauté).

## Ensuite
Nous avons abattu un certain travail jusqu'à présent mais il reste de nombreuses tâches à accomplir.

  1. Ajouter des sonneries. Pour le moment le programme ne joue aucun son lors d'un appel entrant. Il va falloir également jouer les tonalités DTMF quand l'utilisateur composera des numéros.
  2. Implémenter un journal d'appel et son intégration avec Gnome Contacts. Pour l'instant Calls ne journalise rien, nous avons donc besoin d'un format de stockage ainsi qu'une UI. Nous devons également être capable de chercher des contacts depuis Calls et ajouter des contact depuis le journal d'appel.
  3. L'UI est simple mais fonctionnelle. Nous sommes bien loin du niveau de finition que nos designers [envisagent](https://gitlab.gnome.org/Community/Design/app-mockups/blob/master/calls/calls.png). De nombreux efforts pour retravailler et polir l'interface seront nécessaires.
  4. Implémenter les réglages téléphoniques dans Gnome Settings. Nous avons besoin d'une nouvelle page pour les réglages spécifiques comme la sélection du réseau mobile et autres.
  5. Gérer les multiples SIM et les connexions des modems. Pour l'instant Calls est une simple interface pour les objets DBus OFono et ne peut qu'utiliser des modems déjà fonctionnels. Nous avons besoin de mécanisme permettant de configurer quel modems doit utiliser Calls et pour les connecter automatiquement quand l'appareil démarre.
  6. Implémenter un backend Telepathy pour avoir un support des appels SIP ainsi que les autres protocoles supportés par Telepathy.
  7. Le choix final des modems n'a pas encore été fait donc nous ne poussons pas trop les efforts vers le SIM7100E, juste assez pour tester Calls. Nous pourrions implémenter le support de QMI dans oFono si nous décidions d'adopter ce modem. À vrai dire, alors que j'écrit cet article il y a [une discussion](https://lists.ofono.org/pipermail/ofono/2018-May/thread.html#18171) sur leur mailing-list pour le support QMI. Cependant nous pourrions implémenter le support de services supplémentaires dans ModemManager, qui est plus dans l'alignement de la plateforme Gnome.
  8. Ajouter le support des services supplémentaires et les opérations complexes. ModemManager a un support rudimentaire des appels tout comme Calls actuellement. Nous voulons être sûr que notre dialer aura un support complet des standards de la téléphonie mobile.

C'est tout pour le moment, restez branché pour de futurs infos ! 🙂

### ⁰
Une entreprise qui ne sera pas nommé vendait des téléphones basés sur GNU/Linux mais ceux-ci n'étaient pas capable d'émettre des appels téléphoniques quand ils sont sortis.
Cinq ans plus tard, j'ai acheté un de ces téléphones et l'ai apporté à mon [LUG](https://lug.org.uk/) local.
Et biensûr, la première question a été : “Est-ce qu'il peut téléphoner ?! haha!”
La réputation n'est plus à faire une fois que l'on vend un téléphone qui ne peux pas téléphoner !

---------------
Ça avance petit à petit.
C'est pas mal du tout mais ça rassure pas…
La deadline approche et bha ça paraît toujours aussi distant pour les fonctions basiques et le choix du matos.
Gardons confiance.

Leur collaboration avec l'écosystème existant fait toujours plaisir et augure un bon avenir.
