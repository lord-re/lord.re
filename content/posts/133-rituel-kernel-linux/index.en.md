+++
Author = "Lord"
Description = "Each new major kernel release i upgrade it. I enable/disable the new options and all. Here's my little ritual."
Categories = ["linux","cli"]
menu = "fast"
notoc = true
draft = false
PublishDate = 2018-07-27T11:43:00+02:00
date = 2018-10-18T16:43:00+02:00
title = "My usual routine to update the Linux kernel"
+++
Soon we will have a brand new Linux 5.0.
It's not a real major release … it's just … easier to count from zero again rathen than higher than 20.

So each time there is a new release, i quickly (ahem) update it.

Here's my little ritual to upgrade to a new kernel !

  1. Get the source
  2. Decompress and update the symlink
  3. Configuring the new features
  4. Compilation
  5. Installing and testing
  6. Updating the bootloader

Let's be more verbose !


## 1. Get the source
Which better place to get the sources than the famous source ?

Gogo **https://kernel.org**

I just copy the link *Latest Stable Kernel* du jour.

## 2. Decompress and update the symlink

**<samp>cd /usr/src/</samp>**
I go to the right folder.

**<samp>wget le latest</samp>**
I download from the link from the first step.

**<samp>tar xvf *.tar.xz</samp>**
Let's decompress this shit.

**<samp>unlink linux</samp>**
Removing the old symlink (you can use rm but it's way more impressive to use this command !).

**<samp>ln -s linux-votre-latest linux</samp>**
I create the symlink to the new sources.

## 3. Config

**<samp>zcat /proc/config.gz > linux/.config</samp>**
First i get the actual config from the running kernel and i put it in the new sources.

**<samp>make oldconfig</samp>**
And now i ask the kernel to apply this config and it will ask question about any new feature to enable/disable them (most of the time, I disable; I love minimalism).
Often I need to search the web to know what are those.

## 4. Compilation
**<samp>make -j32</samp>**
I just compile.

**<samp>su</samp>**
I'm the one who knocks.

**<samp>make modules_install</samp>**
I install the kernel modules (i don't have many but they still need to be in the righ place (*/lib/modules/kernel.version*)).
It should be good now.

## 5. Installing and testing

**<samp>mount /dev/sda1 /boot</samp>**
Before continuing I must mount the boot partition.

**<samp>cp /arch/x86/boot/bzImage /boot/boot/kernelXXXX</samp>**
I then paste the brand new compiled kernel.

**<samp>reboot</samp>**
The mighty reboot.

**<samp>e</samp>**
To stop Grub from booting and edit the boot command line.
I just need to edit the name of the booting kernel to the new one.

## 6. Updating the bootloader
If it successfully booted then I hardcode it in the config.

**<samp>su</samp>**
I put on my boss cosplay.

**<samp>mount /dev/sda1 /boot</samp>**
I mount the boot partition again.

**<samp>vi /boot/boot/grub/menu.lst</samp>**
Then I edit the Grub config file with the correct kernel filename.

Et voilà, c'est bon.

From time to time I remove the old kernels from */boot* and I also remove the old modules in */lib/modules*.
