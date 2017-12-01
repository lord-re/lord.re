+++
Author = "Lord"
Categories = ["tips","hardware"]
Tags = ["tips","hardware"]
Description = "Fixing an audio bug on an asus g50 laptop"
date = "2010-08-25T21:49:08+02:00"
title = "Ho hi !"
menu = "main"
nodate = true

+++
Hit me again I'm not dead yet ! I just fixed a long standing bug i was facing on an asus g50 laptop : outputting audio from the jack. It was really easy but never found out before.
I just added a line in */etc/modprobe.conf* : 
```options snd-hda-intel model=m51va position_fix=0

I admit this article won't be of a great help but my future me reinstalling a nunux will probably happy to find it.
