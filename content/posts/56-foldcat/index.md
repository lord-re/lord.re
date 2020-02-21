+++
Author = "Lord"
notoc = true
menu = "main"
Tags = ["tips","ux","cli","adminys","linux"]
Categories = ["tips","ux","cli","adminys","linux"]
Description = "Voilà un nouveau script qui me sert à me rappeler de trucs importants quand on rentre dans certains dossiers. Pas mal pour soulager sa mémoire."
date = "2017-08-27T20:14:47+02:00"
title = "Foldcat : se rappeler de quelque chose quand on rentre dans un dossier"
jdh = "https://www.journalduhacker.net/s/oixhwz/foldcat_se_rappeler_de_quelque_chose"
TopWords = [  "oldpwd", "pwd", "reset_color", "db", "prompt", "timer", "zsh", "foldcat"]
+++

Vous avez une mémoire de poisson rouge comme moi ? Ça vous arrive d'installer des trucs un peu exotiques et de pas vous souvenir comment ça fonctionne. Du coup vous allez dans le dossier en question et là vous fouillez à coup de ls / tree / --help. Pas mal mais et si on avait un ptit truc qui venait nous aider.

## Foldcat : le chat du dossier

Votre chat vous passe dans les panards quand vous entrez dans une pièce ? Ouai bha le script qui va suivre va faire pareil. Quand vous entrerez dans un dossier bam, le script va vous sauter au visage.

On va apprendre à ZSH à nous afficher du texte quand on rentre dans un dossier. Ce petit bidouillage fonctionne avec ZSH mais j'imagine que si vous maîtrisez bash, vous devriez pouvoir le recréer sans trop de difficulté.

Bon alors on va commencer par éditer */etc/zsh/zshrc* parceque comme ça tout le monde aura droit à cette merveille. Dans ce fichier on va juste mettre un ptit ```source /etc/zsh/prompt.zsh``` . Jusque là c'est easy.

Maintenant créons ce */etc/zsh/prompt.zsh* et dedans on y fout ça :
```
function preexec() {
	# on initialise timer pour chronométrer les commandes et oldpwd pour foldcat
  timer=${timer:-$SECONDS}
  oldpwd=$(pwd)
}
function precmd() {
  # reset le background en noir
  /bin/echo -e "\033]11;#080808\007"

  # déclenchement de foldcat. Penser à modifier le chemin de foldcat.db où vous voulez le mettre
  if [ "$oldpwd" != "$(pwd)" ] ;
  then
    /bin/grep "$PWD " /home/lord/.config/foldcat/foldcat.db | cut --delimiter='"' -f2;
  fi

  # affichage de la durée d'execution de la dernière commande
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
    unset timer
  fi
}
 # bon là c'est juste la customisation du prompt
autoload -U colors
colors
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
```

## Le ptit foldcat.db

Là c'est ultra simple. Perso je l'ai foutu dans *~/.config/foldcat/foldcat.db* comme ça c'est tout bien gitté avec tous mes fichiers de conf (je vous raconterai un jour je vous le promet).
```
/home/lord "Home sweet home" ouai ça sert à rien
/home/lord/www "site ouaib géneré par hugo. Pour publier : hugo new posts/XX-bla-bla.md ; vi content/posts/XX-bla-bla.md ; hugo ; Penser à gitter" petit aide-mémoire des familles
```
Et voilà le genre de contenu. C'est ultra simple, pas trop de risque de faire des conneries. Ça s'édite dans vim. On peut mettre des commentaires.

