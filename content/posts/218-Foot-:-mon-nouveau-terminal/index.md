+++
Author = "Lord"
Description = "Foot est un émulateur de terminal léger, rapide et complet disponible pour Linux. Il gère tout et bien, un bon remplaçant pour alacritty."
Categories = ["terminal", "linux"]
menu = "main"
notoc = true
WritingDate = 2021-05-03T18:17:42+02:00
date = 2021-05-03T18:17:42+02:00
title = "Foot : mon nouveau terminal"
editor = "kakoune"
TopWords=["terminal","alacritty","linux","cli","shell","url"]
+++
Il y a 170 posts de cela soit quatre ans (pfiouuu), je vous avais fait un ptit [tour d'horizon des émulateurs de terminal]({{< ref "/posts/48-emulateurs-terminaux" >}}).

C'était pas exhaustif hein mais j'abordais les principaux quand même.
Mais force est de constater que depuis il y a de nouveaux arrivants (certains étaient déjà là mais j'étais passé à côté).
Ça fait donc quatre ans que j'utilise [Alacritty](https://github.com/alacritty/alacritty) mais voilà maintenant deux mois que je lui fais des infidélités.

J'utilise désormais [Foot](https://codeberg.org/dnkl/foot) qui coche toutes les cases de ce que je recherche.
Il est *léger, rapide, simple, joli, visuellement minimaliste, supporte toutes les features modernes sans les conneries*.
C'est un projet assez récent mais le logiciel est déjà stable et donc utilisable.

{{< img src="terminal.png" alt="capture d'écran de foot" title="C'est dépouillé comme je l'aime" >}}

## Encore un ?

Il n'est *compatible que wayland* mais bon, on est en 2021 pourquoi supporter autre chose ?

Bon en vrai pourquoi je l'ai adopté ?
Une partie de moi voulait tester un peu autre chose et comme le terminal est le logiciel que j'utilise le plus, c'est de suite dépaysant.
Mais surtout deux petites fonctionnalités absentes de chez Alacritty m'ont titillé :

  1. Le daemon
  2. L'URL mode

### Daemon
C'est une feature qu'on retrouvait déjà dans l'illustre **urxvt** où l'on a en fait une architecture client/serveur.
En gros, on lance un daemon foot qui "ne fait rien".

Ensuite pour chaque terminal on ne lance qu'un client qui fera bosser le serveur.
Du coup chaque nouvelle instance est plus légère et démarre plus vite.

Ça bouffe un peu moins de ram par contre si le serveur se pète la gueule on perd absolument tous les terminaux.
Bon ça ne m'est pas encore arrivé mais ce jour-là je pleure.

Je ne vous cache pas que le temps de lancement d'un terminal me paraît instantané.
Mais bon j'imagine qu'avec un ordinateur moins puissant le gain peut être appréciable.

Il est dit que c'est potentiellement moins rapide à l'usage si on a un terminal qui fait bosser un peu trop le parser puisqu'il n'y a désormais plus qu'un parser mis en commun pour tout le monde.
En deux mois ça ne m'est pas arrivé non plus.

Bon cette architecture est facultative mais perso j'aime bien.

{{< img src="daemon-htop.png" alt="capture d'écran de htop où l'on voit le foot --server suivi de tous les shells" title="On va pas se mentir, dans htop c'est propre et j'aime ça." >}}

### URL mode
Quand dans votre terminal se trouve une URL, dans la majorité des émulateurs, il faut dégainer la souris et cliquer dessus.
N'est-ce pas barbare ?
Devoir utiliser le mulot c'est tellement [60s](https://www.youtube.com/watch?v=yJDv-zdhzMY) !

Alors qu'ici dans ce temple de la modernité, un simple <kbd>Ctrl-Shift-u</kbd> et hop !
Toutes les URL présentes dans la fenêtre se retrouvent affublées d'un ptit post-it avec une lettre.
Vous saisissez cette lettre et pouf ça ouvre l'URL dans votre navigateur.
Tout comme dans **Qutebrowser** !

{{< img src="url-mode.png" alt="exemple de ce mode en action" title="Et en plus on peut styliser le truc autrement mais par défaut ça me plaît." >}}

Ce truc est vraiment agréable à l'utilisation.

## Mise en place

Du coup je le lance via sway.

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id foot --server

bindcode $mod+36 exec footclient

</details>
Et voilà c'est tout comme il faut.

Bien entendu faut aller voir du côté de son fichier de configuration.
Il est tout commenté de partout comme il faut.
Perso je n'y ai pas touché grand-chose si ce n'est la police, et le navigateur et la modification d'un ou deux keybinds.
Vous aurez le fichier dans <samp>~/config/foot/foot.ini</samp> et voilà.

C'est pas la mer à boire et heureusement, ce n'est qu'un terminal après tout.

-----------

Voilà, n'hésitez pas à y jeter un coup d'œil si vous voulez un terminal/léger/rapide mais sans non plus être austère.
Il gère le redimensionnement de la police à la volée, toutes les couleurs possibles, le sixel (haha) bref tout ce qu'il faut.

