+++
Author = "Lord"
Description = "Aurevoir les Zip, Aurevoir les RAR, voici Quompression. Il peut compresser des To de données dans seulement quelques octets."
Categories = ["humour", "algo"]
menu = "main"
notoc = true
PublishDate = 2018-11-12T12:32:26+01:00
date = 2018-11-12T12:32:26+01:00
title = "Quompression"
editor = "kakoune"
+++
J'ai l'algorithme ultime de compression de données.
Vous allez pouvoir compresser plusieurs Go voir To de données et faire rentrer ça dans quelques dizaines d'octets.

## Le quantum des données
L'algo en lui-même est assez flexible et permet de compresser sans aucune perte n'importe quel type de données.
Le temps de compression est très rapide et s'appuie sur des technologies éprouvées.

Le système se base sur les *data-hints* afin d'améliorer la vitesse de décompression.
Plus vous rajoutez de *data-hints* plus votre fichier compressé va gagner en taille.
C'est donc tout un compromis qu'il va falloir faire : **Préferez-vous un fichier rapide à décompresser ou la taille finale est vraiment le critère le plus important pour vous ?**

Avec cette technique un jpeg de 2Mo est compressé dans moins d'1Ko sans *data-hints*.

## Comment ça marche ?
L'algo de compression repose en grande partie sur les algos de hachage tels que *md5*, *sha1* …

Utilisez ces algorithmes sur votre fichier, notez les résultats dans un fichier et … voilà.

## Et niveau restitution ?
Bha là je vous cache pas que c'est là que le bât blesse.
Va falloir *bruteforcer*.

Vous balancez des données aléatoires et vous hachez ces données et regarder voir si ça correspond aux hash que vous avez.
Si c'est le cas, c'est bon vous avez vos données, si c'est pas le cas, vous jetez les données et vous recommencez.
Ouai ça peut être un poil long voire impossible.

Mais toute l'astuce est dans les *data-hints* :
Dans votre fichier compressé vous pouvez rajouter des données supplémentaires pour aider à la reconstruction des données.

Le plus répandu est *size* qui permet tout simplement d'indiquer la taille du fichier d'origine.
Ça permettra à la décompression de créer déjà des données à la bonne dimension.

Ensuite un pratique est le *fb* qui rajoute comme information quel est le premier bit de données (est-ce un 1 ou un 0 ?).
Ça va permettre à l'algo d'être deux fois plus rapide.

Un autre permettant encore de doubler est *lb* qui indique quel est le dernier bit de données (encore un 1 ou un 0 ?).

Comme expliqué plus haut, le format est très flexible, car vous pouvez ajouter autant de *data-hints* que vous le souhaitez et même en créer de nouveaux si ça peut aider.
Par exemple *mime* qui indique tout simplement le type de fichier compressé.
Ou alors *pic-sub* qui indique sur une photo quel est le sujet (un peu de machine learning peut aider à accélérer la décompression).

## Décompression
J'ai jamais réussi à décompresser un fichier, mais je suis pas d'un naturel très chanceux.

Le format n'impose pas le type de hash ni leur nombre, mais il est préferable d'en indiquer au moins deux différents (surtout si vous n'ajoutez pas de data-hints) afin d'éviter les erreurs de décompression.

