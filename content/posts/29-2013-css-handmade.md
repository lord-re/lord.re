+++
Author = "Lord"
menu = "main"
date = "2013-03-03T23:04:55+02:00"
title = "2013 - CSS fait main."
Categories = ["meta","www","css"]
Description = "Et encore un article sur le changement de design du site… Mais qu'est-ce qu'il me prend ?!"

+++

Mais quel indécis ! Ouais je change **encore** mon site. Bon en fait [bootstrap]({{< ref "/posts/23-boostrapper-le-site" >}}) c'est bien sympa mais au final déléguer toute la partie fun bha c'est pas fun.
Autant j'ai toujours du mal à créer du contenu pour le site, autant j'adore faire mumuse avec le css.
Du coup, bha ouais j'ai refait encore le site.
J'ai quasiment pas touché au fond.
J'ai simplifié le menu tout de même et supprimé quelques lourdeurs de bootstrap pour avoir presque que du contenu.
Quelques ajustements par çi par là **et paf un nouveau css**.

En fait j'ai changé le style parce que j'ai un écran 16/9 et bootstrap n'en utilise qu'un gros tiers.
Je passe mon temps à pester contre ce genre de design qui néglige nos chers écrans.
Du coup j'ai pris mon courage à deux mains et j'ai expérimentés deux trois trucs.
Premièrement, utiliser le plus possible les balises html5. Donc j'utilise du nav, de l'article toussa.
C'est un poil plus sémantique (si avec ça je trust pas toutes les premières places des résultats google pour linux et livebox…).

Pour le css, j'ai fait un menu vertical.
C'est ce qui me semble le plus normal avec les écrans larges : on passe notre temps à scroller vers le bas alors qu'on a trop de place horizontal.
Donc autant foutre sur les côtés les éléments dispensables et privilégier le placement du contenu.
On se retrouve avec 85% de l'écran pour le contenu.
On rajoute quelques marges tout de même pour aérer.
Le soucis immédiat c'est qu'on se retrouve avec des lignes de texte si longue que le changement de ligne devient compliqué.
Plusieurs études rapportent que la lisibilité optimale d'une ligne se retrouve en deçà des 80 caractères.
Je ne suis pas parfaitement d'accord sur le chiffre mais la logique est avérée. Du coup pour chaque article, si la fenêtre est assez large, le contenu est découpé en colonne.
Le rendu est vraiment pas dégueu et très agréable à lire.
Le hic (parce qu'il y en a toujours un) est que si l'article à lire ne se contient pas dans un seul écran, il va falloir remonter pour lire la seconde colonne ce que je trouve particulièrement pas adapté à une lecture informatique.
Je vais donc devoir trouver une solution.
