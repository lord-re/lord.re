+++
Author = "Lord"
Description = "Présentation sommaire de GLSA. À la fois une équipe Gentoo, mais aussi une commande pour patcher les failles de sécurité."
Categories = ["linux", "gentoo","sécu"]
menu = "main"
notoc = true
PublishDate = 2018-03-06T23:02:14+01:00
date = 2018-03-06T23:02:14+01:00
title = "Les GLSA de chez Gentoo"
editor = "kakoune"
+++
J'ai réalisé que je parlais pas assez Gentoo sur ce blog.
C'est pourtant de loin la meilleure de toutes les distributions Linux.

Trèves de trolleries, Gentoo c'est bien (entre autre) parcequ'on peut tester vite fait son système pour voir si on a de potentielle faille dans le système.

## GLSA

Gentoo n'est pas une distro avec une immense équipe de dev mais est tout de même pas mal lotie.
Et du coup il y a de multiples équipes spécialisées dont une pour la sécurité.
Et cette équipe de sécurité publie les [GLSA](https://security.gentoo.org/glsa/) pour Gentoo Linux Security Advisories.

Les GLSA sont publiées régulièrement et permettent d'être alerté assez rapidement de failles importantes.
Pour les suivre il y a plusieurs moyens.
Personnellement je suis [leur flux RSS](https://security.gentoo.org/glsa/feed.rss) via [Nib]({{< ref "posts/66-nib-irc-bot.md" >}}).

## GLSA-Check

Mais bon dans le doute j'utilise **glsa-check** qui est un petit outil présent dans **gentoolkit** (un ensemble d'outils spécifiques à Gentoo).

Un ptit coup de ```glsa-check -l``` (une fois par jour) vous listera toutes les failles publiques qui vous touchent (donc en fonction des logiciels installés).
S'il vous trouve quelque chose, vous pouvez premièrement avoir plus d'info avec ```glsa-check -d XXXXX-XX```.
Vous saurez quand a été dévoilée la faille, quels sont les paquets affectés et dans quelle version, quel est l'impact et surtout comment s'en démerdouiller.

Et vous pouvez aussi directement voir avec ```glsa-check -f XXXXX-XX``` pour que, de lui même il applique le correctif nécessaire (généralement mettre à jour un paquet précis).

Ce petit outil est assez peu connu et pourtant très pratique pour avoir un aperçu rapide de l'état des mises-à-jour de sécurité d'une gentoo.
Ce n'est biensûr pas un outil infaillible mais permet déjà d'éviter le pire.
Ça ne remplace bien entendu pas une mise à jour globale du système via **emerge -uDnav @world**.

Tiens d'ailleurs si vous voulez nourrir un peu votre agrégateur de flux rss, Debian publie aussi ses [DSA](https://www.debian.org/security/dsa).
