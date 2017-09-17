+++
notoc = true
date = "2017-09-30T21:46:06+02:00"
PublishDate = "2017-09-21T21:46:06+02:00"
title = "Substring History Search dans ZSH"
menu = "main"
Tags = ["cli","ux","tips","software"]
Categories = ["cli","ux","tips","software"]
Description = "Voyons une astuce pour faire du substring history search avec ZSH. En vrai ça consiste en une autocompletion d'une commande par rapport à votre historique de commande. Un bon gain de temps pour relancer une commande alambiquée."

+++
Les shells de nos chers unices sont de merveilleux outils qui permettent d'interagir avec nos OS. C'est mon interface principale. Je l'utilise constamment et pour tout. J'utilise très peu de logiciels graphiques. Un navigateur, un terminal et un lecteur vidéo. Voilà tout.

Par contre je dois avouer que j'ai pas une super mémoire et du coup j'ai parfois du mal à me rappeler de certaines commandes. C'est d'ailleurs pour ça que j'utilise [Foldcat]({{< ref "posts/56-foldcat.md" >}}) comme vu il y a quelques temps. Par contre ça ne fait pas tout encore. J'ai donc une botte secrète.

## Historique des commandes
Le shell garde en mémoire toutes les commandes que vous lancez. Vous avez alors un fichier *history* ou *zhistory* qui traine dans votre */home*. Dans pas mal de shell vous pouvez chercher dans cet historique avec *Ctrl-r* , c'est pas mal. Mais c'est pas non plus la panacée. On va ajouter un ptit script à notre cher ZSH pour le rendre superbement efficace sur ce point.
Donc on va fouttre [ce fichier](/static/zsh-history-substring-search.zsh) */etc/zsh/zsh-history-substring-search.zsh* en place puis on va faire en sorte qu'il soit utilisé. Pour ça on édite */etc/zsh/zshrc* pour y placer un petit ```source /etc/zsh/zsh-history-substring-search.zsh``` si possible vers le début du fichier (là où on source tous les scripts pour bien ranger). 

Il ne nous reste plus qu'à affecter une touche pour déclencher l'action. On édite encore */etc/zsh/zshrc* et ce coup-ci vers la fin (où on range soigneusement tous les keybinds) ```bindkey "^[[A" history-substring-search-up``` et ``` bindkey "^[[B" history-substring-search-down``` et voilà. **^[[A** correspond comme vous le savez à la flêche du haut et donc **^[[B** évidemment à celle du bas.

## Mise en pratique immédiate.
On ouvre un nouveau shell pour que ce soit pris en compte (ou alors on source mais franchement on est flemmard jusqu'au bout). On commence à rédiger une commande genre **hugo ne** , puis on fait flêche du haut et là pouf votre commande se complète. Si la commande qui arrive est pas la bonne, on continue d'appuyer en haut ou en bas. Et voilà.

C'est vraiment efficace, surtout que l'on peut rentrer n'importe quel morceau de la commande recherchée, pas forcément les premiers caractères. Ça mériterait d'être dans tous les shells par défaut !
