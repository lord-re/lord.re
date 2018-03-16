+++
Author = "Lord"
Description = "AMD vient d'opensourcer un peu plus de sa stack graphique"
Categories = ["opensource", "linux"]
Tags = ["opensource", "linux"]
menu = "main"
notoc = true
noread = true
PublishDate = 2017-12-14T17:02:52+01:00
date = 2017-12-14T17:02:52+01:00
title = "Drivers graphiques AMD 2017"
jdh = "https://www.journalduhacker.net/s/n3j0yb/amd_opensource_son_impl_mentation_de"
+++
En 2007, AMD a adopté une nouvelle stratégie concernant les drivers de cartes graphiques de sa récente acquisition, ATI. Ils ont en effet décidé d'**aider le développement de drivers opensource** en fournissant énormément de documentation qui s'est révélée précieuse. 

Quelques années plus tard ils ont poussé encore plus loin en **donnant même du temps** à quelques-uns de leurs devs pour participer aux drivers opensource.

Encore quelques années plus tard ils ont même adopté une nouvelle architecture où **le driver proprio et le driver opensource partagent une part commune dans le kernel** permettant de mutualiser les efforts.

Et qu'est-ce qu'ils viennent de faire il y a trois jours ? Et bhé ils viennent d'**opensourcer leur implémentation de Vulkan** (l'api graphique à la mode). Il y a donc désormais deux implémentations opensource possibles pour les cartes graphiques AMD. L'historique a été développé depuis deux ans maintenant. Elle est fonctionnelle mais ses performances ne sont pas encore optimales. La nouvelle made in AMD devrait avoir de meilleure performance cependant elle ne sera pas intégrée à mesa.

Ils ont également fourni une nouvelle version de leur driver avec un installeur permettant de facilement choisir quels morceaux on veut utiliser (proprio ou opensource). Franchement, qu'espérer de plus ? (nVidia ? ça serait gentil de faire pareil).

## Et chez Gentoo ?

J'ai récemment changé de carte graphique, je suis passé d'une bonne vieille radeon 6950 à une radeon rx580, la seule chose à faire sur ma ptite gentoo a été de changer le */etc/portage/make.conf* pour y changer la variable **VIDEO_CARDS="amdgpu radeonsi** , un ptit **emerge -uDnav @world** et poser le firmware dans */lib/firmware* et d'ajouter les noms de fichiers dans */usr/src/linux/.config* : 
```
CONFIG_EXTRA_FIRMWARE="amdgpu/polaris10_ce_2.bin amdgpu/polaris10_ce.bin \
amdgpu/polaris10_k_smc.bin amdgpu/polaris10_mc.bin amdgpu/polaris10_me_2.bin \
amdgpu/polaris10_me.bin amdgpu/polaris10_mec2_2.bin amdgpu/polaris10_mec_2.bin \
amdgpu/polaris10_mec2.bin amdgpu/polaris10_mec.bin amdgpu/polaris10_pfp_2.bin \
amdgpu/polaris10_pfp.bin amdgpu/polaris10_rlc.bin amdgpu/polaris10_sdma1.bin \
amdgpu/polaris10_sdma.bin amdgpu/polaris10_smc.bin amdgpu/polaris10_smc_sk.bin \ 
amdgpu/polaris10_uvd.bin amdgpu/polaris10_vce.bin"
```
Et voilà, une recompil du kernel et après c'est tout bon…
