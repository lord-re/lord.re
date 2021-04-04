+++
Author = "Lord"
Description = "SponsorBlock est une extension pour navigateur (et pour mpv) pour passer automatiquement les segments de pub, les intros et les outros dans les vidéos Youtube."
Categories = ["vidéo", "mpv"]
menu = "main"
notoc = true
WritingDate = 2021-04-04T21:48:17+02:00
date = 2021-04-04T21:48:17+02:00
title = "SponsorBlock : S'épargner du temps sur Youtube"
editor = "kakoune"
TopWords=["youtube","mpv","scripts","lua","extension","sponsor"]
+++
J'ai une relation compliquée avec Youtube.
Ce site ouaib est merveilleux.
À mon sens après **Wikipedia** c'est le seul site ouaib qu'il faudrait conserver si jamais Internet/l'humanité devait disparaitre.
Il contient tellement de contenu intéressant/varié/héteroclite/extraordinaire/passionnant/chiant/indispensable/nul/enrageant/…
Bref, c'est un beau reflet du monde.

Mais ça reste *une plateforme tout de même pas mal hostile*, avec son algorithme qui dicte le comportement des créateurs de contenu tout ça pour maximiser la monétisation de tout ce contenu à la fois pour ses créateurs que pour la plateforme elle-même.
Il existe quelques alternatives mais malheureusement la grande force de Youtube est aussi sa faiblesse : la monétisation.
C'est elle qui a permis l'émergence de tout un tas de créateurs de contenu.
Mais c'est aussi elle qui a tendance à uniformiser/pourrir/influencer/… tout un pan des créateurs.

Bref, *j'adore Youtube et je suis un gros consommateur de son contenu* mais je suis parfaitement conscient que c'est une plateforme ayant d'énormes défauts.
Et là j'aborde même le fait que ce soit une branche de Google…

Bon, j'ai beau être un très gros utilisateur, je n'ai pas de compte Youtube.
Je n'ai jamais commenté ni participé globalement au site d'une part, parceque je n'en vois pas vraiment l'intéret ni le temps (haha) et je n'ai pas vraiment envie de rentrer dans le jeu de Google.

Bon et puis comme tout le monde (apparemment non mais bon pourquoi pas) *j'utilise un bloqueur de pub* (certe moins conventionnel et efficace mais largement suffisant).
Du coup, je m'épargne un gros paquet de pub sur Youtube.
Sans ça, la plateforme devient un peu trop proche de son ancêtre la téloche : on est constamment matraqué de pub.
C'en est débilitant.

Je suis désormais tellement épargné par la pub que les rares fois où je la subis ça m'est vraiment insupportable.
Se taper des annonces qui gueulent, avec une répétition qui prennent la tête me met hors de moi.
*J'ai une réaction qui peut paraître exagérée pour ceux plus habitués mais voilà chuis comme ça désormais*.

Et puis le pire dans tout ça, c'est que *la grande majorité des vidéos que je regarde, je les consulte via* **mpv**, du coup je suis même pas compté dans les nombres de vues.
Donc je rapporte même pas de pognon à ces créateurs.
Je ne consulte le site ouaib juste pour trouver la vidéo que je veux pour ensuite déclencher mpv.

Bref, Youtube sans bloqueur de pub est devenu inutilisable (bon ça fait un bail).
Sauf que maintenant les plus gros créateurs de contenu ont su s'adapter et font désormais de la pub eux-mêmes dans leur contenu.
*Tout travail mérite salaire*, je le conçois et ces gens ont besoin de vivre mais bon entendre en boucle de la désinformation limite malhonnête à propos des VPN ça me gonfle (dis donc j'ai l'impression d'être énervé en lisant tout ça alors que pas du tout je suis plutôt relaxe).
La pub pour le dernier jeu mobile de merde que je ne pourrai même pas trouver sur fdroid me fait une belle jambe.

Et là, j'ai découvert le graal : *une extension qui permet de passer les passages de contenu sponsorisé à l'intérieur des vidéos !*
Oui !
Un simili-bloqueur de pub pour l'intérieur de la vidéo !
Voici donc [SponsorBlock](https://sponsor.ajay.app/) qui existe pour les navigateurs classiques.

Mais là, où ils sont forts, c'est qu'*il y a même un script lua pour mpv* !
Du coup c'est utilisable dans mpv !!!
Je suis sauvé \o/

Bon alors comment ça marche ?
En fait *l'extension s'appuie sur ses utilisateurs pour qu'ils renseignent les segments à bloquer dans une vidéo*.
L'extension envoie ça dans sa base de donnée sur son serveur.
Quand on démarre une vidéo, l'extension consulte la base de donnée où elle récupère les segments à sauter.
En sachant que la vraie extension peut être configurée pour sauter que certains types de segments.
Ça peut être que les segments sponsorisés ou bien aussi les génériques par exemple.

C'est un système assez simple mais *ça marche vraiment bien*.
Il faut bien entendu que la vidéo ait déjà été visionnée par d'autres utilisateurs.
Ça marche donc mieux sur les vidéos très populaires et qui ont déjà une certaine ancienneté (quelques heures suffisent).

Voilà voilà.
Je n'ai pas grand-chose d'autres à ajouter à ce propos.
Pensez à tout ce temps que vous allez gagner, toutes ces bribes de cerveau que vous n'allez pas vous détruire !
