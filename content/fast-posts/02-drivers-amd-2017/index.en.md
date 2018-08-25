+++
Author = "Lord"
Description = "AMD just opensourced another piece of their graphic stack"
Categories = ["opensource", "linux"]
Tags = ["opensource", "linux"]
menu = "main"
notoc = true
noread = true
PublishDate = 2017-12-14T17:02:52+01:00
date = 2017-12-14T17:02:52+01:00
title = "AMD Graphic Drivers 2017"
+++
In 2007, AMD adopted a new strategy about their graphics drivers after their ATI acquisition. They decided to help opensource graphics drivers developers by releasing a lot of documentation.

A few years later they helped more by dedicating some of their devs to the opensource driver.

Again, they later adopted a new architecture where their proprietary driver and the opensource one share the same kernel module to mutualize devs efforts.

What did they just do ? They opensourced their Vulkan implementation. There is now two opensource implementations available for radeon users. The historic one in mesa whose performance are still far from optimal but fully functional. The new one from AMD burrow a lot of code with their Window's vulkan implementation.

They also released a new installer which let user choose which parts they want to install : you can mix proprietary and libre. What to expect more ? (nVidia ? Would you do the same ?)

## And in Gentoo ?

I recently replaced my old radeon 6950 with a radeon rx580. To do this i edited */etc/portage/make.conf* to change the right variable **VIDEO_CARDS="amdgpu radeonsi"** , then **emerge -uDnav @world** the last thing to do is putting the new firmware in */lib/firmware* and edit */usr/src/linux/.config* to add it :
```
CONFIG_EXTRA_FIRMWARE="amdgpu/polaris10_ce_2.bin amdgpu/polaris10_ce.bin \
amdgpu/polaris10_k_smc.bin amdgpu/polaris10_mc.bin amdgpu/polaris10_me_2.bin \
amdgpu/polaris10_me.bin amdgpu/polaris10_mec2_2.bin amdgpu/polaris10_mec_2.bin \
amdgpu/polaris10_mec2.bin amdgpu/polaris10_mec.bin amdgpu/polaris10_pfp_2.bin \
amdgpu/polaris10_pfp.bin amdgpu/polaris10_rlc.bin amdgpu/polaris10_sdma1.bin \
amdgpu/polaris10_sdma.bin amdgpu/polaris10_smc.bin amdgpu/polaris10_smc_sk.bin \ 
amdgpu/polaris10_uvd.bin amdgpu/polaris10_vce.bin"
```
And voilà ! A kernel compilation and a reboot later and it's ok…
