+++
Author = "Lord"
Description = "Top est une commande Posix permettant de chopper tout un tas d'infos sur les processus qui tournent sur votre machine. Son plus célèbre concurrent est htop qui permet d'avoir les mêmes infos et mêmes quelques autres en plus d'une jolie ptite interface."
Categories = ["linux", "adminsys","tips"]
menu = "main"
notoc = true
PublishDate = 2019-01-10T19:04:28+01:00
date = 2019-01-10T19:04:28+01:00
lastEdit = 2019-01-18T18:18:12+01:00
title = "Top et Htop"
editor = "kakoune"
+++
Lors d'un récent post je vous ai montré un ptit screenshot d'**htop** et certains étaient intéressés donc voilà un mini article à ce propos.

Le vénérable **top** est bien il est Posix, dispo dans busybox toussa toussa mais htop est quand même bien mieux.

Mais avant de partir direct dans htop, je vais m'attarder sur top parce qu'il est quand même pas trop mal.

## Utiliser top quand c'est inéluctable.
Ouai il y a des fois où vraiment on peut pas avoir htop.
C'est triste mais ça arrive.

Et bha sachez qu'on peut s'en servir sans se vomir dessus.

On va transformer ça :

{{< img src="top-nature.png" link="top-nature.png" alt="top en config par défaut est pas des plus attrayant ni des plus pratique." title="Pas la joie." >}}

En ça :

{{< img src="top-pimped.png" link="top-pimped.png" alt="top tout personnalisé de partout avec pleins de couleurs" title="Ça a de la gueule, hein ?" >}}

### Se démerdouiller
Premier truc à connaître : **<samp>?</samp>** .
Ouai, trouver de l'aide est le premier truc ;-)

Un truc indispensable pour rendre le truc plus lisible **<samp>0</samp>**.
Ça n'affichera que les valeurs non nulles.

Pour chercher une info c'est **<samp>L</samp>** (comme locate).

Pour envoyer un signal à un processus ça sera avec **<samp>k</samp>**.

### Level UP
Bon c'est bien gentil mais c'est, pour l'instant, pas non plus la joie.

On va virer/ajouter les infos qui nous intéressent :
Pour ça faut appuyer sur **<samp>f</samp>** et là choisissez avec **<samp>Espace</samp>** les champs que vous voulez et **<samp>s</samp>** pour le champ qui servira à ordonner les lignes.

Ha là déjà on a énormément progressé !

On peut encore améliorer le truc en pimpant les couleurs : **<samp>Z</samp>** et là tout un nouveau monde s'ouvre à vous !
Ce menu de configuration vous permet de choisir la couleur des différents éléments.

Hey mais vous savez quoi ?
On peut aller encore plus loin !

Avec **<samp>A</samp>** vous aurez le *multi-window* !

O__O

Et oui.
En fait **top** est vraiment pas si pourri que ça une fois un peu confé (:-þ).

Pour passer d'une fenêtre à une autre c'est avec **<samp>g</samp>** puis vous choisissez le numéro que vous voulez (de 1 à 4).
Et vous pouvez re-faire ce que vous avez fait pour la première fenêtre mais pour les trois autres.

Une fois tout aux ptits oignons, pensez à faire un **<samp>W</samp>** pour sauvegarder la configuration.

## Htop
Bon après ce petit chapitre où on voit que top est pas si pourri qu'il en a l'air on va voir pourquoi htop est mieux.

### Tweakons sa face
Bon déjà on va changer un peu son allure par défaut.
Avec **<samp>F2</samp>** on accède aux réglages.

Perso dans les *Meters* en *Left column* je mets :

  - CPU (1&2/4) [Bar]
  - Memory [Bar]
  - CPU [Graph]

et en *Right column*

  - CPU (3&4/4) [Bar]
  - Task counter [Text]
  - CPU [LED]

Ensuite dans les *Display options* j'active :

  - Tree view
  - Shadow other users' processes
  - Hide kernel threads
  - Hide userland process threads
  - Display threads in a different color
  - Show custom thread names
  - Show program path
  - Highlight program "basename"
  - Highlight large numbers in memory counters
  - Leave a margin around header

Et ensuite dans *Colors* choisissez ce qui vous flatte le plus la rétine.

Le dernier onglet concerne les *Columns* là c'est à votre convenance, la mienne ?

  - PID
  - User
  - State
  - Percent CPU
  - Percent MEM
  - Time
  - Command

Et pour finir un ptit **<samp>F10</samp>**.

La configuration se sauvegarde dans le fichier *~/.config/htop/htoprc* .

Voilà jusque-là pas tellement d'avantage face à top, mais du coup pourquoi qu'il est mieux lui ?

### Les atouts
Contrairement à **top** on peut lui faire des trucs en plus sur les processus mais souvent il va falloir rajouter d'autres logiciels.

Un premier truc c'est *strace* qui permet d'observer ce que fait un processus qui tourne (les syscalls qu'il lance permet de savoir s'il dort où s'il attend les io ou autre).
Pour ça une fois que vous êtes sur le processus incriminé, appuyez sur **<samp>s</samp>**.
À noter que vous ne pouvez stracer que les processus lancés par votre utilisateur à moins d'être root.

Les descripteurs de fichiers utilisés par un processus peuvent être vu avec **<samp>l</samp>**.Ça vous lancera donc un *lsof* sur le processus.
Tout comme pour strace, pour des raisons de droits, vous ne pouvez le faire que sur vos processus à moins d'être root.

Un ptit **<samp>L</samp>** vous affichera tous les appels aux libs que fait un processus.
Pour ça il faut que vous ayez *ltrace* d'installé.

Et le ptit dernier c'est **<samp>e</samp>** qui permet de voir toutes les *variables d'environnement* d'un processus.

Voilà pour moi le gros avantage d'htop c'est d'avoir une *config rapidement accessible*, une *interface beaucoup plus intuitive* et de *s'intégrer bien avec les outils d'audit*.

{{< img src="htop.png" link="htop.png" alt="htop une fois personnalisé" title="Le brave Htop" >}}

## Les confs :
Pour les flemmards je vous mets ici les fichiers de configs de ces deux logiciels :

*~/.config/htop/htoprc*

{{< highlight ini>}}
# Beware! This file is rewritten by htop when settings are changed in the interface.
# The parser is also very primitive, and not human-friendly.
fields=0 48 2 46 47 49 1
sort_key=47
sort_direction=1
hide_threads=0
hide_kernel_threads=1
hide_userland_threads=1
shadow_other_users=1
show_thread_names=1
show_program_path=1
highlight_base_name=1
highlight_megabytes=1
highlight_threads=1
tree_view=1
header_margin=1
detailed_cpu_time=0
cpu_count_from_zero=0
update_process_names=0
account_guest_in_cpu_meter=0
color_scheme=5
delay=15
left_meters=LeftCPUs2 Memory CPU
left_meter_modes=1 1 3
right_meters=RightCPUs2 Tasks CPU
right_meter_modes=1 2 4
{{< / highlight >}}

*~/.config/procps/toprc*

{{< highlight ini >}}
top's Config File (Linux processes with windows)
Id:i, Mode_altscr=1, Mode_irixps=1, Delay_time=1.0, Curwin=0
Def     fieldscur=<A5><A8>34;=@ķ<BA><B9><C5>&')*+,-./012568<>?ABCFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghij
        winflags=195892, sortindx=0, maxtasks=0, graph_cpus=0, graph_mems=1
        summclr=6, msgsclr=1, headclr=3, taskclr=2
Job     fieldscur=<A5><A6><B9><B7><BA>(<B3><B4>Ļ<BD>@<<A7><C5>)*+,-./012568>?ABCFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghij
        winflags=195892, sortindx=0, maxtasks=0, graph_cpus=0, graph_mems=0
        summclr=6, msgsclr=6, headclr=7, taskclr=6
Mem     fieldscur=<A5><BA>;<<BD><BE><BF>@AMBNCD34<B7><C5>&'()*+,-./0125689FGHIJKLOPQRSTUVWXYZ[\]^_`abcdefghij
        winflags=1244470, sortindx=21, maxtasks=0, graph_cpus=0, graph_mems=1
        summclr=5, msgsclr=5, headclr=4, taskclr=5
Usr     fieldscur=<A5><A6><A7><A8><AA><B0><B9><B7><BA><C4><C5>)+,-./1234568;<=>?@ABCFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghij
        winflags=195892, sortindx=3, maxtasks=0, graph_cpus=0, graph_mems=0
        summclr=3, msgsclr=3, headclr=2, taskclr=4
Fixed_widest=0, Summ_mscale=1, Task_mscale=3, Zero_suppress=1
{{< / highlight >}}
