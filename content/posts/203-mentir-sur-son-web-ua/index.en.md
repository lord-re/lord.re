+++
Author = "Lord"
Description = "Web browsers identify themself with a user-agent string they give to servers. Most of the information in this string are wrong but are kept for historic reasons. It was put there because of bad websites relying on these to display correctly. Can we start over now in 2020 ?"
Categories = ["web", "culture"]
menu = "main"
notoc = true
WritingDate = 2020-05-25T10:17:55+02:00
date = 2020-05-29T10:17:55+02:00
title = "Should we keep on lying concerning our User-Agent string ?"
editor = "kakoune"
+++
The **User-Agent** is a software used by an user (Thanks Captain).
In this article, we'll talk about web browsers.

## Some User-Agent in the wild
When you are wandering, you don't know it but you tell every website which web browser you are currently using.
But it's not clear and simple nor very logical.

### Firefox
If you use **Firefox** you won's send <kbd>Firefox 77</kbd>, no no.
Instead you are sending <kbd>Mozilla/5.0 (<abbr title="Wich operating system you are running under the hood">Windows NT 6.1; WOW64; rv:77.0</abbr>) <abbr title="Geck is the rendering engine used by Firefox">Gecko/20190101</abbr> Firefox/77.0</kbd>

It's not ultra obvious but it's basic informations.
It tells the web server which OS you are using, which browser and it's rendering engine.
It's quite logical.

### Safari
If you use **Safari** on a Mac, here is what you may send : <kbd><abbr title="This is wrong but it's here for historic reason. It's required to be compatible with some websites">Mozilla/5.0</abbr> (<abbr title="The underlying OS.">Macintosh; Intel Mac OS X 10_9_3</abbr>) <abbr title="The rendering engine is Webkit">AppleWebKit/537.75.14</abbr> (<abbr title="Webkit was forked from KHTML which was a rendering engine made by the people behind KDE. This information is not so true but not so wrong. It doesn't bring any useful information.">KHTML</abbr>, <abbr title="This means that the rendering engine works like Gecko from Mozilla. This is again something put here for historic compatibility reasons.">like Gecko</abbr>) Version/7.0.3 Safari/7046A194A</kbd> .
It's getting messy with nearly half the information wrong or just not up to date but still present.

### Chrome
If you are one of those most evil users relying on the real **Chrome** on Windows you'll send this :
<kbd><abbr title="Like Safari, this is wrong but here for historic reasons.">Mozilla/5.0</abbr> (<abbr title="The OS your are running.">Windows NT 10.0; Win64; x64</abbr>) <abbr title="This was true until 2013 when Google forked Webkit to create Blink the actual rendering engine.">AppleWebKit/537.36</abbr> (<abbr title="Let's be clear : chrome use Blink which was forked from Webkit in 2013. Webkit forked from KHTML in 2003 i think, so this really ancient irrelevant information.">KHTML</abbr>, <abbr title="They still announce that their rendering engine behaves like Gecko from Mozilla.">like Gecko</abbr>) <abbtr title="This is true !!!">Chrome/70.0.3538.77</abbr> <abbr title="This is fake !!!">Safari/537.36</abbr></kbd>
This is pure bullshit.
Most of what Chrome send is wrong.
It mentions Firefox, Safari, KHTML, so most of the rendering engines.
Each evolution is a new cruft on top of existing crufts.

### Edge
You want to laugh a bit ?
Here is what a modern **Edge** (a browser from a small startup) :
<kbd>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.19582</kbd> .
Over the top !
What will we get in 20 years ?!

## But why ?
If you wonder why do browsers identify themselves like this you would have to go back in time.
Not so long ago, many websites used tricks to build their pages instead of using standardized components.
So to display correctly, they tried to detect browsers and adapted their content based on this information.

But web browsers evolved quite fast and mimicked each other, so they tried to guess the logic behind the detection to trick the website to force them to send the content for another browser…
It escalated…

## So what ?
I already wrote a blogpost (in french, sorry) about this [here](https://lord.re/shares/13-browser-user-agent/).
So why another one ?
Just because i like to write (true story).

I chatted about this on IRC the other day, so i wanted to know.
In the blogpost, I finished  with a Norman answer : "maybe yes, maybe no" to the question “Can web browser be honest and send a simpler User-Agent String ?”
So, i wanted to try to answer this.

I configured my web browser (the mighty [Qutebrowser]({{< ref "posts/64-qutebrowser" >}}) ) to send a custom string : <kbd>Qutebrowser</kbd>.
Only this, no convoluted things.

## Will it browse ?
Guess what ?
Everything works.

Everything ?
No !
Somewhere on the World Wild Web lies a small company providing some websites refusing to adopt best practices about web development.
You may have heard of these websites.

There is **Youtube** which is a small site providing multimedia content.
There is also **Google Maps** a web mapping service.
We should forgive this small team of devs trying to do their best to stay relevant in this fast moving world.

*I'm not saying that every other website works perfectly, but it's been one week of daily browsing and i didn't encounter any other website behaving strangely due to this user-agent.*

When using Youtube, its look is a bit different.
It looses the dark mode and the livechat for videos providing it.
With the exact same web browser with just its real user-agent string, it works perfectly.
So, it's not the browser behaving badly, it is just the website being coded like this.
They may just be not skilled enough or their intentions are maybe a bit evil.
In Google Maps, i loose the ability to display the 3D satellite view.
*Coming from the biggest company on the web, which also make the most used browser, is it really incompetence or malice ?*

## What do I do now ?
I'll keep my honest custom user agent string and will lie to Google only.
If you want to do the same with **Qutebrowser** :
<details><summary>~/.config/qutebrowser/config.py</summary>
<kbd>config.set('content.headers.user_agent',"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36", '*://www.youtube.com/*')</kbd>
</details>
Et voilà.
