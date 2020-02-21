+++
Author = "Lord"
Description = "Non non, quand on envoi un mail, ce n'est pas anormal qu'il n'arrive pas immédiatement chez le destinataire, pareil pour les toots."
Categories = ["mail", "fediverse","réseau"]
menu = "main"
notoc = true
PublishDate = 2019-04-28T12:15:33+02:00
date = 2019-04-28T12:15:33+02:00
title = "Tous les protocoles réseaux ne sont pas synchrones"
editor = "kakoune"
TopWords = [  "fédiverse", "protocoles"]
+++

## Message de service
Tous les protocoles réseaux ne sont pas instantanés !

**Lorsque vous envoyez un mail, vous n'avez aucune assurance que le destinataire le reçoive immédiatement.**

**Lorsque vous envoyez un toot sur le Fédiverse, vous n'avez aucune assurance que tout le Fédiverse le reçoive immédiatement.**

## Pourquoi ?
Je ne cite que deux exemples mais c'est vrai pour d'autres protocoles aussi.
Beaucoup de protocoles n'imposent pas de contraintes quant au temps de traitement et d'acheminement.

Si le serveur d'envoi est un peu surchargé ou celui de réception ou les éventuels intermédiaires le sont, il y a de forte chance que les données soient mises dans une *file d'attente pour être traitées ultérieurement*.

Si l'un des serveurs (émetteur, intermédiaire ou destinataire) est HS, il y a des chances que ce soit également mis de côté pendant quelques jours et retenté régulièrement.

D'autres protocoles comme par exemple IRC, eux font tout leur possible pour transmettre immédiatement les données mais il reste toujours les aléas du réseau.

## Les mails et le Fédiverse
*Les mails peuvent être mis de côté pendant une semaine avant de vous revenir en erreur*.
C'est également un des moyens de filtrer le spam : renvoyer une erreur à la première connexion pour forcer le serveur d'émission à se reconnecter plus tard pour renvoyer le mail : on appelle cette technique le **greylisting** et c'est très efficace.

Pour les toots du Fédiverse ça peut expliquer le fait que certaines personnes répondent des heures/jours/semaines plus tard à certains de vos vieux toots : la fédération n'est pas automatique et parfois la communication inter-instances est un peu chaotique.
Il est d'ailleurs courant de *n'avoir qu'une vue partielle ou simplement désynchronisée d'un fil de discussion*.

## C'était un message à caractère informatif

> C'était vraiment très intéressant.
