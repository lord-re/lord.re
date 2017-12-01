+++
Author = "Lord"
Description = "Petite astuce qui va vous empêcher de pourrir une partoche en cas de montage oublié."
date = "2017-08-16T15:49:41+02:00"
title = "Empêcher rsync de pourrir une partoche si c'est pas mount"
menu = "main"
Categories = ["linux","software","tips","cli"]
Tags = ["linux","software","tips","cli"]

+++

Rhaaa Linux et son arboressence unique. Qu'est-ce que c'est bien !

Rhaaa Linux et ses montages ultra flexibles. Qu'est-ce que c'est bien !

Ouai j'adore. Réellement. C'est pas sarcastique ou ironique ni des fautes de frappes. C'est franchement bien de pouvoir morceller son arboressence et répartir ça sur pas mal de systèmes de stockage différent. Par contre il y a un ptit truc un poil relou.

Quand tu as un script qui s'execute régulièrement et que ce script sert à faire un gros backup de pas mal de machines différentes mais qu'il fait tout ça sur un disque dur qui n'est pas monté… bha tu dois te faire chier à aller faire le nettoyage. Ensuite tu montes la partoche en question et voilà. Rien d'insurmontable mais bon c'est quand même un pain dans le cul.

La solution ? Et bha en fait c'est plutôt simple : **chattr +i /stockage/backup** et hop. Le dossier est immutable : même root ne peut pas y écrire. Du coup si jamais la partoche est pas montée, le script n'y fouttra pas ses fichiers. Par contre ça veux dire pas de backup. Méfiance. Rassurez-vous, malgré le chattr +i, vous pouvez monter votre partoche sans aucun soucis. C'est juste parfait.

Voilà pour la ptite astuce de filou. Je l'ai trouvé dans les commentaires d'HN (une mine d'or)…

