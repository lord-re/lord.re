+++
Author = "Lord"
Description = "Let's play with BTRFS multi devices."
menu = "main"
date = "2014-02-16T23:28:35+02:00"
title = "Multi devices BTRFS"
Categories = ["linux","software","adminsys","tips"]
Tags = ["linux","software","adminsys","tips"]

+++
As i'm sick this weekend, what's better than playing with virtual machines and BTRFS to heal ? I'll soon renovate my NAS and i'm considering using one BTRFS spread on multile devices. It means having one file system on multiple hard drives so your OS will only see one big contiguous space. And I'll be able to play with all btrfs features. :-)

## LVM RAID to the trash can
I know some of you will be triggered but i never really liked LVM and RAID. The new FS generation brought many features which make LVM and RAID irrelevant in many cases. Software RAID were invented to mimic Hardware RAID and brought some refinements but still suffered from the same flaws (checking parity of a 4TB hard drives can take days).
LVM was developped to bring flexibility to storage. Being able to move/grow/shrink a partition was awesome. I can't deny that. But BTRFS supports these features (from raid and lvm) without needing any userspace tools. BTRFS even go beyond : you can convert your raid type to another (from raid0 to raid1 or raid5 as an example (you still need free space to accomplish that)) without any downtime. One of the best feature is the bitrot prevention (we'll see later). It's smart enough to only check parity where there is real data which is way faster. You can add subvolumes, remove them, add a new device remove one on the fly.

The official wiki states that it's still not *stable* but many people already use it heavily.

## Multi-device : from one RAID to another
Let's start playing. In a VM, we will boot a well-made liveCD (sysrescueCD with its brand new linux kernel). We create a partition on the emulated hard drive then we add a second emulated hard drive.
```
mkfs.btrfs /dev/sda
mount /dev/sda /mnt/test
btrfs device add /dev/sdb /mnt/test/
btrfs filesystem show
… devid 1 … devid 2 …
```
There you see your two devices in only one fs \o/. Nothing especially magic for now but I still like this. Now we will add RAID ! Let's begin slowly with **btrfs filesystem df**.

This tool will show you available storage space (the real df doesn't work well with btrfs). It will also show you how space is occupied between *data*, *metadata* and *system* and which parity level is used (which raid type).
**btrfs balance start -dconvert=raid1 /mnt/test**

This is where the magic begins ! Mr Kernel will duplicate your data. After some time, you'll have a raid1 (only the data, not metadata).

**btrfs balance start -mconvert=raid1 /mnt/test**

**btrfs filesystem df**
And now you check that everything is in RAID1.

Now we will reboot with only one hard drive.

When booting you have a bright message asking you to read the *dmesg*. You must manually mount the system with the *degraded* option. It's okay, it boots. Now the thing to do is adding a new hard drive and rebuild the raid on it.

**btrfs device add /dev/sdc /mnt/test**

**btrfs device delete missing /mnt/test**

And voilà ! We could even play with raid0.

## Bitrot
Bitrot comes from your hard drives altering one bit or two silently. It's not very rare. Have you ever heard MP3 with strange sound spikes coming from nowhere ? Or pictures with strange colors on one part ? It may be bitrot. With aging hard drives it's getting more frequent.

On a classic RAID if your data is altered, the system won't notices it. Worse, it may even nuke parity and affects more files (even the whole FS if you are very unlucky). As a generous god, BTRFS will checksum every files and so detects bitrots. If you have enough parity it will automagically repair your files. It's easy to simulate in a VM. Choose on of your virtual disk and change some bits there and there (avoid the bootloader). It will boot. You'll have some messages in *dmesg* explaining wich blocks are repaired.

