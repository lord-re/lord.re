+++
Author = "Lord"
Description = "Vimifions ZSH et simplifions son utilisation en affichant le mode actuel"
Categories = ["shell", "vi","ux"]
Tags = ["shell", "vi","ux"]
menu = "main"
notoc = true
PublishDate = 2018-01-09T15:44:34+01:00
date = 2018-01-09T15:44:34+01:00
title = "Utiliser ZSH à la façon de VI en réduisant les inconvénients"
+++
***Vi*** et ***Emacs*** ont inspiré et inspire encore pas mal les devs car ils ont posés deux bases d'expériences utilisateurs qui ont depuis le temps prouvé leur efficacité. Ils s'appuient tous les deux principalement sur l'utilisation du clavier mais abordent le problème différemment.

  - Emacs s'appuient sur **des raccourcis claviers** nécessitant tous pleins de doigts pour appuyer simultanément sur diverses touches : Ctrl-Alt-Shift-Altgr-x …
  - Vi lui utilise **des modes** : un mode pour entrer des commandes, un mode pour écrire, un mode pour faire le café …

Ce sont donc deux approches différentes mais pourtant efficaces. Il est par contre assez difficile de passer de l'une à l'autre car elles nécessitent tout de même un temps d'apprentissage et d'adaptation assez long, bien que l'on puisse se contenter de nager en surface et donc de ne pas en profiter à fond.

Bref généralement au bout de quelques années de pratiques on acquière pas mal de mémoire musculaire et on se retrouve parfois frustré de pas pouvoir utiliser ça partout. Par exemple je ne supporte plus d'utiliser un navigateur web qui ne suit pas la philosophie de vi (d'où ma migration vers [qutebrowser](https://lord.re/posts/64-qutebrowser/)). Mais du coup : saviez-vous que même votre shell préféré (ZSH ! mais bon bash aussi et fish aussi…) peut mimer vi.

## ZLE KEYMAP VIINS
L'avantage du mode vi est que l'***on va pouvoir éditer les lignes de commandes comme dans vi***, c'est à dire utiliser la plupart des raccourcis de vi en mode normal : **x** pour virer un caractère, **r** pour remplacer un caractère, **ciw** pour changer le mot actuel… pleins de raccourcis permettant de gagner pas mal de temps.

ZSH est modulaire. Le module s'occupant de la ligne de commande est ***ZLE*** : ZSH Line Editor. Et ce module utilise des keymaps qui sont des ensembles de *raccourcis claviers* déclenchant des actions. Il existe un keymap emacs, des keymaps vi (qui correspondent aux différents modes) et un keymap **safe** qui n'est pas éditable/supprimable. Il vous est possible d'en créer d'autres ou bien juste de modifier les existants. Bon du coup le but du jeu va être de foutre le keymap par défaut de ZLE en **viins** (vi insert). Donc dans */etc/zsh/zshrc* et on y colle un 

	bindkey -v 

Et voilà c'est fait vous êtes désormais en mode viins par défaut. Bon du coup si vous appuyez sur **ECHAP**, vous vous retrouverez dans le mode normal de vi.

## Améliorations
Le premier truc un poil chiant c'est que le changement de keymap ne se fait pas instantanément. Il y a un timeout de 0.4s qui est un poil trop long. Pour le réduire, il vous suffit d'exporter la variable ***KEYTIMEOUT*** à 1 par exemple pour avoir que 0.1s d'attente lors d'un changement de keymap, ce qui est devient de suite plus tolérable.

Un autre truc un peu chiant c'est qu'on ne sait pas dans quel mode on se trouve mais j'ai trouvé une astuce [sur le blog de Doug Black](https://dougblack.io/words/zsh-vi-mode.html) qui consiste à faire une petite bidouille qui va bien pour afficher le mode **Normal**. Je l'ai à peine modifié pour aller dans mon */etc/zsh/prompt.zsh* :

	function zle-line-init zle-keymap-select {
		VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
		RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $LAST_COMMAND_DURATION s"
		zle reset-prompt
	}
	zle -N zle-line-init
	zle -N zle-keymap-select

Quelques explications : déjà ***RPS1*** est la variable contenant le prompte de droite. D'abord on a défini la variable VIM_PROMPT qui défini l'affichage désiré pour le mode normal (en jaune c'est sympa) puis une double substitution made in zsh qui remplace le nom du keymap par la variable VIM_PROMPT sauf si le mode actuel est *main* ou *viins*. Je colle ensuite $LAST_COMMAND_DURATION qui est la variable qui contient la durée de la dernière commande exécutée.

## Adaptons à nos besoins
Du coup là on a pas fait grand chose de bien méchant. On a choisi un keymap et modifié le prompt, rien de bien tordu. On peut tout de même apporter quelques modifications pour ajouter de nouveaux raccourcis. On va donc en profiter pour virer les ptits inconvénients du keymap de vi : les emmerdes pour se déplacer normalement avec les flèches et plus.

Retournons dans */etc/zsh/zshrc* et ajoutons/trafiquons quelques raccourcis.

	#Pour pouvoir utiliser les flêches haut et bas pour chercher les commandes dans l'historique
	bindkey "^[[A" history-substring-search-up
	bindkey "^[[B" history-substring-search-down
	#Pour pouvoir utiliser Orig et End sur le clavier pour aller en début/fin de ligne (plus pratique)
	bindkey "^[[7~" beginning-of-line
	bindkey "^[[8~" end-of-line
	#Pour utiliser les flêches de gauche et de droite pour se déplacer normalement
	bindkey "^[[D" backward-char
	bindkey "^[[C" forward-char
	#Pour utiliser Suppr
	bindkey "^[[3~" delete-char

Et voilà vous avez des vimmeries ainsi que des raccourcis plus classiques sur le même keymap.
