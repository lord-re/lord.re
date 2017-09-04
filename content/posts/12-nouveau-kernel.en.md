+++
Tags = ["adminsys","linux"]
date = "2010-08-25T21:34:45+02:00"
title = "New kernel not for fun"
Description = ""
menu = "main"
Categories = ["adminsys","linux"]
nodate = true

+++
I just changed my kernel from an openvz patched 2.27 to a brand new 2.33.1. I also add some crucial options which where lacking : the *redirect target* for netfilter (yes i forgot it), then the *nfs server support* (to enhance my pxe) and the *kvm support* (instead of openvz). Stay entertained dear readers and keep having fun until next time on my future new CMS (aiming to run on less than 1MB of ram). :wq
