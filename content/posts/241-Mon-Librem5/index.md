+++
Author = "Lord"
Description = "Ça y est j'ai un Librem 5 un téléphone sous linux assez particulier."
Categories = ["librem", "linux"]
menu = "main"
notoc = true
WritingDate = 2023-05-07T19:10:26+02:00
date = 2023-05-08T14:10:26+02:00
title = "J'ai un Librem5 !"
editor = "vim on librem5"
TopWords = [ "usb", "appli", "matos", "menu", "clavier", "linux", "logiciel", "android", "téléphone","sway"]
+++
Rappelez-vous !
Vous les lecteurs les plus fidèles de mon humble blog, il y a cinq ans j'étais tout foufou à propos du **Librem5**.
Ça y est, j'en ai un !
J'ai enfin la chance de posséder cet ovni.

## Librem5, mais c'est quoi donc ?
Purism est une entreprise américaine qui fabrique des ordinateurs mais qui tente tant que possible de faire en sorte que toute la partie logicielle soit libre.
Ils ont leur propre distribution Linux basée sur Debian, ils vendent des machines avec Libreboot, bref vous voyez le topo.

Ils ont monté un crowdfunding pour fabriquer le **Librem5** un smartphone tournant qu'avec du Logiciel Libre.
Ce n'est donc *pas de l'Android mais bel et bien un authentique Linux sur cette machine*.
Et voilà qu'on a une belle brique chauffante !

Quand je dis que c'est un ovni, il faut bien voir que Purism s'attaque à un truc qu'à peu près personne d'autre ne fait.
{{< img src="librem5.jpg" alt="Photo du téléphone sur une table. On remarque qu'il est assez épais et présente trois boutons physiques." title="Aussi appelé la brique avec des finitions pas top.">}}

*Ils fabriquent des ordinateurs et maintenant un téléphone où tout le logiciel nécessaire est libre*.
Le téléphone coûte cher, trèèès cher.
On parle de **1200$ pour du matos qui est techniquement à sa sortie à la ramasse** niveau performance avec des finitions assez hasardeuses.
Mais ce prix permet de payer des devs pour écrire des drivers, de l'interface, des applications libres et tout cela … bha oui ça nécessite du pognon.
On est pas dans le business model classique du smartphone où le constructeur sort un modèle avec pour objectif d'en vendre des palettes pendant un an et puis c'est tout.
Ici, *leur but est de sortir le matos mais également d'écrire tout le logiciel qui va avec et d'assurer une certaine durée de vie à l'appareil.*

Le fabricant de ce téléphone ne se fait pas trop d'illusion, ils ne visent pas le marché grand-public, ils sont conscients des limites de leur téléphone.

## PureOS
L'OS fourni avec l'appareil est donc *un dérivé de Debian avec un environnement Gnome*.
L'interface graphique est cependant pas du Gnome pur mais **Phosh** qui est *plus adapté à une utilisation téléphone portable*.
C'est plus petit, ça utilise des glissés, il y a une barre de statut assez ptite qui donne accès à des réglages rapides.
Ce n'est pas ma tasse de thé.
Sur ordinateur fixe, j'ai jamais vraiment accroché à Gnome surtout à partir de la version 3.
J'ai toujours trouvé que c'était des *logiciels étrangement foutus*.
À chaque fois je trouve les réglages par défaut bizares et le pire c'est que souvent il n'y a pas spécialement moyen de les modifier.

*Leur interface a été décriée parcequ'elle semblait trop s'adapter au monde des téléphones et des tablettes et pourtant force est de constater que c'est du tout le cas.*
D'ailleurs Purism a fait un énorme boulot auprès de GTK avec leur **libhandy** qui sert à adapter les logiciels aux tout petits écrans des appareils portatifs (handheld).
Mais il faut que les logiciels soient adaptés pour utiliser cette dernière.

*J'ai testé un peu leur distro quand j'ai reçu l'appareil mais franchement c'est pas du tout à mon goût.*
C'est lent et … bha mine de rien quand on est habitué au confort d'Android dont l'interface a été pensée et repensée ces quinze dernières années… ça fait un choc.
Je n'ai même pas pris le temps de prendre des screenshots.

C'est pas de la merde, j'ai pas dit ça, mais *ça n'a pas le même niveau de finition et de raffinement d'Android.*
Android est aussi agréable à utiliser grâce à ses très nombreuses itérations.
Ça ne s'est pas fait du jour au lendemain, mais on a tendance à oublier le boulot qu'ils ont déjà accompli sur ce terrain.

Bref, PureOS c'est pas mal mais c'est loin d'être fini et il faudra encore une montagne de taff pour améliorer la situation.

Il y a une ptite brochette d'appli installées de base.
C'est pas exhaustif mais ça a de quoi couvrir une ptite partie des besoins.
Par contre le catalogue est … très peu fourni.
Bref, *se contenter de PureOS me semble assez difficile.*

## Les problèmes de ce téléphone
Bon je vais pas tourner autour du pot, je ne me vois pas recommander ce téléphone.

### Soucis d'autonomie
D'un point de vue performance brutes, déjà, c'est du matos un peu vieillot pour ceux qui suivent un peu le truc.
Mais bon, *c'est pas non plus un point rédhibitoire*.

Par contre *niveau autonomie c'est juste pas possible*.
La batterie du téléphone ne tient absolument pas.
*Il se vide tout seul à environ 20% par heure* même en ayant coupé wifi et sans carte SIM.

Apparemment c'est en partie dû au matos utilisé.
Le constructeur a choisi du matériel avec des critères assez particuliers : il fallait que ça tourne avec du logiciel libre.
Aurevoir le matos ultra optimisé, le choix était très restreint et on retrouve donc du matériel qui à la base n'est pas forcément prévu pour du matériel qui tourne sur batterie mais plus pour des appliances normalement branchées sur secteur.
*Ce ne sont donc pas les puces les plus sobres qui existent.*

*À cela on rajoute des drivers pas forcément optimisés au max.*
Et le troisième coup de massue : tout simplement *le userspace linux classique n'est pas autant optimisé qu'Android sur ce point*.
Android a tout un tas de code fait pour limiter la consommation énergetique du code qui tourne en limitant les applis à mort et tout.
Bha là c'est inexistant donc … ça bouffe du jus.
Les logiciels ne sont pas au courant qu'ils tournent sur une machine à l'autonomie très limitée.

*Il en résulte une autonomie merdique et un téléphone qui chauffe pas mal et qui en plus est assez lent par rapport aux téléphones android à prix équivalent*.

### L'environnement logiciel
*Pour le commun des mortels, un téléphone sous linux n'a aucun intéret.*
Ici pas d'appli pour faire des bruits de prouts, pas d'appli bancaire, pas d'appli pour controler votre sonnette connectée, pas d'appli pour regarder la télévision, pas d'appli pour …

**En fait il n'y a juste pas d'applications mais du bon vieux logiciel.**

Pour un geek, pas juste kevin qui achète le dernier iphone tous les ans et qui regarde micode les yeux qui brillent entre deux articles Clubic, non je parle d'un vrai geek ; pour lui ça sera par contre jouable.
*C'est un super jouet à bidouiller.*

### Allo ?
Bon là j'ai pas d'avis, j'ai pas mis de carte SIM dedans et je ne compte pas le faire.
*Je sais pas si on peut vraiment téléphoner avec, je sais pas si on reçoit les sms, je sais pas si on capte bien.*

Ça ne m'intéresse pas, je n'ai pas l'intention d'en faire mon téléphone usuel.
Le boulot me force à utiliser Android sans alternative possible.

## Mais c'est de la merde ?
Je dois avouer que quand je l'ai reçu, j'étais en grande partie conscient de ces soucis.
Mais de les constater réellement ça a été un peu *la douche froide*.

Par chance je ne l'ai pas payé le prix attendu puisqu'il m'a été donné par un fédinaute pour le simple prix du transport.
Jamais je n'aurai pu me permettre de balancer autant de pognon là-dedans d'ailleurs.
J'imagine mal les gens ayant balancé 1200$ être satisfait.

Par contre *je ne pense pas que c'est de la merde*.
Déjà, parceque mine de rien ce téléphone fait un peu avancer les choses.
Une partie du prix du téléphone permet de contribuer au logiciel libre et c'est déjà cool.

Ensuite il crée une communauté d'utilisateurs qui sont pour la plupart également dev et donc se penchent sur le bousin et crée du logiciel en rapport.

*Les premiers jours quand j'ai testé PureOS j'ai trouvé ça très décevant.*
Par contre, le weekend venu j'ai pris le temps de flasher le téléphone pour y installer autre chose.
Là, *ça a été une épiphanie avec PostmarketOS*.

## Je déteste Android
*Android était censé être l'OS basé sur Linux qui allait libérer tout le monde* sur son passage mais au final on se retrouve sur un truc de plus en plus vérrouillé de partout contrôlé par Google.
Cet environement me semble d'ailleurs *de plus en plus hostile envers ses utilisateurs* avec les années qui passent.

Alors que les roms customs étaient légions, *les constructeurs se battent constamment pour empêcher le root et vérouillent leurs bootloaders*.
Et quand ce n'est pas le cas, il faut suivre des tutos sortis de forums louches où l'on installe des binaires se reposant sur des failles logiciels ou hardware en provenance de sites étranges.
Et le pire c'est qu'on risque de briquer le téléphone en foirant sa garantie au passage.

En plus chaque constructeur fait sa variante, chaque opérateur rajoute ses merdes, Google passe le premier pour pourrir l'OS.
Bref, sur un téléphone neuf on se retrouve avec un empilement de logiciels des moins ragoûtant.

Mais heureusement un sauveur est arrivé !

## PostmarketOS
C'est une distribution Linux qui a pour but de donner *une seconde vie aux smartphones* délaissés par les constructeurs.
Exit Android et tout son userspace, ici on est sur du *Alpine Linux avec des scripts et des préconf pour rendre les téléphones utilisables*.

Le problème c'est que c'est *une petite distribution communautaire sans le sou*.
Ils sont malheureusement *tributaires des constructeurs de téléphones* : c'est au constructeur de ne pas vérrouiller le bootloader, c'est au constructeur de fournir des drivers libres pour le matos, c'est au construteur de publier le code nécessaire pour faire tourner leur matos sur du Linux quoi.

Et justement le **Librem5** (et le pinephone) est justement le téléphone le moins chiant pour cette distro vu que de base il tourne déjà sur un kernel linux propre.

C'est pour cela qu'*installer PostmarketOS sur le Librem5 est au final super simple*.

Cette distribution propose plusieurs environnements.
Il y a notamment Gnome desktop/phosh/plasma/plasma-mobile/sxmo/…

Contrairement à un ordinateur où il faut foutre le média d'installation sur clé USB puis booter dessus, on doit dans ce cas passer par un ordinateur.
En gros on le programme **pmbootstrap** qui permet de "construire" la distribution en fonction de ses goûts.
Ensuite on passe le téléphone en mode flash (on enlève la batterie, on appui sur volume UP, on branche l'USB, on met la batterie) et au bout de cinq minutes c'est bon c'est installé.

On démarre le téléphone et c'est flashé.
Pas de logiciel tordu, pas de faille, pas de manip hasardeuse, pas de code déverouillage à choper auprès du constructeur.
Non ici, c'est volontairement facile.

Merci beaucoup **Purism** pour cela, merci beaucoup **PostmarketOS** pour cela.

## Sxmo
Bon, après avoir testé la gnomerie de PureOS j'ai voulu testé Plasma Mobile mais pas de chance, sur la version experimentale du jour, une dépendance manquait.
Je me suis donc rabattu sur ce que je voulais réellement : **SXMO** [Simple X MObile](https://www.youtube.com/watch?v=c6Q1v4zRt1w).

{{< img src="firefox.png" alt="Le navigateur version classique qui affiche ce superbe blog." title="C'est le vrai firefox, pas la version bâtarde d'Android." >}}

C'est un environnement adapté à un appareil de ptite taille et pourtant ils ont fait tous les choix les plus contre-intuitifs.
Ils utilisent **Sway** qui est fait pour être utilisé principalement au clavier, ils ont rajouté tout un tas de menu via **bemenu** qui à la base s'utilise également au clavier.
Et le pire **c'est que ça marche sacrément bien !**

### wvkbd
Commençons par le clavier : [wvkbd](https://github.com/jjsullivan5196/wvkbd).
Il s'agit d'un composant vital après tout.

Ils ont donc fait un clavier *sans fioriture mais qui fonctionne*.

{{< img src="wvkbd.png" alt="" title="Oui le brouillon de cet article est rédigé sur le téléphone mais avec le clavier physique branché sur le port usb." >}}

Comme vous pouvez le voir il est plutôt rudimentaire et s'ils proposent quelques alphabets alternatifs, il ne connait pas l'azerty ni le bépo.
Pas de swipe, pas de prédiction, par contre ça marche avec wlroots et donc potentiellement vous pouvez le faire tourner sur votre ordinateur de bureau.

### lisgd
Mais comment utiliser avec ses gros doigts sur cet écran tactile ?
Et bien ils ont créé [un ptit logiciel du nom moche de lisgd](https://git.sr.ht/~mil/lisgd) permettant de lancer des actions avec des mouvements.

  - On glisse vers le bas depuis le haut pour lancer le menu système.
  - On glisse vers le haut depuis le bas pour ouvrir le clavier.
  - On glisse vers la gauche/droite pour changer de workspace, … bref vous voyez le topo.

C'est un peu difficile au premier abord mais après quelques heures ça le fait plutôt bien.
Et finalement couplé à **Sway** c'est terriblement efficace !
*Ça pourrait probablement être repiqué pour Android*.

### Bemenu
Alors là c'est du boulot de haute volée qui a été fait.

Si comme moi vous utilisez bemenu pour avoir quelques raccourcis à portée de main, *vous n'avez rien vu de la puissance de cet outil*.
Ces gens sont particulièrement doué : ils font des menus qui peuvent avoir plusieurs pages, ça affiche un mode dans la barre de sway, c'est pratique avec les doigts, ça ne nécessite pas le clavier.
J'ai été bluffé, je ne pensais pas que c'était possible !

{{< img src="contextual_foot.png" alt="Fonctions proposées : copy/paste/zoom in/zoom out/scroll up/scrool down/URL mode/hotkeys/search…/system menu/close menu" title="Je trouve ce menu contextuel via Bemenu complètement fou !" >}}

Bemenu combiné avec tout un tas de scripts et d'outils divers permet de gérer quasiment tout le téléphone : se connecter à un réseau wifi, augmenter la luminosité, baisser le volume, prendre un screenshot, redémarrer, lancer une appli, être utilisé en tant que menu contextuel !
Tout cela depuis un simple menu et utilisable avec les boutons physiques.

{{< img src="contextual_fx.png" alt="Le menu contextuel pour firefox avec des options en rapport avec la page." title="Et tous ces menus sont utilisables au doigt ou alors avec les boutons de volume et power (ou au clavier).">}}

Et comme le montre les screenshots, ils ont également fait des menus contextuels pour l'application avec le focus dans bemenu !
😲

## Qu'en faire ?
Et bha pour l'instant je ne sais pas trop mais, franchement c'est une machine atypique.

J'ai testé mon ptit dock USB-C qui me sort un hdmi avec un port ethernet et des USB.
Et le HDMI fonctionne (ptet l'ethernet aussi, pas testé) !

{{< img src="deck.png" alt="Capture d'écran avec le téléphone sur le premier écran et firefox+weechat sur le second écran" title="Dualscreen fonctionnel !" >}}

J'ai démarré un film, ça a tourné sans souci, un stream twitch, une vidéo youtube, de la musique, ssh pour de l'IRC.
*Je pense réellement que la machine peut remplacer un ptit laptop une fois couplé à un clavier et un dock USB-C ou tout du moins une tablette*.

## Conclusion
Je pense que c'est un très chouette joujou malheureusement bien trop cher.
L'expérience est très frustrante : avoir une machine avec autant de potentiel logiciel qui se retrouve sabordé par un hardware à la ramasse.

Cela reste un appareil de niche et ses très faibles ventes ne vont pas arranger la chose.

Haa si seulement une boîte comme Fairphone ou bien Framework se lançait dans la création d'un téléphone sous Linux avec un hardware réparable modulaire et avec du logiciel respectueux de l'utilisateur ça serait juste parfait !
Un appareil vendu avec Android mais où tous les drivers sont compatibles avec Linux et sans vérrouillage serait le chouchou des geeks.
