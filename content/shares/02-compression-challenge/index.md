+++
Author = "Lord"
Description = "Un impossible challenge de compression en 2001 ayant donné lieu à un échange de mail."
Categories = ["web", "impossiburu"]
menu = "main"
notoc = true
PublishDate = 2018-07-01T23:07:58+02:00
date = 2018-07-09T16:07:58+02:00
title = "5000$ Compression Challenge"
editor = "kakoune"
+++
Ce second partage avec vous est une perle que je souhaitais vous montrer depuis des lustres mais je n'avais pas de moyen bien pour vous le partager auparavant.

Il s'agit d'*un échange de mail entre Mike Goldman (j'ai pas trouvé d'infos) et Patrick Craig* qui est un informaticien avec un [site perso](http://www.patrickcraig.co.uk/index.htm). 

Notre cher Mike a décidé de lancer un concours avec à la clé 5000$ de gain en l'an de grâce -3 avant Facebook.

## Le challenge

*Le participant choisit une taille de fichier. Il recevra ensuite un fichier de la taille voulue et devra renvoyer ce même fichier compressé + le décompresseur. Pour gagner, la somme des deux devra être inférieure à la taille du fichier initial.*

Pour participer il faut envoyer 100$.

## [La page en question](https://www.patrickcraig.co.uk/other/compression.php)-[cache local](original)
Bon par contre cette fois aussi, c'est en anglais.

## TL;DR - Spoiler !
Pour ceux que l'anglais rebute ou qui n'ont pas la patience de lire l'histoire voilà un ptit résumé et quelques explications.

Le fichier que va génèrer Mike Goldman sera un fichier aléatoire bien foutu.
Ça veut donc dire qu'en théorie, il n'est pas compressible efficacement.
Même si ce fait n'est énoncé à l'avance il n'y a rien d'étonnant à cela.

Notre cher Patrick Craig est très probablement bien au fait de tout cela mais avant de participer pose une question faussement innoncente :
*Est-ce que la solution peut être constituée de multiples fichiers du moment que le décompresseur retourne le bon résultat ?*
Ce à quoi Mike Goldman ne vera pas d'objection.

Notre cher participant paie la taxe de participation et demande un fichier de 3Mo.

Entre temps, Mike Goldman a annoncé avoir un participant à son challenge sur la newsgroup comp.compression (ouai c'est pas récent, à l'époque les ng étaient pas mal utilisées encore).
Il annonce fièrement que *ce challenge est mathématiquement impossible* (ce qui est effectivement le cas).

Patrick Craig nous explique ensuite qu'il est mathématiquement impossible de gagner ce challenge **MAIS** il y a une petite feinte.
Le fait de pouvoir rendre plusieurs fichiers est l'astuce.

En gros le fichier original contient des caractères aléatoires.
La compression consiste donc à lire le fichier original et de le découper à chaque apparition d'un caractère particulier ("5"), de supprimmer ce caractère et c'est reparti.
Recompresser le fichier consiste à lire le premier fichier compressé, caténer le caractère "5" puis de passer au fichier suivant et ainsi de suite.
Donc *oui les fichiers compressés + le décompresseur sont plus petits que le fichier original*.
Mais *non ils ne prennent pas moins de place*.

### Pourquoi ?
L'astuce réside donc dans le fait d'utiliser plus de méta-données afin de réduire la taille des données.

Le système de fichier, pour chaque fichier doit stocker des méta-données dans sa base de données.
Donc au lieu d'avoir 1 fois des méta-données pour 1 fichier, il y a désormais 218 fois des méta-données pour 218 fichiers (+1 pour le décompresseur) mais comme le système de fichier ne les affiche pas.

Bref il y a eu filouterie :-)

Patrick Craig n'a pas eu le droit à ses 5000$ mais il ne comptait pas trop dessus.
Il aura perdu tout de même 100$ de participation mais franchement c'est plutôt marrant l'histoire qui en découle et puis surtout :

*« My main motivation was to "out-trick the tricker". »*
