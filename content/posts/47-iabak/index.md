+++
Author = "Lord"
Description = "Filons un coup de mains à archive.org dans leur quête de préservation de l'Internet"
date = "2016-12-08T15:22:34+02:00"
title = "Redondons les archives du net"
menu = "main"
Categories = ["libre","adminsys","communs","git"]
jdh = "https://www.journalduhacker.net/s/mwco7z/redonder_les_backup_darchive_org"
TopWords = [  "annex", "bak", "stockage", "volontaires", "archive", "shard"]
+++
J'imagine que vous connaissez de près ou de très loin le site [archive.org](https://archive.org).
Il s'agit d'un site tenu par une poignée de volontaires très passionnés s'étant donné pour mission d'archiver.
À la base ils archivaient le web, puis le net puis en fait tout ce qui est composé de 0 et de 1.
Sacré boulot.
Mais ces gens sont vraiment très passionnés.
Ils arrivent à mettre la main sur des données plus ou moins perdues/ignorées/oubliées et les rendent accessibles à tous.
Le tout en les classant/organisant/archivant.
Gros gros boulot.
Leur tâche est titanesque, mais ils s'en sortent plutôt bien.
Un de leur projet les plus populaires est l'[Internet Wayback Machine](https://web.archive.org/) qui permet de consulter d'anciennes versions de site ouaibs.
C'est vraiment super sympa pour voir l'évolution des modes du webdesign.
Une sacrée mine d'or intarissable.

## Leur petit souci
Du stockage ils en ont un paquet.
En 2014 c'était plus de 50 Peta octets stockés chez l'Archive Team.
À noter qu'ils ne se content pas uniquement des données numériques mais désormais tente de sauver également des livres et autres manuels.
Cependant il ne s'agit que d'une petite association avec finalement assez peu de moyen par rapport à leurs ambitions.

Une telle volumétrie numérique est un réel fardeau technique.
Surtout qu'il faut tout backuper et répartir : tout stocker à un seul endroit est impensable pour la pérennité (rapelez-vous de la fameuse bibliothèque d'Alexandrie).
Du coup ils répartissent leurs données en plusieurs endroits géographiques.
Malheureusement ça leur coûte de plus en plus cher de faire ça sérieusement.
Donc en plus de faire appel au pognon du chaland, ils font également appel à leurs skeudurs.
Depuis deux ans ils expérimentent un backup distribués de leurs données.

## Leur solution : IA.BAK
Un peu à l'image de BOINC et Folding@Home qui utilise les ressources processeurs des volontaires, ici IA.BAK utilise le stockage des disques durs des volontaires.
Le but est d'avoir au moins trois copies complètes en dehors de leurs machines propres et si possible répartis géographiquement.
Dans le cas où ils perdraient leurs données, ils auraient au moins trois possibilités de récupérer les données perdues.
Voyons un peu comment cela marche sous le capot.
Les développeurs de logiciels utilisent le très célèbre logiciel git pour travailler à plusieurs sur le même ensemble de fichier de code.
C'est vraiment puissant et flexible mais assez complexe à prendre en main et le souci c'est que ce n'est pas spécialement adapté aux données binaires brutes.
Or les archives sont en très grandes parties remplies de ce genre de données.
L'archive team a du coup porté son choix vers git-annex qui est un git aux hormones.
Git commence à galérer à partir d'un million de fichiers, ils ont donc choisi simplement de découper leur set de données en plusieurs groupes plus petits appelés Shard.
Lorsqu'une personne décide de s'inscrire elle va décider quelle quantité de données elle est prête à héberger et va se voir attribuer un shard dans lequel le logiciel va aller télécharger à peu près la quantité de données voulue.
Il y a moyen de laisser faire le logiciel tout seul ou alors il est même possible de choisir dans le shard quels fichiers ils veulent stocker (bon c'est vraiment un petit détail mais bon).
Git-annex va donc télécharger tout ce petit monde, ça peut être un poil long bien entendu.
Et voilà.
Enfin… pas vraiment.
Maintenant tous les mois il va falloir relancer git-annex qui va parcourir les fichiers afin de s'assurer que leur intégrité est bonne et histoire de pointer auprès de l'archive histoire de montrer que vous participez toujours et que les données sont disponibles en cas de besoin.
Si vous ne le faites pas au bout d'un certain temps vos données seront considérées comme non backupés.
Rassurez-vous en pratique vous n'avez qu'à lancer le truc, tout se fait seul sans intervention de votre part (un ptit cron qui va bien et hop).

## Un projet participatif indispensable
Voilà c'est assez simple, ça ne demande qu'un peu de stockage, de bande passante et c'est tout.
Ensuite vous pourrez regarder les stats de votre shard (le mien c'est le 6 et j'offre un joli Tera).
Donc c'est du logiciel libre qui tourne très bien sous linux, c'est gratuit (encore heureux), ça rend service et bonus, vous aurez tout plein de fichiers étranges que vous pourrez consulter à votre guise (pour la ptite histoire lors d'une coupure d'accès internet à la maison j'ai pris un peu le temps d'explorer ce que j'héberge et j'ai découvert qu'il existait des compétitions de hockey sous-marin en apnée et qu'il y avait des compétitions et que j'en avais quelques vidéos, bref c'est étrange ce qu'on peut découvrir sur ses skeudurs).
Si vous voulez contribuer rendez-vous sur [le site du projet](http://archiveteam.org/index.php?title=INTERNETARCHIVE.BAK).


