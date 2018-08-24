+++
Author = "Lord"
date = "2017-07-23T15:35:44+02:00"
title = "Changer la couleur de fond de son terminal à la volée"
menu = "main"
Categories = ["software","cli","tips","linux","shell"]
Description = "Une petite astuce qui devient très vite indispensable pour changer la couleur de fond du terminal à la volée. Super pour distinguer les terminaux avec une session ssh."
jdh = "https://www.journalduhacker.net/s/vcqj7d/changer_la_couleur_de_fond_de_son_terminal"

+++

Ça vous arrive combien de fois de plus savoir si vous êtes sur une session ssh distante ou si vous êtes sur un terminal local ? Pour moi ça m'arrive constamment. Enfin ça m'arrivait. J'ai trouvé une petite astuce qui change tout : Changer le background d'un terminal à la volée !

Et ouai il existe un séquence d'échappement qui permet de faire ce petit miracle à condition que votre terminal le gère (par exemple xterm et très bientôt alacritty). La séquence magique est ***\033]11;#rrggbb\007*** . Voilà voilà.

Comment utiliser ça ? Easy ! Vous éditez votre */etc/ssh/ssh_config* et vous mettez
```
PermitLocalCommand yes
LocalCommand /bin/echo -e "\033]11;#440044\007"
```
et là bam : à la prochaine connexion ssh un magnifique fond violet vous sautera à la gueule. Toute fois, cela empêchera le scp, méfiance. Par contre comment remettre le fond comme il faut au retour ? Là il faut ruser un poil, on vera après. Vous pouvez également faire en sorte de mettre une couleur différente par destination ssh, soit du côté client en modifiant votre ~/.ssh/config mais du coup c'est un poil chiant car local, soit en modifiant le script d'initialisation du shell distant. Perso je rajoute le fameux echo dans le /etc/zsh/zshrc avec des couleurs différentes. Comme ça, quelque soit la machine d'origine ça fonctionne.

Bon pour récup la couleur d'origine faut feinter. Dans mon cas j'utilise zsh. Dans ce zsh j'ai rajouté un ptit truc sympa qui permet de chronométrer toutes les commandes que je lance et d'afficher la durée dans le prompt. Pour se faire, j'ai un fichier */etc/zsh/prompt.zsh* avec dedans deux fonctions : une *preexec()* qui définie une variable timer. Et la *precmd()* qui récupère la variable timer, calcule les secondes écoulées et affiche le résultat dans le *RPROMPT*. Jusque là rien d'éxotique. Il suffit donc de rajouter le **/bin/echo** dans la precmd() et le tour est joué. Cette commande étant executée à la fin de chaque commande, en sortant d'une session ssh, vous retrouverez la couleur souhaitée.

C'est presque aussi efficace qu'un mollyguard pour le moment. Par contre à voir si je ne m'y accoutumerais pas trop.
