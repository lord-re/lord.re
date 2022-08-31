+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2022-08-28T23:11:52+02:00
date = 2022-08-31T21:11:52+02:00
editor = "kakoune"
title = "Récap 37 : Aout 2022"
+++
Bon bha ce billet arrive en retard vu que j'ai plus de connexion à la maison.
Une sombre histoire de pelleteuse.
Ça va fausser un peu les stats également mais bon.

C'est fou comme un ordi sans Internet perd beaucoup d'intéret.
Il est loin le temps où la connexion était intermittente voir inexistante.
Je ne regrette pas cette époque !

## Blog

En bref ce mois-ci : 2 articles, 5 commentaires, 14 visionnages, 404310 requêtes, 39524 visiteurs uniques pour 7.6 Go de trafic.

## Films

  - [Firestarter]({{< ref "visionnages/firestarter-(2022)" >}}) ([Stephen King]({{<ref "visionnages/stephking" >}}))
  - [Chance]({{< ref "visionnages/chance" >}})
  - [Idila]({{< ref "visionnages/idila" >}})
  - [Resort Paraiso]({{< ref "visionnages/resort-paraiso" >}})
  - [Once Upon A Time In The West]({{< ref "visionnages/once-upon-a-time-in-the-west" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [The Founder]({{< ref "visionnages/the-founder" >}})
  - [Prey]({{< ref "visionnages/prey" >}})
  - [UHF]({{< ref "visionnages/uhf" >}})
  - [Unforgiven]({{< ref "visionnages/unforgiven" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [Top Gun : Maverick]({{< ref "visionnages/top-gun-:-maverick" >}})
  - [Airheads]({{< ref "visionnages/airheads" >}})
  - [Rocky]({{< ref "visionnages/rocky" >}}) ([top imdb]({{< ref "visionnages/topimdb" >}}))
  - [The Pick Of Destiny]({{< ref "visionnages/the-pick-of-destiny" >}})

## Séries

Je me suis fait la saison 3 de **Umbrella Academy** et … bha j'avais pas vraiment accroché à la première saison.
La seconde était bien plus cool et là … 
Bah …
C'est cool.

C'est drôle, de bonne humeur, il y a de l'action et certains personnages sont très attachants.

## Jeux
J'ai réinstallé **Team Fortress 2**.

Sinon je me suis surtout lancé dans **Deathloop** mais je pense que je vais faire un article dédié.
Je vous le spoil tout de suite : c'est un grand jeu *Arkane Studios* donc c'est trop bien !

## Nuxeries

### IPv6
Tiens j'ai réparé l'IPv6 sur l'une de mes machines.
Ça déconnait sans que je ne sâche pourquoi.

Je m'en suis rendu compte en étant en wifi à la maison sur mon téléphone portable.
Certains de mes services ne connectaient pas alors qu'en connexion cellulaire tout marchait.
Et sur mon ordi ça marchait aussi.

Il s'avère que mon nunux tente de se connecter en ipv4 si la connexion ipv6 échoue contrairement à Android.

Bon et du coup comment j'ai réparé ?
En refoutant la route IPv6 vers la passerelle…

Ouai, je sais pas trop comment mais ça avait sauté.

N'étant pas en adressage automatique (ni RA ni DHCP) il fallait la foutre à la main.
Ça a pris moins de cinq minutes à se faire réparer.

### Résolveur local 
Bon bha j'ai une perte de connexion à la maison.
Le souci c'est que ça a pété mon monitoring vu que mêmes les machines locales passent par les noms de machines pour joindre mon InfluxDB.

Je me suis donc résolu à faire un truc que j'aime pas : modifier le résolveur DNS de mon lan pour qu'il renvoie les ip locales et non les ip publiques :-/

Il faudra que je pense à virer ça une fois tout revenu à la normale.

## Vrac
Un truc qui fait grand bruit en ce moment sur Hacker News : **Stable Diffusion**.
C'est un nouveau logiciel faisant appel à du machine learning pour générer des images.

À la différence de **DALL-E** qui a fait sensation quelques semaines plus tôt, ici c'est du logiciel libre et donc disponible au plus grand nombre.
Il faut une machine avec une belle carte graphique pour faire tourner l'engin mais c'est à peu près tout.

Ça sert à générer des images à partir de texte ou bien à partir d'autres images.
En gros on donne une description et le programme tente de "dessiner" ce que vous lui avez dit.

Le résultat est vraiment bluffant.
Les artistes se feront ptet dégager au profit de logiciels ?
