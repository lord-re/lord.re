+++
Author = "Lord"
Description = "Tmux est un super outil. Ouai je sais screen toussa mais je préferre Tmux. Et d'ailleurs une de ses forces est le fait que toutes ses commandes interactives sont également déclenchables via des commandes externes ce qui le rend scriptable."
Categories = ["tmux", "tips","shell"]
menu = "main"
notoc = true
WritingDate = 2020-02-17T13:59:32+01:00
date = 2020-02-19T13:59:32+01:00
title = "Scripter une session Tmux"
editor = "kakoune"
TopWords = [  "alyve", "pane", "keys", "blog", "script", "shell", "window", "session", "tmux"]
+++
Cette semaine [Alyve](https://hostux.social/@Alyve) a publié [un chouette article sur son blog pour créer des sessions Tmux avec Tmuxinator](https://www.alyve.be/informatique/2020/02/16/tmuxinator.html).
Et là au milieu de l'article il est écrit :

> Alors on va me dire “Oui mais tu peux configurer un script sh pour quand tu lances tmux toussa toussa”. Oui, j’ai pas ton temps, frère. Je suis là pour être productive et botter des culs avec mes nouvelles Doc Martens.

Du coup je saisis la perche au vol : *Oui on peut scripter ça assez facilement !*

On va recréer un environnement similaire à celui de l'article : 

  - Une session tmux
  - Un premier espace de travail avec un éditeur de texte
  - Un second espace de travail scindé en deux parties
  - Une première partie avec hugo qui génère le blog à la volée
  - Une seconde partie avec les commandes git à portée de main

## Script pas à pas
En fait toutes les commandes interactives de Tmux sont également disponibles en commandes shell que vous pouvez lancer manuellement ou bien lancer dans un script.

On va donc faire tout cela dans un script que l'on nommera */usr/local/bin/blog*, on pense tout de suite à le rendre éxecutable avec <samp>chmod +x /usr/local/bin/blog</samp> et c'est partit !


{{< highlight "shell" >}}
#! /bin/sh
session="blog"
window="$session:0"
{{< / highlight >}}

Bon tout bon script commence par un … shebang et quelques déclarations de variables pour se simplifier la vie.
Il faut savoir que Tmux permet de créer des *sessions* avec dedans des *fenêtres* et chaque fenêtre peut contenir de multiple *panes*.
Les panes sont les terminaux virtuels.

Donc pour parler d'un *pane* en particulier son nom est de la forme session:fenêtre.pane .
En sachant qu'on commence à compter à partir de 0.
(gardez cette info pour la suite)

Ensuite premier truc concret, on va faire en sorte que lorsqu'on lance le script, si la session tmux est déjà existante, bha on fait rien si ce n'est rentrer dedans.
Ça va être le moment le plus délicat du script

{{< highlight "shell" >}}
if [ $(tmux attach -t "$session" )]; then
  exit 0
fi
{{< / highlight >}}

Voilà, si la session existe, on s'y rattache puis on coupe le script (si on ne le fait pas, la session se rouvrirait dès que vous la fermez).

Bon, maintenant on va commencer pas mettre dans le bon dossier et à créer la session

{{< highlight "shell" >}}
cd /home/lord/www
tmux new-session -d -s "$session"
{{< / highlight >}}

Voilà on est dans le bon dossier, la session est créée.
On est détaché (<samp>-d</samp>) et on lui a donné un ptit nom (<samp>-s blog</samp>)

{{< highlight "shell" >}}
tmux split-window -t "$window"
tmux split-window -t "$window"
tmux select-layout -t "$window" main-vertical
{{< / highlight >}}

On commence par couper l'espace de travail en deux puis en trois.
Ensuite on active le *layout main-vertical* qui consiste en un terminal principal sur la moitié gauche et sur la droite un empilement des suivants.

{{< highlight "shell" >}}
tmux send-keys -t "$window.0" "kak" C-m
{{< / highlight >}}

Maintenant, on se démarre [kakoune via sa commande kak]({{< ref "/posts/114-kakoune" >}}) dans le pane 0 de notre fenêtre.
D'ailleurs pour envoyer une commande c'est avec <samp>C-m</samp> qui fait un **Ctrl-m** (ça fonctionne aussi dans votre shell), sinon vous pouvez aussi mettre Enter à la place.
{{< highlight "shell" >}}
tmux send-keys -t "$window.1" "hugo server --navigateToChanged --disableFastRender" C-m
{{< / highlight >}}

On se place dans le second pane (c'est le vocabulaire de tmux pour dire terminal) et on y lance hugo qui va permettre de faire des previews et tout.

{{< highlight "shell" >}}
tmux send-keys -t blog "git status" C-m
{{< / highlight >}}

On se place dans le troisième pane et on y lance un ptit git status comme ça on sait tout de suite ce qui est en attente ou non.

{{< highlight "shell" >}}
tmux attach -t "$session"
{{< / highlight >}}

Voilà, on rentre dans notre session

On a assemblé notre T800 yapukatester !

<details><summary>Si vous voulez le revoir en un morceau</summary>
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

Bref, c'est ptet un peu plus long à monter soi-même mais bon si vous recopiez ce script ça sera plus rapide.
En tout cas merci pour l'idée et n'hésitez-pas, allez voir le [blog d'Alyve](https://www.alyve.be).
