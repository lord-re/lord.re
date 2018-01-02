+++
Author = "Lord"
Description = "Monoculture is never a good thing and this time CPUs will suffer in this 2018's beggining"
Categories = ["news", "drama","hardware"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-01-02T22:05:14+01:00
date = 2018-01-02T22:05:14+01:00
title = "Monoculture disaster in the CPU world in early 2018"
+++
Monocultures proved multiple times they were risky not only in the IT world. When you plant only one type of vegetables, you risk losing everything when an insect or a disease chooses you. Today, time has come for Intel CPUs to suffer.

## Intel's monopoly
Intel is a leader in CPU for many decades and sometimes it becomes a monopoly. It's like this for at least ten years. AMD is just recovering thanks to its new Zen architecture after ten years of despair. Intel is alone in the server world (Xeon are everywhere) and only some left overs is shared to AMD in the laptop/desktop world. We can also notice that those last 7 years, CPU's performances stalled a bit. My current computer hasn't changed for six years and is still competitive today (but it's another story). The actual monopoly is a strong monoculture of Intel CPUs in the amd64 world.

## So what ?
Well, a security breach has been found. We still don't know everything as there is an embargo for now to let some time to the devs to publish patches. Apparently **every Intel systems are affected** (from the last 10 years).

This breach comes from a bug in the hardware architecture of the cpu. There is a patch for the linux kernel but it comes with a major drawback. There is a **5 to 50% performance loss** on some *syscalls*

We also now know that AMD isn't affected thanks to a [second patch](https://lkml.org/lkml/2017/12/27/2).

## Is it serious SERIOUS or just serious ?
It is ***SERIOUS***. This breach is exploitable on many levels. Virtualized systems are impacted. Apparently it can even be used through specially crafted javascript.

So, even a personal machine could be affected through a web page. Every VM hoster is probably patching as soon as possible.

We don't know for now every details but as usual we don't know if it's already used in the wild.

## What to do ?
Patch as soon as your OS release the update.

And for the next time, buy some AMD system to lessen the Intel monopoly. The new Zen architecture is performing more or less the same as Intel and you can have more cores for the same price.

## A bit more reading :

  - [The blogpost which started drawing attention on this](http://pythonsweetness.tumblr.com/post/169166980422/the-mysterious-case-of-the-linux-page-table)

  - [How to read kernel memory from usermode](https://cyber.wtf/2017/07/28/negative-result-reading-kernel-memory-from-user-mode/)

  - [Reddit thread on the subject](https://www.reddit.com/r/sysadmin/comments/7nl8r0/intel_bug_incoming/)
