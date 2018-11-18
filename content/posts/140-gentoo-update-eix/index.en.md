+++
Author = "Lord"
Description = "Since we can update the portage tree with Git, eix can't find the new packages. To solve this issue we must regenerate portage's metadata manually."
Categories = ["gentoo", "git"]
menu = "main"
notoc = true
PublishDate = 2018-11-18T17:02:14+01:00
date = 2018-11-18T17:02:14+01:00
title = "Updating metadata's portage cache while using git"
editor = "kakoune"
+++
Gentoo usually use *rsync* to upgrade the Portage tree but it's now possible to use *git*.
It's way faster because instead of reading the whole tree to see the differences between the local tree and the remote one, you just need to transmit the commits since the last update.
It uses less bandwidth, less IO.

But when you do this, you won't have the tree's metadata.
It may be a problem if, like me, you use **eix** to get informations concerning local ebuilds.
So, even if you update with **<samp>emerge --sync</samp>** or **<samp>eix-sync</samp>** you won't have the updated informations in eix.

You have to manually update the metadata cache with **<samp>egencache --jobs=8 --update --repo=gentoo</samp>**

It may take a lot of time.

The time to synchronize you tree will be shorten but the time required to update the cache will be way bigger.
That's why I don't do it each time i update Portage.
As I closely track the new packages in Portage with RSS, I more or less know what's coming inside the tree so I only update it when something interesting get in.

