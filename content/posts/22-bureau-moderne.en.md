+++
menu = "main"
Categories = ["libre","linux","ux"]
Tags = ["libre","linux","ux"]
Description = "Some thoughts about modern linux desktops. Which tools,philosohy to reach which goals."
date = "2012-07-22T22:17:39+02:00"
title = "A Modern linux desktop"

+++

Yes the title is quite pretentious and some would say a bit misleading. But, i just reinstalled a brand new Gentoo on my old laptop from 4 years ago. The small Arch which ruled just passed away (a sad update story about not using/updating it for some months) so this time i wanted to get back to my beloved Gentoo. No more traitor in my geekdom. A small fleet of Gentoo.

I reinstalled with a very similar approach to the one used on the desktop. I used PXE to netboot a debian. I took the opportunity to upgrade this debian too. Gnome3 isn't as crappy as i thought (at least not gnome-shell). After a bit of time using it, i think it can become quite handy. But stop blathering : Gentoo as a modern desktop.

## Gentoo ! What did you expect ?
First things first, **Gentoo**. Some rumors say it's slowing down but don't listen to this. It's false. Gentoo is still alive and well maintained. It's still on top and with nice features. It's awfully stable, it works like a charm, no surprise, everything is well sorted, the documentation is excellent and it's customisable as hell. Such flexibility ! There is a few preinstalled packages on a default installation. Everything can be replaced with another package. The package manager is a pure jewel which lets you add external repositories very easily (easier than in noobuntu). Well i think you now understand that i'm an accomplished fanboy.

I'm totally convinced that Linux (with it's gnus) is a perfect Operating System for a desktop (not to oppose to laptop but to server). Everything can be accomplished except gaming (actually we could quibble on this point as we can hack some things to make games runningè even if it's not perfect). This OS can run on nearly any hardware, it's hackable in everyparts of it. You can choose from many Desktop Environments. Where on other OSes you must fight to change a poor icon, here you change anything. It won't be everytime easy but you'll succeed if you read enough documentation. To build your perfect environment you'll have to work a bit and it's gonna take some time. You can even choose a linux distro which did this work for you. But you'll have to follow their choices. Either you do it yourself or you'll have to put up with their choices. It's a deal. Patience is a virtue, learning how to master a tool takes time and experience comes from investment.

## Modern Desktop
So, what's a modern desktop ? Well, i would say it's a digital environment that you have a total mastery on. Every aspect suits you and where no compromise has been made for a perfect satisfaction. Perfection is here when there is nothing more to remove. I want an OS where i can interact using the mouse but (and mainly) with a keyboard. Not relying on using the rat is something i've learned to love. I surprise myself grabbing the mouse for the first after some long hours of using the computer because of a poorly coded website.

Another capital point in ergonomy is a coherent set of keybindings between applications. I always try to keep the same logic between applications. For example to close the web browser i use Ctrl-Q. To close a window with the window manager i use Alt-Shift-Q to close a window and to shutdown the computer when i'm on the login manager. Every browser's keybindings use Ctrl. Every window manager's keybinding use Alt. As simple as that.

For now, all I do is using a web browser and using terminal applications. Nearly no graphical software on this machine. It looks quite rude and not so 2012 but in fact it's way more efficient. More and more web applications appear (webmail, video player, music player,…), it's nearly a full environment which lives in the Interweb. Morevore, drop you web browser's tabs ! Why bother with them ? You already have a window manager with all you keybindings and lots of possibilities to organize windows. Why would you restrict yourself with dumb tabs ? Less keybindings and more options to sort web pages. You'll be able to use tabs/stacks/tilings/floating with each page. And the adress bar ? Drop it ! How many time do you really need it ? When you want to open/edit an URL just press the required key and it's ok. No need to waste screen space with it.

So i've already talked about the browser, let's talk about the other elements of my perfect OS.

## Login→Windows→Terminal
Let's start with the login manager. I choose **qingy**. One of the smallest one. Very light but still powerfull. It can replace login/agetty/gdm/kdm/slim/orthos. It's has many advantages. It is light and doesn't require a lot of dependencies. It can output to a pure console or be more graphical. It doesn't rely on X but DirectFB so even if you broke your Xorg it will run flawlessly. It can launch graphical sessions or text sessions. It can remember the last logged user and launch X on the currently used tty so it's easier to have many X sessions simultaneously. It can even lock a X session when the computer is inactive for some time or when you change the active tty. This soft is close to perfection.

What comes next is the window manager (WM). I used **wmii** for quite a lot of time. It was a pleasant experience but it's exotic plan9's architecture was tiring even if it was intriguing. I choose one of it's successor : **i3**. It's the best of his kind even there is a lot of competition in the tiling wm niche. Is has everything you can expect. Light, fast, easy and it works ! You can have virtually any layout imaginable. You can stack windows, sort them as tabs, put them side-by-side, one on top of others, or mix all of this. And all this is done using your almighty keyboard. Cherry on the cake ? The configuration file is easy to understand with a straight forward syntax and explicit command names. You can add as many keybinding as you want to control you media player, you can add an info bar. You can specify if you want a 1px border on you window or a title bar or even nothing at all. Well it's the perfect WM.

To choose a terminal emulator it's easy. I need an unicode-aware terminal which is light, fast and rock-stable and if it's possible not ugly (i have my eyes 8h/day on it). I choose **rxvt-unicode** (urxvt for friends). It matches all my criterias and even has an exotic client/server architecture : urxvtd wait for urxvtc connections. One daemon which runs and many clients using it. Only one process for lots of terms.

## Web 3.5
For the webbrowser, I sometime use **surf**. It runs on gtk-webkit so it's modern but it has some drawbacks. I still prefer the good old **Opera** (12, the real opera, not the chrome-skin). I know. It's closed source. It's not libre at all nor opensource. But it is so fucking good ! Ultra customizable, light, does everything, always on par with web standards (or quite close), a lot of features.
I use it in a particular way : i removed all it's interface (it's chrome). No toolbar : no tab bar as I don't use them, no adress bar (I use a keybind), no status bar because i don't know what to do with it… For tabs i rely on i3. I set up Opera to only open one page per window. If can't stand a proprietary software you can use surf or maybe try **uzbl** or **vimprobable**, **pentadactyl** (gecko) but it wont be as moldable/good/easy.

So, I nearly wrote a novel but it's more… how to say ? … personal, bloggy, parabolic than usual. I think i ommited some things. Maybe I'll add more later.

***PS 2017 :*** I just translated this article and omg it's verbose but it's still ok by now. I still use Gentoo and qingy and i3. I recently switched to Alacritty instead of urxvt. I dropped Opera when they dropped the in-house webengine (presto). I used pentadactyl and vimperator on firefox for 4 years. I now use Qutebrowser as vimperator is dying becaus Mozilla decided to drop their old addon api (in fact i'm not sad at all, it's a good thing to do. I hope that vimperator will be remade with new api).
