+++
Author = "Lord"
Description = "Vous souhaitez vous installer dans le Fédiverse et vous hésitez : quel service sera le plus adapté pour vous accueillir. Voici donc le grand combat Pleroma vs Mastodon."
Categories = ["fediverse", "pleroma","mastodon"]
menu = "main"
notoc = true
WritingDate = 2019-07-21T21:41:41+02:00
date = 2019-11-23T21:41:41+02:00
title = "Comparatif entre Mastodon et Pleroma"
editor = "kakoune"
+++
Je traîne un peu sur le Fédiverse.
C'est un amalgame de services différents constituant un réseau social assez différent de ce qu'on trouve ailleurs.
Une de ses plus grande force à mes yeux est le fait de pouvoir s'héberger son (ses) ptit(s) bout(s) à soit.

*Le réseau propose actuellement plusieurs services différents comme du partage de photo, de vidéos, de musique, quelques petits jeux, du blog et surtout du micro-blog*.
Le Micro-blog c'est du simili-twitter : des messages courts avec des hashtags et des gens qui réagissent/boostent…

Le microblog c'est sympa mais il existe plusieurs logiciels différents pour en faire sur le Fediverse.
Le plus connu est **Mastodon** et son concurrent le plus visible est **Pleroma** mais il y a également **MissKey** ou bien le plus ancien **GNU Social** et enfin **microblog.pub** qui est plus minimaliste.

Pour rejoindre le Fédiverse, la majorité des utilisateurs du réseau ont rejoint une instance existante (au moins le temps de découvrir).
Mais de nombreux geeks à tendance adminsys décident de s'y établir un peu plus sérieusement et donc de se monter une instance perso (ouai en vrai je vous raconte mon parcours, mais c'est mon blog ! J'ai le droit !).
Et donc une question se pose assez vite : **Mastodon ou Pleroma** ?

J'ai donc demandé de l'aide sur le Fediverse pour créer un tableau comparatif entre ces deux poids lourds du secteur et voilà le résultat.

**Glitch.soc** est un fork de Mastodon apportant quelques améliorations bien venues à Mastodon.
Il est inclu dans Pleroma et s'avère être l'interface web Mastodon de Pleroma ce qui fait que ce qui est possible sur glitch est faisable dans Pleroma.

Bien entendu ce n'est pas ultra exhaustif et c'est très mouvant (Pleroma et Mastodon sortent très régulièrement de nouvelles versions).

### Pour les utilisateurs

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|toot                      |            X |              X |           X |            |
|local timeline            |            X |              X |           X |            |
|global timeline           |            X |              X |           X |            |
|Nombre de caractères      |          500 |            500 |        5000 |configurable|
|formattage du texte       |              |              X |           X |source de tension|
|formattage des liens      |              |              X |           X |pour intégrer un lien dans du texte |
|Affichage du texte formatté|             |              X |           X |            |
|Affichage des articles    |      tronqué |              X |           X |Sur Glitch et Pleroma : configurable|
|Envoi d'images            |            X |              X |           X |            |
|Envoi d'audio             |            X |              X |           X |Arrivé récemment sur Mastodon |
|Envoi de vidéos           |            X |              X |           X |            |
|Dessiner                  |              |              X |           M |            |
|Sondages                  |            X |              X |           X |Arrivé récemment sur Pleroma |
|Limite choix sondage      |            4 |              4 |         20+ |            |
|Content Warning           |            X |              X |           X |            |
|Restriction de visibilité |            X |              X |           X |(global, pas listé, followers seulement, privé |
|Recherche d'utilisateurs  |            X |              X |           X |            |
|Recherche de hashtag      |            X |              X |           M |            |
|Recherche intégrale       |            X |              X |           X |            |

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|Photo de profil           |            X |              X |           X |            |
|Bannière de profil        |            X |              X |           X |            |
|Fond d'écran              |              |                |           X |            |
|Thême graphique           |            X |              X |           X |            |
|Personnalisation de thême |              |                |           X |[galerie](https://plthemes.vulpes.one/) |
|Emojis                    |            X |              X |           X |            |
|Liste d'émoji             |            X |              X |             |            |
|Édition de toot envoyé    |            X |              X |           M |            |
|Suppression de toot       |            X |              X |           X |            |
|Silence d'un fil de disc. |              |              X |           M |            |

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|Follow                    |            X |              X |           X |            |
|Silence                   |            X |              X |           X |            |
|Block                     |            X |              X |           X |            |
|Report                    |            X |              X |           X |            |
|Favoris                   |              |              X |           M |Marquer un toot comme favoris |
|Épinglage de toot         |            X |              X |           X |Pour s'afficher en haut dans le profil |
|Création de listes        |            X |              X |           M |Ranger des utilisateurs dans des listes |
|Interface BBS             |              |                |           X |Gadget de poisson d'avril |
|Interface Gopher          |              |                |           X |Gadget de poisson d'avril |
|Chat integré              |              |                |           X |Permet de discuter avec l'instance locale |


### Pour les Administrateurs

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|MRF                       |              |                |           X |Filtres programmables sur les activités |
|Transparence de la modér. |              |                |           X |Les MRF peuvent être publiques dans le NodeInfo |
|API d'administration      |              |                |           X |[voir doc](https://docs.pleroma.social/admin_api.html#content) |
|API de modération         |            X |              X |           X |            |
|Support de OStatus        |              |                |             |raîchement supprimé de Mastodon et Pleroma |


### Pour les devs

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|Langage                   |         Ruby |           Ruby |      Elixir |            |
|Base de données           | Postgres + Redis | Postgres + Redis | Postgres |         | 
|Nodeinfo                  |              |                |           X |            |
|Plateforme de dev         |Github + Discord | Github + Discord | IRC/Matrix + Gitlab | |
|API Mastodon              |            X |              X |           X | C'est ce qui permet d'utiliser les applis Mastodon |
|API Compatible Twitter    |              |                |           X |Ancienne version de l'API |


### Pour les (auto-)hébergeurs

|                          |   Mastodon   |   Glitch.soc   |   Pleroma   |            |
|--------------------------|:------------:|:--------------:|:-----------:|------------|
|Configurable à chaud      |            X |              X |          \* | \*Disponible très récemment|
|Tourne sur un Rasp. Pi    |              |                |           X |            |
|Peu de dépendances        |              |                |           X |            |
|Dev communautaire         |              |              X |           X | Gargron décide de tout pour Mastodon |
|Médias distants           | réenco+stock | réenco+stock   | proxy optionnel |        |
|Stockage S3               |            X |              X |           X |            |


Bon c'est pas super digeste…
Et ça sera probablement pas à jour très longtemps.

## Mon avis
Je trouve que la gouvernance plus ouverte de Pleroma et l'orientation du projet est bien plus sympa que Mastodon.
Mastodon est le reflet de la volonté de Gargron et donc si la communauté veut quelque chose mais que lui, non… bha Mastodon n'aura pas cette chose.

En plus de cela, d'un point de vue technique, faire tourner Pleroma est beaucoup plus simple :

  - Ça demande beaucoup moins de ressources
  - La stack logicielle est plus simple à installer
  - Postgres est suffisant, pas besoin de Redis et d'ElasticSearch même pour la recherche.

D'un point de vue utilisateur, tout ce que sait faire Mastodon est disponible sur Pleroma, que ce soit via son interface propre ou bien l'interface Mastodon qui est fournie avec.
Les applis Mastodon sont nativement compatibles avec Pleroma.

À la vue de tout cela, *je ne vois pas vraiment d'intéret d'héberger un nœud Mastodon plutôt que Pleroma*.
Donc au final Mastodon't.

L'an dernier je vous ai publié un [petit tour des services du Fédiverse]({{< ref "posts/142-les-services-du-fediverse-fin-2018" >}}) si jamais vous voulez voir les autres challengers.

----------------

Merci à tous les gentils contributeurs du [framacalc](https://lite.framacalc.org/masto-plero) pour leur coup de main.
Ça traîne depuis juillet mais ça arrive enfin !


