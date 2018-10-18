+++
Author = "Lord"
Description = "À chaque nouvelle version majeure du kernel Linux je me fait une joie de mettre à jour et de reluquer un peu les nouveautés. Voyons dans le détail comment je m'en démerde."
Categories = ["linux","cli"]
menu = "fast"
notoc = true
draft = false
PublishDate = 2018-07-27T11:43:00+02:00
date = 2018-10-18T16:43:00+02:00
title = "Rituel à chaque nouveau kernel"
+++
Dans plus très longtemps maintenant, on va passer à Linux 5.0.
Bon c'est pas une version plus majeure qu'une autre… c'est juste que … c'est chiant de compter à plus de 20, donc autant repartir au dessus à zéro.

Bon donc à chaque nouvelle sortie du kernel Linux, je m'empresse (keuf keuf) de mettre à jour.

Voilà donc mon petit rituel lors de la sortie d'un nouveau kernel !

  1. Récupération des sources
  2. Décompression et mise à jour du lien symbolique
  3. Configuration des nouveautés
  4. Compilation
  5. Installation et test
  6. Mise à jour du bootloader

Activons donc le mode verbeux !

## 1. Récupération des sources
Et quel meilleur endroit pour récupérer les sources que d'aller à la source ?

Gogo **https://kernel.org**

Et là je me fais pas chier je prends le lien du *Latest Stable Kernel* en cours.

## 2. Décompression et Mise à jour du lien symbolique

**<samp>cd /usr/src/</samp>**
Je me fous dans le bon dossier.

**<samp>wget le latest</samp>**
Je télécharge donc le lien choppé précédemment.

**<samp>tar xvf *.tar.xz</samp>**
Je détarre le bousin.

**<samp>unlink linux</samp>**
Je supprime le lien symbolique pointant vers les sources du kernel précédent (on peut utiliser rm mais ça impressionne plus d'utiliser unlink !).

**<samp>ln -s linux-votre-latest linux</samp>**
Je crée un lien symbolique vers les nouvelles sources.

## 3. Config

**<samp>zcat /proc/config.gz > linux/.config</samp>**
Je récupère la conf du kernel qui tourne actuellement et je la fous dans les sources du nouveau.

**<samp>make oldconfig</samp>**
Et c'est parti pour voir toutes les nouveautés du kernel et à chaque nouvelle option il demande si je veux ou pas l'ajouter (généralement non, j'aime les kernels minimaux).
Il faut souvent chercher un peu sur le web à quoi correspond certaines nouveautés.

## 4. Compilation
**<samp>make -j32</samp>**
Bon bha compilation.

**<samp>su</samp>**
Pour la suite faut devenir le patron.

**<samp>make modules_install</samp>**
J'installe les modules kernels (j'en ai pas beaucoup mais ça les fout au bon endroit (*/lib/modules/la.version/*)).
Bon bha là c'est bon, enfin j'espère.
Des fois c'est pas si bon.

## 5. Installation et test

**<samp>mount /dev/sda1 /boot</samp>**
Je monte la partoche de boot.

**<samp>cp /arch/x86/boot/bzImage /boot/boot/kernelXXXX</samp>**
J'y copie le kernel tout juste sorti de la calculette.

**<samp>reboot</samp>**
Le reboot indispensable.

**<samp>e</samp>**
Pour interrompre Grub et éditer la ligne de boot, j'y change la version du kernel qui boot.

## 6. Mise à jour du bootloader
Si ça boot sans encombre il reste plus qu'à passer ça en dur.

**<samp>su</samp>**
Je remets mon cosplay de patron.

**<samp>mount /dev/sda1 /boot</samp>**
Je remonte la partoche de boot.

**<samp>vi /boot/boot/grub/menu.lst</samp>**
Et j'édite la conf de grub en changeant juste le nom du kernel que je boot.

Et voilà c'est fini.

Bon de temps à autre faut penser à virer les anciens kernels de */boot* et aussi les anciens modules dans */lib/modules* .
