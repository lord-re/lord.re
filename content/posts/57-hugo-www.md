+++
Description = ""
notoc = true
date = "2017-09-08T17:03:12+02:00"
title = "Refonte complète du site"
menu = "main"
Tags = ["www","meta","adminsys","cli"]
Categories = ["www","meta","adminsys","cli"]
publishDate = "2017-09-08T17:03:12+02:00"

+++

Ça faisait un bail que j'avais pas trop touché au site (blog ?). Ça fait depuis quelques années qu'il ne s'agissait que d'un simple fichier *index.html* que j'éditais à la mano dans vim. Une seule et unique page avec tout le contenu. C'était plutôt élégant techniquement et pratique. Mais ça a aussi quelques limites. La première c'est que j'avais pas de flux rss. C'est un peu la honte. Étant moi même présentement présent un très grand utilisateur des reusseusseu ça me tiraillait. D'autant plus que je ne publie absolument pas régulièrement sur le site.
Il se passe régulièrement de nombreux mois sans que je ne prenne la plume puis soudainement il va m'arriver d'écrire coup sur coup quelques articles (comme actuellement). Le rss brille dans cette situation : on consulte le site, on aime le contenu, on choppe le rss, puis le site dort pendant quleques mois et d'un coup pouf à l'improviste ça apparait dans l'aggrégateur.

## Bref j'ai craqué
J'ai tenté un outil ou deux pour générer manuellement le rss mais c'était soit hébergé ailleurs (coucou feed43) soit assez crado soit fallait que je me motive à pondre du xslt des familles.
Et puis bon ça me trottait un peu quand même dans le crâne de tester les nouveaux cms statiques à la mode actuellement. J'ai un peu reluqué l'offre actuelle. Je connaissais un peu *wok* et *pelican* mais celui qui me faisait de l'œil c'était **hugo**. Je sais pas trop pourquoi d'ailleurs. Étant un lecture plutôt assidu d'HackerNews (hn pour les intimes) je dois avouer que je suis légèrement éclaboussé par la hype de *rust* et *go*. Et **hugo** est en *go*. Et le *go* c'est sympa ! C'est facile à compiler/installer. Pas d'emmerdes avec les dépendances. C'est performant et coup de bol il y a un ebuild (pas super à jour mais bon pas trop à la bourre non plus) dans *gentoo*.

## Bon ça donne quoi ?
Bon alors on suit le guide officiel dans la doc :

+ Étape 1 : ***installation.*** Easy c'est packagé dans gentoo. next.

+ Étape 2 : ***Création d'un nouveau site.*** Heuuu ça tombe bien je veux faire un site ! Bon en vrai c'est une commande **hugo new site le_nom_du_site**

+ Étape 3 : ***Choisir un thême.*** On va voir la gallerie. Il y a pas mal de choix. J'en trouve un sympa. J'installe à coup de git. Erf il utilise js et pleins de trucs externes. Bon m'en contente pour l'instant

+ Étape 4 : ***Ajouter du contenu.*** Logique. La commande est **hugo new nom/du/fichier.md** . Puis on édite ce fichier dans notre éditeur de texte favoris (vim, what else ?).

+ Étape 5 : ***Customiser le thême.*** Pas bête mais j'ai dit que je verai après, donc j'ai vu plus tard.

+ Étape 6 : . Quoi ?! Pas de sixième étape ? Ha bha non la doc s'arrête là. Bon en vrai il faut modif le *config.toml* pour y modifier l'install. Et enfin il faut générer pour publier à grand coup de **hugo**. Voilà.

## Ça donne quoi du coup ?
Bha franchement j'aime bien. Ça permet d'utiliser du markdown pour rédiger. Je suis pas vraiment fan du markdown mais bon je pense que je chopperai le coup de main. On peut modifier le site ouaib assez facilement, changer de thême super simplement. La génération est très rapide (moins d'une seconde). Ça gère les catégories et les tags (je les utilise de la même façon). Donc pour le lectorat c'est quand même plus agréable : le site est plus moderne. Pour l'instant je suis conquis. À voir dans la durée.

D'ailleurs ce post a été écrit il y a un mois et j'ai mis une date de publication dans le futur pour voir.

## Et tu parles pas du nouveau design ?
Haha merci titre de me rappeler d'en parler ! Bon bha voilà j'ai refait un nouveau design. Donc au début j'était parti sur un thême existant (redlounge) et je pensais le modifier un peu. Mais au final quand j'ai vu qu'il fallait du js toussa toussa j'ai changé d'avis. Du coup j'ai regardé un peu son code voir comment c'était branlé et au final pour ce que je voulais faire ça allait être diablement simple.

Ni une ni deux je commence à trifouiller un truc simple dans la même charte graphique que l'ancien site (le fameux *design4.css*) mais je voulais en profiter pour adapter mon site aux grands écrans. Depuis peu j'ai un écran 4K et j'en ai marre des sites pas super adaptés. Donc je veux un truc qui s'adapte aux téléphones, aux ordis habituels et à la 4K. Je veux pas une usine à gaz.

Bon je commence à partir vers du flexbox, le truc un peu à la mode pour simplifier les designs flexibles. Ouai c'est vrai que ça a l'air sympa. C'est pas mal de pouvoir réordonner l'ordre d'affichage dans le css. Mais bon c'est quand même plus adapté aux sites plus complexes. J'ai pas besoin d'aussi complexe. En gros je veux une sidebar qui se fouttent à l'horizontal en haut quand l'écran est petit. J'ai donc testé sur un truc à base de column (la propriété css3). Mouai c'est pas bien pour organiser un layout, pas du tout fait pour. C'est bien pour ranger du texte mais pas plus.

Au final j'ai utilisé une ruse. Un *div* en **position:fixed** pour la sidebar et un autre *div* qui est juste décalé de la taille de la sidebar. Et quand l'écran est plus petit je fais plus de **position:fixed** et voilà. Et j'ai mis plusieurs tailles de font en fonction de la taille. Bref vous voyez le résultat actuellement.

Voilà j'apporterai probablement des modifs par-ci par-là j'imagine.
