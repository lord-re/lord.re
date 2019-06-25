+++
Author = "Lord"
Description = "L'installation par défaut l'Alpine Linux vient avec toute une tripottée de firmwares inutiles (au cas où). Par chance on peu s'en débarasser facilement avec un simple apk add linux-firmware-none."
Categories = ["linux", "alpine", "adminsys", "tips"]
menu = "main"
notoc = true
PublishDate = 2019-06-25T22:01:16+02:00
date = 2019-06-25T22:01:16+02:00
title = "Se débarasser des firmwares en rabe dans Alpine"
editor = "kakoune"
+++
Allez un micro-article des plus rapides.

Vous connaissez **Alpine Linux** ?
C'est l'une des meilleures distros du moment.
L'une de ses forces et sa légèreté.

Ça s'installe très vite, ça prend très peu de place, son administration est vraiment légère.
Par contre, si vous prenez l'install de base pour faire une VM (enfin c'est pas spécifique au VM à proprement parlé, hein), vous allez remarqué qu'il y a quand même pas mal de trucs installés.

Et quand je dis trucs, je veux parler des *linux-firmware-X* qui servent à faire fonctionner du matériel.
Il y a fort à parier que vous n'avez pas besoin de tout ce qui est pré-installé.
Dans ce cas-là, il suffit de faire un ptit coup de **<samp>apk add linux-firmware-Y</samp>**.

Bon, il faut savoir de quels modules vous avez besoin et là… bha faut connaître votre machine.
En faisant ça, cela supprimera tous les modules sauf ceux que vous avec explicitement choisis.
Mais si vous n'en avez besoin d'aucun, il vous suffit d'installer le paquet virtuel avec **<samp>apk add linux-firmware-none</samp>** et voilà.

Voili voilou.
À chaque fois je cherche le nom de ce paquet magique, maintenant je le retrouverai plus facilement.
