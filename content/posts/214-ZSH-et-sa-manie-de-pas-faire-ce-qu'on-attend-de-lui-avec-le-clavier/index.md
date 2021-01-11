+++
Author = "Lord"
Description = "ZSH est un super shell. Il est ultra configurable notamment pour le clavier mais c'est parfois un peu rebutant quand ça fait pas ce qu'on espère. Voyons comment obtenir des réglages propres concernant le clavier."
Categories = ["zsh", "tips","cli"]
menu = "main"
notoc = true
WritingDate = 2021-01-11T20:37:58+01:00
date = 2021-01-11T20:37:58+01:00
title = "ZSH plus loin : les touches du clavier"
editor = "kakoune"
TopWords = [  "clavier", "widget", "shell", "terminal", "bindkey", "zsh", "key", "kbd"]
+++
Bon j'espère que je suis pas le seul à avoir ce genre de souci : des fois t'appuies sur une touche et **zsh** ne fait pas ce que tu espères qu'il fasse.
Je parle pas pour les lettres où les caractères spéciaux, je parle plus pour les touches genre <kbd>Home</kbd> ou <kbd>End</kbd>.
Mais enfin !
Si, les touches avec <kbd>⇱</kbd> et <kbd>⇲</kbd> qui permettent d'aller au tout début ou à la fin !

Bon et bien quand vous appuyez sur ces touches et que ce couillon de ZSH ne fait rien.
Il vous regarde benoitement.
Est-ce le clavier qui cesse de fonctionner ?
Est-ce le terminal qui a décidé de ne plus envoyer les infos au shell ?
Et bien non c'est souvent ZSH qui … ne fais rien parcequ'il sait pas quoi en faire.

Il y a tout plein de manière de corriger ça.
Mais d'abord essayons de comprendre ce qui déconne.

## Pourquoi ça merde ?
Ouai alors là j'irai pas non plus à fond dans les détails mais en gros : votre terminal envoie ce que vous tapez au clavier au shell.
Ensuite c'est au shell de comprendre ce qu'il reçoit.

Bon quand vous appuyez sur une lettre, c'est facile, le terminal envoie une lettre et le shell comprend cette lettre.
Quand vous envoyez une touche une touche spéciale, le terminal envoie une séquence de caractères, le shell reconnait (ou pas) cette séquence et agit en conséquence.

Par exemple quand vous appuyez sur <kbd>F1</kbd>, le shell reçoit <samp>^[OP</samp> .
Ha !
C'est moins parlant là d'un coup !
Donc ensuite c'est au shell de faire sa tambouille pour savoir que cette suite de caractère c'est **F1**.

Et à vraie dire chaque terminal n'envoie pas forcément la même séquence de caractères pour une touche donnée.
Et ça varie également en fonction de l'OS.
C'est pour ça que vous avez toujours la variable d'environnement **$TERM** qui permet à votre shell de savoir quel est le terminal qui le fait tourner.
Avec cette info il utilise un dictionnaire différent lui permettant de traduire les chaînes de caractères comme il faut (entre autres).

Il peut arriver que le shell que vous utilisiez n'ait pas le dictionnaire qui convienne ou que votre terminal ne se comporte pas comme il devrait ou juste que le shell soit configuré autrement.

## Voir les chaînes de caractères
Bon maintenant vous êtes curieux, vous voulez voir ces fameuses chaînes de caractères !

  - Ouvrez un terminal dédié (il sera foutu, il faudra le kill à la fin).
  - Lancez un ptit <kbd>stty raw</kbd>
  - Lancez un ptit <kbd>read</kbd>
  - Pianotez ce que vous voulez pour voir ce à quoi ça correspond.

## ZKBD
**Zsh** est maintenant un vieux shell qui a su se créer sa ptite communauté d'utilisateurs.
Et ils ont tous déjà eu les soucis que vous allez rencontrer.
Et les plus débrouillards ont su se dépatouiller et créer des ptits outils pour aider les suivants.

Et c'est là que **zkbd** entre en jeu !

Il s'agit d'un script permettant d'apprendre à ZSH à se démerdouiller par la suite.
Selon votre distro vous l'aurez ou non.

Dans une fière **Gentoo** vous le trouverez dans */usr/share/zsh/5.8/functions/Misc/zkbd* .
Il vous suffit de l'executer et de suivre ce qu'il vous raconte.

<details><summary> /usr/share/zsh/5.8/functions/Misc/kbd </summary>

<pre>
Enter current terminal type: [xterm-256color]

We will now test some features of your keyboard and terminal.

If you do not press the requested keys within 10 seconds, key reading will
abort.  If your keyboard does not have a requested key, press Space to
skip to the next key.

Hold down Ctrl and press X: <kbd>^X</kbd>

Your Meta key may have a Microsoft Windows logo on the cap.
Hold down Meta and press X: <kbd>x</kbd>
Your keyboard or terminal does not recognize the Meta key.

Hold down Alt and press X: <kbd>^[x</kbd>

---------

You are using zsh in MULTIBYTE mode to support modern character sets (for
languages other than English).  To use the Meta or Alt keys, you probably
need to revert to single-byte mode with a command such as

    unsetopt MULTIBYTE

If you want to use these extra keys with zsh, try adding the above command
to your /home/lord/.zshrc file.

See also "man stty" or the documentation for your terminal or emulator.
Press a key to proceed:

---------

You will now be asked to press in turn each of the 12 function keys, then
the Backspace key, the 6 common keypad keys found on typical PC keyboards,
plus the 4 arrow keys, and finally the Menu key (near Ctrl on the right).
If your keyboard does not have the requested key, press Space to skip to
the next key.

Do not type ahead!  Wait at least one second after pressing each key for
zsh to read the entire sequence and prompt for the next key.  If a key
sequence does not echo within 2 seconds after you press it, that key may
not be sending any sequence at all.  In this case zsh is not able to make
use of that key.  Press Space to skip to the next key.

Press a key when ready to begin:

If you do not press a key within 10 seconds, key reading will abort.
If you make a mistake, stop typing and wait, then run this program again.

Press F1: <kbd>^[OP</kbd>
Press F2: <kbd>^[OQ</kbd>
Press F3: <kbd>^[OR</kbd>
Press F4: <kbd>^[OS</kbd>
Press F5: <kbd>^[[15~</kbd>
Press F6: <kbd>^[[17~</kbd>
Press F7: <kbd>^[[18~</kbd>
Press F8: <kbd>^[[19~</kbd>
Press F9: <kbd>^[[20~</kbd>
Press F10: <kbd>^[[21~</kbd>
Press F11 : <kbd></kbd>
Press F12 : <kbd></kbd>
Press Backspace: <kbd>^?</kbd>
Press Insert : <kbd></kbd>
Press Home: <kbd>^[[H</kbd>
Press PageUp: <kbd>^[[5~</kbd>
Press Delete: <kbd>^[[3~</kbd>
Press End: <kbd>^[[F</kbd>
Press PageDown: <kbd>^[[6~</kbd>
Press Up: <kbd>^[[A</kbd>
Press Left: <kbd>^[[D</kbd>
Press Down: <kbd>^[[B</kbd>
Press Right: <kbd>^[[C</kbd>
Press Menu : <kbd></kbd>

Warning: Delete key sends ^[[3~ (not ^?)

Warning: Backspace sends ^?

Parameter assignments for the keys you typed have been written to the file:
/home/lord/.zkbd/xterm-256color-:0

You may read this file into /home/lord/.zshrc or another startup
file with the "source" or "." commands, then reference the $key parameter
in bindkey commands, for example like this:

    source ~/.zkbd/$TERM-${${DISPLAY:t}:-$VENDOR-$OSTYPE}
    [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
    [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
    # etc.

Adjust the name of the file being sourced, as necessary.

</pre>
</details>

Le script vous permet donc de lire un peu toutes les touches qui posent habituellement problèmes et vous écrit ça dans un fichier que vous pouvez sourcer afin de tout bien prendre en compte.
## Bindkeys

Bon maintenant **ZSH** sait interprêter les touches.
Mais … c'est pas pour autant qu'il y associe des actions.

Et un des trucs chouette c'est qu'on peut lui faire faire un peu ce qu'on veut.
Mais bon on va pas se le cacher, ce qu'on veut c'est que ça ait le fonctionnement basique.
Notamment on veut que la touche <kbd>Home</kbd> et <kbd>End</kbd> bouge le curseur en début et fin de ligne.

Pour ça il faut modifier le fichier de conf.
Moi je suis mono-utilisateur sur ma machine mais il m'arrive de passer en root et j'aime bien avoir le même comportement quand je suis root, du coup je passe tout dans */etc/zsh/zshrc* histoire d'éviter les surprises.

Là je pose un petit 

<details><summary>extrait de /etc/zsh/zshrc</summary>
{{< highlight "shell" >}}
typeset -g -A key
bindkey "^[[7~" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
bindkey "^[[D" backward-char
bindkey "^[[C" forward-char
bindkey "^[[5~" beginning-of-buffer-or-history
bindkey "^[[6~" beginning-of-buffer-or-history
bindkey "^[[H" beginning-of-line
{{< / highlight >}}
</details>

Et le tour est joué.

Tiens d'ailleurs s'il vous reste encore un peu de curiosité.
Toutes les "actions" des keybinds sont en fait des **widgets** dans le jargon de zsh.
Vous pouvez retrouver tous les widgets par défaut existants dans le <kbd>man zshzle</kbd> (cherchez “STANDARD WIDGETS” pour arriver au bon endroit).

Et là vous vous dites que vous allez pouvoir en mettre partout dans tous les sens.
Oui, mais il va vous faloir une bonne mémoire (ce que je n'ai pas, j'ai capitulé).
