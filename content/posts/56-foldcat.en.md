+++
Author = "Lord"
notoc = true
menu = "main"
Tags = ["tips","ux","cli","adminys","linux"]
Categories = ["tips","ux","cli","adminys","linux"]
Description = "This is a small script i use to remember things as I browse my filesystem."
date = "2017-08-27T20:14:47+02:00"
title = "Foldcat : text hints will browsing your folders in your shell"

+++
You can't remember things you did only once or twice like me ? You install exotic things you use very infrequently and it's always hard to remember how to use ? So you go in the said folder, you go through any hint you can find with **ls / tree / --help**. Not bad but very inefficient. Let's improve this !

## Foldcat : the cat from the folder

Does your cat flee from any room you enter while rushing in your feet ? This script will do the same. Each time you'll be in a folder, you'll have a message.

We will teach ZSH how to do it. It works with ZSH but i think it's doable in bash and maybe fish but as I don't use them…

So we will start editing */etc/zsh/zshrc* like this everyone will benefit from it. In this file we will just add ```source /etc/zsh/prompt.zsh```. As easy as ABC.

Now we create this file and we put this inside :
```
function preexec() {
	# We initialize a timer to get command execution time and to now the previous working directory
  timer=${timer:-$SECONDS}
  oldpwd=$(pwd)
}
function precmd() {
  # Reset the background color to black
  /bin/echo -e "\033]11;#080808\007"

  # foldcat trigger. Adapt with the path to your foldcat.db
  if [ "$oldpwd" != "$(pwd)" ] ;
  then
    /bin/grep "$PWD " /home/lord/.config/foldcat/foldcat.db | cut --delimiter='"' -f2;
  fi

  # displays the last command execution time (very handy !)
  if [ $timer ]; then
    timer_show=$(($SECONDS - $timer))
    export RPROMPT="%F{cyan}${timer_show}s %{$reset_color%}"
    unset timer
  fi
}
 # a bit of prompt tweaking
autoload -U colors
colors
PROMPT="%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m %{$fg_no_bold[yellow]%}%1~ %{$reset_color%}%#"
```

## The tiny foldcat.db
This part stays simple. Create *~/.config/foldcat/foldcat.db* (so it will be gitted with all your other dotfiles (blog post incoming… soon… one day). 

```
/home/lord "Home sweet home" ouai ça sert à rien
/home/lord/www "site ouaib géneré par hugo. Pour publier : hugo new posts/XX-bla-bla.md ; vi content/posts/XX-bla-bla.md ; hugo ; Penser à gitter" petit aide-mémoire des familles
```
This is the kind of content i put there. It's quite foolproof. You edit it with your preferred text editor (vim). You can even add comments !

