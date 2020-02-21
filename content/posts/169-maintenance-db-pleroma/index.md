+++
Author = "Lord"
Description = ""
Categories = ["pleroma", "fediverse", "adminsys"]
menu = "main"
notoc = true
PublishDate = 2019-06-11T18:23:39+02:00
date = 2019-06-11T18:23:39+02:00
title = "Maintenance de la DB de Pleroma"
editor = "kakoune"
TopWords = [  "2018", "2019", "pleroma", "adminsys","postgresql","postgres"]
+++

Le Fédiverse c'est vraiment génial.
Son écosystème bouillonnant avec de nouveaux logiciels et fonctionnalités qui arrivent de partout.
Perso, j'ai jeté mon dévolu sur Pleroma qui est léger et fonctionnel.

Enfin léger… sa base de données augmente inexorablement.
Entendons-nous, c'est pas un bug ni rien.
C'est le fonctionnement normal, plus le temps passe, plus la quantité de données augmente, c'est tout à fait logique.

J'ai installé mon instance fin Octobre 2018.
Mon instance s'est donc fédérée petit à petit au point de connaître désormais plus de 2000 autres instances.

| |   DB Postgres   |   /home/pleroma   |
|:-:|:-:|:-:|
|29/10/2018| 26 Mo | 144.5 Mo |
|04/11/2018| 88 Mo | 144.9 Mo |
|20/11/2018| 320Mo | 161.5 Mo|
|02/02/2019| 1212 Mo | 256.4 Mo|
|18/03/2019| 1809 Mo | 280.4 Mo|
|31/05/2019| 5021 Mo | 345.7 Mo|

Bref, ça monte assez vite et il faut donc faire un peu de ménage.

Pleroma commence à proposer quelques commandes internes pour cela.

## Étape par étape

  - Situation initiale : **5021 Mo**
  - <samp>MIX_ENV=prod mix pleroma.database remove_embedded_objects</samp> → **5997 Mo** NANI !?
  - <samp>psql -d pleroma_prod -c 'VACUUM FULL ANALYZE'</samp> → **3836 Mo** ! pfiouuu c'est mieux, beaucoup mieux.
  - <samp>MIX_ENV=prod mix pleroma.database prune_objects</samp> → **3573Mo**, ça aide aussi pas mal.
  - <samp>psql -d pleroma_prod -c 'VACUUM FULL ANALYZE'</samp> → **3372 Mo** ! pfiouuu c'est mieux, beaucoup mieux.

Et voilà.

Lorsque vous faites le *VACUUM FULL ANALYZE* votre instance sera inutilisable (vous ne perdrez pas de toots pour autant, soyez juste un peu patient).

## Encore plus ?
Et oui c'est possible ma bonne dame !
Vous êtes vraiment limité en espace disque et vous voulez vraiment gagner beaucoup plus de place ?
Et bien l'ami Tetsumaki a la solution.
Si vous suivez [son article](https://blog.tetsumaki.net/articles/2019/06/purge-des-donnees-pleroma.html) vous pourrez gagner de précieux octets.

Pour vous donner un ordre d'idée, en suivant sa technique je suis de 3372 Mo à tout juste **242Mo**.
Ouaip !
242Mo !

Bon la manipulation est un peu plus touchy donc faites bien votre backup avant et sachez le restaurer au cas où.
Cette manipulation est plus destructrice : vous perdrez des anciens toots et compagnie mais au final… est-ce vraiment gênant ?
