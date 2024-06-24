+++
Author = "Lord"
Description = ""
Categories = ["jeux", "sway"]
menu = "main"
notoc = true
WritingDate = 2024-06-24T19:08:00+02:00
date = 2024-06-24T19:08:00+02:00
title = "Débloquer les FPS dans les jeux à cause de Sway"
editor = "helix"
Audio = ""
Soustitre = ""
+++
Oui on peut jouer sous Linux.
Je le fais depuis des années.

Ça marche globalement plutôt bien.
Même sur une Gentoo avec quelques choix logiciels un peu exotiques, ça marche à peu près tout le temps.
Wayland, Sway, pas de systemd et pleins de ptits trucs plus ou moins signifiants qui sortent des sentiers battus.

Mais ces derniers temps j'avais un bug un peu chiant sur plusieurs jeux mais pas tous : les FPS étaient limités à 30.
Et ce alors que ma carte graphique peut débiter bien plus.
Mème en foutant tous les réglages graphiques au minimum.

Bref, c'est un bug logiciel mais j'ai jamais trop trouvé d'où ça venait.
Puis au détour d'une conversation IRC, j'ai un début d'idée !

Et si c'était Sway qui faisait quelque chose de bizarre ?

Allez je teste un truc.
Reload de config.
Lancement d'un jeu problématique.
Verdict ?
Ça marche !

Bon allez je vous fais pas plus attendre :

<details open><summary>~/.config/sway/config</summary>

output "*" max_render_time 5

</details>

<kbd>swaymsg reload</kbd>

Juste ça.
Ça impose sway de ne pas attendre plus de 5ms pour compositer sa frame.
Ça suffit à démerdouiller le bousin.

Si vous aussi vous avez certains jeux cappés à 30FPS ça vaut le coût de tester.
Ça prend 30s.

Voilà, à l'occasion de ces élections anticipées, c'est le bon moment de relancer **[Wolfenstein 2 : Youngblood]({{<ref "recap/30-janvier-2022/#wolfenstein-2--youngblood">}})** 
