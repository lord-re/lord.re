+++
Author = "Lord"
menu = "main"
Categories = ["gentoo","adminsys","tips","portage"]
Description = "Emerging gentoo ebuild when your toolchain is broken"
date = "2011-08-25T22:05:17+02:00"
title = "Hack^wFixing some Gentoo."
nodate = true
+++
Imagine that by some pure randomness you were to use a poor abandonned Gentoo. You want to update it and you find yourself in a state where glibc can't be emerged for whatever reason. So you have to find a way to fix this. How ?

## Here comes the other friendly Gentoo
You'll have to involve another Gentoo to build your package and then install on the broken one.

Your two gentoo must have the same cpu architecture (if not you'll have to cross-build but I won't address this here). It's easier to have the same *ACCEPT_KEYWORDS* but you can still fiddle everything to make this work.

On your sane Gentoo you need to **emerge category/package --buildpkgonly**. It won't be installed on the system but placed in */usr/portage/package/category/package.tbz2*. You now have to transfers on the good old gentoo in the same path. On the poor gentoo now try **emerge category/package --usepkgonly** and it should be good.

You now have a working toolchain and can build locally everything. :-)
