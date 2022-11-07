+++
Author = "Lord"
Description = "Je vais tenter de rétablir la vérité concernant les nombreux commentaires concernant la complexité, les soucis de sécurité et la censure sur Mastodon."
Categories = ["fediverse"]
menu = "main"
notoc = true
WritingDate = 2022-11-07T15:13:42+01:00
date = 2022-11-07T15:13:42+01:00
title = "Mastodon ça censure, Mastodon c'est compliqué, Mastodon c'est pas sécure"
editor = "kakoune"
+++
Elon Musk a racheté Twitter pour 44 Milliards de dollars et du coup il y a une nouvelle vague de migration d'utilisateurs de Twitter vers Mastodon.
Du coup avec cette vague de migration il y a également tout un tas d'avis et de commentaire sur Mastodon.

Je vais donc tenter de rester le plus neutre possible ici pour débunker/répondre à certaines questions.
À la toute fin je donnerai mon avis perso.

## Petit point vocabulaire
Pour les non-initiés voilà un tout petit peu de vocabulaire qui ne sera pas indispensable.

Alors déjà juste une toute petite précision pour jouer les rabats-joie : *Mastodon est un logiciel, le réseau social lui est le fédiverse*.
Mais en pratique on utilise souvent le terme Mastodon pour parler du réseau social (moi le premier) (métonymie toussa toussa).

*Une instance c'est un logiciel en fonctionnement* : quand vous démarrez Firefox sur votre ordinateur vous démarrez une instance de firefox.
Quand vous ouvrez l'appli bidule sur votre téléphone vous lancez une instance de bidule.
Donc quand on parle d'une instance Mastodon, c'est le logiciel Mastodon qui tourne sur un ordinateur (généralement un serveur).

*Un admin est tout simplement la personne qui fait tourner une instance*.
C'est lui qui gère le matériel, le logiciel et choisit les règles de son instance.

La fédération : le réseau social fédiverse est donc composé de multiples instances de Mastodon (et d'autres logiciels plus ou moins similaires).
*Toutes ces instances peuvent communiquer entre elles* et donc un utilisateur d'une instance peut interagir avec un utilisateur d'une autre instance.
À l'inverse sur Twitter, il n'y a pas de fédération : on ne peut communiquer qu'avec des gens présents sur Twitter.

## Mastodon c'est compliqué
Oui.
C'est vrai.

Les systèmes fédérés décentralisés sont déjà par nature plus complexes que les systèmes centralisés classiques.
Techniquement c'est plus complexe mais également sur les côtés plus humains mais ça j'en parlerais plus tard.

Mais cette complexité sous-jacente n'est pas obligatoirement visible de la part des utilisateurs.
Et je trouve que Mastodon a réussi à bien planquer tout cela.
*En pratique, un utilisateur lambda ne se rendra pas spécialement compte de toute cette complexité*.
Il y a, à mon sens, trois grandes différences :

  1. Les noms d'utilisateurs et les points d'entrées.
  2. La portée de la recherche
  3. La modération

Mais je tiens d'abord à préciser que *n'importe quel réseau social est complexe à appréhender*.
La première fois que l'on débarque sur Twitter, on n'y pipe rien.
Pareil pour Facebook, Discord, IRC …

Ce n'est qu'avec de l'habitude et donc de l'expérience que l'on s'y retrouve et que l'on s'y sent à l'aise.

Tout comme Twitter possède de nombreuses applications proposant des interfaces différentes, il y a la même chose pour Mastodon.

### 1 Les noms d'utilisateurs et les points d'entrées
Sur Twitter un utilisateur est nommé de la forme **@monsieur_truc_muche** .
Sur le Fediverse un utilisateur est nommé de la forme **@monsieur_truc_muche@son.instance.com** .

Voilà, *ça n'a pas spécialement plus d'implication pour un utilisateur*.
Si vous voulez mentionner quelqu'un, pensez à mettre le nom complet.

C'est pas trop difficile, en plus ça ressemble à une adresse mail.

Concernant les "points d'entrées" c'est en fait comment vous connecter à son compte.
Quand vous voulez vous connecter à Twitter vous allez sur twitter.com et c'est parti.
*Quand vous voulez vous connecter à votre Mastodon il ne faut pas aller sur mastodon.com mais sur l'adresse de votre instance de résidence.*

Voilà, c'est une adresse web à retenir (votre navigateur saura faire).

### 2 La portée de la recherche
Là c'est un point qui diffère pas mal.
*Sur Twitter la recherche est globale, alors que sur Mastodon la recherche est par défaut limitée à votre instance.*

Du coup si vous cherchez quelque chose, vous chercherez dans ce que "connait" votre instance.
Je ne vais pas rentrer dans les détails parceque là, oui ça va être très technique.

Par contre, vous pouvez entrer l'adresse d'un toot (un message) dans la barre de recherche et votre instance ira la chercher là où ça se trouve.
Et pareil vous pouvez chercher un utilisateur se trouvant ailleurs, elle ira chercher l'info ailleurs.

### 3 La modération
La modération sur Twitter existe elle a ses règles et son application est à géométrie variable mais elle existe.

*Sur le Fediverse, il y a non pas 1 modération mais autant de modération qu'il y a d'instance.*
Chaque instance établit sa modération.

Ça a des conséquences que je détaille plus loin.

## Mastodon c'est pas sécure
Hahahaa.
On voit plein de messages qui alertent que sur Mastodon l'administrateur d'une instance a accès aux mot de passe ainsi qu'aux messages privés des utilisateurs de son instance.

Oui, c'est totalement vrai.
Mais c'est également vrai pour Twitter et pour globalement un peu tous les services sur Internet.

Il n'y a rien de spécifique au Fediverse ici.
C'est juste une question de confiance.

De toute façon, *vous n'utilisez votre mot de passe que sur un seul site à la fois, vous ne le réutilisez pas ailleurs, hein ?!*

Et concernant les messages privés, *sur Internet n'est privé que ce qui est chiffré de bout en bout*.
Ce n'est pas le cas de Twitter ni du Fediverse.

## Mastodon ça censure
Là on rentre dans le point qui me ramone le plus les nasaux.

De nombreux utilisateurs crient à la censure sur Mastodon.
Mais déjà ce n'est pas de la censure mais de la modération.
Et *elle existe également sur Twitter, vous n'avez peut-être pas été censuré mais de nombreuses personnes l'ont été, que ce soit pour de mauvaises ou bonnes raisons.*

Il faut bien comprendre que l'une des forces d'une Fédiverse s'illustre justement sur ces questions.
*Chaque instance a sa modération et donc définie ses règles de ce qu'elle va tolérer ou non.*
Il va y avoir des instances se définissant comme garante de liberté d'expression (free-speech)(en ne modérant à peu près rien donc) et d'autres qui au contraire vont choisir d'interdire tel ou tel contenu.

Là où sur Twitter vous n'avez pas le choix et devez donc vous astreindre à respecter [leur choix de modérations](https://help.twitter.com/en/rules-and-policies#twitter-rules) (que vous relisez régulièrement quand ils y apportent des modifications), *sur le Fediverse vous pouvez choisir une instance où les règles de modérations vous conviennent*.

Très généralement, les instances présentent leur charte de modération via un lien sur leur page d'accueil.

Le Fediverse accueille de très nombreuss utilisateurs différents qui sont de plus en plus variés.
*Certaines communautés sont pour le moins étranges et peuvent se situer à un endroit où la culture et les lois sont différentes de chez vous.*
Ce qui peut être choquant pour l'un ne le sera pas pour une autre personne.
Et *les lois ne sont pas les mêmes dans tous les pays !*

## Du coup Mastodon c'est parfait ?
*Non, Mastodon n'est pas un paradis ni un havre de paix.*
*Non, Mastodon ne solutionne pas tous les maux.*
*Non, Mastodon n'est pas rempli de gentils.*

Mastodon est complexe et on ne pourra pas interagir avec absolument tout le monde mais c'est une alternative plus que crédible au modèle centralisé de Twitter.

*Il faut se rendre compte que si vous vous faites censurer par une instance, il y a de fortes chances que les gens de cette instance ne veulent pas écouter votre discours.*
À quoi bon râler et persister à vouloir délivrer votre message à des gens qui n'en veulent pas ?
Vous ne les ferez très probablement pas changer d'avis.
Si vous vous êtes fait jarter de votre instance, allez ailleurs (il est possible de migrer aisément) et si aucune instance ne veut de vous, montez la votre !

*La première difficulté est le choix de l'instance mais il faut savoir que celui-ci n'est pas définitif.*
Vous pouvez très bien tâter la température de l'eau sur une instance un peu au hasard.
Vous vous créez votre première toile sociale avec les gens que vous allez suivre et discuter.
Une fois mieux maîtrisé l'outil vous pouvez choisir de migrer sur une autre instance où la modération est plus en phase avec vos idées.
Vous conserverez vos abonnements et vos abonnés.

## Mon avis non neutre
Bon merci d'avoir lu jusque-là déjà.
J'ai commencé cet article énervé, maintenant ça va mieux.

*Le Fediverse est un agglomérat de petites dictatures.*
Il y a des chefaillons et c'est tout à fait normal.
Quand vous utilisez un service sur Internet vous êtes en train d'utiliser l'ordinateur de quelqu'un d'autres.
Certains acceptent cela en échange d'argent (directement ou indirectement via vos données personnelles dans le cas de Twitter), certains acceptent pour d'autres raisons (des admins du Fediverse aiment la technique, d'autres ont la volonté de monter une communauté, … chacun ses raisons).
*Certaines dictatures tendent à s'approcher de la démocratie* (les associations aspirent souvent à cela, hein Framasoft, LQDN…).

*Un admin investi du temps et des ressources pour créer son ptit bout de réseau social, c'est tout à fait normal qu'il y applique les règles qui lui plaisent.*
Vous ne pouvez pas reprocher à un admin de ne pas vouloir héberger et diffuser votre contenu.
Ou alors … tention ça va faire mal … passez un contrat avec un admin (probablement contre rémunération).

La très grande majorité des soucis de censure se résolvent **en montant sa propre instance** ou en se trouvant une instance en phase avec ses idées.

Twitter était connu (on peut parler au passé dès maintenant, non ?) pour être très tolérant vis-à-vis des contenus d'extrème-droite.
Le Fediverse est un repère de gauche et franchement tant mieux.
De nombreux exilés de Twitter en sont partis car ils étaient persécutés/harcelés/bannis et sont donc venus sur le Fediverse, ces derniers ne sont pas spécialement râvis de retrouver leurs bullies revenir en force…
Il y a des instances ouvertement de droite, elles sont parfois bloquées par les instances de gauches.

C'est *pour l'instant un réseau social ignoré du capitalisme* : il n'y a pas de business, pas de pub, pas de tracking et pourvu que ça dur.

Si jamais vous subissez la censure et plusieurs instances vous jarte en vous traitant de nazi … il est ptet temps de commencer à accepter le fait que vous êtes un nazi et que vous indésirable. :-)

Je suis très content que le Fediverse gagne en popularité mais c'est pas grave si tout le monde n'y trouve pas sa place.

Et je le répète encore une fois.
N'hésitez pas à monter votre instance :-)
