+++
Author = "Lord"
Description = "Petite liste des applis Android que j'utilise en 2019. La majorité sont libres et téléchargeables depuis Fdroid."
Categories = ["android"]
menu = "main"
notoc = true
WritingDate = 2019-09-10T23:40:02+02:00
lastedit = 2019-09-17T15:45:30+02:00
date = 2019-09-16T10:40:02+02:00
title = "Mes applis Android"
editor = "kakoune"
+++
Après avoir [épuré le téléphone]({{< ref "/posts/179-epurer-un-tel-android" >}}) il est temps de le peupler convenablement.

La quasi-totalité des applis que j'utilise sont libres et dispos sur **fdroid**.
Il y a encore qui ne le sont pas mais c'est généralement les applis pré-installées pour laquelle je n'ai pas trop cherché de remplaçant.

## Launcher
Première chose à faire, utiliser un launcher potable.
Habituellement j'utilisais *Trébuchet* que j'ai découvert sur Cyanogenmod il y a maintenant fort longtemps.
La force de l'habitude étant, j'ai toujours essayé de le réinstaller lors des changements de téléphone.
Pas de bol, il n'est pas compatible avec mon nouveau téléphone (problème de version d'Android je suppose).
Du coup j'ai regardé un peu fdroid et j'ai débusqué **Kiss Launcher**.
J'avais déjà testé un launcher uniquement textuel et j'avais trouvé ça assez con sur un tel tactile.

Là cependant, c'est juste nickel, pas de supreflu : des icônes en bas pour les favoris, une barre de recherche, quand on appuie sur l'écran il affiche la liste complète des applis.
Il est on ne peut plus rapide et super léger et se permet même quelques options bien venues.

C'est rare de trouver des applis aussi légères et bien foutues !

## Clavier
Je vous ai déjà pondu un truc à ce propos : j'utilise **MessageEase**.
Il est pas libre mais malheureusement je suis addict.

J'ai jamais trouvé mieux, il est bien pensé et bien foutu.
Il est pas beau, mais je m'en fous complet, il fait tout bien ce qu'il faut et n'a pas de trackers ou autre et on peut le télécharger direct sur leur site sans passer par le Play Store.
Bref, si vous voulez, [mon article plus détaillé à son sujet]({{< ref "/posts/153-messagease" >}}) est toujours dispo.

## SMS
J'utilise **Silence** depuis quelques années maintenant.
J'aime bien le fait que c'est une appli de SMS qui semble classique mais qui permet d'avoir des conversations chiffrées avec les autres utilisateurs.

Et ça n'utilise que les SMS, pas de data nécessaire.
Et pour chiffrer c'est ultra simple, tout le monde peut le faire, ça ne nécessite aucune connaissance technique.

## Lecteur de QR Codes
J'utilise le classique **Barcode Scanner**.
J'ai pas testé d'autres trucs mais celui-là fonctionne bien pour le peu que j'en ai besoin.

## Navigateur
J'ai choisi **Fennec** qui est un dérivé de Firefox made in Fdroid.
En gros ils ont recompilés Firefox en enlevant le branding et les parties les plus problèmatiques.
En gros c'est à 99% du Firefox classique.
Ça tourne bien et il y a peu de pistage.

## GPS
Là j'utilisais **Google Maps**.
Ça marche quand même super bien, le moteur de recherche est top et c'est très rare qu'il ne trouve pas une adresse.
Il peut trouver aussi les commerces par leur nom.
Mais bon c'est du Google proprio quoi…

Du coup je tente de migrer à **Maps.me** (enfin Maps tout court sur fdroid) mais c'est pas encore parfait.
L'interface est pas mal, les cartes bien exhaustives (merci les mappers) et puis ça marche complètement offline.
Par contre le moteur de recherche … c'est pas facile : la moindre faute il trouve pas, parfois il trouve pas mais en fouillant un peu les suggestions finalement si c'est bien présent mais en fin de liste alors que j'ai bien tapé « 3 rue du boudin trifouillis-les-oies ».
En dehors de ce souci de moteur de recherche c'est vraiment bien.

Je me demande pourquoi ils font pas comme certains GPS où tu rentres les premières lettres de la ville et il te propose une liste de choix, puis les premières lettres de la rue et il te propose de compléter, puis le numéro.
C'est moins moderne, mais j'imagine que lorsque le moteur de recherche n'est pas aussi performant que ce qu'offre Google c'est une bonne alternative.

## Notes
Mes besoins sont vraiment légers, juste de quoi noter un truc et c'est tout.
Pas de synchro, pas d'upload, pas de formatage.
Juste un pense-bête minimaliste.
Du coup je me suis tourné vers **Simple Notes**.

Ça fonctionne, parfait.

## Fediverse
Pour traîner sur le Fediverse j'ai utilisé Tusky quelque temps et finalement j'ai migré sur **Fedilab**.
Pas mal d'options (presque trop).
Je m'en sers assez peu, c'est vraiment pour combler les rares moments d'ennuis.

C'est très souvent mis à jour et ça fonctionne pour un peu tous les services du Fédiverse.
Le dev fait un sacré boulot !

## Kodi
J'ai un Kodi qui traîne à la maison pour mater des films.
Du coup je le contrôle à la télécommande de la téloche mais c'est pas terrible.
J'ai également une manette de xbox c'est mieux (beaucoup plus réactif) mais dès qu'il faut entrer du texte c'est une tannée.

Du coup j'ai aussi **Kore** qui permet de contrôler Kodi depuis le téléphone.
Ça permet on peut naviguer dans les menus mais surtout d'entrer du texte.
Bon ça vaut pas un vrai clavier physique mais c'est mieux qu'une manette ou une télécommande.

## Youtube
Pour mater des vidéos sur Youtube ou juste y écouter de la musique, j'utilise **NewPipe**.
Elle propose tout ce qu'on peut espérer : choix de la résolution, téléchargement, écoute en arrière-plan, PIP.
Et le pire c'est que l'interface reste simple.
Il paraît que c'est mieux que l'appli officielle.

## IRC
J'utilise l'appli **Weechat Android** ~~qui n'est pas dispo sur fdroid~~ mais chopable direct depuis github.
Elle se raccorde à une instance weechat tournant ailleurs et permet de retrouver tous ses buffers sur le téléphone.
L'interface est bien adaptée au téléphone ce qui lui confère un avantage certain par rapport à un client ssh pour récupérer une session tmux avec weechat.

Elle a juste une ptite tendance à pas aimer être mis en veille par le téléphone (ce qui rend la reconnexion impossible, il faut killer l'appli et la redémarrer dans ces cas).

## Contacts
Bon, là je suis aussi parti sur **Simple Contacts**.
C'est simple et efficace.
Pas besoin de plus.

## Dialer
J'en ai pas trouvé de libre qui me convienne, j'ai testé *Emerald Dialer* qui pourrait suffire mais l'affichage complètement foireux (pour les français) des numéros me rebute complètement.

Depuis deux semaines j'ai installé **Dialer2**, on verra bien.
À première vue l'appli date des temps reculés mais est toujours fonctionnelle.

-----------------
Voilà tout.

Globalement c'est les applis de téléphonie qui sont les plus pauvres en alternatives.
Triste monde.
Pas d'appli de téléphonie sur fdroid, deux pauvres dialers, niveau contacts c'est pas reluisant non plus.


