+++
Author = "Lord"
Description = "Here's how to enable javascript only on selected websites in a recent Qutebrowser."
Categories = ["web", "qutebrowser","javascript"]
menu = "main"
notoc = true
date = 2018-04-02T19:51:09+01:00
Publishdate = 2018-03-15T13:51:09+01:00
title = "Qutebrowser per Domain Settings"
editor = "kakoune"
+++
Starting with version 1.2, Qutebrowser added a really nice feature :

## Per-domain settings

You can now have global settings but on top of this having specific settings on a per-domain basis.
The first interesting thing to do is *being able to disable globally javascript but enabling it for selected websites*.

Your web browsing will become nicer.
Everything feel faster and snappier, more secure and with better privacy.
It's still not as good as good old uMatrix but still better than before.

The syntax of the setting is not the prettiest.
BUT, yes i wrote it with capital letters !
There is a new well-made shortcut for this.

First we *globally disable javascript* with **<kbd>:set content.javascript.enabled false</kbd>** .
Then on each page you want to enable js, you just **<kbd>tSh</kbd>** and you are done.

If you just want to enable JS ponctually but not to make this setting persisten across reboot, just press **<kbd>tsh</kbd>** (no capital S).

That's it.

## And with next releases ?
It's the first step of per-domain settings.
Future releases should add more settings.
One of the long term goal on the roadmap of Qutebrowser is to provides features close to uMatrix.
So more or less the same thing but with more controls and granularity and a nice gui.

I just use these settings for js but it's possible to do the same thing for images, plugins and other settings.
