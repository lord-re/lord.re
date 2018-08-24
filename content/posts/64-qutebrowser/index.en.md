+++
Author = "Lord"
Categories = ["web","www", "software", "qutebrowser"]
Description = "Qutebrowser is a Python/Qt web browser using webkit/blink. You'll browse the web like you edit in vim !"
Tags = ["www","web", "software", "qutebrowser"]
date = "2017-11-08T16:03:10+01:00"
menu = "main"
notoc = true
title = "Qutebrowser"

+++

It's been some months now that i migrated to Qutebrowser. It's a small web browser not so popular which differentiate itself not by it's engine (but in fact yes a bit !) but thanks to it's user interface. It's clearly not intuitive but it's blazingly fast and efficient !

## Web engineS

Qute can use many engines. First there is the good old webkit in it's Qt flavor. But this one is on the road to deprecation Then you can use webkit-ng which is the direct successor. More or less the same thing… Finally you can choose qt-webengine.

You may not know this one but in fact it's Blink the google made chrome webengine but in a qt flavor. That's the one i choose.

## The User Interface

The main advantage of QuteBrowser (or just Qute or QB) is it's interface. It's inspired by famous firefox's addons : Pentadactyl and Vimperator. The idea is to ditch most of the visible interface and to rely on keybindings and commands from vim. You can now throw your mouse away and sit confortably with your keyboard !

All your interactions will use the keyboard. The only remaining graphic interface is the *status bar* on the bottom where you have the actual URL, the scrolling percentage, and the tabs.

{{< figure src="qute1.png" title="Qutebrowser's interface showing the french version of my blog" alt="screenshot of qutebrowser" >}}

As you can see, it's quite minimalist.

All your interactions will be the same as in **vim**. You'll use the famous ***hjkl*** (i don't use them as my keyboard layout doesn't match at all) to move yourself. The ***G*** and ***gg*** to go directly to the beginning/end of the page.

One crucial thing is ***f*** which will let you *hint* all the links. It will add a small label on every links you'll have to type to open the corresponding link. In my case, i changed the mode to *number* (**:set hints.mode number**). I now just type **f** then i enter some letters of the link's text and if there is only one match it's done. If there is more than one, i just type the number of the label and it's good.

{{< figure src="qute2.png" title="Hint mode" alt="qutebrowser screenshot showing the hint mode" >}}
{{< figure src="qute3.png" title="After i typed home" alt="qutebrowser screenshot showing the hint mode" >}}

It may seems slow and counter-intuitive at first but after a couple hours you'll never go back. It's way faster than the traditionnal system especially if you are already a vimist.


## Using it

### Text edition

Like vim, Qute is modal. By default you are in *normal mode*. If you go to a text field (with ***f*** or by clicking), qute will automatically switch to *-- INSERT MODE --* but sometimes it doesn't (thanks js) so you must manually press ***i***. If you are on a page using hotkeys, you'll have to manually go to this mode too.

It's nice and all but you edit something longer than usual like a wiki page or a mail will you really write it on your browser ? Nahhh. You'll use vim ! In a text field press ***^e*** and your favorite (vim of course (or maybe emacs (really ? nano ?!))) will spawn. Once saved and closed all your text will appear in qute by magic ! (To change the editor **:set editor.command '["alacritty", "-e", "vim", "{}"]'** ).

### Thee status bar

Like in vim, you can launch commands with **:** . For example : **:set content.javascript.enabled false** or i don't know **:view-source** … There is a good autocompletion system.

It's also here that you'll type your searches and url. You can launch **:open your search** or **:open lord.re** or just type ***o*** then your url. If you want to edit the current url it's ***O***.

### Search engines

By default, if you type a string of text which isn't an url it will search your string in your default search engine.

But you can add other search enginges which you can choose by typing their character. For example i use a lot **:open w linux** to open the wikipedia page for *linux*. And also **:open y slayer** to open the youtube's results for *slayer*. To configure Qute like this just **:set url.searchengines '{"DEFAULT": "https://duckduckgo.com/?q={}", "w": "https://fr.wikipedia.org/w/index.php?search={}", "y": "https://www.youtube.com/results?search_query={}"}'**

### Settings

As we've see in the articles, you can edit settings with **:set your.setting** . It's really fast but sometimes you won't find what you want. To see every settings available you can open [qute://settings](qute://settings).

### Tabs

Tabs are called buffers (as in vim). As already [explained in 2012](https://lord.re/en/posts/22-bureau-moderne/), i don't use tabs but only rely on windows. I manage them with my window manager. Qute is well thought and provide you a nice way to enable this with **:set tabs.tabs_are_windows** which is the most explicit settings of all :-)

## Conclusion

It's a really good web browser wich can replace vimperator without too much troubles. Some features aren's already here but they will come and now you can do 90% of what you did in vimperator. It's a young browser made by a young coder. It's community is growing slowly and its irc channel is very welcoming and active.

Future evolutions are quite promising. The main dev wants to add a way to have per-domain settings. The ultimate goal is to be able to replicate uMatrix which is the only addon i miss from Firefox.

 


  - The [official github repo](https://github.com/qutebrowser/qutebrowser/)
  - The [official website](https://www.qutebrowser.org/)

## Tips concerning videos

I don't like watching videos inside the web browser but i'm a big watcher of tv replays from arte or youtube videos and sometimes twitch's streams. What i do is open the web page then ask MPV to open the page to play the video with ***m***.

I also added an *hint mode* to open the page with MPV instead of qute with ***Fm***.

**:set bindings.commands ‘{“normal”: {“F”: null, “Fm”: “hint links spawn –detach mpv {hint-url}”, “m”: “spawn –detach mpv {url}”}}’**
