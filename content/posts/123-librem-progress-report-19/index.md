+++
Author = "Lord"
description = "19ème article d'avancement du Librem 5. Ça parle uniquement de Chatty l'application pour les conversations 1 à 1 pour les SMS et XMPP dans un premier temps."
PublishDate = 2018-08-29T21:25:26+02:00
date = 2018-08-29T21:25:26+02:00
Categories = ["traduction", "software","librem","purism"]
menu = "main"
notoc = true
title = "19ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = ""
+++

Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-19/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Aujourd'hui sera l'occasion d'avancées techniques et d'une démo de SMS et de chiffremment de bout-en-bout de messages XMPP sur l'application que nous développons : Chatty.
Mais tout d'abord un peu de contexte historique…

## La montée en puissance et la chute des messageries instantanées

Dans le monde d'aujourd'hui, toujours plus prompt au changement, de nouveaux produits propriétaires apparaissent chaque quart d'heure.
Certains parviennent à attirer un grand nombres d'utilisateurs et survivent sur le marché pour deux années.
Cependant, parfois ils disparaissent au profit d'un nouveau service plus attractif dans ses fonctionnalités ou juste par la force de leur campagne marketing.
Dans le monde des médias sociaux, on a vu Myspace disparaitre dans l'indifférence lorsque les gens ont rejoins Facebook.
Mais il y a eu bien plus de fluctuation dans le monde des messageries instantanées ces deux dernières décennies.
Vingts ans auparavant nous utilisions ICQ jusqu'à son acquisition par Yahoo.
Puis pour quelques temps, MSN et Yahoo Messenger ont eu leur instants de gloire.
Le premier s'éteint en 2013, alors que Yahoo débranche son service pour ses 20 ans le 17 Juillet de cette année.

Aujourd'hui WhatsApp et Facebook-messenger sont à leur pic.
Mais comme les habitudes des utilisateurs changent, il est fort probable que ces services ne perdurent pas et que leur durée de vie soit similaire à leurs prédécesseurs.
Aujourd'hui, les utilisateurs de Facebook-Messenger se tournent vers la messagerie d'Instagram et Telegram grignote des utilisateurs à WhatsApp et ainsi de suite.

## S'échapper des Walled Garden
Les services de messagerie instantanée sont majoritairement centralisés, non-fédérés et tournent grâce à une seule entreprise.
Puisque le protocole et/ou le logiciel serveur n'est pas du Logiciel Libre (où le code est disponible), les utilisateurs ne peuvent savoir comment leurs données sont utilisées.
Même si le fournisseur de service ne peut pas forcément lire vos conversations lors de l'utilisation de chiffrement de bout-en-bout, il peut tout de même savoir avec qui vous discutez et à quels moments puisqu'ils gèrent vos comptes, votre liste de contacts avec toutes les métadonnées associées.

Les alternatives aux systèmes mono-fournisseur sont les systèmes décentralisés, des structures fédérées faisant fonctionner une pile logiciel complètement Libre.
De nombreux serveurs relaient les informations en utilisant un protocole commun, permettant aux gens inscrits chez différents fournisseurs de communiquer ensemble.
Ce type de conversation fonctionnent à peu près comme les emails.
Bien sûr, chacun doit avoir confiance envers son fournisseur de service pour gérer son compte mais en plus les données seront aussi manipulés par d'autres stations-relais où certaines métadonnées devront être partagées avec le serveur abritant vos amis.

XMPP (Extensible Messaging and Presence Protocol) est l'un de ces systèmes fédérés ainsi qu'un standard maintenu à long terme et bien spécifié.
Inventé en 1999 par la Jabber Open Source Community pour faire de la messagerie instantanée, de la présence, du chat de groupe, de la voix et aussi des appels vidéos.
De nombreuses implémentations existent.
N'importe qui peut faire tourner un serveur XMPP avec par exemple [Prosody](https://prosody.im).
Débuté avec un client est assez simple car il existe une multitude de clients pour toutes les plateformes ([Pidgin](http://pidgin.im), [Gajim](https://gajim.org) ou [Dino](https://dino.im) pour Linux; [Adium](https://adium.im) et [Swift](https://swift.im) pour macOS;[Conversations](https://conversations.im) sur Android; [ChatSecure](https://chatsecure.org) sur iOS) et il existe de nombreux [serveurs XMPP publics](https://list.jabber.at) à choisir (lorsque vous voulez choisir un serveur de la liste, vérifiez sa sécurité avec [IM Observatory](https://xmpp.net/index.php). Il effectue quelques connexion pour tester et évaluer le chiffrement entre le client et le serveur ainsi que le chiffrement entre serveurs).

## SMS : old but gold
Aujourd'hui, la plupart d'entre nous utilisons notre banque en ligne avec [son authentification à deux facteurs via SMS](https://www.howtogeek.com/361244/sms-two-factor-auth-isn%E2%80%99t-perfect-but-you-should-still-use-it/). De *nombreux* services en ligne ont également recours à ce système.
Les SMS semblent archaïque, mais la réalité veut qu'ils jouent un grand rôle dans les technologies modernes.
Un sondage a montré que les SMS sont le meilleur moyen pour joindre une personne avec près de 90% de taux de lecture dans les minutes suivant l'envoi.
Pourquoi ?
Parceque lorsqu'ils reçoivent un SMS les gens pensent qu'il doit s'agir de quelque chose d'important.
Envoyer un SMS est vu comme fiable.
Et franchement, j'envoie régulièrement des SMS lorsque je veux être sûre d'être lue en temps et en heure même si j'ai du wifi à portée.

“The rumors of my death have been greatly exaggerated”
− Mark Twain

Donc, réellement, un téléphone comme le Librem 5 se doit d'avoir une application pour gérer les SMS.

**Les SMS seront gérés par notre application au nom de code “Chatty”** (le nom définitif n'est pas encore attribué), en temps que plugin pour libpurple comme interface pour ModemManager.

  - La libpurple supporte de nombreux protocoles de messagerie via des [plugins](https://developer.pidgin.im/wiki/ThirdPartyPlugins) et permet aux utilisateurs de se connecter à divers services simultanément depuis une seule application. Le client de messagerie ayant recours à cette lib le plus connu est Pidgin puisqu'elle a été développée pour lui.
  - Libpurple permettra ainsi à d'autres devs de créer leur propre application de SMS.

## Island hopping
Au tout début, “Chatty” devait simplement être l'appli des SMS pour le Librem 5 à cause de nos contraintes de temps et nos ressources limitées.

À force d'en discuter dans l'équipe, l'idée d'intégrer le chiffrement de bout-en-bout et les SMS dans une seule application s'est imposée.
C'est toujours un fardeau de devoir se rappeler quel écosystème de discussion choisir lorsqu'on veux discuter avec un ami avec qui l'on a pas discuté depuis un bail, nous nous sommes dit que l'idée d'avoir une seule appli pour gérer de nombreux services différents était une évidence, d'autant plus lorsque libpurple fait tout le boulot “gratuitement”.

Néanmoins, **Chatty supportera XMPP avec le chiffrement OMEMO ainsi que les SMS lors de la sortie**.
D'autres protocoles comme Telegram *pourrait* arriver plus tard si la fonctionnalité peut s'intégrer correctement dans l'interface.

Libpurple fournit des fonctionnalités essentielles pour la messagerie instantanée en général, pas uniquement le support des protocoles.
Lorsqu'un contact est choisi dans la liste, libpurple récupère les données liées à cette personne, choisi le plugin associé au protocole, établie une connexion, et émet le signal pour que l'application puisse afficher l'interface avec l'historique.

## Donc, comment s'en sort Chatty ?
Pour le moment Chatty peut faire la base (ce qui est probablement le plus difficile) comme envoyer et recevoir des SMS via ModemManager et un modem SIMCOM, ainsi que des messages XMPP/OMEMO via libpurple et le [plugin lurch](https://github.com/gkdr/lurch), comme vous pouvez le voir dans la démo en vidéo :

<video class="wp-video-shortcode" id="video-57183-1" width="960" height="540" poster="https://puri.sm/wp-content/uploads/2018/08/2018-08-Chatty-demo-video-HDR-poster.jpg" preload="metadata" controls="controls"><source type="video/mp4" src="https://puri.sm/wp-content/uploads/2018/08/Chatty-Demo.mp4?_=1" /><a href="https://puri.sm/wp-content/uploads/2018/08/Chatty-Demo.mp4">https://puri.sm/wp-content/uploads/2018/08/Chatty-Demo.mp4</a></video>

Pour le moment, les fonctions basiques de Chatty seront étendues par l'écriture de fonctions pour lier des objets GTK+ à libpurple.
Ces fonctions de callback seront enregistrés dans les structures d'interface d'UI de libpurple pour que son noyaux gère les conversations, la liste de contacts ainsi que l'interface utilisateur.

Il reste un long chemin afin de rendre Chatty suffisamment utilisable pour le Librem 5.
Voici certaines des tâches à accomplir en ce sens :

  - Wrapper le code des SMS/ModemManager dans un plugin libpurple (ça a déjà commencé. L'interface avec ModemManager fonctionne et sa sortie peut être vue dans la fenêtre de debug de pidgin.)
  - Stocker l'historique des messages dans une base de données
  - Créer une visualisation des messages avec le support des images et des capacités de lazy load (chargement des images que lorsque c'est nécessaire)
  - S'interfacer avec la base de données des contacts
  - Designer les écrans de gestions des comptes libpurple (pour XMPP et ceux que l'on ajoutera plus tard)
  - Implémenter le chiffrement de bout-en-bout pour les fichiers (images) dans le plugin lurch
  - Ajouter la gestion de confiance dans le plugin lurch et designer une UI appropriée

Aucun client XMPP n'était dispo pour les appareils mobiles avant la sortie de “Conversations” en 2014 sur Android.
C'est d'autant plus excitant comme mission de rendre XMPP disponible sur le Librem 5.
Et peut-être que d'autres protocoles seront ajoutés par la suite via les plugins libpurple.

## Lectures intéressantes
Des mythes persistent concernant les performances d'XMPP.
[Cet article](https://xmpp.org/about/myths.html) les abordent.

Daniel Gultsch a écrit [un long article concernant ses efforts à lui ainsi qu'Andreas Straub pour rendre le chiffrement OMEMO disponible pour de nombreux clients XMPP](https://gultsch.de/omemo_by_default.html).
Alors qu'ils ont eu besoin de plus de deux ans, Whatsapp, par exemple, a pu déployé le chiffrement du jour au lendemain.
Mais rien ne pourra mieux décrire leur épopée que la conclusion de l'article de Daniel :

“…Enabling end-to-end encryption in a homogenous environment is easier than introducing it in a heterogenous one like Jabber… However, if something is hard to achieve there are two possible approaches: Either try your best and don’t give up, or put your head in the sand and create yet another walled garden that is no different from other proprietary solutions.”

“…Apporter le chiffrement de bout-en-bout dans un environnement homogène est plus simple que dans un environnement hétérogène comme Jabber… Cela dit, si quelque chose est difficile à réaliser il y a deux approches possibles : Soit vous faites de votre mieux en vous démenant sans abandonner, soit vous vous plantez la tête dans le sable et créez un autre jardin clôt similaire à l'approche propriétaire.”



<hr>
Original par Andrea Schäfer.

La démonstration est rassurante et montre un système déjà fonctionnel et compatible avec un système radicalement différent (un iTruc).
L'utilisation de libpurple est bon signe car l'ajout d'autres protocoles sera plutôt aisé (que ce soit par eux ou par des devs extérieurs).
Toujours pas de nouvelles concernant le kit de dev qui devraient déjà être livrés.

Je n'ai pas traduit *Walled Garden* car je ne trouve pas d'expression équivalente.
Le walled garden est littéralement le jardin clôt.
Il s'agit du principe selon lequel une entreprise enferme ses utilisateurs dans un environnement clôt incompatible avec l'extérieur (Facebook, les iTrucs, …).
Pour discuter avec une personne dans un walled garden, il faut soi-même être dans ce même walled garden.
On pourrait parler de «chasse gardée», de «prison dorée», bref vous voyez quoi.

Je n'ai pas traduit *Island Hopping* car je ne pense pas qu'il y ait d'expression équivalente non plus.
Notre cher wikip nous apprend qu'il s'agit d'une stratégie militaire adoptée par les USA pour atteindre le Japon.
Au lieu de traverser l'océan Pacifique d'une traite, ils ont conquis les îles sur le chemin en y établissant des bases.
Donc en gros au lieu de se taper un long et incertains voyage d'une traite, il est préférable de le découper en de multiples plus petits voyages pour arriver à ses fins.
Scinder pour moins se décourager.

Je me rend compte que j'ai vraiment du mal à traduire quand ça parle vraiment code.
Je ne connais que les termes anglais et du coup ne sait pas faire de phrases vraiment claires.
Heureusement qu'il y en a assez peu dans ces articles…
