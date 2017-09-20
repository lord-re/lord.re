+++
Description = "A small tip to avoid filling your host partition when you forgot to mount a fs."
date = "2017-08-16T15:49:41+02:00"
title = "Keep rsync from filling an unmounted partition"
menu = "main"
Categories = ["linux","software","tips","cli"]
Tags = ["linux","software","tips","cli"]

+++
Rhaaa Linux and it's filesystem hierarchy. That's so good !

Rhaaa Linux and of it's mounting point system. That's so good !

I love these features. For real ! That's no sarcasm nor ironny or typos. It's a great thing to being able use many mount points. Having lots of different filesystems on many devices. That's so flexible. There is just a little wart on the face.

When you have an automated script running regularly to backup many things from many machines on an unmounted external hard drive disk… you have to clean everything and mount the said hdd. Then you restart the script. That's not very difficult or else but it takes some time and can wreck havoc if the host partition gets saturated.

So now you want to know the secret everybody's talking about ? It's just easy and elegant : **chattr +i /storage/backup**. Thats's all. The mount point is immutable. Even root can't write on it. But you still can mount a fs on it ! Perfect. You still have to make sure that your backup are done.

I found this trick while browsing HN comments (a real gold mine)…
