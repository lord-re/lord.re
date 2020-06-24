+++
Author = "Lord"
Description = ""
notoc = true
WritingDate = 2020-05-02T20:07:55+02:00
date = 2020-06-01T00:07:55+02:00
editor = "kakoune"
title = "Récap 10 : Mai 2020"
TopWords = ["arkane","half life","crossing","mike ward","mesa"]
+++
La fin de 55 jours de confinement.
La vie normale revient petit à petit.
Décevant, hein ?

## Blog
Peu d'articles ce mois-ci.
Pas trop d'inspiration malgré le temps libre.

En bref ce mois-ci : 4 articles, 17 commentaires, 18 visionnages, 654291 requêtes, 47933 visiteurs uniques pour 16.66 Go de trafic.

## Films
Je me suis fait l'intégrale de la saga **Le parrain** c'était vraiment chouette même si je trouve que c'est un poil surcôté.
J'ai eu quelques congés du coup j'ai vraiment maté plus de films que d'habitude.
Quasiment que des découvertes, pas de revisionnages de films connus quasiment.

## Musique
Ce mois-ci une petite sélection de clips incongrus.

On commence avec le groupe *Rivers Of Nihil* pour leur clip de [Where Owls Know My Name](https://www.youtube.com/watch?v=LBAXZto7uVc).
Ce clip est d'une beauté certaine avec ses looks qui détonnent en cette pincée de Psychédélisme.

Maintenant on passe au groupe *Infant Annihilator* qui a enfanté du clip de [Three Bastards](https://invidio.us/watch?v=8dnJpuWuGn8).
C'est un groupe habitué à ne pas être trop sérieux et bha effectivement ils ne le sont pas.

Un ptit tour chez le glorious nipon avec *LadyBaby* pour le clip de [Nippon Manju](https://www.youtube.com/watch?v=M8-vje-bq9c).
N'hésitez-pas à baisser le volume, faudrait pas chopper une mauvaise réputation auprès de vos voisins !
Bon je pense que le clip est suffisamment explicite, vous comprendrez pourquoi il a droit à sa ptite place ici.

Vous aimez les patates ?
C'est vrai que [c'est bon les patates](https://www.youtube.com/watch?v=RYQkATYkE04) surtout avec *Mononc Serge*.


## Nuxeries
Tiens j'ai découvert un ptit truc sur Gentoo : les paquets dits en version *live* (installé direct depuis le dernier commit git), bha on peut installer en vrai à partir du commit qu'on veut.
Pour ça il suffit de rajouter <kbd>EGIT_COMMIT="blablabla" emerge votre_paquet -av"</kbd> et voilà.
Simple efficace.

Et justement dans les paquets en version *live* que j'utilise il y a **mesa**.
C'est une brique assez importante sur les unix car c'est l'implémentation d'Opengl (enfin les différentes versions) et le Vulkan.
C'est donc un paquet dont dépend à peu près tous les softs graphiques accélérés.
Bref, c'est un morceau que je mets à jour assez régulièrement ce qui permet d'avoir quelques ptites optimisations de temps à autres (pas tous les jours, hein), des corrections de bugs ou bien des ptits bouts supplémentaires d'opengl.
Sauf que là, pas de bol, j'ai eu deux emmerdes d'affilées, un glitch graphique dans **Qutebrowser**.
Ce bug a été corrigé le lendemain (je mets pas à jour tous les jours mais assez régulièrement quand même).
J'ai eu par contre un autre bug un peu plus chiant, toutes les applis pétées au point de ne pas démarrer, (pas même **sway** ni **xorg** ni rien).

Là c'était donc plus problématique.
D'autant plus que je ne savais pas exactement de quel jour datait la dernière mise à jour.
Il a donc fallu que je remonte de quelques jours en arrière dans le git de mesa à tester au peu au hasard à partir de quand ça a pété.
Au bout d'une quinzaine d'essai j'ai trouvé le commit précis à partir duquel ça a commencé à merdouiller.
Ensuite, ne sachant pas trop comment report ça, je me suis rué sur le bon salon irc (*#dri-devel* sur freenode).
J'y ai trouvé le bon dev, je lui ai parlé du truc et moins d'une heure après il y avait un nouveau commit avec le patch qui va bien mergé et déjà disponible pour tout le monde :-)

Merci *Marek Olsak* et tous les autres devs qui minent de rien abatent un boulot énorme.
Voilà, si vous non plus vous savez pas coder ni même n'avez les compétences pour débugguer, vous pouvez quand même contribuer au Libre.

## Vidéos
Ce mois-ci je vous file un lien pour [un sketch de Mike Ward](https://www.youtube.com/watch?v=8Nl0SQ3KQOE) lors du festival de Montreux.
C'est un humoriste du Québec qui nous raconte un peu comment ça se passe dans l'intimité avec sa femme.
Une belle tranche de rire sublimé par son accent et ses expressions.

Cette année c'est les vingt ans du studio de jeux vidéo *Arkane*.
Du coup *Noclip* a fait [un super documentaire](https://invidio.us/watch?v=h4kdqwdbZZ8) retraçant leur histoire.
Il y a même des vidéos inédites de trois de leurs jeux avortés dont **The Crossing** qui avait l'air vraiment super mais aussi un potentiel **Half Life : Episode 3** ou tout du moins un spin-off.
Bref, très intéressant à voir.
