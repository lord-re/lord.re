+++
Author = "Lord"
Description = "I don't use a full desktop environment where everything is prebuilt/prepackaged but i installed many different software to create my own lite environment. It's sway based with many little tools on top. "
Categories = ["sway", "ux","linux"]
menu = "main"
notoc = true
WritingDate = 2020-10-13T14:57:55+02:00
date = 2020-10-13T14:57:55+02:00
title = "Enhancing my nunux environment"
editor = "kakoune"
+++
I already mentionned how i'm obsessed about using a KISS environment with as few running processes possible.
But it's been a couple months now where i'm going in the opposite direction where i add some little tools to enhance my comfort and ease of use.

I run **Sway** for more than two years now and i'm perfectly satisfied.
It's a small wayland compositor trying to mimic **i3** which i used for many years.

During these two years wayland became's user experience drastically improved.
Many small bugs or missing features where fixed and it's now nearly on par with X11.


## Redshift
You probably guessed it, i'm using my computer for many hours a day and sometimes far in the night.
It's now common knowledge that it can mess your circadian rhythm to stare at screen because of their blue light.

If i mention it, you probably guessed that i was impacted and tried to solved it.
Not at all, i sleep like a baby 5 minutes after getting to bed and only my fellow cat can prevent it.

But it's free and I could still be impacted later in my life…
I installed [Redshift](https://github.com/jonls/redshift) which is a well known tool which changes the colors of your screen by adding a red tint depending on the hour of the day.

You give it your geolocation and with this information it guesses when the sun goes down to remove the blue.

Default settings are quite hardcore, everything is way too red for me.
If you read text it's okay but watching a movie or just picture or even playing games becomes way too redish.

I launch this tool directly through sway's configuration.

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id redshift -t 5700:3500 -m wayland -l XX.XX:YY.YY

</details>

Et voilà !

Nearly working in fact.
You'll need a [forked release of Redshift](https://github.com/minus7/redshift) to make it works with Sway.

Even with those settings, watching a movie is quite disturbing but don't despair, there is a small lua script to give to **mpv** which can toggle redshift automatically.
Put [this script](https://git.sr.ht/~q3cpma/dotfiles/tree/master/.config/mpv/scripts/redshift_toggle.lua) in *~/.config/mpv/scripts* to enable it and that's all.

## Pulseeffects
During the french containment, I migrated to **PulseAudio** one of the thing from the infamous Lennart Poettering.
I hate all its ecosystem, i hate its way of working, i only need it for one feature.
I have one sound card with only one audio output used.

Alsa works perfectly fine for me.
The tiny thing i wanted was **PulseEffects** which can add effects in realtime to your audio output.
I have good speakers but these are sound monitors so they produce a very neutral sound and i want my sound louder.

I use this tiny soft to greatly enhance the sound by increasing basses.
But, wow, this soft is quite hellish.
It's made with GTK, requires dbus, uses dconf… all those shitty things i hate.

To launch it without opening a window i use sway's config.

<details><summary>~/.config/sway/config</summary>

exec --no-starstup-id pulseeffects --gapplication-service

</details>

You still need to configure it the first time and beware not to launch it twice…

To prevent crackling sounds be sure to lower the volume to ~80%.

## Swayidle
By default, **sway** doesn't provide any way to turn on a screensaver or a way to stop the screens.
If you let you computer run while you are away, you may consider using this to slightly decrease your power consumption.

**Swayidle** is a tiny tool which lets you scripts things to do on predefined events.
If like me you don't use systemd, you can only use *timeout* and *resume* events but it's enough in my case.

After 10 minutes of idling, i switch off my screen and switch it on when i wake the computer.
Basic but that's what i prefer.

Once again, it's done through sway's configuration.

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id swayidle -w timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'

</details>

It's possible to add multiple actions to events or with different timeout values.
That way you could turn your screen of then some minutes later turn the whole computer off.

This tool is packaged with sway on most linux distros.

You'll notice that **mpv** is a good citizen : this good boy will prevent swayidle to consider your computer as idle.
**Qutebrowser** on the other hand … no.
When it plays a video, it won't prevent swayidle to trigger its event.
The workaround is to tell sway to inhibit the idle timeoute when **Qutebrowser** is in fullscreen (playing a video).

<details><summary>~/.config/sway/config</summary>

for_window [app_id="org.qutebrowser.qutebrowser"] inhibit_idle fullscreen

</details>

## Bemenu
When i used i3 in the old X11 world, i used the popular **dmenu** from the [suckless](http://suckless.org/) team.
Like most of their tools, it's a very handy and well crafted software quite minimal but it will probably never leave X11 (there are some forks…).
I needed the same thing but wayland native.

I choose a small new one : [bemenu](https://github.com/Cloudef/bemenu) and i like it well.
Even the default colorscheme suits me well.

I use it to launch softwares, to change the music, to get my passwords, to watch movies.
One nice feature is being able to launch it with every settings in many flags, no need to have a configuration file.

<details><summary>exemple d'appels via sway</summary>

bindcode $mod+26 exec "bemenu-run --fn 'Liberation Mono 17'"
bindcode $mod+27 exec "passmenu -l 10 -p 'Pass :' -fn 'Droid Sans Mono-15' -nb '#322'"

</details>

<details><summary>/usr/local/bin/mpdmenu</summary>

#! /bin/sh
mpc listall | bemenu -i -l 40 --fn 'Droid Sans Mono 26'| mpc insert

</details>

{{< img src="mpdmenu.png" alt="le haut de l'écran affiche la recherche et le bas tous les morceaux de musique correspondant" title="It's not pictured here but you can fuzzy search everything." >}}

KISS

-------------

That's it for now.
Everything is lite except Pulseeffects.
I'd love getting rid of it though.

Let me know if you know other little tools to improve the user experience (beware, i'm very picky).
