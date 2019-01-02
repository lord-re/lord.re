+++
Author = "Lord"
Description = "Last weeks I reimplemented my irc bot in Golang. It was first built as a bash script using multiples tools. But the main goal was to use a way smaller environment."
Categories = ["irc", "golang","alpine"]
menu = "main"
notoc = true
PublishDate = 2019-01-01T21:43:01+01:00
date = 2019-01-02T16:43:01+01:00
title = "Gonib and its environment"
editor = "kakoune"
+++
Yesterday i plugged in GoNib and now it lives !

Yesteryear I wrote about [Nib]({{< ref "/posts/66-nib-irc-bot" >}}) my **N**ano **I**rc **B**ot.
It's my personal assistant which can't talk but at least it doesn't spy on me.
It let me do some more or less futile things through IRC.

This script was a pile of different tools glued with bash shell.
It worked well but i wanted a smaller and cleaner thing.
I decided to code it in Go those last weeks.

Et voilà ! GoNib !
It's still not complete but can do most of what I need now.
But this article is more about How I installed it and configured its environment.

## Compiling the code
I code it on my main machine which is a classic *amd64* computer but I intend to run it on a container in my router.
So the first thing to do is to crosscompile it to be able to run on an *arm7* architecture.
Golang is very well done for this : **<samp>GOARM=7 GOARCH=arm go build -ldflags="-s -w" gonib.go</samp>**.

You just need to specify the architecture thanks to the two environment variables.
Just for fun I added <samp>-s</samp> and <samp>-w</samp> to generate a smaller binary.
Not mandatory but it doesn't cost much.

## Creating the container
I'm still on my *Alpine Linux* vibe so I create a 3.8 container on my router.
Then I install **tmux**.

Then I create a service file to automatically start it at boot with this */etc/init.d/tmux* :

```
#!/sbin/openrc-run

name="Tmux Init"
command="/usr/bin/$SVCNAME"
command_user="nib"
pidfile="/var/run/$SVCNAME.pid"
command_args="new-session -d -n gonib '/home/nib/gonib -server=irc.geeknode.org'"

depend() {
        need localmount
}
```

You then need to put it in the default runlevel with **<samp>rc-update add tmux</samp>** and I also removed all other services except *crond* which will be used for planned actions (like birthdays, todo or else).

I then create the *nib* user with **<samp>adduser nib</samp>**.

I then upload the binary to */home/nib/gonib* and make sure it's executable.

## Launching the container at boot
In *OpenWRT* to start containers at boot time, you need to add them in */etc/config/lxc-auto* .

## Testing it
Let's do it !

**<samp>lxc-stop -n gonib</samp>**

**<samp>lxc-start -n gonib</samp>**

It works !

## Conclusion
Everything works for now \o/

I stopped nib for now but i keep it for now.
I'm pretty confident i won't need it.

The nib container used Debian and weight **384MB**.
The new one using Alpine just require **21.1MB** and only eats 10MB of RAM.

Less moving parts, less disk space needed, less ram.
It's a good optimization !

Now i just need to wait and see if it works.
