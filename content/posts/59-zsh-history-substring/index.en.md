+++
Author = "Lord"
notoc = true
date = "2017-09-21T21:46:06+02:00"
PublishDate = "2017-09-21T21:46:06+02:00"
title = "Substring History Search in ZSH"
menu = "main"
Tags = ["cli","ux","tips","software"]
Categories = ["cli","ux","tips","software"]
Description = "PROTIP : how to substring history search in ZSH."

+++
Our unices shells are wonderful tools to interact with our OS. That's my main user interface. I use it for everything. I only use three graphical softwares : a web browser, a media player and a terminal emulator. That's all.

I admit that i have a very volatile memory. I can't remember a thing I only do once or twice a year. I forget a lot of commands. That's why i use [Foldcat]({{< ref "/posts/56-foldcat" >}}) as seen earlier. But it's still not optimal. I have another trick !

## Commands history
Yous shell log every command you enter in a file. This file is *history* or *zhistory* somewhore in your */home*. Most of shells lets you search automatically in this file with **Ctrl-r** which is not bad. But that's far from optimal. We will add a script to ZSH the great.

Put [this file](/static/zsh-history-substring-search.zsh) in */etc/zsh/zsh-history-substring-search.zsh* and we now need to tell ZSH how to use it. Go in */etc/zsh/zshrc* and add ```source /etc/zsh/zsh-history-substring-search.zsh``` in the beggining (where all other "sources" are (it's better sort them together). 

Now we must bind a key to trigger the script. Stil il */etc/zsh/zshrc* but near the end of the file this time (with all your keybinds) : ```bindkey "^[[A" history-substring-search-up``` and ``` bindkey "^[[B" history-substring-search-down```. There you go. **^[[A** as you guess means the up arrow of your keyboard and **^[[B** the down one.

## Using this thing now
Open a new shell (or source your zshrc, but frankly it's faster to open a new one). Start typing a command like **hugo ne** , then press the **up arrow** and you should have your command completed with the latest command. You can use your arrows multiple times. And voilà !

That's easy and really fast. You don't even need to type the beggining of a command. Any part will fit. It should be in all default shell options !
