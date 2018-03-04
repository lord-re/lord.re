+++
Author = "Lord"
Description = "Le post-mortem de Purism concernant leur grosse panne de ce début 2018 nous rapelle la terrible dépendances envers les registrars."
Categories = ["actu", "purism","dns","spof","purism"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-02-21T14:02:59+01:00
date = 2018-02-21T14:02:59+01:00
title = "La Terrible Dependance Envers les Registrars"
editor = "kakoune"
+++
Purism vient de subir une [importante panne de leur infrastructure réseau](https://puri.sm/posts/the-great-purism-dns-outage-of-2018/).
Leurs sites web étaient injoignables.

La cause ?
Visiblement leur nom de domaine était injoignable.
Après investigation leur infra DNS était pourtant nickel.

## Chez le registrar

Le soucis provenait de leur *registrar*.
Pour info le registrar c'est l'entité qui vous loue votre nom de domaine (non non ça ne s'achète pas).
En téléphonant à leur prestataire ils n'ont rien appris de plus : leur domaine utilisant le TLD (la partie la plus à droite du domaine) *.sm*, il faut attendre la disponibilité de l'expert *.sm*…

La panne a eu lieu au milieu de la nuit californienne, il a fallu attendre le petit matin que l'expert *.sm* du registrar américain débarque.

Une fois celui-ci arrivé, il a vérifié et pu déclarer que chez le registrar tout était OK et que du coup il faut remonter au cran au dessus.

## Chez le registre

Au dessus de registrar il y a le *registry* ou registre dans la langue de Yann Le Pentrec.

*.sm* est donc le TLD de [Saint Marin](https://fr.wikipedia.org/wiki/Saint-Marin) qui se trouve donc en Europe.
Le registrar doit donc attendre les heures d'ouverture européenne du registry…

Purism a pris les devants et a contacté en direct le registry pour se rendre compte de la raison de la coupure :

*Le registrar n'a pas payé les droits d'enregistrement.*

Hahahahaha j'imagine la joie des équipes de Purism lorsqu'ils ont appris cela.

Bref, retour de flamme chez le registrar et tout rentre dans l'ordre.

## Conclusion ?

**Le choix du registrar a des conséquences direct sur la disponibilité de votre infra réseau.**

Vous aurez beau avoir de la redondance de partout via du RAID, des VM en haute disponibilité, toute une infra réseau multi-homée, dans de multiples datacenter, votre nom de domaine et votre registrar seront toujours un *SPOF* (single point of failure) inévitable.


Purism a fait le choix de prendre un second nom de domaine chez un autre registrar sur un second TLD malheureusement c'est pas parfait : si les gens se connectent à votre domaine principale sans essayer le domaine de secours… bha vous avez pas de secours.

**Le choix du registry a des conséquences direct sur la disponibilité de votre infra réseau.**

Tout comme pour le registrar, le choix du registry (et donc du TLD) est capital. Prendre une extension juste sur des critères esthétiques peut se révéler une future faille et n'est pas sans conditions d'utilisations mais ça je vous en reparlerai plus tard.

Même en hébergeant ses propres serveurs DNS et en les gérant au poil, on est pas à l'abri d'une connerie des couches inférieures.
