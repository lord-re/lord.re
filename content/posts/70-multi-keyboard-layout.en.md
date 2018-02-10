+++
Author = "Lord"
Description = "How to configure Xorg to have multiple keyboard layouts on multiple physical keyboards ?"
Categories = ["linux", "xorg","keyboard","bépo"]
menu = "main"
notoc = true
PublishDate = 2018-01-31T21:18:40+01:00
date = 2018-01-31T21:18:40+01:00
title = "Multi keyboard layouts in Xorg"
+++
I really like keyboards. I often plug multiple keyboards on my computer… at the same time. It's a bit pointless but I like fiddling with keyboards. My main keyboard is in a slightly tweaked [bépo](https://bepo.fr) (a dvorak-style french layout) while most of the others are in azerty and even some in qwerty. So I configured *Xorg* to provide these features :

  - My main board must provide bépo, azerty and qwerty
  - Other keyboards must provide azerty, bépo, qwerty
  - Right Ctrl must be the **Compose** key
  - Ctrl-Alt-Backspace must kill the Xorg session
  - Left-Shift + Right-Shift must cycle the layouts

So all of this can be configured in */etc/X11/xorg.conf* . Some linux distros replaced this file with a folder containing multiple files to split the xorg.conf, find the one containing input devices.

	Section "InputClass"
        Identifier "evdev keyboard catchall"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        Driver "evdev"
        Option "XkbLayout"      "fr,fr,us"
        Option "XkbVariant"     "oss,bepo, "
        Option "XkbOptions"     "compose:rctrl,terminate:ctrl_alt_bksp,grp:caps_toggle"
	EndSection

	Section "InputClass"
        Identifier "Custom Keyboard"
        MatchIsKeyboard "on"
        MatchDevicePath "/dev/input/event*"
        MatchVendor "Lord_Corp"
        Driver "evdev"
        Option "XkbLayout"      "fr,fr,us"
        Option "XkbVariant"     "bepo,oss, "
        Option "XkbOptions"     "compose:rctrl,terminate:ctrl_alt_bksp,grp:caps_toggle"
	EndSection
	
As simple as that

## How does it work ?

So Xorg works with some *"drivers"* where one is **evdev** which must find all the input devices and configure them. It works by scanning */dev/input/* and reading each file corresponding to every input devices found by the kernel.

Depending on the type of a device (mouse/keyboard/tactile board/…) it will apply a different configuration. It does this thanks to **catchall** rules.

Evdev is generous as it lets you apply specific configuration to specific a device by selecting it with additional *match*. In my case, i pick the *Vendor* field (provided by the device) matching *Lord_Corp*.

### Where do I find matching criteria ?

Easy: ***xinput --list --long***
