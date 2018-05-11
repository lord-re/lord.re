+++
Author = "Lord"
Description = "Suivons toujours les avancées de Purism pour créer le Librem 5. On voit un nouveau concept de design du téléphone, et ils dévoilent les différentes phases qui donneront naissance à l'interface logicielle."
menu = "main"
notoc = true
PublishDate = 2018-05-11T09:22:07+01:00
date = 2018-05-11T09:22:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "11ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/svt6ls/11_me_article_davancement_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-11/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Salut tout le monde !
Beaucoup d'avancements depuis mon dernier rapport de design.
Jusqu'à maintenant je n'ai rapporté que les avancées design sur le plan *software*, mais nos efforts ne s'y limitent évidemment pas.
L'expérience que ressent une personne vis-à-vis d'un appareil physique est également très importante.
Cet article résumera les récentes décisions prises d'un point de vue logiciel mais également matériel.

## Penser à l'interface physique

Notre but avec le Librem 5 est d'améliorer l'identité visuelle de la lignée Librem tout en restant proche de notre look humble et minimaliste qui nous caractérise.

Le principal challenge d'un design de boitier est un compromis entre l'esthétisme, l'ergonomie, la praticité et les limitations techniques.

Comme vous le savez, le Librem 5 est particulier car contrairement à la tendance actuelle, nous auront un processeur et un chipset distincts.
La consommation électrique est un facteur majeur à prendre en compte mais également la capacité de la batterie ainsi que l'arrangement des circuits imprimmés et ne voulons pas sacrifier l'endurance de la batterie pour quelques milimètres d'épaisseurs. Cela-dit :

  - Nous visons désormais un écran d'une taille d'environ 5.5 à 5.7 pouces avec un ration de 18:9 ce qui nous permettrait d'inclure une plus grande batterie sans impacter le format du téléphone.
  - Nous allons également opter pour une forme chanfrein (voir la photo), au lieu de l'habituel bord arrondi. Non seulement c'est élégant, mais ça permettra une meilleure préhension tout en donnant un peu plus d'espace pour les composants internes.

{{< figure src="/static/100-l5-v1-turn-around.jpg" link="/static/100-l5-v1-turn-around.jpg" alt="Concept de design du Librem 5 en version 1">}}

## Simplification de l'interface utilisateur
Au fur et à mesure de l'avancement du Librem5, nous sommes conscient du planning serré en visant une sortie en Janvier 2019, et sommes donc concentrés sur la robustesse et l'efficacité pour la première version de l'interface mobile ("phosh"), que nous allons pousser pour devenir l'interface mobile de Gnome Shell.

Nous avons donc revus les fonctionnalités et décidé de diviser le design et son implémentation en plusieurs phases.

**La Phase 1** définie une interface la plus simple en terme de fonctionnalité et d'utilisation. C'est ce qui sera livré avec le téléphone en Janvier 2019.

{{< figure src="/static/100-l5-shell-1.jpg" link="/static/100-l5-shell-1.jpg" alt="Concept des différents éléments d'interface de l'interface phosh.">}}

Cela inclu :

  - Un écran de verrouillage.
  - Un écran de déverrouillage à base de code PIN pour protéger la session.
  - Un écran d'accueil affichant une liste paginée d'applications.
  - Une barre en haut affichant des informations utiles comme l'heure, le niveau de batterie, le volume audio, le niveau de signal réseau.
  - Une barre du bas simulant un bouton de retour (uniquement visible quand une application est ouverte).
  - Un clavier virtuel.
  - Des notifications d'appels entrants.

Le multi-tâche, la recherche ou les notifications ne seront implémentés qu'en **phase 2** et donc disponible plus tard.

Même si la “phase 1” ne correspond pas à l'offre pléthorique habituellement proposé, nous pensons que cette interface minimale sera extrèmement simple à appréhender ce qui favorisera une adoption sans heurts.
Cela sera un très bon point de départ.

## Designer l'application Contacts
L'application **Contacts* sera au centre des fonctionnalités de communication.
C'est l'application qui aura en charge la gestion des contacts pour les autres applications comme **Calls** ou **Messages**.

Pour cela, nous sommes en train d'adapter l'applications [Contacts](https://wiki.gnome.org/Apps/Contacts) existante en designant son agencement mobile et en ajoutant de nouveaux champs nécessaires pour les différentes applications.

{{< figure src="/static/100-contact-adaptive-design.jpg" link="/static/100-contact-adaptive-design.jpg" alt="Différents écrans de l'interface de l'appli Contacts à la fois sur ordinateur et sur mobile.">}}

## Librem 5 & Fractal team hackfest à Strasbourg
Cette semaine, certains membre de l'équipe Librem 5 (incluant moi-même) seront au [Fractal Hackfest 2018](https://wiki.gnome.org/Hackfests/Fractal2018) à Strasbourg dans le but d'aider l'[équipe Fractal](https://wiki.gnome.org/Apps/Fractal) à créer application basée sur [Matrix](https://matrix.org) à la fois jolie et sécurisée à la fois sur ordinateur que sur plateforme mobile.
J'espère faire un rapport sur les fonctionnalités de communication du Librem 5 dans un futur article où j'aborderai ce qu'il se sera passé au Fractal Hackfest.

---------------
Bon bien entendu quand vous lisez "je" dans cet article, ce n'est pas moi mais l'auteur original François Téchené membre de Purism.

Les modifications de concept de design physique sont intéressantes.
Mine de rien les modes des smartphone a pas mal changé depuis la création du crowdfunding et ce nouveau design (provisoire) est déjà plus sympa et accuse moins le coup.
J'aime beaucoup le fait qu'ils ne cherchent pas à faire le smartphone le plus fin possible.
Perso ça ne me gène pas d'avoir un appareil un peu épais, surtout si ça permet d'avoir une meilleure batterie et un téléphone mieux branlé.

Concernant le logiciel, certains vont probablement râler mais bon la deadline est vraiment courte.
Même s'ils repartent de briques existantes, le monde GNU/Linux est quand même pas vraiment adapter au téléphone et du coup tout le userspace est à créer ou presque.
Bref c'est bien qu'ils annoncent que dans un premier temps ça sera léger.
Il y a plus qu'à espérer qu'ils ne s'arrêteront pas à la Phase 2 mais poursuivent les efforts par la suite.
