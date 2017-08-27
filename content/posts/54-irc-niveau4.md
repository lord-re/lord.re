+++
date = "2017-08-24T16:09:56+02:00"
title = "Guide d'utilisation d'IRC : niveau 4"
menu = "main"
Categories = ["irc","tips","réseau"]
Tags = ["irc","tips","réseau"]
Description = "Bon suite à l'article précédent vous êtes devenu un usager de niveau 3 sur IRC. Et si vous voulez lvl up faut se pencher vers la gestion des salons pour savoir être un bon op. Allez on suit le guide."
notoc = true

+++

## Guide pour op : Protéger son salon
Tout fier de votre casquette d'op, vous vous demandez comment protéger votre fief des abrutis spammeurs/emmerdeurs ? Haha voilà un ptit guide pour défendre votre chez vous.

**Enregistrez votre salon**, c'est la toute première chose à faire auprès de C avec ***/msg C chan register #votresalon***, ici pas de mot de passe, par contre il faut que vous soyez identifié pour que ça fonctionne (comme toute la suite).

**La gestion des utilisateurs**. C'est un très vaste sujet qui pourrait suffire à un article dédié mais on va survoler et donner quelques clés. Il y a deux modes de gestions : soit avec des flags, soit avec des niveaux. Les flags sont le moyen le plus simple à privilégier à moins de vraiment vouloir du tordu. Il s'agit d'une simple liste d'utilisateur et pour chacun vous indiquez les accès de l'utilisateur. Par exemple dans le salon #truc vous voulez que l'utilisateur Lord soit op : ***/msg C chan #truc Lord +oO***. Désormais quand Lord rejoint #truc il pourra devenir op (+o) et il sera automatique op (+O). C'est donc un peu de boulot de remplir la liste des accès d'un salon mais c'est tout de même assez flexible et évite de se taper ça manuellement par la suite. La liste des accès possibles se trouve via ***/msg C help chan access flags***. Il est à noter que ça ne fonctionne qu'avec les utilisateurs enregistrés (ouai va falloir pousser vos utilisateurs à s'enregistrer pour profiter de ces raffinements).

Si vous êtes déconnecté et qu'aucun op n'est dispo mais que vous avez les accès requis pour l'être, il va vous falloir récupérer les accès. Donc pour op quelqu'un (ou vous même) il faut ***/msg C chan op #lechan lepseudo*** . Bon c'est pas mal mais si on a pas mal de monde à trafiquoter c'est long. Là on peut faire un ***/msg C chan resync #lechan*** pour que tous ceux qui ont un accès de configuré. Rapide et efficace.

## Les options
Bon bha maintenant que vous avez votre petite équipe d'utilisaeurs/op de bien geré, il va vous falloir modifier deux trois **options**.
La première option intéressante est le **private** qui permet de planquer quelques informations sur le chan, le second est le **secure** qui permet de voicer/opper uniquement les utilisateurs identifiés et éventuellement **protectops** qui empêche les ops d'être déoppé. ***/msg C chan set #lechan loption on***

## Les modes d'accès
Il y a pas mal de **modes pour les salons**, cette partie va être un gros morceaux. À commencer par les "modes d'accès" tels que **vhoq** (voice/hop/op/owner) mais ceux-là on les a déjà abordé.

Il y a également le mode **b** qui est en fait la liste des bans du salon.

Une fonctionnalité peu connue mais qui peut être utile est le mode **I** qui est une liste permettant aux gens présents sur celle-ci de joindre le chan même quand il est en mode **i** (inviteonly).

## Les modes indispensables
Dans les modes **basiques mais indispensables** on retrouve le trio **ntT** ainsi que le **s** et le **k**.

- **n** permet de bloquer les messages en provenance de personnes extérieures au salon (ouai sur irc, de base, vous avez le droit d'envoyer un message à un salon sans forcément y être).

- **t** quant à lui bloque les modifications du topic aux membres de niveau h ou plus alors que le **T** bloquer les "notices de salon" (qui sont un moyen exotique d'irc pour afficher des messages sur le salon (généralement vous n'en voudrez pas)).

- **s** permet de déclarer un salon comme étant secret. C'est à dire qu'il n'apparait pas dans les whois des utilisateurs et qu'il ne sera pas listé lors d'un ***/list***.

-  **k** permet de mettre un mot de passe (key) à un salon. Bon finalement, un ptit dernier pour la route, si vous êtes en milieu hostile, vous pouvez choisir de n'accepter que les gens utilisant du chiffrement via le mode **z**.

## Les modes "défensifs"
Bon passons aux modes pour se défendre des gentils vilains.

- Le premier mode (le plus connu) est le **m** pour modération. Une fois activé, seuls les gens de niveau "+" ou plus pourront parler sur le salon. Les casses pieds se retrouvent ainsi bouche bée.

- Il existe également le mode **M** qui est une variante qui est similaire sauf que les personnes identifiées même non voicées peuvent également parler.

- À coupler avec le mode **i** où seuls les gens recevant une invitation (via la commande /invite) pourront joindre le canal (d'ailleurs si vous êtes à la porte et que vous voulez une invitation, faites un */knock #lesalon*). Ces trois modes permettent de réagir à la majorité des attaques simples.

## Les modes contre les bots
Les attaques de bots sont un peu plus relou. Généralement ça consiste en de très nombreux "utilisateurs" qui rejoignent puis quittent immédiatement avec un message ou non, ceux qui vont changer de pseudo constamment, ceux qui vont flooder le salon. Il y a plusieurs solutions pour ça.

- **c** ce mode bloque tout ce qui est formattage du texte comme le gras/italique/couleurs.

- **l** ( L minuscule pour ceux qui ont une font pourrie ), permet de limiter le nombre de personnes connectées au salon.

- On bloque les hordes de knock avec le mode **K** (ouai ce genre d'attaque relou existe très rarement mais ça s'est déjà vu).

- Pour contrer les changements de pseudo c'est le **N**.

- Le **R** permet de limiter les join aux seuls membres enregistrés auprès des services (redoutable).

- Le dernier mode intéressant et l'un des plus complexes (ça reste soft quand même) est l'antiflood **f**. Il permet de définir des règles et du coup possède une syntaxe différentes des autres. Typiquement ***/mode -f [5t]:15*** signifie qu'à partir de 5 lignes de textes en 15 secondes, la personne sera kickée. Pas mal de possibilité pour ce mode sont à voir sur sa page de doc officielle.

Bon voilà pour ce que vous pouvez faire en tant qu'op sur un salon. C'est pas exhaustif mais ça permet de pouvoir réagir dans pas mal de situations.

**Concernant Geeknode** : ces derniers temps on a ajouté quelques modules pour se protéger des lourdingues.

 - Le premier est l'anti-amsg. Les amsg sont des messages qui sont envoyés sur plusieurs canaux simultanément.
 - Ensuite plus sympa c'est l'anti-caps. POUR ÉVITER LES HURLEURS. Les messages contenant trop de majuscules seront passés en minuscules. C'est un poil moins aggressif.
 
 - Et troisièmement l'anti-masshl. Les HL ou Highlight c'est quand quelqu'un mentionne le pseudo de quelqu'un. Dans la plupart des clients irc ça créer une notification et ça change les couleurs pour quelque chose de très visible (un highlight). Bref, ce module kill (déconnecte du serveur) les personnes faisant plus de 5 hl consécutifs (dans la même phrase ou alors 1hl par phrase dans 5 phrases d'affilées). Bref pas mal pour virer les pollueurs. Ce comportement peut être désactivé (certains bots ont tendance à hl) en mettant le salon en **s** ou **i**.

