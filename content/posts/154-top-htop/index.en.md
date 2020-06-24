+++
Author = "Lord"
Description = "Top is a posix command to collect many informations about running processes on your machine. Htop is a popular alternative giving you the same informations plus some more in a nicer interface."
Categories = ["linux", "adminsys","tips"]
menu = "main"
notoc = true
PublishDate = 2019-01-10T19:04:28+01:00
date = 2019-01-12T10:04:28+01:00
title = "Top et Htop"
editor = "kakoune"
+++
In a recent blog post i showed you a small screenshot of **htop** and some of you were interested about it so here's a small post about it.

The good old **top** is good, belongs in Posix, is available everywhere even in busybox but htop is still better.

But before going full on htop, we'll se how we can improve top's configuration.

## Using top when there is no alternative
Yep, sometime you can't install your little htop.
It's sad but life's hard you know.

You can still tweak top to make it usable without puking.

We'll transform this :

{{< img src="top-nature.png" link="top-nature.png" alt="Default top configuration is as bland and not so usable" title="That's so sad with a poor UX." >}}

Into this :

{{< img src="top-pimped.png" link="top-pimped.png" alt="top customized with some colors and many fields." title="What an handsome boi" >}}

### Taming the beast
First thing to know :  **<kbd>?</kbd>** .
Yep, finding help is the first good thing to master ;-)

First setting to change is to display only non-zero values with **<kbd>0</kbd>**.
This will unclutter the UI.

Then if you are looking for something specific you can use **<kbd>L</kbd>** (to locate).

To send a signal to a process you'll use **<kbd>k</kbd>**.

### Level UP
Well you know the very basic now but it's still far from usable.

We will add/remove the fields top displays :
You have to press **<kbd>f</kbd>** then choose the fields with **<kbd>Espace</kbd>** and press **<kbd>s</kbd>** to select the sorting field.

With just this, it's way better !

We can still pimp the colours : **<kbd>Z</kbd>** here is a brand new world to explore !
This menu will let you choose the colours for every elements.

But you know what ?
We can still go deeper into top !

With **<kbd>A</kbd>** you'll enable the *multi-window* mode !

O__O

Yes.
In fact **top** isn't a shitty as it looks at first.

To go from one window to another you can press **<kbd>g</kbd>** then enter the window number (from 1 to 4).
Then you can change the colour as you did before with **<kbd>Z</kbd>** for the 3 other windows.

Once all is perfectly configured you should save with **<kbd>W</kbd>**.

## Htop
So now that you know that top isn't so bad after all, let me show you why htop is better.

### Let's tweak its UI
First we will change a bit its default interface.
To access the settings menu press **<kbd>F2</kbd>**.

I personnaly do this in *Meters* / *Left column* :

  - CPU (1&2/4) [Bar]
  - Memory [Bar]
  - CPU [Graph]

and in *Right column*

  - CPU (3&4/4) [Bar]
  - Task counter [Text]
  - CPU [LED]

Then inside *Display options* i put :

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

Then choose your favorite *Colors*.

Then the last tab about *Columns* you can put what you want, i like these :

  - PID
  - User
  - State
  - Percent CPU
  - Percent MEM
  - Time
  - Command

Then press **<kbd>F10</kbd>** to save.

The config file will be written in *~/.config/htop/htoprc* .

So now top and htop are pretty close from each other, so why is htop better ?

### The pros
Unlike **top**, **htop** can use external commands from within its interface to get more informations.

My favorite one is using *strace* to see every syscall a running process is doing (to know why a process looks like sleeping it's very handy).
To launch it, just press **<kbd>s</kbd>** when you are hovering the process.

Another one i use a lot is *lsof* which lets you see which files are opened by a process.
Just press **<kbd>l</kbd>** and there you go.

I never use this one but maybe you will : **<kbd>L</kbd>** will show you lib's call thanks to *ltrace*.

The last one is included is **<kbd>e</kbd>** will show you the environnement variables of a process.

So here are the main advantages of htop over top : *an accessible UI*, *lots of configuration options* and *many integrations with external tools*.

{{< img src="htop.png" link="htop.png" alt="htop customized" title="The mighty htop" >}}

## Configuration files :
Here are my configuration files for those two tools :

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
