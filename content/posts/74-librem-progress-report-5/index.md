+++
Author = "Lord"
Description = "5ème avancement du Librem 5"
Categories = ["traduction", "hardware","software","librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-02-14T11:39:02+01:00
date = 2018-02-14T11:39:02+01:00
title = "5ème article d'avancement du Librem 5"
jdh = "https://www.journalduhacker.net/s/p3aqwm/5_me_article_davancement_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-5/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org) et le projet [Matrix](https://matrix.org).
Ils sont assez transparent sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

## De retour du FOSDEM
Être au [FOSDEM 2018](https://fosdem.org/2018/) était une tuerie !
On a obtenu pleins de vos retours concernant ce que nous avons déjà accompli et ce que nous visons.
Ces retours constructifs nous permettent d'être ce que nous sommes et nous motivent !
Ça nous permet de mieux concentrer le développement.
En plus de cela, nous sommes impressionnés de l'appréciation de la communauté du Logiciel Libre.
Nous savons que les relations entre les entreprises (même affiliées au Libre, telle que Purism) et la communauté du Logiciel Libre est toujours un équilibre délicat :
*L'équilibre entre la transparence, l'ouverture et le Libre d'un côté et générer un revenue pour soutenir le developpement de l'autre côté.*
Vos retours positifs du FOSDEM et l'engouement général pour nos projets sont toujours agréables à entendre.

Nous nous efforçons pour que des produits éthiques basés sur du Libre et de l'OpenSource deviennent une réalité.
Ce n'est pas “juste un boulot” pour l'équipe de Purism; nous aimons tous ce que nous faisons et croyons réellement envers le bien fondé de notre but.
Vos retours sont le moteur de notre motivation pour travailler encore plus dur.
Merci beaucoup !

## Avancées logicielles
Comme expliqué [précédemment]({{< ref "/posts/71-librem-progress-report-3" >}}), nous avons reçu des i.MX 6 QuadPlus de test. Donc voilà quelques photos :

{{< img src="*4-photo1.jpg" title="" alt="Photographie de la board raccordée à un écran" link="74-photo1.jpg" >}}

À droite, vous pouvez voir la *carte Nitrogen* avec la carte modem installée.
Sur la gauche un écran affichant la page web Purism et en dessous une fenêtre de terminal d'où a été lancé le navigateur web.
Remarquez la carte Micro SD pour une idée de la taille :

{{< img src="*4-photo2.jpg" title="" alt="Photographie de l'écran avec une carte micro SD apposée dessus" link="74-photo2.jpg" >}}

La fenêtre de terminal fait environ la taille de 3 cartes Micro SD !
Ça démontre clairement le fait qu'il y a pas mal de travail nécessaire pour adapter les applications aux écrans à haute résolution et les rendre utilisabless avec les doigts.
Dans la photo suivante on a posé 1 €uro et sommes passés sur l'affichage de la console :

{{< img src="*4-photo3.jpg" title="" alt="L'écran avec une pièce d'un euro sur la console" link="74-photo3.jpg" >}}

Concernant le logiciel, nous travaillons à faire marcher la base du framework sur le matériel que nous avons à disposition.
Une pièce essentielle est le middleware qui manipule le modem pour passer les appels et envoyer/recevoir les SMS.
Pour cela nous nous appuyons sur [oFono](https://01.org/ofono) car c'est également utilisé par [KDE Plasma](https://plasma-mobile.org/).
Nous avons un premier jalon à partager :

{{< img src="*4-photo4.jpg" title="" alt="Capture d'écran montrant l'envoi d'un sms depuis le prototype" link="74-photo4.jpg" >}}

C'est le tout premier SMS envoyé via oFono depuis la carte iMX et le modem vers un smartphone classiques où la capture d'écran a été prise.
Nous sommes donc sur le bon chemin ici avec un système qui commence à fonctionner sur de multiples systèmes comme Plasma Mobile ou un future environnement mobile [Gnome/GTK+](https://www.gnome.org/).

Le SMS a été envoyé par un script python utilisant l'API DBus d'oFono.
Au préalable, les pilotes kernel pour le modem ont dû être activés puis il faut démarrer ofonod qui autodétecte le modem.
Ensuite le modem doit être démarré et connecté (online-modem). Une fois fait, envoyer un SMS se résume à :

      purism@pureos:~/ofono/test$ sudo ./send-sms 07XXXXXXXXX "Sent from my Librem 5 i.MX6 dev board!"

Le script en lui même est très simple et intéressant. Simuler la réception d'un SMS peut également se faire avec une commande de ce genre :

      purism@pureos:~/ofono/test$ sudo ./receive-smsb 'Sent to my Librem 5 i.MX6 dev board!' LocalSentTime = 2018-02-07T10:26:19+0000 SentTime = 2018-02-07T10:26:19+0000 Sender = +447XXXXXXXXX

## L'évolution de la fabrication d'appareils mobiles

Nous construisons un téléphone, donc la partie matérielle est un élément crucial.
Dans notre dernier article de blog, nous parlions de la recherche de partenaire pour la fabrication.
Puisque nous ne fabriquons pas un énième smartphone basé sur un SOC Qualcomm mais que nous partons de zéro, nous nous attelons à effectuer tous les choix de design ainsi que des partenaires de fabrication.
Cette phase de travail supplémentaire est entièrement dépendante envers le marché du téléphone mobile et de son évolution de ces dernières années.
Voyons ça.

Aux balbutiements des smartphones, le processeur central était séparé du modem cellulaire qui implémentait dans son firmware tous les protocoles réseaux nécessaires pour faire fonctionner l'interface radio − d'abord GSM, puis UMTS (3G) and désormais LTE (4G).
Ces protocoles et l'interfaçage radio sont devenus si complexe que la puissance de calcul nécessaire ainsi que la taille du firmware a grossi.
Les actuels modems 3G/4G utilisent des firmware de l'ordre de 60 Mo ou plus.
Stocker et faire tourner ces firmwares est rapidement devenu problématique (nécessite également plus de RAM).

Les smartphones ont généralement ont généralement un second cœur de CPU pour le système d'exploitation et les applications interagissant avec l'utilisateur.
Ça signifie que le smartphone possèdent deux systèmes de RAM, un pour le baseband et un pour le CPU.
Cela signifie également deux systèmes de stockage pour le firmware : un pour pour le CPU et un pour le baseband.
Comme vous pouvez l'imaginer, faire marcher tous ces composants et faire rentrer tout ça dans un appareil au format restreint nécessite énormément de ressources de dev et de fabrication.

## La montée en puissance des smartphones bas de gamme

Il y a énormément de pression sur le prix des smartphones.
Sur le marché, on retrouve des smartphones simples à des prix inférieurs à 100$.

L'arrivée des puces combinant le baseband radio et le CPU sur un seul a permis de réduire massivement les coûts.
Maintenant, la RAM et le stockage peut être mutualisé. Les deux puces ne sont plus qu'une seule ce qui réduit les coûts de production pour les fabricants de puces ce qui se répercutent sur les fabricants via réduction les nomenclatures (BOM).
Ça permet d'économiser une grande puce pour le modem, une puce de flash pour le firmware du modem ainsi que la ram dédiée au modem.
Non seulement ça baisse le prix des composants mais également fait gagner de la place sur le circuit imprimmé (PCB) ce qui permet de fabriquer des téléphones plus petits et plus fins.
Aujourd'hui, nombreux sont les constructeurs à vendre ce type de chipsets − comme Qualcomm, Broadcom et Mediatek pour en citer quelques-uns.

Ces puces ont radicalement changé le marché du modem baseband.
Il était alors courant de trouver sur le marché des modems baseband seuls.
Mais depuis la montée en puissance des puces combinés, le besoin de modems séparés s'est drastiquement réduit.
On trouve toujours ce type de puces mais celles-ci visent désormais les appareils M2M (machine to machine, pas les appareils pour humains) avec de faibles débits et ne gérant pas la voix ou bien seulement sur des formats inutilisables dans notre cas comme le miniPCIe ou bien M.2.
La conséquence directe pour nous est le choix restreint de modem baseband indépendant.

## Ce que ça signifie pour les OEM, ODM ou les DIY

Toute cette consolidation du marché a un impact sur l'éventail de choix.
Quasiment tous les smartphones actuels des [OEM](https://en.wikipedia.org/wiki/Original_equipment_manufacturer)/[ODM](https://en.wikipedia.org/wiki/Original_design_manufacturer) sont basés sur des puces combinés; c'est tout ce dont ils sont capables.
Plus personne ne fait de smartphone à baseband séparée désormais et ceux le faisant ne sont ni OEM ni ODM.
Nos choix sont d'autant plus restreints que nous n'utiliserons pas de matériel avec des firmwares propriétaires sur le CPU (ce que nous verrons plus loin).
Les fabricants ne sont pas familiers avec les i.MX6 ou i.MX8 et ne veulent pas s'y risquer.
Notre liste de partenaires potentiels se réduit donc à peau de chagrin.

Toutefois, nous avons quelques partenaires prometteurs que nous continuons à évaluer.
*Nous sommes plutôt confiant sur le fait de pouvoir suivre notre cahier des charges initial pour le Librem 5.*
Nous voulons juste partager avec vous les challenges à surmonter et pourquoi notre équipe est la meilleure pour ce plan.
Pour continuer les négociations avec des fabricants et fournisseurs, Purism ira à l'Embedded World, l'un des plus gros salons de l'embarqué se tenant à Nürnberg en Allemagne début Mars.
Et comme d'habitude, nous vous tiendrons informé de l'avancement !

## Bonnes nouvelles concernant notre prototype
Nous avons patiemment attendu l'arrivée de l'*i.MX 8M* suite aux prévisions de NXP.
En parallèle, nous avons bien avancé sur la partie logicielle en utilisant des carte d'évaluation i.MX6 QuadPlus de chez [Boundary Devices](https://boundarydevices.com/), plus précisément la NITROGEN6_MAX (Nit6Qp_MAX) qui est la carte la plus proche de la future i.MX 8M.
Nous avons une image *Debian Testing* fonctionnant sur le banc d'essai pendant que l'équipe de PureOS prépare une image PureOS spécifique pour ARM et ARM64.

Sur ces cartes d'évaluations nous avons toutes les interfaces nécessaires pour le dev :

  1. Wifi
  2. Entrée/Sortie Vidéo
  3. USB en entrée
  4. Console série et socket carte SIM en miniPCIe pour un modem
  5. Sierra Wireless MC7455 3G/4G miniPCIe modem qui est simplement un modem USB au format miniPCIe
  6. Un superbe écran branché via HDMI. 5.5" AMOLED en full-HD nativement en portait.

Cette configuration matérielle nous permet de commencer le dev logicielle en parallèle de l'avancement sur le matériel jusqu'à l'arrivée de l'i.MX 8.

Prochain élément sur la todo-list : passer des appels !

<hr>

Bon pas énormément d'avancement depuis la dernière fois mais cela dit ils rassurent côté matériel.

Ils veulent suivre le cahiers des charges établi pour le crowdfunding.

On devrait avoir plus d'infos côté software j'imagine. Leur prototype en place ils vont pousser Gnome/KDE pour rendre les interfaces plus doigts-friendly.
