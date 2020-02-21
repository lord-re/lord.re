+++
Author = "Lord"
Description = "Je suis très loin d'être un roi de l'organisation et j'ai une phobie administrative mais pour me simplifier un peu la vie je suis un adepte du 0 inbox depuis quelques années maintenant. C'est une méthode d'organisation de votre boîte mail."
Categories = ["mail", "tips"]
menu = "main"
notoc = true
PublishDate = 2019-04-06T11:38:19+02:00
date = 2019-04-06T12:38:19+02:00
title = "Le Zéro Inbox pour vous soulager"
editor = "kakoune"
TopWords = [  "boîte", "dossier", "dossiers", "inbox", "viré","mail","organisation"]
+++
J'ai eu quelques boîtes mails durant ma vie comme probablement tout le monde.
Les plus importantes c'était celle de **Hotmail** avec ses *2Mo de stockage* qui paraissaient pas immense mais au final largement suffisant pour l'époque.
*Avoir un webmail c'était génial* : pouvoir accéder à ses mails de n'importe où sans rien installer !

Puis Google a débarqué avec son **Gmail** et sa boîte de *1Go mais en perpétuel accroissement* !
Et puis cette interface toute moderne : la frontière entre webmail et client lourd commençait à se brouiller tellement l'interface était bien faite.

Mais j'ai vite commencé à avoir peur de Google et ses potes et j'ai entamé une dégooglisation à partir de 2007.
Et du coup j'ai entrepris d'héberger mon propre serveur de mail.

Un poil galère au début mais pas tant que ça non plus.
De *nouvelles responsabilités* (ouai si je fais pas de sauvegarde des mails bha… hé… personne d'autre ne le fera à ma place et je risque de tout perdre.
Et puis *faut pas configurer le serveur comme un sagouin* pour pas se prendre trop de spams et surtout ne pas devenir émetteur de spam et se faire blacklister.

Mais en contrepartie une *liberté accrue* : plus de restriction sur la capacité de stockage des mails, possibilité d'avoir des pièces jointes de la taille que je veux (enfin si les serveurs en face sont d'accord eux aussi), autant de boîtes que je veux.

*L'ivresse de la maîtrise de ses données toussa toussa, c'était la classe.*

## Après la dégooglisation la simplification

Un motif assez récurrent que j'ai constaté chez les personnes éprises d'auto-hébergement est la *folie de vouloir monter tout un tas de trucs*.
Après tout c'est logique, l'offre de logiciels libres pour faire tout un tas de trucs est pléthorique, c'est assez fun à faire (pour certains), les ressources matérielles sont démentielles (même sans dépenser des milles et des cents) et puis c'est grisant d'avoir ses propres services rien qu'à soit.

Du coup on s'installe un serveur mail, puis un DNS, puis un ptit serveur web, on continue avec un lecteur de flux RSS, un serveur de synchronisation de fichiers, de contacts, de notes, un wiki, une ptite plateforme de vidéo, un truc pour synchro son portable, un autre truc pour enregistrer ses traces GPS, une galerie photo, un serveur de streaming de musique…

**On se bloat.**

Tout ce qu'on installe est un potentiel d'emmerdes.
Je ne dis pas que ça va tomber en panne, mais il y aura forcément de la maintenance : *il faudra mettre à jour* sinon c'est de l'inconscience.
*C'est pas toujours compliqué ni très consommateur en temps mais il faudra quand même le faire.*

Avec le temps, on gagne en expérience et c'est de plus en plus simple à faire et bien moins chronophage.
Mais on se rend compte que *"Ha bha en fait tel service m'en sert peu voire pas du tout."*
Ou bien que tel logiciel est tombé en désuétude et qu'il faudrait migrer vers un autre mais est-ce que ça vaut vraiment le coup ?

Bref la seconde phase de cette belle aventure c'est de réduire ses services à ceux qu'on utilise vraiment.
Les moins accrocs décrocheront probablement pour aller voir des fournisseurs de services respectueux (avec le collectif des CHATONS ça n'a jamais été aussi simple de le faire avec une certaine confiance).

Personnelement j'ai viré pas mal de services pour ne garder que ce qui m'est vraiment utile mais je n'ai rien extériorisé.
Donc me voilà désormais avec moins de trucs qui dorment, moins de maintenance à faire et plus de sérénité (moins peur de mettre à jour le système en croisant les doigts que des services ne pètent pas).

*Et en dix ans, bha j'en ai accumulé du mail.*

## On recule et on purge
Jamais je me suis retrouvé à fouiller les mails d'il y a huit ans…
Les rares fois où je cherchais un mail c'était généralement pour retrouver des identifiants à une certaine époque mais maintenant que j'utilise un [gestionnaire de mots de passe]({{< ref "/posts/36-gestionnaire-passwords" >}}) bha ça ne m'arrive plus.

Les mails de newsletters que je n'ai pas lu il y a 7 ans… bha je les lirai pas aujourd'hui ni demain…

Les mails annonçant une panne d'un service réseau de Mars 2013 ça me fait une belle jambe.

J'ai bien quelques mails de la famille mais … bha … je suis pas très versé famille et c'est généralement de la futilité absolu ou bien des trucs qui étaient plus administratifs qu'autre chose, bref rien qui ne mérite d'être conservé.

*J'ai pris la décision de purger.*

Bon, j'y suis allé mollo quand même, j'avais quand même peur de supprimer le mail qu'il allait me manquer deux jours après (alors que bon, ça ne m'est jamais arrivé, mais la rationalité n'est pas de mise).

  - J'ai créé un dossier dans la boîte mail pour classer les trucs de familles.
  - J'en ai créé un autre pour les inscriptions/logins.
  - J'en ai ensuite créé un par année (sauf la courante).

J'ai entrepris de classer tous les milliers de mails dans ces dossiers.
Là pas de miracle, j'ai tout fait à base de grep et de mv (avec une boîte au format maildir c'est super simple).

**J'ai fait un backup.**

Ensuite, j'ai viré les dossiers annuels, j'ai scruté celui des logins et j'ai complété le **password-store** puis je l'ai viré.
Le dossier de famille j'ai relu un peu tout et j'ai viré tout ce qui n'était pas … comment dire … heu … "émouvant", puis purgé.

Voilà il ne m'est resté que les mails de l'année.

J'ai reluqué un peu tout et en dehors de cinq/six mails encore d'actualité j'ai tout viré.

Mon *inbox* se résume alors à une dizaine de mails.
À côté de ça, j'ai une dizaine de dossiers en sursis et voilà.
Quelques mois plus tard, je virrais quasiment tous les dossiers et la purge ultime passera pour n'avoir plus que 6 mails.

Et voilà le chemin vers le **Zéro Inbox**.

## Et comment ça se gère ?
Bha c'est simple, *je me sers trèèèèès peu des mails*.
Je les consulte quand j'en attends un et parfois, de temps à autres.
Dans le meilleur des cas c'est une fois dans la journée et des fois c'est au bout d'une semaine.

Ensuite tout ce que je reçois, *je le lis immédiatement et là soit j'ai rien à en faire : je le jette; soit je fais ce qu'il faut faire tout de suite*.
Je réponds tout de suite, parfois même juste pour indiquer que j'ai reçu le mail et que j'ai pas de réponse dans l'immédiat mais que je répondrai plus longuement après réflexion ou récupération des infos nécessaires.
Et si c'est un truc à conserver des tickets pour un évènement ou autre, je fous ça dans un dossier spécifique que je pense à vider de temps à autres avec tout ce qui est passé.

Alors je sais qu'il existe des variantes de la zéro inbox mais cette technique me convient plutôt bien.

Je reste très peu de temps dans mes mails et voilà.

D'ailleurs j'utilisais principalement un webmail (**Rainloop**) mais je suis passé à **néomutt** (que je sais à peine utiliser) et je m'en contente.
Je me suis désinscrit de toutes les newsletters, j'ai blindé mon antispam et je n'envoie quasiment pas de mails de moi-même mais juste en réponse du coup je reçois plus grand-chose et ça me fait du bien à ma phobie administrative.

------------

Voilà, je veux pas vous pousser à en faire autant, je sais que pour beaucoup de monde c'est pas vraiment faisable surtout pour le boulot mais ayant la chance de pouvoir le faire, je suis super content.
J'ai fait pareil avec la boîte du boulot où j'ai même pas de dossier et qu'une quinzaine de mails en inbox.

Et d'ailleurs en passant, s'il y a une newsletter à suivre c'est [le courrier du hacker](https://lecourrierduhacker.com/) qui vous permettra d'avoir un bestof hebdromadaire (elle est nulle mais j'atteins pas le quota de blagounettes sinon) de [Journal du Hacker](https://www.journalduhacker.net/) et ça me tient vraiment hacker (bon elle est nulle aussi).


