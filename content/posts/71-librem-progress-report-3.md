+++
Author = "Lord"
Description = "Traduction libre du troisième article d'avancement du Librem 5"
Categories = ["traduction", "hardware", "software", "librem","purism"]
menu = "main"
notoc = true
PublishDate = 2018-02-02T21:35:38+01:00
date = 2018-02-02T21:35:38+01:00
title = "3ème article d'avancement du Librem 5"
jdh = "https://www.journalduhacker.net/s/brdjj4/3_me_article_davancement_du_librem_5"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-3/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org) et le projet [Matrix](https://matrix.org).
Ils sont assez transparent sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

-------

## Le Librem 5 et l'actualité récente

Ces derniers temps, pas mal de news assez alarmistes ont fait l'actualité.
De nombreuses failles de sécurité ont été trouvées au seins même des processeurs.
Elles ne touchent pas uniquement Intel mais également en partie AMD et quelques cœur ARM.
En même temps, certains de nos contributeurs ont fait entendre leurs inquiétudes à propos du futur de NXP (fabricant du processeur envisagé pour le Librem 5) en vue d'une potentiel acquisition par Qualcomm. Certains se sont donc demandés :
"*Est-ce que le Librem 5 est affectés par ces bugs également ?*" et "*Est-ce que Purism parviendra à obtenir des puces i.MX 8 comme prévu ?*", donc répondons à ces interrogations.

## Épargné par Spectre/Meltdown

Pour le moment nous sommes quasiment sûr d'utiliser une des puces de la nouvelle branche i.MX 8 de chez NXP pour le Librem 5.
Plus précisément nous nous orientons vers l'i.MX 8M qui comprends 4 cœurs ARM Cortex A53.
Selon ARM, ces cœurs ne sont *pas* affectés par les failles Spectre et Meltdown, ce qu'ARM a résumé dans [leur bulletin de sécurité](https://developer.arm.com/support/security-update).

Donc pour le moment on est presque certains que le Librem 5 ne sera pas affecté cependant nous continuerons à surveiller de près la situation car des nouveautés font surface régulièrement.
À ce propos nous sommes heureux de vous annoncer que nous avons un nouveau consultant pour assister notre équipe sur les questions de sécurité du matériel ansi que des questions tel que : "*Est-ce que le CPU est affecté par Spectre/Meltdown ou non ?*".

## La possible acquisition de NXP par Qualcomm : pas un soucis

Les rumeurs comme quoi Qualcomm serait intéressé par un rachat de NXP courent depuis quelques temps.
Comme nous allons utiliser une puce NXP comme processeur principal (de la famille I.MX 8) nous sommes au courant et nous intéressons de près à cette histoire.

Qualcomm est leader pour les gros volumes de puces grand public alors que NXP vise le marché industriel à faible volume.
Il en résulte une approche radicalement différente concernant le support, particulièrement du logiciel libre.
Alors que NXP est habituellement tourné vers l'ouverture de ses spécifications techniques, Qualcomm est au contraire fermé.
Cela se reflète particulièrement sur le support du kernel Linux des puces des constructeurs respectifs.
La question est : Comment est-ce que le support des logiciels libres et la disponibilité des informations concernant les SOC NXP perdurera s'il y a acquisition ?

Tout d'abord, il est peu probable que le deal est lieu.
Qualcomm a vécu une année 2017 plutôt rude donc ils ne sont pas forcément dans une position financière leur permettant d'acheter une autre entreprise.
Ensuite, il y a également des rumeurs comme quoi Broadcom pourrait en fait racheter Qualcomm.
Après, les organisations mondiales de contrôles anti-monopole mènent des investigations afin d'approuver ou non une fusion.
Il y a à peine quelques jours, l'organisme de contrôle des monopoles européen a accepté une fusion mais avec de lourdes conditions.
Par exemple, Qualcomm devrait donner de nombreuses licences gratuitement concernant certains de ses brevets, etc.
Enfin, NXP est tenu par de nombreuses obligations : la façon dont NXP vise les petits et moyens clients les rendant dépendants; changer radicalement d'attitude blesserait ses clients et porterait lourdement atteinte à la réputation de Qualcomm et entraînerait également une perte de part de marché.

On imagine donc que la fusion n'aura pas lieu de si tôt et n'impacterait probablement que peu les i.MX 8.
Si la fusion s'opérait, seuls les futurs produits seraient impactés.

## Le développement

En plus de travailler à l'obtention de kit de développement i.MX6QuadPlus pour travailler dessus, l'équipe téléphone est activement en train de chercher et évaluer les logiciels qui formeront la base de nos développements pour les prochains mois.
Nous sommes parfaitement conscient de l'énorme quantité de travail à accomplir et des responsabilité que nous endosserons.
Parmi nos recherches, nous avons contacté l'équipe Gnome *human interface design team* avec qui nous avons discuté design et implémentation.
Par exemple, nous avons commencé à implémenter un widget prototype qui permettrait d'adapter bien plus simplement l'interface existante des applications desktop vers le téléphone voir d'autre style d'interface utilisateur.
Nous aimerions parvenir à faire en sorte qu'une application puisse s'adapter à l'appareil sur lequel elle tourne.
C'est toujours un objectif lointain, mais on y travaille ardemment.
Nous rencontrerons également les membres de Gnome au FOSDEM pour discuter de possibles évolutions et objectifs de design ainsi que de possibles collaborations.

Le travail de dev pour KDE/Plasma sera également fait par leur propre équipe d'interface.
Purism supportera leurs efforts en leur fournissant du matériel et de la documentation au fur et à mesure de l'avancement du téléphone.
Cela permettra à KDE/Plasma de fonctionner normalement sur le Librem 5 dès la sortie.
Pour mieux comprendre l'avancement avec Gnome et KDE, vous pouvez consulter [cet article de blog](http://puri.sm/posts/gnome-and-kde-in-pureos-diversity-across-devices).

Nous avons également testé et évalué différents compositeur et interface de bureau que nous pourrions utiliser comme interface pour le téléphone.
Nous visons un environnement *uniquement* Wayland pour se débarrasser de l'héritage X11 autant que faire se peu afin de profiter d'une meilleure sécurité et de meilleures performances.
Après discussions avec les mainteneurs Gnome des interfaces et compositeurs, nous ferions peut-être mieux de créer un nouveau compositeur (utilisé et soutenu par Gnome) afin d'éviter le fardeau d'X11.

Du côté application, nous avons créée une impressionnante liste d'applications que nous pourrions modifier pour permettre au téléphone d'atteindre les objectifs de la campagne (de crowdfunding) et nous avons plus restreint les piles de middlewares.
Nous sommes toujours en cours de réflexions/évaluations donc nous n'entrerons pas plus dans les détails pour le moment.
Nous aborderons bien sûr tout cela un peu plus tard dans un futur article.

## Rencontre avec les fabricants de puces

Comme le choix du CPU est quasiment pris, nous allons rencontrer NXP et d'autres fabricants de puces à l'*Embedded World* À Nürnberg en Allemagne à la fin du mois.
C'est très encourageant car cela fait maintenant des mois que nous travaillons à établir des liens direct avec NXP.
Nous allons enfin rencontrer nous rencontrer en personne lors de la conférence.
La recherche pour le design et les partenaires de fabrication prend plus de temps que prévu.
Notre équipe d'ingénieurs hardware et notre équipe logiciel (particulièrement bas niveau et ingénieurs kernel) ont commencé à créé une nomenclature (Bill Of Material) matériel et également un "plan" d'un éventuel PCB.
Mais il s'avère que beaucoup de constructeurs rechignent travailler avec des i.MX 8M car c'est un CPU/SOC tout nouveau.
Nous avons cependant de prometteuses pistes et de bons contacts donc nous explorerons cela.

## L'équipe Librem 5 sera au FOSDEM

Au fait, une bonne partie du staff de Purism [sera au FOSDEM](https://puri.sm/posts/meet-us-at-fosdem-2018/) ce week-end du 3 au 4 Février.
En plus des équipe design et marketing, les équipes PureOS et Librem 5 seront également là.
Nous aimerions vous rencontrer !
Des représentants Purism seront là pour répondre à toutes vos questions et porteront un tshirt Purism pour que vous les reconnaissiez facilement.

----
Et voilà :-)

Bref, ils rassurent à propos des failles Spectre/Meltdown.

Ce qui est intéressant c'est qu'ils expliquent un peu plus leurs collaborations avec Gnome et KDE. Ils adoptent un développement bien plus ouvert que ne le fait Google avec Android. C'est dommage que cet article ne parle pas de Matrix mais ça sera probablement pour une prochaine fois.

Comme d'habitude avec ce genre de projet, on apprend que ça prend un peu plus de temps que prévu sur le plan matériel mais visiblement leur choix de cpu est à peu près arrêté. Bref ça avance !
