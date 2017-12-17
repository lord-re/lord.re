+++
Author = "Lord"
Description = "The last 2017 Mozilla's drama concerning its SpyGlass addon"
Categories = ["news", "firefox","drama"]
Tags = ["news", "firefox","drama"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2017-12-17T10:43:22+01:00
date = 2017-12-17T10:43:22+01:00
title = "Last 2017 Firefox' Drama"
+++
Mozilla had a great year. Since Chrome's first release and its gigantic marketing (remember those video ads, giants billboards in all inhabited place, and all those links on Google's websites…), Firefox's market shares slowly diminished. But Mozilla is awakening and many of its efforts starts to show off.

Now Mozilla release “oxidized” Firefox (it means they are implementing more and more code written in Rust (rust… oxide… it's not my idea, it's semi-official)) and rebuild all its infrastructure with some trade offs. The biggest one is the end of all the ancients addon's API and the adoption of a new one : webextension. It's a big loss but it's for better stability and security. Many users felt betrayed and choose to change their browser (mainly to adopt browsers with the same new addons api than firefox ([ironic](https://media.tenor.co/images/231e2f67bc42bbfcff592d58f0e9517e/raw))), [me included]({{< relref "posts/64-qutebrowser.en.md" >}}). But finally the ultimate drama of 2017 is elsewhere.

## SpyGlass

Mozilla pushed to all Firefoxes a small unactivated addon. But if you accidentally go to **about:config** and change the right setting, to the right value, you could have activated this addon which adds headers and other references to [Mr Robot](https://en.wikipedia.org/wiki/Mr._Robot). Such a drama !

Seriously, if you are panicking because an unwanted addon has been auto installed but not activated without your consent you should stand back a little. ***You just have a self-updating browser (in most cases), which can add code you (probably) can't see (whereas you can see a new installed addon), which add code you can't remove (whereas you can remove an addon) and which is limited (whereas actual code can access your filesystem, network and hardware).***

Moreover, if your reaction is to adopt a closed-source browser (most other browsers), you expose yourself to the exact same thing but without all the advantages from an addon (security, restricted access, removability, discoverability) and you can add all the bad stuff that comes with closed-sources software…

I reckon Mozilla's attitude is pretty bad. No communication at all, it looks like an ad and/or hacking attempt. But it's far from all the closed-source problems.

 

-------

***PS***

Mozilla started communicating about it in [its knowledge pase](https://support.mozilla.org/en-US/kb/lookingglass).
