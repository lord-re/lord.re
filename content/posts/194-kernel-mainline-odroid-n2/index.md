+++
Author = "Lord"
Description = "L'odroid N2 est une SBC très puissante mais fournie avec un kernel linux utilisant des blobs et assez ancien. Il est cependant possible depuis peu d'utiliser un kernel mainline. Je vais l'installer, c'est parti."
Categories = ["sbc", "odroid","kernel"]
menu = "main"
notoc = true
WritingDate = 2020-03-19T00:06:58+01:00
date = 2020-03-19T00:06:58+01:00
title = "Kernel Mainline sur Odroid N2 vol.1"
editor = "kakoune"
TopWords = [  "uart", "emmc", "uboot", "odroid", "mainline", "ordi", "sbc", "linux", "kernel"]
+++

L'odroid N2 est une petite <abbr title="Single Board Computer : comme les raspberry pi par exemple">SBC</abbr> très puissante.
C'est mon ptit serveur à la maison qui héberge une bonne partie de mes services.

*Elle utilise de base un vieux kernel blobbé.*
C'est un kernel linux qui a déjà pas mal de versions de retard et qui utilise des drivers proprios pour certains morceaux.
C'est cool ça fonctionne et tout, mais d'un point de vue évolutivité c'est vraiment pas cool.
Et niveau sécurité c'est pas top.

Mais j'avais entendu des rumeurs.
Des rumeurs comme quoi *il est maintenant possible de faire tourner cette petite bête sur un kernel mainline* sans blob.
Et ça, c'est la méga classe.
Un kernel mainline, ça veut dire un kernel normal, sans modif particulière, le truc classique sans modification.
C'est assez rare chez les SBC et je dois vous avouer que j'espérais très fort que ça soit effectivement le cas lorsque je l'ai acheté.

Chez [Hardkernel](https://www.hardkernel.com/) (le fabricant), contrairement à beaucoup d'autres, ils assurent pas mal le suivi de leurs bestioles et tentent autant que possible d'avoir un support mainline (sans hack, sans blob si possible).

Bref, avec ce temps libre qui s'offre à moi, j'ai voulu tenter l'aventure !

Bon j'ai commencé à la bourrin en choppant l'emmc, pour l'enficher dans son adaptateur microSD, que je fous dans l'adaptateur SD que je fous dans le lecteur usb de mon ordi.
Je colle un kernel que j'ai compilé en suivant des instructions, je trifouille le boot.ini.
Je serre les doigts et croise les fesses.
Je refous ça sur la board, je branche et je lance un ping en espérant chopper une réponse de sa part.

 

 

C'est long, là non ?

 

C'est ptet normal que ça prenne plus de temps pour booter que le kernel tout optimisé, non ?

 


Bon, j'arrête de me voiler la face, ça marche pas.

Bon je rechoppe l'emmc pour la coller dans mon ordi.
Là je vois, que le kernel peut décider de ne pas booter si il n'a pas un ptit argument qui va bien.
Bon, ça doit être ça.
Je reserre les doigts et recroise les fesses.

 

Bon bha ça n'a pas l'air mieux.

C'est pas possible cette méthode.
C'est du bruteforce débile à l'aveugle.

*C'est vraiment des manips que je ne maîtrise pas trop.*
Le monde ARM c'est bien gentil matériellement mais logiciellement c'est vraiment le Far West.
Il faut un kernel, éventuellement un initrd, mais surtout il faut rajouter un *dtb* ou *dts*, le bootloader c'est pas un bon vieux grub mais *uboot*.
On peut pas lui filer juste le kernel à l'arrache comme ça, il faut y faire une modif, puis charger ça a des adresses mémoires particulières.
Pour le moment c'est vraiment abscons pour moi.

J'ai la main sur à peu près rien, je suis bien loin de ma zone de confort.
C'est un échec, je m'avoue vaincu.

Allez, je refous le kernel d'origine et je remets le boot.ini comme il faut.
C'est dommage.
