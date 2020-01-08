+++
Author = "Lord"
Description = "Las de me répéter concernant les switchs voici un ptit topo sur leur fonctionnement. Les switchs réseaux sont un élément de base de tous les réseaux informatique."
Categories = ["réseau", "culture","vulgarisation"]
menu = "main"
notoc = true
WritingDate = 2020-01-07T11:55:20+01:00
date = 2020-01-07T11:55:20+01:00
title = "Le fonctionnement d'un switch réseau"
editor = "kakoune"
lastEdit = 2020-01-08T23:39:11+01:00
+++
Le *commutateur réseau* ou *switch* est un appareil de base de tout réseau informatique.
C'est la multiprise réseau qui permet de raccorder un peu tous vos appareils à votre réseau local pour avoir accès à l'Internet !

C'est un truc assez basique mais qui n'est au final pas très bien compris.
Et au lieu de me répéter encore cinquante fois autant écrire ici une fois pour toute un chouilla de vulgarisation à son propos.
Je vais pas aller très loin dans la technique et je me contenterai des switchs classiques qu'on peut s'acheter pour la maison.

## Un port réseau
Un port réseau c'est … une prise réseau ethernet.
C'est le trou avec une forme caractéristique (un rectangle avec une encoche en haut pour la languette des câbles (le truc qu'on casse et qui est censé empêcher le câble de se déconnecter).

*Ce port réseau contient 8 contacts électriques pour faire passer le signal*.

À l'époque fallait faire gaffe au type de câble mais maintenant les ports réseaux des différents appareils s'arrangent pour croiser/décroiser comme des grands.

Pour faire passer du téléphone on peut également utiliser ces prises et on a besoin uniquement de 2 contacts (du milieu) sur les 8 disponibles.
Pour faire passer du réseau il en faut au minimum 4 sur les 8 mais pour atteindre la vitesse maximum, il faut bien entendu les 8.

(je précise car c'est une source de problème assez courant d'avoir soit la prise soit le câble un peu pété mais pas complètement.)

## Le Hub
Avant l'arrivée des switchs il existait déjà les hubs qui sont *l'ancêtre primitif des switchs*.
Ils ont le même but : **raccorder différents équipements ensemble**.

Le but est le même mais un hub est "con" et s'avère n'être qu'une multiprise.
*Tout ce qui rentre par l'un des ports est envoyé à tous les autres ports*.

Ça fonctionne sauf qu'on s'est vite rendu compte que ce n'était clairement pas très efficace et que d'un point de vue confidentialité des échanges c'est pas top.
N'importe qui branché sur un hub peut écouter tout ce qu'il se raconte sur le hub.
Il est possible d'intercepter toutes les communications sans équipement particulier.

## Le switch
Face à ces problèmes et les avancées technologiques aidant (les puces étant moins chères surtout), *on a ajouté de l'intelligence dans les hubs pour les transformer en switch*.

Le switch comprend le langage utilisé par les machines qui lui sont raccordé.
Et avec ce qu'il comprend il se débrouille pour n'envoyer les informations qu'aux ports concernés.

Imaginons un cas simple :

  - un switch
  - un ordinateur A
  - un ordinateur B
  - un ordinateur C

Lorsque A discute avec B, l'ordinateur C ne recevra pas la conversation entre A et B.

## Comment il sait ?
Le switch possède donc un petit processeur et surtout un peu de mémoire.
Lorsqu'un ordinateur est branché sur un port du switch, l'ordinateur annonce qu'il possède telle adresse MAC.

**Le switch consigne l'information que sur le port X se trouve l'adresse MAC Y**.
Il met tout ça dans un tableau qu'il consultera à chaque fois pour savoir à quel port envoyer telle information.

Bon ça paraît simple et vite vu mais il faut garder à l'esprit que sur un port d'un switch, vous pouvez brancher tout et n'importe quoi.
Vous pouvez brancher un autre switch.
Ça veut donc dire que sur un port, vous n'allez non pas avoir 1 adresse MAC mais tout un tas d'adresses MAC correspondant à chacune des machines présentes sur le second switch.
Et vous pouvez en enchaîner plusieurs comme ça.

Une des caractèristiques technique d'un switch est donc la taille de sa mémoire lui permettant de connaitre plus ou moins d'adresse MAC.

*Mais que se passe-t-il quand sa mémoire est saturé ?*
Et bhé c'est moche à dire mais ne sachant plus trop quoi faire, il peut avoir un comportement aléatoire.
Certains switchs vont carrément se planter (très mauvais switch, ceux-là faut les éviter).
D'autres vont se comporter comme des hubs avec des performances pas mal dégradées (symptôme repérable).

Ce second comportement est d'ailleurs une attaque assez classique d'un réseau : **sur un port on sature la mémoire du switch en envoyant plein d'adresses MAC fictives**.
Une fois la mémoire saturée, le switch se comporte en hub et l'attaquant est désormais à même de capturer le trafic passant sur tout le switch (interception d'appels SIP, capture de trafic web, récolte d'identifiant telnet…).

## Le cas des boucles
Si vous êtes un peu farfouilleur, vous vous demandez ce qu'il se passe quand on fait une boucle :

Vous branchez le switch A sur le switch B et un second câble qui relie le switch B au switch A.
Vous avez créé une boucle.
Du coup sur les ports en question vous avez les adresses MAC qui vont se répliquer d'un switch à l'autre à l'infini.
BOUM.

*Les switchs ont horreur de çà et là aussi c'est la loterie*.
Certains switchs vont tenter de fonctionner tant bien que mal, mais vous aurez des performances d'un autre temps.
Ça deviendra inutilisable.

D'autres switchs cesseront de fonctionner mais certains sont suffisamment malin pour détecter ce genre de connerie et ils prendront la décision de désactiver l'un des deux ports de la boucle.

Ça paraît con mais c'est une cause trèèèès fréquente de panne.

*Quand vous voyez toutes les loupiotes du switch clignoter de façon assez synchrone c'est louche et il va falloir trouver la boucle*.
Ça peut paraître con mais quand vous êtes sur un réseau avec une quinzaine de switchs dans tous les sens c'est beaucoup moins drôle à dénicher.


## Performances d'un switch
L'argument premier d'un switch est son nombre de ports.
C'est vrai, on cherche souvent à raccorder tous ses appareils et le reste importe peu et pourtant il y a quelques considérations à avoir.

Il faut aussi regarder les vitesses qu'il permet d'atteindre.
*Il y a des switchs (anciens certes mais encore à la vente) qui sont limités à 100Mbps.*
C'est désormais pas mal **obsolète**, d'autant plus que les connexions fibrées sont désormais pas mal démocratisées et qu'elles seraient bridées par un tel switch.
Méfiez-vous des grandes surfaces qui vendent encore ce genre de truc alors que pour moins cher vous trouverez bien mieux.

On trouve donc des switchs plus rapide jusqu'à même 10Gbps (je parle pas du matos pro qui monte plus haut sur des technos en fibre optique) même si c'est encore un peu tôt pour de tels débits.
Méfiez-vous tout de même, quand on donne ces vitesses la, *c'est la vitesse individuelle d'un port*.
Il faut bien voir que si tous les ports du switchs sont sollicités à fond en même temps, la vitesse sera bien moindre.
Sur la fiche technique on trouve (assez rarement) la vitesse cumulée totale que le switch est à même de soutenir.

Si j'insiste un peu sur ce point, c'est que sur des ptits switchs bas de gamme, les performances réelles sont loin des théoriques.
**Si vous investissez dans un switch, vous le garderez très probablement de longues années et donc grapiller quelques menus €uros n'est pas forcément très judicieux.**

## Conseil d'achat ?
Bof.
Mais bon *j'aime bien les ptit netgear GS108E, c'est du basique mais très fiable*.
Vous vous en tirerez pour une cinquantaine d'€uros pour du 8 ports.

J'en ai trois dont un qui tourne depuis 8 ans.

## En quoi les switchs pro sont différents ?
Ils font beaucoup plus que simplement switcher.

 - Certains sont de véritables routeurs
 - Certains font un peu de pare-feu.
  - Ils peuvent avoir plein de fonctionnalités de switchs supplémentaire (les VLAN, la QoS…) permettant d'avoir de meilleures performances ou surtout plus de sécurité en segmentant le réseau en différents réseaux plus petits et plus hermétiques.
  - Ils peuvent faire des statistiques.
  - Ils peuvent être configurés à distance et monitoré.
  - Ils peuvent transformer un port en Hub (pour du débug et plus si affinité).
  - Ils peuvent raccorder de la fibre ou atteindre des débits bien plus élevés.
  - Ils peuvent se raccorder les uns aux autres pour fonctionner comme un seul gros switch.
  - Ils peuvent alimenter électriquement les appareils qui y sont reliés (très pratique !).
  - Ils permettent de raccorder bien plus d'équipements

C'est bien entendu non exhaustif mais c'est juste pour vous donner quelques pistes.

-----------

Voilà pour ce ptit tour concernant les switchs.
J'ai bien trop écrit switch aujourd'hui.
