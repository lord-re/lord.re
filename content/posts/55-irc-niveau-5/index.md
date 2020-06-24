+++
Author = "Lord"
Tags = ["irc","tips","réseau"]
Categories = ["irc","tips","réseau"]
Description = "Bon bha l'ultime niveau c'est la gestion du réseau. Donc c'est à destination des ircop et des netadmin."
date = "2017-08-25T09:54:59+02:00"
title = "Guide d'utilisation d'IRC : niveau 5"
notoc = true
menu = "main"
TopWords = [  "gline","irc","modes","salon"]
+++
## Guide pour ircop : Protéger son réseau
Cette partie est plus un mémo personnel qu'un guide général. C'est très spécifique à l'ircoperie de Geeknode…

Premier rappel : globalement on évite les operoverride (utiliser des commandes d'op, lorsqu'on est pas op sur un chan. La modération des chans n'est à priori pas du ressort des ircop.

## Gérer les relous

La plupart des relous peuvent être calmés par un <kbd>/gline lerelou 1h</kbd> cependant si le relou en question revient constamment un moyen très efficace est le <kbd>/tempshun lerelou</kbd> il pourra toujours écrire/interagir sauf que personne ne recevra ses daubes. Il ne s'en rendra pas compte. Cela dit, certains clients bizarrement foutu se retrouvent en ping timeout et du coup ça recommence…

Pour les spammeurs occasionnels qui viennent, balancent leur message puis disparaissent quelques heures/jours, il faut passer par un spamfilter. Ça marche à base de regex toussa de ce genre <kbd>/spamfilter add -simple cpnNPq kill|shun|gline - le_nom_du_spam_filter le_spam/</kbd>

## Admins habituel

- *Problème d'auth :* C est capricieux avec l'envoi des mails, du coup généralement les mails de mot de passe perdus n'arrivent jamais. La technique est donc de <kbd>/msg C oper superadmin on</kbd> pour passer en mode berzerk puis <kbd>/msg C oper forceauth bidule</kbd> .
- *Suppression d'un gline :* il est préferrable de d'abord les lister avec <kbd>/stats G</kbd>. Ensuite pour supprimmer un gline c'est simplement <kbd>/gline -le@gline</kbd> . Et voilà
- *Lister tous les utilisateurs provenant d'une même ip* : avec un <kbd>who +i adresse_ip</kbd>

