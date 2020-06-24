+++
Author = "Lord"
Description = "Tmux is a really powerful tool. I know there is GNU screen but I prefer Tmux. One of its feature is the availability of all its interactives commands as shell commands which lets you write scripts to drive it."
Categories = ["tmux", "tips","shell"]
menu = "main"
notoc = true
WritingDate = 2020-02-17T13:59:32+01:00
date = 2020-02-19T13:59:32+01:00
title = "How to script a Tmux session"
editor = "kakoune"
+++
This week, [Alyve](https://hostux.social/@Alyve) published [a nice blog posts about Tmuxinator (french)](https://www.alyve.be/informatique/2020/02/16/tmuxinator.html).
Halfway in this posts you can read :

> Alors on va me dire “Oui mais tu peux configurer un script sh pour quand tu lances tmux toussa toussa”. Oui, j’ai pas ton temps, frère. Je suis là pour être productive et botter des culs avec mes nouvelles Doc Martens.

Which I took as a challenge : *Yes, we can easily automate things in Tmux natively !*

We will try to reproduce the same behavior as this blogpost :

  - 1 tmux session
  - the first workspace with a text editor
  - A second workspace split in two
  - The first part will run hugo
  - The second will launch one git command and wait

## Scripting it one step at a time
All we need to do is writing every tmux command needed to do this in a script and it should work.

So let's write */usr/local/bin/blog*, and don't forget to make it executable with <kbd>chmod +x /usr/local/bin/blog</kbd>.
Let's go !


{{< highlight "shell" >}}
#! /bin/sh
session="blog"
window="$session:0"
{{< / highlight >}}

Every script starts with a … shebang and some variables to ease our life.
All you need to know is that Tmux creates *sessions* where will resides *windows* which can contain multiples *panes*.
Panes ar virtual terminal with a shell.

If you want to do something to a specific pane you'll need to give its name which looks like this : session:window.pane .
And remember, we counts from 0.

Then the first (and hardest part of the script) is to make sure that if the tmux session already exists to not build it but attach to it.

{{< highlight "shell" >}}
if [ $(tmux attach -t "$session" )]; then
  exit 0
fi
{{< / highlight >}}

If our session exists we go inside it and we stop the script (if we don't, it will recreate it each time…).


{{< highlight "shell" >}}
cd /home/lord/www
tmux new-session -d -s "$session"
{{< / highlight >}}

We first go in the right folder and create a brand new tmux session with the right name.
Make sure to create it but don't attach to it (<kbd>-d</kbd>) and to give it a name (<kbd>-s blog</kbd>)

{{< highlight "shell" >}}
tmux split-window -t "$window"
tmux split-window -t "$window"
tmux select-layout -t "$window" main-vertical
{{< / highlight >}}

We then split the workspace in three panes and apply the *main-vertical* layout which is one big terminal on the left and a stack of secondary terminals on the right.

{{< highlight "shell" >}}
tmux send-keys -t "$window.0" "kak" C-m
{{< / highlight >}}

Now, we start [Kakoune (my favourite text editor)(https://kakoune.org) in the left pane (0).
*C-m* means <kbd>Ctrl-m</kbd> (it also works in a regular shell) but you could also use *Enter*.

{{< highlight "shell" >}}
tmux send-keys -t "$window.1" "hugo server --navigateToChanged --disableFastRender" C-m
{{< / highlight >}}

We then launch *hugo server* in the top right pane.

{{< highlight "shell" >}}
tmux send-keys -t blog "git status" C-m
{{< / highlight >}}

And finally we launch *git status* in the bottom right pane, ready to work.

{{< highlight "shell" >}}
tmux attach -t "$session"
{{< / highlight >}}

This is the end of the script.
You attach to your newly built session.

We built our T800.

<details><summary>Here is the complete script</summary>
{{< highlight "shell" >}}
#! /bin/sh
session="blog"
window="$session:0"

if [ $(tmux attach -t "$session") ]; then
  exit 0
fi

cd /home/lord/www
tmux new-session -d -s "$session"

tmux split-window -t "$window"
tmux split-window -t "$window"
tmux select-layout -t "$window" main-vertical

tmux send-keys -t "$window.0" "kak" C-m
tmux send-keys -t "$window.1" "hugo server --navigateToChanged --disableFastRender" C-m
tmux send-keys -t "$window.2" "git status" C-m

tmux attach -t "$session"
{{< / highlight >}}
</details>

It probably takes a bit more time to setup than **Tmuxinator** but you won't need to install anything.
Thanks for the little challeng and go see [Alyve's blog (fr)](https://www.alyve.be).
