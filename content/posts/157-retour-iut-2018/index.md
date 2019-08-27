+++
Author = "Lord"
Description = "Chaque année j'interviens en IUT pour donner des cours d'adminsys et cette année je vous fait un petit retour."
Categories = ["perso", "linux","vulgarisation"]
menu = "main"
notoc = true
PublishDate = 2019-02-16T16:26:26+01:00
date = 2019-02-16T16:26:26+01:00
title = "Retour suites aux cours 2018"
editor = "kakoune"
+++
Bon c'est un ptit article de vrac.

Chaque année je dispense quelques cours de Licence Pro ASUR (Administration et Sécurisation des Réseaux) où j'interviens juste ponctuellement deux fois dans l'année.
Je ne connais pas spécialement le programme (en dehors de ce que je donne) mais c'est très orienté Linux et logiciels libres.

Mon cours est … très court.
Par contre la très grande majorité est en fait un TP qui aborde pas mal de points différents dans le domaine en question.

Je pense qu'assommer les pauvres étudiants n'est clairement pas la bonne façon de faire et qu'il faut les balancer à la flotte au plus tôt pour qu'ils apprennent à nager.
Et du coup, je lâche très vite les élèves avec tout un tas de questions qui sont un peu orientées mais pas trop, d'abord assez limitées dans leur scope puis de plus en plus ouvertes.

{{< img src="fly_you_bitch.jpg" alt="comic présentant 4 façons de prendre soin de ses petits. Gentoo préconise de balancer ses petits pour qu'ils apprennent à voler" title="Merci TheSquareComics pour la graine de ce meme que j'affectionne particulièrement" link="fly_you_bitch.jpg" >}}

Et force est de constater, qu'ils n'ont pas l'habitude de rédiger autre chose que des réponses bêtes et méchantes.

Ils peuvent pondre des screenshots, même quelques schémas, copier/coller les commandes.
Mais argumenter leur réponse, justifier leur raisonnement ou juste expliquer très succinctement leur raisonnement bha là ils savent pas faire.

J'ai beau mettre un préambule assez massif où j'indique qu'une réponse techniquement fausse mais avec le bon raisonnement sera comptée comme juste, que les screenshots du résultat de leur commande je m'en bats les steaks s'il n'y a pas d'explication avec mais … non.
Et même si je rabâche toute la journée (quand je tourne dans la salle pour leur filer un coup de main/les orienter/donner des indices/expliquer des notions) que je n'ai pas besoin qu'ils me prouvent qu'ils ont réussi à faire ce que je demandais mais qu'ils me prouvent qu'ils ont compris ce qu'ils ont fait… bha non, ils restent scolaires.

Bon du coup pour éviter de faire un blogpost rien que pour râler, je vais dans la suite donner quelques pistes pour améliorer les comptes-rendus et aussi quelques tips divers et variés (on sait jamais, s'ils tombent sur ce blog ça pourrait les aider).

## Ce qui peut être amélioré

  - **Lire les questions complètement et si ce n'est pas clair demander des compléments d'informations.**
Ça peut paraître con mais quand on vous demande de nommer le fichier que vous allez rendre d'une certaine façon, pour pas passer pour un tâcheron avant même que votre compte-rendu ne soit lu c'est de respecter ça.
Et quand on vous dit et écrit de multiples fois que les captures d'écran n'ont aucune valeur, pas la peine de perdre du temps à en faire.
Le prof vous met pas au défi quand il vous le dit.
Quand votre TP c'est 90% de commandes shell, au mieux vous n'avez qu'à faire du copié/collé de votre terminal.

  - **Quand on vous dit de vous méfier des tutos sur le web et de privilégier le man, c'est qu'il y a une raison.**
Ça fait dix ans que je prodigue les mêmes cours/TP et dix ans que je tombe sur des réponses choppées sur les mêmes tutos sur le net avec les mêmes conneries obsolètes depuis des lustres.
Les intervenants extérieurs ne sont pas là pour vous faire chier, au contraire, on arrive avec un état d'esprit clairement positif à votre égard.
Souvent on a fait les mêmes études/diplômes et tout ce qu'on souhaite, c'est partager notre savoir/passion en faisant en sorte que vous ayez l'impression d'avoir progressé.
On n'est pas là pour le pognon mais clairement dans une démarche positive, et pour vous directement, et plus globalement pour la profession (meilleur sont les étudiants, meilleurs seront les gens dans leur taff plus tard).

  - **Ça ne vous plaît pas ? Cassez-vous !**
Si vous faites un Bac+3 pour contenter papa et maman mais que vous êtes en souffrance, vous serez en souffrance toute votre vie.
Arrêtez les frais au plus vite et réorientez-vous au plus vite.
Je ne dis pas ça pour être méchant mais réellement pour votre bien être.
Si le domaine ne vous plaît pas alors que vous débutez et que vous êtes tout frais, vous vous embarquez pour 42/45/60 (seul le futur nous le dira) de malaise et ce n'est clairement pas ce que je vous souhaite.
Vous êtes encore jeune et même si c'est pas le chemin naturel, il est encore facile de changer d'orientation maintenant ; le plus tôt sera le mieux.

  - **Si on vous dit que tel truc est déprécié/obsolète, demandez pourquoi ? par quoi on remplace ?**
Demandez pas "Pourquoi on m'a enseigné ça ?", ça fait pas avancer le débat et si alors que vous êtes encore étudiant vous refusez de remettre en question le peu de savoir que vous avez, qu'est-ce que ce sera dans cinq ans/dix ans ?
L'informatique est un milieu qui évolue constamment et pour pas être largué vous allez vous aussi devoir évoluer avec.
Donc quand on vous annonce "ifconfig est déprécié depuis 18 ans" ne répondez pas un "ouai mais j'ai appris comme ça, ip je comprends rien".
Vous n'avez pas encore des habitudes fortement ancrées, c'est maintenant qu'il faut réapprendre et pas après dix ans de mauvaises habitudes solidement imprégnées dans votre cerveau.
N'abordez pas votre apprentissage par de la méfiance (encore une fois, si je vous le dis c'est pas pour vous faire chier, c'est pour que vous soyez plus à l'aise, plus performant, plus à jour).
Si vous êtes en apprentissage avec des vieux briscards adminsys, ne pompez pas leurs défauts mais soyez prêt à leur apporter un nouveau savoir à eux aussi.

## Quelques astuces pour les débutants sous Nunux
Le **man** est la documentation à peu près officielle.
Certaines pages sont effectivement assez rébarbatives mais globalement c'est quand même assez bien foutu (surtout dans le cas de ssh).
Mais il faut apprendre à s'en servir.

### Rechercher
Ça utilise des raccourcis assez communs sous Linux.
Par exemple, pour chercher vous pouvez utiliser **<samp>/</samp>** puis vous tapez le mot que vous cherchez.
Ensuite avec **<samp>n</samp>** vous irez à la prochaine occurence du mot recherché.
C'est tout con mais rien que le fait de connaître ça rend le truc utilisable.

### Comment c'est rangé
Tous les *man* ont un ordre assez similaire : d'abord le *nom* de la commande, ensuite le *synopsis* qui donne un résumé bref, ensuite la *description* qui va indiquer toutes les options possibles avec leur intéret, ensuite des *précisions* en fonction du programme (dans le cas de ssh ça explique le fonctionnement de l'authentification, les caractères d'échappements, le tunneling, la gestion des clés d'hôte, bref des trucs spécifiques qui apportent pas mal de complément d'information), ensuite le *voir aussi* qui cite d'autres pages man en rapport pour compléter et enfin les *auteurs*.

Il y a parfois une section *exemple* qui regroupe les utilisations communes des logiciels ce qui peut vous faire gagner pas mal de temps, pensez-y, le man c'est pas un tuto mais c'est bien mieux une fois outrepassé la laideur du bousin.

### Syntaxe de man
Le synopsis c'est pas mal mais si vous comprenez pas sa syntaxe c'est balot ça aide pas trop.

Prenons l'exemple du *man ssh*

<samp>ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface] [-b bind_address] [-c cipher_spec] [-D [bind_address:]port] [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11] [-i identity_file] [-J destination] [-L address] [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port] [-Q query_option] [-R address] [-S ctl_path] [-W host:port] [-w local_tun[:remote_tun]] destination [command]</samp>

Bon déjà, *tout ce qui est entouré de crochet est facultatif*.

Donc dans notre exemple le minimum obligatoire est <samp>ssh destination</samp>.
Et quand on regarde un peu plus bas dans le man ils indiquennt à propos de destination : *may be specified as either [user@]hostname or a URI of the form ssh://[user@]hostname[:port].* avec la même syntaxe des crochets.

Revenons à l'exemple, au début il y a le gros pâté <samp>[-46AaCfGgKkMNnqsTtVvXxYy]</samp> qui indique toutes les options qui n'ont pas besoin d'argument et que vous pouvez donc tout coller à la suite, mais c'est pas obligatoire, vous pouvez faire <samp>-4 -A -f</samp> ou bien <samp>-4Af</samp>.

### Les messages d'erreur sont précieux
C'est con de devoir le dire, mais les messages d'erreurs sont pas faits pour être ignorés.
Les logiciels bien faits ont des messages d'erreurs qui veulent dire quelque chose et assez explicites.

Et quand c'est pas le cas, il faut parfois rajouter un **<samp>-v</samp>** pour activer le mode verbeux qui détaille un peu plus ce que fait le programme ce qui peut être précieux.

Et vous aurez souvent les mêmes messages qui vont vous permettre de vite savoir d'où vient le souci.

  - *Name or service not known* : Visiblement il n'y a pas de DNS qui répond à cette requête. Donc est-ce que le nom est bon ? Est-ce que votre résolveur DNS fonctionne?
  - *Connection refused* : C'est généralement au niveau TCP cette erreur. Donc est-ce que le port auquel vous tentez de vous connecter est ouvert ? est-ce que c'est la bonne machine ? est-ce que vous avez du réseau ?
  - *No route to host* : Votre machine n'a pas de route pour joindre la destination. Est-ce que la machine est sur votre LAN ? Est-ce que vous avez une passerelle ? Est-ce que les routeurs entre votre client et votre serveur sont bien up et configurés ?
  - …

Avec un niveau Bac +3 ce genre d'erreur devrait tilter en moins d'une seconde et vous devriez avoir votre ptite checklist à dérouler.



------------
Bon même si j'ai l'air assez énervé et aggressif en vrai pas tant que ça.
Cette année j'ai été très agréablement surpris, contrairement aux deux/trois années précédentes le niveau était bien meilleur mais surtout le sérieux global était très largement en amélioration.
J'avais une appréhension suite à l'année précédente qui était assez catastrophique, mais ils m'ont redonné l'envie de continuer.

C'était agréable pour moi et j'ai eu l'impression que ça l'était aussi pour eux.

