+++
Author = "Lord"
Description = "Let's see how to improve your ZSH skills. ZMV will let you bulk rename files."
Categories = ["cli", "shell"]
menu = "main"
notoc = true
PublishDate = 2018-08-23T17:43:55+02:00
date = 2018-08-26T21:43:55+02:00
lastedit = 2018-08-26T22:17:32+02:00
title = "Farther in ZSH : ZMV"
editor = "kakoune"
+++
Ordinary people like their desktop environment but as a beard holder, i prefer a plain old dark terminal.

You probably know the **<samp>mv</samp>** command which lets you **m**o**v**e a file.
Most of the time it's ok, but sometime you may have a lot of files to rename with some common parts.
And now starts hell.

You'll be able to bulk rename many files with some fancy options thanks to our beloved **ZMV** !

Here is a classic example where you want to rename a prefixed file :
<figure>

| Original | ▶ | Renamed |
|:-:|:-:|:-:|
|XXX-file1.jpg| ▶ |YYY-file1.jpg|
|XXX-file2.jpg| ▶ |YYY-file2.jpg|
|XXX-file3.jpg| ▶ |YYY-file3.jpg|

<figcaption><h4>zmv 'XXX(\*)' 'YYY$1'</h4></figcaption>
</figure>
<p> </p>

As easy as ABC.

**<samp>zmv 'the_pattern_to_remove(*)' '$1-the_new_pattern'</samp>**

To be safe, you should first use **<samp>-n</samp>** which won't do anything except showing you the potential result.
There is also an interactive mode with **<samp>-i</samp>** where you need to acknowledge any edit.

Of course there are other options [documented](http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#index-zmv) but these two are the most needed.

The extra-bonus comes from the *globbing* and *modifiers* support from ZSH but i won't explain it now.
With these two features, it's possible to add criterias.
ex : **<samp>zmv '* *' '$f:gs/ /_'</samp>** will replace spaces by underscores.
I admit i can't recall this one but now I know i'll find it here each time i need it.

PS : To be able to use zmv you need to add **<samp>autoload -U zmv</samp>** in your *~/.zshrc*.
