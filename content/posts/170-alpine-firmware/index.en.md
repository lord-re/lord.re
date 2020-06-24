+++
Author = "Lord"
Description = "The default Alpine Linux installation comes with many unneeded firmwares installed (just in case). Luckily, they can be easily removed with a simple apk add linux-firmware-none."
Categories = ["linux", "alpine", "adminsys", "tips"]
menu = "main"
notoc = true
PublishDate = 2019-06-25T22:01:16+02:00
date = 2019-06-25T22:01:16+02:00
title = "Getting rid of unneeded linux firmwares in Alpine"
editor = "kakoune"
+++
A real quick post today.

You probably know **Alpine Linux**, no ?
It's one of the best linux distribution for now.
One of its strength is its really small weight.

It's very fast to install, take very few storage, and can be easily run.
But, if you use one of the many default setup to use as a virtual machine (that's not really specific to VM) you'll notice that there is a lof of preinstalled things.

I'm talking specifically about all the *linux-firmware-X* which allows Alpine to run on your hardware.
You'll probably don't need most of them.
At most you'll really need two or three.
In this case, all you need to do is a small **<kbd>apk add linux-firmware-Y</kbd>**.

You'll have to know your which firmwares are required so … know your hardware.
By doing this, you'll remove all firmware except those you explicitely choose.
But what if you don't need any firmware ?
Well, you'll just **<kbd>apk add linux-firmware-none</kbd>** and you're done.

There there.
Each time i install Alpine i can't remember this package.
Now i'll recall !
