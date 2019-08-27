+++
Author = "Lord"
Description = "16ème rapport des avancées du Librem 5. On découvre un peu plus les applis de téléphonie basée sur GNOME."
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-07-11T22:36:26+02:00
date = 2018-07-31T22:36:26+02:00
title = "16ème article d'avancement du Librem 5"
editor = "kakoune"
jdh="https://www.journalduhacker.net/s/siodxa/16_me_article_davancement_du_librem_5"
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-16/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Nous avons passé les dernières semaines concentrés sur le design des applications de communication par défaut du Librem 5.
Nous sommes donc parvenu à établir des spécifications pour deux applications.
L'une d'elle se nomme *Calls* et sert à - vous l'avez deviné - recevoir et émettre des appels téléphoniques.
La seconde est *Messages* quant à elle permet comme son nom l'indique d'envoyer et recevoir des messages.

Tobias, notre lead designer, a particulièrement bien bossé en communiquant et collaborant avec l'équipe design de GNOME ce qui nous a permit de faire de grands progrès conjointement avec le projet upstream GNOME.
Quand Tobias nous a rejoint, nous avons eu une conversation avec Allan Day et Jakub Steiner (de l'équipe design de GNOME) où nous leur avons présenté le projet, nos buts et discutés à propos de la structuration de nos contributions à GNOME.
Par exemple, nous avons un [dépot de design applicatif](https://gitlab.gnome.org/Community/Design/app-mockups) sur le serveur Gitlab upstream de GNOME où nos designs et prototypes sont rendus disponibles à tous.
Au final, notre projet et sa vision semble bien reçu par la communauté GNOME.

## L'application Calls

L'application étant nouvelle, nous sommes donc partit de zéro.
Nous l'avons fait alors que Bob progressait dans [l'implémentation des fonctions basiques d'appels](https://puri.sm/posts/librem5-progress-report-12/).

{{< img src="*119-calls-app-1.thumb.png" link="119-calls-app-1.png" alt="Les différents écrans visibles lors d'un appel" >}}

*Calls* est supposé permettre à l'utiliateur d'utiliser les fonctions de base d'un téléphone classique mais n'est pas limité à cela.
Elle est architecturé de façon telle qu'elle promet un haut niveau de sécurité et d'intimité (privacy) via du chiffrement de bout-en-bout de façon transparente.
Les appels privés, entre deux appareils supportant cette fonction seront établis juste en sélectionnant un contact et en appuyant sur le bouton d'appel.

{{< img src="*119-calls-app-2.thumb.png" link="119-calls-app-2.png" alt="Le numéroteur ainsi que les contacts de l'application Calls" >}}

Le design complet de l'application peut être admiré dans notre propre [dépot](https://gitlab.gnome.org/Community/Design/app-mockups/tree/master/calls).

## L'application Messages

{{< img src="119-fractal-hackfest.thumb.jpg" alt="Photo des devs lors du hackfest fractal" >}}

Au début de l'été, certains de nos employés (Dorota, Adrien, Tobias et <abbr title="François Téchené, pas moi, hein">moi-même</abbr>) avons participé au [Fractal](https://wiki.gnome.org/Apps/Fractal) hackfest à Strasbourg.
Le but était d'analyser et discuter des possibilité d'utiliser Fractal comme appli par défaut pour la messagerie dans PureOS et le Librem5.
C'est motivé par notre souhait d'être en phase avec les choix upstreams mais aussi par le fait que Tobias, en plus d'être designer des applis du Librem 5 est également le designer de Fractal.
Nous avons également profité de l'opportunité pour rencontrer Matthew de [Matrix](http://matrix.org) qui nous apporta des clarifications techniques bienvenues à propos de Matrix.

Il était clair lors de ce meeting que les plans pour Fractal soient en accord avec les principes du [Design éthique](https://2017.ind.ie/ethical-design/) que le Librem 5 et PureOS suivent.
Une application suivant ces recommandations doit être simple et dédiée à une seule tâche.

On pourrait penser que l'état actuel de Fractal sied déjà au but premier de *Messages* (envoyer et recevoir des messages), mais elle est trop générique en terme de but.
Discuter en privé avec un ami est différent d'une discussion dans un salon public IRC bondé.
Bien que la technologie employée dans le fond soit la même, l'interface utilisateur doit répondre à des objectifs différents.
Ce fût discuté lors du hackfest Fractal (Tobias a eu recours à l'analogie [du "barbecue" et du "banquet"](https://blogs.gnome.org/tbernard/2018/05/16/banquets-and-barbecues/) pour exposer le soucis), où les devs de Fractal décidèrent de scinder l'application en deux : une application pour les discussions en aparté ou petit groupe (le barbecue) tandis que la seconde sera dédiée aux discussions publiques (le banquet).
Il faudra cependant un peu de temps pour découper l'application existante.

L'application simplifiée *Messages* que nous avons développée est basée sur le cas du "barbecue"; ce qui s'avère être l'utilisation majoritaire.
Le but de *Messages* est d'être capable de gérer des SMS mais aussi des messages chiffrés de bout-en-bout de façon transparente entre deux appareils compatibles.

{{< img src="*119-messages-app.thumb.jpg" link="119-messages-app.jpg" alt="Exemple de conversation dans Messages" >}}

Le design global de *Messages* peut être reluqué dans son propre [dépot](https://gitlab.gnome.org/Community/Design/app-mockups/tree/master/messages).



---------------------
Original par François Téchené

Un retour sur leur collaboration avec l'équipe Matrix.
Les screenshots sont plutôt encourageant surtout pour ceux appréciant le look de GNOME.
Ça commence franchement à avoir une gueule d'OS de smartphone.

Un truc qui serait pas mal c'est une compatibilité avec l'application *Silence* pour Android qui permet d'envoyer des SMS de façon chiffré même pour des personnes pas spécialement douées en informatique.

