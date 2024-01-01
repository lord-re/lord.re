+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2023-12-02T12:45:14+01:00
date = 2024-01-01T10:45:14+01:00
editor = "helix"
title = "Récap 53 : Décembre 2023"
+++
ALlez hop une année de plus terminée.
Ce qui est fait n'est plus à faire.

Probablement l'année la plus sèche que j'ai jamais connue avec 264mm de pluie sur l'année soit -58% par rapport à la normale !
Bon c'est aussi l'année la plus chaude, sans trop de surprise.

## Blog

En bref ce mois-ci : 1 article, 9 commentaires, 25 visionnages, 430201 requêtes, 63283 visiteurs uniques pour 8.52 Go de trafic.

## Films
Bon j'ai encore pas chômé niveau visionnages !
Et en plus j'ai pas mal avancé dans le Top IMDB.
Bon faut dire, que bon ça va maintenant faire trois ans que je l'ai commencé et je viens seulement d'atteindre les deux tiers !
Allez encore un peu de patience, si je suis très sérieux je peux le finir en 2024.
Mais ça va être compliqué.

Et comme ça en 2025, j'archive la page du Top et je la recrée avec le top actuel avec les scores mis à jour et donc de nouveaux films dedans.
Ça m'occupera moins longtemps cela-dit, mais j'ai déjà d'autres idées pour continuer à explorer les pépites.

Bon sur cette fin de mois je me suis enfin décidé à regarder des films de *Quentin Dupieux*.
Et bha du coup j'aime beaucoup et je m'en suis tartiné pas mal !
Encore un peu et je me les serais tous fait !

Bon et sinon mon film préferré du mois de Décembre 2023.
C'est très probablement **Fumer Fait Tousser**.
Je me suis vraiment régalé sur çui-là.

  - [Koyaanisqatsi]({{< ref "visionnages/koyaanisqatsi">}})
  - [They Live]({{< ref "visionnages/they-live">}})
  - [Shin Godzilla]({{< ref "visionnages/shin-godzilla">}})
  - [The Princess Bride]({{< ref "visionnages/the-princess-bride">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Killers of the Flower Moon]({{< ref "visionnages/killers-of-the-flower-moon">}})
  - [Winter Sleep]({{< ref "visionnages/winter-sleep">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Shutter Island]({{< ref "visionnages/Shutter-Island">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Taxi Driver]({{< ref "visionnages/Taxi-Driver">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Red Lights]({{< ref "visionnages/Red-Lights">}})
  - [The Lion King]({{< ref "visionnages/The-Lion-King">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Avengers : Infinity War]({{< ref "visionnages/Avengers-:-infinity-war">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Mandibules]({{< ref "visionnages/Mandibules">}})
  - [Catch Me If You Can]({{< ref "visionnages/Catch-Me-If-You-Can">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Spotlight]({{< ref "visionnages/Spotlight">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Rubber]({{< ref "visionnages/Rubber">}})
  - [Ford v Ferrari]({{< ref "visionnages/Ford-v-Ferrari">}}) ([top imdb]({{< ref "visionnages/topimdb">}}))
  - [Dream Scenario]({{< ref "visionnages/Dream-Scenario">}})
  - [Fumer Fait Tousser]({{< ref "visionnages/Fumer-Fait-Tousser">}})
  - [The Banshees of Inisherin]({{< ref "visionnages/The-Banshees-Of-Inisherin">}})
  - [Réalité]({{< ref "visionnages/Réalité">}})
  - [Au Poste]({{< ref "visionnages/Au-Poste">}})
  - [Wrong Cops]({{< ref "visionnages/Wrong-Cops">}})
  - [Incroyable Mais Vrai]({{< ref "visionnages/incroyable-mais-vrai">}})
  - [Steak]({{< ref "visionnages/steak">}})
  - [Yannick]({{< ref "visionnages/Yannick">}})


## Musique
Le mois dernier c'était les 25 ans de **Half Life** et on avait eu le droit à un documentaire bien sympatoche.
Mais c'était également les 25 ans de **Grim Fandango** mais non pas de documentaire.
Cependant il y a eu un concert avec le compositeur et tout !!
C'est [dispo sur Youtube](https://www.youtube.com/watch?v=YGrT5dFJaUc) et c'est juste trop bon.
Ces légères réinterprêtations et par moment ces ajouts de chant, ça fait plaisir.

## Nuxeries
Hey j'ai eu un ptit souci.
Une embrouille quand on fait mumuse avec trop de terminal, on copie-colle un truc, on percute la souris, le focus change toussa.
Bref, j'ai supprimé le dossier <samp>/var/db/pkg</samp> de ma ptite gentoo.

Vous savez ce qu'il contient ce dossier ?
Toute la base de donnée de portage qui lui permet de savoir ce qui est installé avec quel USE, depuis quel repo et tout…
Bref, c'est pas une bonne idée de le supprimer.

Bon, ça ne supprime pas le fichier contenant la définition de @world, donc en théorie il suffit de lui dire de remerge @world et c'est bon.
Pas vrai ?
Bha ouai mais comme pour ce pauvre petit portage vous n'avez plus aucun paquet d'installé, vous allez vite vous retrouver dans des embrouilles de dépendances circulaires pour builder.

Effectivement, pour installer le moindre programme, il vous faut… un compilo, une libc et compagnie que vous n'avez officiellement plus même si en pratique vous les avez !

Comment m'en suis-je débrouillé ?
Je me suis déjà brûlé les ailes il y a fort longtemps et du coup j'avais un backup à jour et testé !
Non.

Biensûr que non je n'ai pas de backup de ça.

Mais !
Haha !
J'avais une parade.
Dans portage j'ai défini une option qui m'a sauvé la mise !
La FEATURES <samp>buildpgk</samp> de portage permet de créer un paquet binaire pour chaque paquet que vous installez.
Il stock ça bien au chaud.
Du coup, il m'a simplement fallu ré-installé à peu près tout avec l'option <samp>--usepkg</samp> et hop le tour est joué.

Plus de peur que de mal.
Bon bien, entendu certains USE ont changé mais entre temps mais c'est pas bien grave.
Il n'y aura que quelques paquets à recompiler entièrement.

Dans un autre registre **AlpineLinux** est sortie en version 3.19 et du coup j'ai migré mes quelques serveurs qui étaient sur la 3.18.
Sans encombre si ce n'est un php qui trainait et qui est passé en 8.2 il a fallu modifier deux trois ptits trucs, rien de bien méchant.

J'ai également mis à jour **TT-RSS** sans problème.
Par contre pour **Blocky** je sais pas trop pourquoi le binaire qu'ils fournissent veut pas tourner sur ma ptite machine.
J'ai beau prendre la version linux en armv7l mais ça tourne pas.
Du coup, je prends les sources et je le cross compile avec <kbd>GOARCH=arm GOARM=7 go build</kbd> et hop.
Voilà voilà.

Non le truc le plus chiant c'est **Caddy**.
Il y a deux mois je vous parlais de [changements que j'ai fait dans mon CAA](https://lord.re/posts/245-renforcement-caa-avec-lets-encrypt/) et … bha ça vient de me retomber sur le coin de la gueule.
Mon git.lord.re était complètement indépendant sur une machine séparée de mon reverse proxy et tout.
C'est le seul endroit où j'utilise Caddy plus pour tester et je dois avouer que je l'avais complètement oublié.
Mis en place il y a des années et pas retouché depuis.

Et bha vla-t-y pas que je tente de push sur mon git et ça se gueule que le certif est hs.
Et là, je réalise que ouai… caddy se démerde seul de son côté pour le cert mais que **LetsEncrypt** ne génère pas de certif à cause de mon CAA.
Bref, j'ai d'abord tenté de voir s'il y avait moyen de se démerdouiller en disant à caddy d'utiliser un autre account mais c'est pas spécialement clair et la doc est pas conciliante.
Et voilà, adieu Caddy, je t'aimais bien, tu étais vraiment pas emmerdant mais voilà il suffit d'une fois.
Hop, mon **nginx** qui sert pour un peu tout le reste est réquisitionné pour reverse proxy ce domaine.
Un coup d'**acme.sh** et trente seconde plus tard le tout tourne de nouveau.

## Vidéos
Une ptite vidéo façon **Konbini** pour trouver des pépites de comédie française, ça vous tente ?
Et bien voilà [Le fond du faitout](https://www.youtube.com/watch?v=iB6fP8HKSz4).
De la bonne grosse daube mais au-delà de juste se moquer, les deux gars ont une réflexion un peu politique que je ne pensais pas retrouver ici.

