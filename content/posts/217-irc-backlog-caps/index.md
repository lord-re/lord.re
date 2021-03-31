+++
Author = "Lord"
Description = "Il est désormais possible d'avoir le backlog d'un salon de discussion IRC. Pour cela il faut que les opérateurs du salon aient activé le mode +H et que votre client IRC le gère."
Categories = ["irc", "tips"]
menu = "main"
notoc = true
WritingDate = 2020-05-28T22:56:32+02:00
date = 2021-03-29T12:56:32+02:00
title = "Weechat et les caps"
editor = "kakoune"
TopWords = ["weechat","irc","caps","historique","rfc","geeknode"]
+++
## Ce bon vieux IRC
IRC est un protocole de chat.
C'est mon mien favori.
C'est léger, simple, rapide et vraiment léger.
Pas de fioriture, pour chatter on peut difficilement faire plus dépouillé.

C'est un protocole assez ancien maintenant.
C'est plus vieux que le web d'ailleurs.

Bref, c'est un protocole texte assez rustre.
Ici on ne peut pas s'échanger directement des gifs, on peut pas se wizzer, on peut pas corriger ou supprimer ce que l'on a envoyé, on peut pas discuter à l'oral ni en vidéo.
Pas de sticker, ni de réaction, mais *un chat qui fonctionne depuis trente ans et pour probablement encore autant*.

Par contre c'est léger, n'importe quel ordi avec du réseau sera capable de chatter quelque soit sa puissance.
Un serveur accueillant 300 personnes ça tourne sur 64Mo de ram et ça bouffe virtuellement 0% de cpu.
Bref, c'est ultra efficient.

Bien que ce soit dénué de fonctionnalité, c'est *un protocole ouvert contrairement à la grande majorité de ce qu'il se fait ailleurs*.
Ça veut dire que la façon de parler ce protocole est documenté et ce de manière plutôt bien définie.
Et c'est défini par des RFC (qui sont un ensemble de documents contenant les spécifications d'une grande partie de l'Internet).
Et le système des RFC n'est pas figé.
Quand quelque chose a besoin d'évoluer, il arrive qu'une nouvelle RFC soit rédigée pour complémenter ou carrément remplacer une précédente.

## Le retour d'IRC !
Et c'est ce qui est en train de se passer (à son rythme et depuis quelques années déjà) pour IRC.
Le protocole est en perte de vitesse, de moins en moins de gens l'utilisent.
Faut dire que certaines fonctionnalités présentent ailleurs commencent à lui faire cruellement défaut.
Du coup, "en ce moment", il y a l'initiative d'[IRCv3](https://ircv3.net/), qui cherche à ajouter de nouvelles fonctionnalités.

Bon, faut pas s'attendre à des bouleversements radicaux non plus.
Faut dire, que mine de rien, la légèreté légendaire d'IRC est un gros point fort.

Il y a donc plein de petits ajouts qui à première vue pourraient sembler anecdotiques.
Mais certains peuvent apporter des trucs vraiment cool.
C'est par exemple le cas de *server-time* qui est donc un bout de la spec permettant au serveur d'indiquer l'heure d'un message.

Ouai c'est con, mais sur IRC, les messages n'étaient de base pas horodatés, c'est le client qui ajoute l'heure à laquelle il a reçu un message.
Bon dis comme ça, je vous le concède ça a pas l'air top mais en fait ça va permettre bien plus.
Ça va permettre au serveur de logguer un peu ce qui se dit sur un salon et lors d'une connexion d'un nouvel arrivant, il sera désormais possible de lui envoyer une partie du backlog puisqu'ils pourront être horodatés correctement.

Le fait de ne pas avoir les messages échangés lorsqu'on est pas connecté est un reproche constant contre IRC.
Tous les nouveaux protocoles de chat ont permis aux absents de quand même recevoir les messages qu'ils ont manqués.
C'est une philosophie un peu différente.
Après tout, IRC peut être considéré comme une discussion orale, une personne absente … bha elle n'est pas dans la conversation.
Je suis pas à 100% sûr que ce soit forcément une bonne chose mais force est de constater que pour outrepasser cette limitation je fais tourner un client IRC 24h/24 7j/7…
*J'espère qu'avec cette nouvelle fonctionnalité, la baisse de popularité d'IRC va s'atténuer et pourquoi pas s'inverser*.

## Les messages lorsqu'on est déconnecté
*Il sera possible de recevoir les messages qui sont passés lorsque l'on était déconnecté*.
D'ailleurs je sais pas pourquoi je parle au futur, c'est dès maintenant possible.
**UnrealIRCD** qui est le serveur IRC le plus répandu (en nombre d'installations) est depuis 6 mois en version 5 et possède désormais cette option.
Les opérateurs d'un salon peuvent donc désormais ajouter le mode <kbd>/MODE #channel +H 15:1440</kbd> qui affichera les 15 dernières lignes sur maximum 1 jour (s'il y a moins de ligne sur les dernières 24h bha tant pis).
Bon, le serveur c'est bien beau, mais faut aussi que les clients gèrent cette spec.
La plupart le gèrent désormais y compris le meilleur des clients irc : **Weechat**.

Ouai, sauf que Weechat est bien gentil mais pour le coup il le supporte pas, par défaut.
En fait lorsqu'un client irc se connecte à un serveur, lui et le serveur se disent bonjour en annonçant les fonctionnalités qu'ils savent gérer l'un l'autre (les *CAPS*).
Et par défaut, Weechat n'annonce rien le coquin.
Bref, il va falloir faire un coup de <kbd>/set irc.server_default.capabilities account-notify,account-tag,server-time,away-notify,cap-notify,chghost,extended-join,invite-notify,multi-prefix,userhost-in-names</kbd>, un ptit <kbd>/save</kbd> au passage histoire que ça soit persistant.
Et par contre il faut se reconnecter pour que ça soit pris en compte.

Et vous voilà prêt pour le futur.
Lorsque vous rejoindrez un salon ayant activé ce mode, vous recevrez les dernières lignes.

Vous pouvez également à tout moment faire un ptit coup de <kbd>/quote history #channel</kbd> pour recevoir l'historique du salon.

## Concernant Geeknode
Je traîne cet article dans les brouillons depuis pas loin d'un an maintenant.
Je le publie maintenant car depuis ce week-end, le réseau est enfin compatible avec cette fonctionnalité suite à une vague de mise à jour des ircd.

Voilà, donc si vous gérez un salon sur Geeknode vous pouvez utiliser ce nouveau mode pour le plaisir de vos utilisateurs.

Tout est dit, n'hésitez pas à venir faire un coucou sur #fediverse sur Geeknode ;-)
