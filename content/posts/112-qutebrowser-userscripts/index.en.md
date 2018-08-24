+++
Author = "Lord"
Description = "Using native javascript in Qutebrowser"
Categories = ["qutebrowser", "javascript","web"]
menu = "main"
notoc = true
PublishDate = 2018-07-01T09:45:56+02:00
date = 2018-07-01T09:45:56+02:00
title = "Userscripts in Qutebrowser"
editor = "kakoune"
+++
Qutebrowser is a [really nice browser]({{< ref "/posts/64-qutebrowser" >}}) but some points still lack while comparing it to the main browsers.
It's developpment is way slower than Chrome and Firefox because of it's smaller scale with way less contributors and no paid devs without any commercial entity behind it.
But it's still a good alternative with strong features if you are ready to accept little sacrifices.

One of the sacrifice is the lack of extensions.
But you can still add some userscripts.
These are small javascripts codes executing on webpages to change the website's behavior.

Originally it was created for the [Greasemonkey](https://www.greasespot.net/) plugin created in 2005 which has been deprecated in favour of [TamperMonkey](http://tampermonkey.net).
Nowadays, most browsers adopted a way to be compatible with these scripts.

## In QB
Qutebrowser is natively compatible with these *userscripts*.
To use them, it's really easy : **Put theme in ~/.local/share/qutebrowser/greasemonkey/** and voilà !

Nothing else to do, nothing to configure or else.

But you still need to relaunch Qutebrowser…

## Where to find'em ?
Multiple sites.

There is [Greasy Fork](https://greasyfork.org/en/scripts) which has a nice collections but i don't really like their interface.
A better site is [OpenUserJS](https://openuserjs.org/).

## Those I use

  - For Youtube, the best is [Iridium](https://github.com/ParticleCore/Iridium) which adds a ton of options.

I removed two others, one is now incompatible and another one was useless to me.
