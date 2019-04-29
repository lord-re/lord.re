+++
Author = "Lord"
Description = "La téléphonie précède l'informatique de quelques décennies et pourtant tend à converger avec cette dernière. Voyons quelques bases de la téléphonie pour les informaticiens qui veulent démystifier un peu le truc."
Categories = ["téléphonie", "culture"]
menu = "main"
notoc = true
PublishDate = 2019-04-25T13:15:12+02:00
date = 2019-04-25T19:15:12+02:00
title = "La téléphonie c'est pas si compliqué !"
editor = "kakoune"
+++
En voilà un sujet étrange !
Ouai j'en ai jamais parlé auparavant, mais je m'aperçois que c'est finalement assez peu compris même par les informaticiens.
Donc voilà quelques micro-bases de téléphonie pour ceux habitués aux dinateurs.

## Vocabulaire

  - **Téléphone** : Le terminal utilisateur constitué d'un micro, un haut-parleur de quoi numéroter.
  - **PABX** : L'appareil sur lequel est raccordé tout un tas de téléphone.
  - **Ligne** : Ce qui "alimente" un téléphone pour établir une communication.
  - **Numéro** : L'identifiant d'un téléphone ou d'une ligne.

Bon là c'est assez basique, mais il faut bien voir que sur une installation téléphonique on peut décoreller le nombre de téléphone, du nombre de ligne et du nombre de numéro de téléphone.
C'est-à-dire que l'on peut avoir par exemple 10 téléphones, avec seulement 4 lignes et uniquement 2 numéros de téléphones.
C'est ensuite le PABX qui va s'amuser à gérer tout cela.

Bref on peut assimiler le nombre de ligne au débit d'une connexion Internet, les téléphones aux ordinateurs, le PABX à un mix de box et de serveur et enfin les Numéros aux IP publiques.

## PABX

Le PABX c'est un appareil qui a le rôle de **modem**, **routeur**, **switch**, **serveur**.
Il peut en effet s'accomoder de types de lignes différentes, router les appels aux bons endroits en fonctions de règles.
On y branche plus ou moins de téléphones (de technologies différentes) dessus et en plus il permet d'ajouter des services supplémentaires (du répondeur enregistreur, de la répartition d'appels, du serveur vocal interactif…).

Bref c'est un peu comme les box des FAI désormais.
C'est d'autant plus vrai que désormais *les PABX sont de plus en plus proches du monde IP et donc sont parfois uniquement du logiciel sur une box*.

D'ailleurs soit dit en passant, on voit souvent l'appelation IPBX qui ne veut pas dire grand-chose selon moi.
Les PABX existent depuis des décennies et se sont toujours adaptés aux évolutions technologiques des lignes et des téléphones.
Ils sont passés du bon vieux RTC à du trunk SIP en passant par du Numéris avec des téléphones RTC, des DECT et des softphones.
Donc pourquoi changer le nom à part pour faire plaisir aux informaticiens ?

## Les lignes

  - Commençons tout d'abord par la **ligne analogique** ou **RTC**.
La ligne comme à la maison : deux fils de cuivre pour faire une boucle.
La qualité sonore est basique, mais elle a l'avantage d'être alimentée par l'opérateur ce qui pour certains téléphones peut suffire pour fonctionner encore lors de coupure de courant.
Elle va "bientôt" disparaître en n'étant tout d'abord plus proposé à la vente.

  - Il y a ensuite eu le **Numéris** ou **ISDN** existe en deux variantes en France : le **T0** et le **T2** (et rarement aussi en demi-T2).
Là, c'est une sacré évolution : c'est du *numérique de bout-en-bout* avec donc une meilleure qualité sonore.
Le T0 permet d'avoir deux communications simultanées alors que le T2 monte à 30.
Il nécessite cependant un petit boitier d'interface : la *TNR*.
Ce boitier est la propriété de l'opérateur et peut être alimenté électriquement chez le client en cas de ligne un peu capricieuse.
En plus de sa bien meilleure qualité sonore, la vitesse d'établissement d'un appel est vraiment beaucoup plus rapide.
Ces lignes ne sont vendues quasi-exclusivement qu'aux entreprises et sont sur le déclin du fait de leur prix élevé mais à une époque elles servaient pour avoir un accès à Internet à 128Ko/s voir près de 2Méga pour un T2.

  - La mode est en ce moment aux **trunks SIP** qui sont donc utilisé par-dessus le réseau Internet.
Ce protocole est donc bien plus proche du monde informatique que les précédents (il y a tout de même eu le h323 qui a eu son moment de gloire avant).
H323 émanait de l'[ITU](https://en.wikipedia.org/wiki/ITU-T) un organisme du monde des téléphonistes alors que SIP lui émane de l'[IETF](https://en.wikipedia.org/wiki/Internet_Engineering_Task_Force) qui règne sur le monde de l'Internet.
C'est le moment où la téléphonie a commencé a pas mal perdre pied face à l'informatique.
Il s'agit d'une *signalisation proche du HTTP*.
C'est ce qui se vend le plus actuellement.
Il arrive même parfois que l'on interface des PABX à des lignes SIP via des convertisseurs qui présentent des T0/T2 d'un côté et du SIP de l'autre.

## Les numéros

Déjà le plan d'adressage mondial est très hétérogène : chaque pays utilise un nombre de chiffre différent, le téléphone en lui-même ne peut donc pas savoir combien de numéro il doit envoyer mais c'est aussi galère même en restant en France.

  - On a des numéros à deux chiffres (les urgences)
  - à trois chiffres (les numéros de services)
  - les numéros à quatre chiffres (souvent surtaxés)
  - Enfin tout le reste est à dix chiffres.

C'est à peu près le même topo dans pleins d'autres pays.
Donc si on rajoute les préfixes internationaux, le système ne saura jamais combien de chiffres il va y avoir et ça peut être assez problèmatique.

Et comme pour l'IPv4, on s'est vite rendu compte qu'un numéro unique par terminal c'était pas forcément utile donc *on a développé un système similaire aux IP publiques et IP privées*.
Les opérateurs attribuent donc 1 <abbr title="Numéro de Désignation d'Installation">NDI</abbr> à chaque client et après, optionellemment vendent des <abbr title="Sélection Directe à l'Arrivée">SDA</abbr> aux clients ayant besoin de plus de numéro.
*Le PABX agit donc comme un routeur qui fait du NAT* avec d'un côté le réseau opérateur qui vous attribue X numéros (1 NDI et X-1 SDA) et de l'autre les terminaux sur lesquelles il va falloir attribuer les SDA.

D'ailleurs fun fact : les lignes Numéris peuvent être groupées (par exemple avoir 3 T0) pour pouvoir établir plus de communications simultanées.
Et bien dans ce cas, le premier T0 sera le "porteur du NDI" et les deux autres T0 auront un *numéro alphanumérique* donc avec des "ABCD" qui ne sont donc pas numérotables.
Ce numéro sert en interne pour l'opérateur.

Le PABX gèrera donc son plan de numérotation (plan d'adressage) local où il attribuera un numéro unique à 2/3/4/5/6/8 chiffres à chacun des téléphones qui lui sont raccordés dessus et fera la concordance avec une SDA et ce numéro interne.
Il arrive couramment donc qu'un téléphone n'ait pas de SDA (numéro publique) et donc il ne pourra être joint que par un transfert depuis un autre téléphone tout comme un serveur n'ayant pas d'IP publique pourra être joint via du NAT de la part du routeur.

## Les terminaux

On retrouve classiquement les téléphones mais ce n'est pas aussi simple que cela.
On a les simples **téléphones analogiques** qui ont deux modes principaux de numérotation : la signalisation par impulsions ou bien les DTMF qui ont succedées.
Ces téléphones fonctionnent sur deux fils de cuivre tout simplement avec une tension de fonctionnement variant entre 12 Volts et 60 Volts selon les modèles.

Il y a ensuite les **téléphones numériques** et là chaque constructeur de PABX fait à sa sauce : vous ne pourrez jamais faire marcher un PABX de marque X avec un téléphone numérique de marque Y.
Ces téléphones embarquent des fonctionnalités supplémentaires (les fameuses touches de supervision notamment).
Ils fonctionnent généralement sur une paire de cuivre mais parfois sur deux paires… rien de standardisé (ça peut être dans un autre ordre que l'accoutumée).

Il y aussi les **téléphones DECT** qui est la norme de téléphonie sans-fil la plus répandue, c'est un *simili-wifi* pour la téléphonie.
C'est étrangement compatible entre constructeurs.
On pose une antenne et on y appaire des téléphones avec plus ou moins de niveau de services.
Il y a les DECT "nature" génériques et les DECT des constructeurs qui ajoutent encore plus de fonctions mais au prix d'une compatibilité incertaine et d'un prix lui certain.

On retrouve ensuite les **fax**, mais aussi des **TPE** et des **machines à affranchir** mais dans un futur proche ça ne se vera plus sur des lignes RTC mais directement sur de l'IP…

Il y a aussi des **ascenseurs** qui ne sont que de gros téléphones (un peu capricieux) et les **alarmes** qui se modernisent eux aussi pour passer en SIP ou bien en GSM.

Les **téléphones IP** et autres **softphones** sont un peu différents car rattachés à l'informatique mais rien de fondamentalement différent non plus.

## Vous avez les bases
Maintenant vous devriez mieux vous y retrouver avec ces bases.

Les mondes de la téléphonie et de l'informatique se rapprochent voir désormais se chevauchent et il est toujours marrant de voir ces philosophies bien distinctes se confronter.
Les gros PABX sont en fait des amas de multiples ordinateurs imbriqués les uns dans les autres et fonctionnent en harmonie avec des uptimes colossaux (on croise régulièrement des machines avec quinze ans d'uptime).
La téléphonie est un domaine ultra propriétaire où toute fonctionnalité se déverrouille par l'achat de matériel mais en plus de licence.
L'arrivée rapide de logiciels libres dans ce domaine est une bouffée d'air frais mais la téléphonie proprio reste encore ultra majoritaire.
