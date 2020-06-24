+++
Author = "Lord"
Description = "Il arrive régulièrement de recevoir de vieux toots sur Pleroma (pour diverses raisons). Il existe cependant un moyen de les filtrer pour ne plus s'encombrer la vie. Vous ne répondrez plus six mois plus tard à un vieux toot."
Categories = ["pleroma", "tips"]
menu = "main"
notoc = true
WritingDate = 2020-06-08T16:31:58+02:00
date = 2020-06-12T16:31:58+02:00
title = "Pleroma : s'épargner les messages trop vieux"
editor = "kakoune"
+++
Si vous avez une instance Pleroma vous avez probablement vu arriver dans votre Timeline, ici et là, des toots remontant à plusieurs mois.
Il s'avère que le logiciel, parfois s'amuse à récupérer ces vieux status (ou alors on les lui envoie).
Et c'est vrai que si on fait pas gaffe, on se retrouve à répondre à un truc plus trop d'actualité six mois plus tard.

En plus mine de rien tous ces vieux toots, ça vient encombrer votre base de données alors que ça n'a que peu d'intéret.
Cependant il est possible de faire en sorte de filtrer ces vieilleries.
Pleroma utilise les **MRF** pour Message Rewrite Filtering qui permettent d'effectuer diverses actions sur les toots entrants.

C'est un système vraiment pas mal pouvaint faire pleins de trucs divers et variés :

  - virer les médias des status
  - bloquer les reports en provenance d'une instance particulière
  - rejeter les messages d'une instance
  - Appliquer des NSFW
  - Rejeter les vieux status

La liste n'est pas exhaustive mais c'est cette dernière possibilité qui va nous intéresser.

Si vous voulez le mettre en place suivez le guide :
Rendez-vous dans l'interface d'administration (ça ne marche que si vous avez mis la conf en base de donnée, ce que je vous recommande).

{{< img src="icone_admin.png" alt="Présentation des 4 icônes dans l'entête avec le lien vers l'admin" title="C'est la troisième icone en partant de la gauche" >}}

Ensuite dans **Settings**, rendez-vous dans **Instance** et à environ un quart de la page vous trouverez **Rewrite Policy** qui vous indiquera une liste de ce que vous pouvez activer.
Il faut sélectionner <kbd>ObjectAgePolicy</kbd>.

Allez ensuite dans l'onglet **MRF** et ici, presque tout en bas vous avez **Reject or delists posts based on their age when received** avec deux actions.
La première c'est de définir le <kbd>Threshold</kbd> qui est l'âge à partir duquel vous voulez déclencher l'action (j'ai mis 86400 secondes).
Et enfin <kbd>action</kbd> où vous choisissez que faire (je reject).

{{< img src="admin_mrf.png" alt="aperçu du menu MRF dans l'admin" title="voilà à quoi ça ressemble" >}}

Vous sauvegardez et voilà.
Vous n'avez désormais que du contenu frais.

<br>

Bon bien entendu s'il y a des perturbations dans la force, qu'une instance était un peu down mais pas trop et qu'elle remonte mais que la durée est expirée… bha vous recevrez pas les messages (même les directs).

Voilà voilà.

