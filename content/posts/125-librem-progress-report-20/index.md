+++
Author = "Lord"
description = "20ème article d'avancement du Librem 5. Annonce d'un report de 4 mois à cause de bug hardware dans le SoC."
PublishDate = 2018-09-04T20:03:26+02:00
date = 2018-09-04T20:03:26+02:00
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
title = "20ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = ""
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-2018-09-hardware-report/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logicielles opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>
Comme vous vous en êtes aperçu lors du «dernier appel» concernant les devs kits, de nouvelles spécifications ont été publiées.
Je veux expliquer ce qui nous a poussé à ces spécifications et pourquoi nous avons fait ces choix et quel est le calendrier actuel pour les devkits et les Librem 5.

Nous voulons fabriquer un appareil mobile de communication sûr qui propose une expérience proche des smartphones concurrents actuels, tout en étant aussi libre et transparent que nous puissions au vu de la situation actuelle.
Nous prenons le concept de «libre» et «liberté» sérieusement afin de coller au label «Respects Your Freedom» ([RYF](https://www.fsf.org/resources/hw/endorsement/criteria)) de la Free Software Foundation ([FSF](https://www.fsf.org/)).
Obtenir cette certification est important et un objectif capital pour nous.
Les critères de la RYF interdissent un grand nombre de matériel ce qui rend la tâche de créer un smartphone certifiable par la RYF très compliqué.
Il aurait été à peu près trivial de fabriquer un smartphone avec des drivers GPU non libres et un CPU intégrant le GPU et la radio en quelques mois, mais créer un smartphone classique n'est pas notre objectif.
Nous avons des ambitions bien supérieures.

Nous avons choisi de fabriquer un appareil libre.
Un appareil respectant la vie privée et la sécurité de ses utilisateurs.
Nous l'avons choisi car c'est un défi pour notre entreprise et pour fournir un produit se souciant réellement de la liberté logicielle et matérielle.
C'est un point où nous ne ferons aucun compromis, car nous savons pertinemment que c'est atteignable.

Parlons donc de l'état actuel du projet.

## La route depuis l'i.MX6 vers l'i.MX 8M
Vous vous rappelez probablement d'un article précédent [où nous expliquions le raisonnement du changement de plateforme de l'i.MX6 à l'I.MX8M](https://puri.sm/posts/librem5-roadmap-to-imx8/).
Aujourd'hui, nous vous donnerons plus de détails et les avancées sur la transition en cours.

Le matériel d'un téléphone comprend un SoC (System on a Chip - un système sur une puce) et des périphériques comme les modems pour se connecter au réseau téléphonique.
Début 2017, lorsque nous avons commencé nos recherches pour trouver le bon SoC, nous sommes rapidement arrivés à la conclusion que la famille NXP i.MX − avec les drivers libres Etnaviv pour le GPU Vivante embarqué − serait le meilleur choix.
Le fait que le i.MX6 ne nécessite pas de firmware propriétaire pour une utilisation normale de smartphone combiné avec le driver libre «etnaviv» disponible étaient très attirant pour nous.
Le fait que le SoC soit sur le marché depuis un certain temps signifie également que les drivers étaient stables et solides.

À la fin de l'été 2017, nous étions alors au courant d'une nouvelle génération de SoC "i.MX 8" dont les rumeurs prédisaient la sortie prochaine.
À ce moment, nous avions déjà lancé notre campagne de crowdfunding et nous devions donc continuer sur les plans initiaux.
La possibilité d'avoir un SoC bien plus récent suffisait pour que l'on contacte NXP et certains distributeurs pour avoir plus d'informations.
Alors que nous continuions le travail pour les autres composants et sur l'aspect logiciel, nous avons continué de nous tenir au courant concernant les opportunités sur ce nouveau SoC pendant six mois.
Nous avons pu alors obtenir un début de documentation mais pas de date de disponibilité.

Début 2018, nous avons appris que la famille d'i.MX 8 serait annoncé à l'«Embedded World» à Nürnberg en Allemagne.
Du coup, après un petit hackfest en Allemagne, le président de Purism Todd Weaver et moi nous sommes rendus à Nùrnberg et avons rencontré NXP et les partenaires i.MX8.
Nous avons eu le droit à une démonstration de matériel i.MX8 avec les firmwares associés pour le voir tourné.
Même les derniers Etnaviv fonctionnaient déjà correctement.
Nous étions excités à l'idée d'utiliser du matériel bien plus récent.

Nous étions confiants sur la capacité de l'i.MX8 pour faire tourner le Librem 5 et pour être disponible en quantité suffisante pour notre date de livraison de janvier 2019.
La décision de se tourner vers un SoC de nouvelle génération apporte les avantages d'un CPU moderne de 64bits, plus de GPU sur la puce, moins de conso électrique et d'autres améliorations tout en étant toujours compatible avec la certification «RYF» de la FSF.
Nous pensons que le compromis de changer de matériel vaut le coup.
Le SoC n'est bien entendu pas la seule préoccupation pour le Librem 5.

## L'épreuve de fabriquer un smartphone Non-Android
Fabriquer un téléphone non android faisant tourner un système d'exploitation approuvé par la FSF supportant toutes les fonctionnalités attendues (réseau cellulaire, Wifi, Bluetooth, écran tactile) requière de la recherche étant donné qu'aucun smartphone n'a obtenu la certification RYF et les découvertes impliquent de trouver des solutions à de nouveaux problèmes.

L'industrie propose tout le matériel pour créer facilement un smartphone, puisque les fournisseurs de SoC incluent un modem (cellulaire et wifi) intégré.
Une simple recette : prenez un SoC, Placez-le sur un <abbr title="un circuit imprimmé">PCB</abbr>, Ajoutez de la RAM et une puce de mémoire flash par-dessus (ce sandwich s'appelle un PoP : Package on Package), Ajoutez des antennes et de l'énergie.
La difficulté réside dans les firmwares et les logiciels pour faire tourner le tout.
Les firmwares requis sont fournis par les fabricants de puces, tout comme les drivers pour le GPU et autres.
Ces logiciels sont par contre propriétaires sans code source et peu voir pas d'alternatives.

## Modem cellulaire (baseband)
Le modem cellulaire est de loin l'élément le plus complexe d'un téléphone mobile.
C'est le composant qui doit implémenter toute la famille de protocole de téléphonie (2G, 3G, 4G et bientôt 5G).
Il le fait en faisant tourner son propre système d'exploitation comme une boîte noire.
Il est couvert pas des milliers de brevets détenus par des centaines d'entités différentes.
Maintenant imaginez cela :  Le modem est situé sur le bus de la RAM du SoC !
Du logiciel non-libre qui a non seulement accès aux données entrant et sortant du SoC, mais avec également la possibilité de les altérer.
Parce que l'OS de ce modem est une boîte noire proprio, on n'a aucune idée de ce que ce composant fait et quelles sont ses vulnérabilités.

Revenons au design du Librem 5, nous estimons que ce n'est assurément pas une bonne solution.
Le modem doit être isolé du SoC pour qu'il ne puisse pas accéder à la RAM.
La situation s'est compliquée, lorsque lors de nos recherches pour un modem, nous avons réalisé qu'il y a très peu de fabricant et que la quasi-totalité d'entre eux intègrent leur modem dans un SoC.
Qui plus est, vous devez acquérir une licence pour faire tourner ces firmwares proprio dans un SoC.

Cela nous a donc laissé qu'un choix : utiliser un «module» de modem tout prêt et notre propre arrangement pour isoler le modem du SoC.
Il existe différents modems disponibles avec différents formats et différentes spécifications de vitesse, de fréquence radio, etc.
En s'orientant vers un module, nous pouvons nous fournir auprès d'un fournisseur répondant à nos critères stricts et aussi permettre une isolation entre le modem et la RAM ainsi que le CPU.

Pour isoler le modem, nous le placerons donc sur un (remarquablement rapide) bus USB et donc le téléphone interagira à travers l'USB au lieu de la RAM.
Cela séparera le modem sur son propre bus sans qu'il voit d'autre données.

## Modem Wifi/Bluetooth
Pour le Wifi et le Bluetooth nous collaborons étroitement avec Redpine Signal.
Ils nous fourniront une solution WIFI/Bluetooth à faible conso utilisant l'interface SDIO.
Nous nous sommes tournés vers eux car leurs puces ne nécessitent pas de téléchargement de firmware lors du fonctionnement contrairement à d'autres fournisseurs.
Devoir télécharger un firmware violerrai les recommandations RYF de la FSF.
Au final, nous pensons avoir une excellente solution Wifi et Bluetooth qui s'intègrera bien et consommera peu.
Ceci souligne l'attachement que porte Purism en tant qu'entreprise à but social de pousser nos convictions du Libre et de la liberté de nos utilisateurs dans notre chaîne d'approvisionnement.

## EE, ID et MD (Electronics Engineering, Industrial Design et Mechanical Design)
Pour trouver les bons partenaires pour fabriquer nos composants matériels, Todd et moi nous sommes rendu à Shenzhen en Chine il y a quelques temps.
C'est l'endroit où sont fabriqués les deux tiers des smartphones ; plus d'un milliard d'appareil y sont fabriqués chaque année.
C'est ici que s'est développé une chaîne logistique optimisée ces dernières décennies et où se retrouve l'expertise électronique de nos jours.
Nous avons choisi cette zone car c'est ici que nous trouverions les compétences pour fabriquer les composants matériels que nous avons choisis.

Sélectionner des partenaires pour la fabrication de nos designs fait maison était un exercice excitant de part les possibilités qui vont se concrétiser.
Depuis le début Avril de cette année, nous avons évalué des entreprises de fabrications et des usines intéressées pour travailler avec nous.
En accord avec notre planning originel nous avons commencé avec une maison de design électronique et peu de temps après nous avons trouvé notre design mécanique et notre fabrique matérielle.

## État des devkits
Si tout se passe comme prévu, nous enverrons les devkits en octobre.
Nous avons conscience de l'impatience des centaines de développeurs et sommes tout aussi pressé de vous permettre de travailler sur la plateforme PureOS du Librem 5.
Nous avons pas mal mis la pression sur notre chaîne d'approvisionnement pour que tout aille aussi vite que possible.
Ils seront équipés des SoC i.MX 8M.
L'état actuel des choses est que nous avons terminé le design et nous travaillons vers les tests d'allumage.
Nous sommes fiers de vous annoncer que les devkits seront assemblés et fabriqués aux USA, plus précisément à San Diego en Californie alors que la production finale des téléphones aura lieu elle en Chine.

Avec ce nouveau SoC, les devkits auront un matériel plus récent, rapide, un GPU plus puissant (quatre cœurs au lieu de deux), 64bits ainsi qu'une consommation en baisse et moins de chauffe.
Cela améliorera l'attractivité du téléphone pour ceux comparant avec la concurrence durant leur shopping.

La documentation pour développeur des devkits est presque prête et nous pensons que ceux recevant leur kit pourront commencer à écrire des applications relativement vite.

Ces trois/quatre derniers mois ont connus une grande activité ici chez Purism avec beaucoup de débroussaillage, de négociation, de répartitions des tâches − une valse avec les différents partenaires pour travailler de concert dans un effort commun de concevoir le bon produit.
Mais comme vous, nous sommes impatients du résultat : un téléphone fonctionnant au Libre que nous espérons voir disrupter le marché d'aujourd'hui avec des concepts innovants tout en ayant toutes les fonctionnalités d'un téléphone d'aujourd'hui.

{{< img src="devkits-parts-table.jpg" link="devkits-parts-table.jpg" alt="photographie d'une table jonché de sachets de composants électroniques" title="Des éléments du devkits dans nos bureaux allemands. Le design des PCB que nous construisons comprennent plus de 700 composants" >}}

## État de la feuille de route du Librem 5
Abordons le planning de sortie du Librem 5.
Avec les dernières informations dont nous disposons, nous envisageons un retard de production jusqu'à **Avril 2019**.
La faute revient à un bug dans le silicium du SoC causant une surconsommation sur la batterie.
Si nous sortions le téléphone en l'état, la batterie serait à cours en près d'une heure…
Ce n'est pas la première impression que nous voulons donner !

L'errata de NXP (le fabricant du silicium) pour la révision en cours de vente peut se trouver [ici](https://www.nxp.com/products/processors-and-microcontrollers/arm-based-processors-and-mcus/i.mx-applications-processors/i.mx-8-processors/i.mx-8m-family-armcortex-a53-cortex-m4-audio-voice-video:i.MX8M?tab=Documentation_Tab).
Plus spécifiquement, ce [document](https://www.nxp.com/docs/en/errata/IMX8MDQLQ_0N14W.pdf) où les deux problèmes affectant la gestion de l'énergie et la consommation d'énergie sont identifiés en tant que «e11174» et «e11171».

Nous collaborons étroitement avec NXP pour régler le souci.
Pourquoi avril ?
Nous souhaitons être réalistes dans nos projections en se basant sur quelques facteurs :

  1. Si le problème se résout d'ici décembre, ça tombe pendant les vacances de fin d'année en Europe et Amériques.
  2. Février est le nouvel an chinois et effectivement le pays tout entier est à l'arrêt pour ce mois. Ce qui veut dire que nous pouvons relancer la production en mars pour que les premières pièces sortent en avril.
  3. En interne, nous avons de nombreux plans à accorder en fonction de la sortie afin de synchroniser les relations presse, la communauté (en ligne mais également à différents évènements), nos investisseurs et autres.
  4. Nous voulons vous donner une date qui soit réaliste afin de ne pas vous frustrer. Nous voulons vous épater et pour cela nous avons besoin d'une longue période de QA (Assurance qualité). C'est pour cela que nous espérons commencer la production en avril (si nous pouvons le faire plus tôt, tant mieux, mais nous préférons ne pas faire de promesse intenable).

Vous vous demandez probablement pourquoi les plans pour les devkits ne sont pas plus impactés que ça comparé aux Librem 5.
Les devkits sont faits pour être branchés et ne sont donc pas impacté négativement par les bugs dans le silicium.
Ils seront donc livrés avec les puces contenant ces bugs, mais cela n'affectera pas les développeurs (puisque ce n'est pas comme si vous vouliez vous balader avec le devkit avec une longue autonomie).

Pour vous ouvrir l'appétit, admirez quelques schémas des devkits (ne les utilisez pas comme référence !) ainsi que quelques rendus 3D pour le plaisir des yeux.

{{< img src="dev-kit-blueprint.jpg" link="dev-kit-blueprint.jpg" alt="un schéma de devkit assez joli où l'on voit quelques composants majeurs" title="Un des premiers schémas du devkit" >}}
{{< img src="devkit-front-back-combined.png" link="devkit-front-back-combined.png" alt="un rendu 3D du devkit avant et arrière plutôt réaliste" title="Rendu 3D du devkit Librem 5 avant et arrière" >}}

Au-delà des devkits, un détail qui devrait tous vous plaire est l'utilisation d'une batterie remplaçable par l'utilisateur : contrairement à la majorité des smartphones sur le marché aujourd'hui, les nôtres n'auront pas leur batterie soudée sur la carte mère et la coque ne sera pas collée.

Les schémas du design du téléphone sont à peu près terminés et nous sommes actuellement concentrés sur l'assemblage de l'appareil.
Certaines pièces font encore défaut comme le modem, mais au-delà de ça, il n'y a aucun soucis pour l'assemblage.

Nous nous sommes également affairés pour qu'il y ait [aussi peu de branding que possible sur le téléphone](https://puri.sm/posts/librem5-progress-report-18/).

## L'épopée continue
Une incroyable montagne de travail a été nécessaire dans la création du Librem 5 et nous apprenons encore de nouvelles choses et faisons encore face à certains challenges.
L'une des plus grandes difficulté a été l'établissement d'une chaîne de fournisseurs et collaborer avec un grand nombres de partenaires à travers le monde, trouver les bons contacts pour obtenir ce que l'on veut.
On ne doit pas sous-estimer la difficulté qu'a été de créer cette chaîne d'approvisionnement.
L'autre défi est de trouver du matériel compatible avec notre idéologie et la compatibilité avec le RYF de la FSF lorsque toute la chaîne d'approvisionnement est optimisée pour la réduction des coûts.
Trouver des fournisseurs permettant d'éviter tout blob dans le système d'exploitation s'est révélé, incroyablement, long et fastidieux.

Nous continuerons d'avancer en comprenant mieux comment fonctionne cette partie de l'industrie.
Le succès de notre téléphone est critique car il nous apportera une légitimité et nous donnera les moyens pour [orienter les fabricants de matériel vers notre façon de penser](https://puri.sm/about/business-model-and-vision/) en leur montrant que nous avons le potentiel d'être leader sur un marché de produits éthiques qui respectent leurs utilisateurs.

Pour ceux qui ont investi en nous et continuent d'être patient avec nous : vous avez toute notre gratitude.
Pour ceux qui ont adopté l'approche wait-and-see (j'attends de voir pour juger), nous espérons que vous rejoindrez la famille Purism soit avec notre téléphone soit avec nos autres offres.
Merci

<hr>
Original par Nicole Faerber.

Et bha voilà !
Ils annoncent enfin qu'ils auront du retard.
Bon j'imagine que ça n'étonne personne mais bon, perso ça ne me gène pas du tout.
Déjà parce que c'est que quatre mois et aussi parceque ça leur permettra de peaufiner un peu plus l'OS.

En plus c'est un peu en grande partie la faute du fabricant du SoC qui a un bug matériel.
Ça arrive assez fréquemment, surtout sur des designs complètement nouveaux.
Bref rien de bien grave pour le moment, espérons qu'il n'y ait pas d'autres déconvenues matérielles.

Pfiouuu qu'il était long cet article.
On sent qu'ils arrivent vers la fin du projet et que ça approche de la concrétisation.

Gare à vous, ils ont l'intention de vous disrupter votre marché du smartphone !
