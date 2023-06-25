+++
Author = "Lord"
Description = ""
Categories = ["sway", "wayland","ux"]
menu = "main"
notoc = true
WritingDate = 2023-06-25T13:57:26+02:00
date = 2023-06-25T13:57:26+02:00
title = "Amélioration de mon environnement nunux vol.3 : Multimonitor + Yambar"
editor = "helix"
+++
J'ai un second écran depuis peu.
Et comme j'ai plus d'espace et que j'ai par la même occasion plus de workspace, je me suis dit que je pouvais me permettre d'avoir une barre.
Ça y est, c'est le luxe, l'opulence.

J'ai donc adapté un peu ma conf **sway** pour gérer le multi-écran à ma convenance.

## Sway multi-monitor
Allez ne perdons pas de temps en palabre, voyons direct la conf !

<details open><summary>extrait de ~/.config/sway/config</summary>
{{< highlight config>}}
output HDMI-A-1 pos 3000 3000
output DP-2 pos 0 0

workspace 1 output HDMI-A-1
workspace 2 output DP-2

focus_wrapping workspace
exec_always sh -c "killall yambar; yambar ;"
{{< / highlight>}}
</details>

Déjà j'ai configuré les deux écrans de façon à ce qu'ils ne soient pas contigûs pour éviter de passer la souris d'un écran à l'autre sur les bords.

J'ai ensuite assigné les deux premiers workspaces aux écrans histoire que ça démarre toujours comme il faut.
Par contre si par la suite vous ouvrez un nouveau workspace, il s'ouvrira sur l'écran où vous vous trouvez.
Il y a un ptit coup de main à prendre.

Et ensuite je vous spoile la suite mais je fais en sorte de redémarrer **yambar** à chaque reload de la conf.

C'est tout.
Rien de plus à faire.

Oui c'est facile et rapide !

## Yambar
J'ai tout d'abord recompilé **Sway** avec le support de waybar.
Mais j'ai vite déchanté : il n'est pas possible de faire ce que je voulais.
En gros j'ai donc deux écrans, avec des workspaces sur les deux mais je ne veux la barre que sur un seul écran.
Et je souhaite que la barre liste les workspaces de tous les écrans et pas uniquement les workspaces de l'écran où s'affiche la barre.
Bref, **waybar** ne sait pas le faire du coup j'ai cherché dans la myriade d'alternatives.

J'avais quelques exigences : le moins de dépendances (ça dégage tout ce qui est basé sur GTK, ça élimine déjà plus de la moitié des softs), un truc léger, configurable.
Et en fait je ne suis pas allé chercher bien loin : j'utilise **foot** comme terminal et son auteur fait également **yambar**.
Si c'est pareil, c'est ma came !

Bon il n'y a pas de site officiel donc allez directement [sur le repo](https://codeberg.org/dnkl/yambar) pour trouver le bousin.
C'est déjà dispo dans les repos Gentoo bien évidemment ;-)

Utilisant déjà foot, beaucoup des dépendances sont déjà installées sur mon système (toute à vrai dire).
Du coup ça s'installe en deux deux.

Je le lance à la main et pouf ça fonctionne mais c'est un peu vide et moche.
Allez, penchons-nous sur sa config !

### Configuration
Bon alors on se rend dans ~/.config/yambar/config.yml et là on respire un bon coup, on va écrire du yaml à la main.
Il faut donc faire gaffe à la syntaxe où l'indentation compte !
C'est un peu du json mais plus agréable à écrire et lire à mon goût.

On commence par définir les options globales de la barre :

<details open><summary>extrait de ~/.config/yambar/config.xml</summary>

{{< highlight "yaml">}}
bar:
  monitor: HDMI-A-1
  location: top
  height: 30
  background: 00000066
  font: DejaVuSans:pixelsize=22
{{< / highlight >}}
</details>

Bon c'est plutôt explicite pour le moment.
Pour connaitre le nom de l'écran sur lequel vous voulez afficher la barre vous pouvez utiliser <kbd>swaymsg -t get_outputs</kbd> qui vous listera les écrans avec leur nom.

Yambar dispose de différents modules.
Qu'est-ce que je veux ?

  - Voir mes workspaces sway >> module i3 (oui oui c'est compatible)
  - Voir ma musique de mpd >> module mpd
  - Gérer un peu le son >> module pipewire
  - Voir l'heure >> module clock

Il en existe d'autres mais j'en ai pour le moment pas besoin.
Vous verrez que je me suis inspiré d'extraits qu'on trouve à droite à gauche sur la toile pour composer ma barre.

### Module i3
Alors oui il s'apelle i3 mais fonctionne parfaitement avec sway.
C'est grâce à lui que j'utilise **yambar** au lieu de **swaybar** même si au final il est assez simple.

<details open><summary>extrait de ~/.config/yambar/config.xml</summary>

{{< highlight "yaml">}}
  left:
  - i3:
      sort: ascending
      content:
        "":
          map:
            margin: 2
            default:
            - string:
                text: " {name} "
                foreground: 918175ff
                on-click: swaymsg workspace "{name}"
            conditions:
              state == focused:
              - string:
                  text: " {name} "
                  foreground: FBB829ff
                  deco: {overline: {color: FBB829ff, size: 3}}
                  on-click: swaymsg workspace "{name}"
              state == urgent:
              - string:
                  text: " {name} "
                  foreground: EF2F27ff
                  deco: {overline: {color: EF2F27ff, size: 3}}
                  on-click: swaymsg workspace "{name}
              - string:
                  text: " {name} "
                  foreground: d99609ff
                  deco: {overline: {color: c98607ff, size: 3}}
                  on-click: swaymsg workspace "{name}"                  
              state == unfocused:
              - string:
                  text: " {name} "
                  foreground: d99609ff
                  deco: {overline: {color: c98607ff, size: 3}}
                  on-click: swaymsg workspace "{name}"                  
{{< / highlight >}}
</details>

On a donc la liste des workspaces qui est affichée.
S'ils sont "focused" il y a une couleur vive, si c'est visible mais pas focus (sur l'autre écran), c'est moins vif et sinon c'est gris.
Très pratique pour en un clin d'œil se rendre compte de ce qui est à l'écran ou non.

Bon le seul truc pas ouf c'est qu'on ne peut pas savoir sur quel écran est un workspace.
L'action on-click permet de se rendre sur le workspace en question.
On sait jamais, si par malheur vous aviez la souris à la main…

Remarquez qu'on utilise une condition qui regarde la valeur d'une variable.
Ça sera très utilisé plus loin.

### Module mpd
Non je ne vous montre toujours pas le résultat :-þ

Bref, maintenant au milieu je veux afficher la musique qui tourne dans **mpd**.

<details open><summary>extrait de ~/.config/yambar/config.xml</summary>
{{< highlight "yaml">}}
  center:
    - mpd:
        host: /var/lib/mpd/socket
        anchors:
          list: &artist_album_title
            spacing: 0
            items:
              - map:
                  conditions:
                    state == playing: {string: {text: "{title}", foreground: e0d72eff}}
                    state == paused: {string: {text: "{title}", foreground: ffffff66}}
              - string: {text: " par ", foreground: ffffff66}
              - map:
                  conditions:
                    state == playing: {string: {text: "{artist}"}}
                    state == paused: {string: {text: "{artist}", foreground: ffffff66}}
              - string: {text: " dans ", foreground: ffffff66}
              - map:
                  conditions:
                    state == playing: {string: {text: "{album}"}}
                    state == paused: {string: {text: "{album}", foreground: ffffff66}}
              - string: {text: " - ", foreground: ffffff66}
              - map:
                  conditions:
                    state == playing: {string: {text: "{pos}/{end}"}}
                    state == paused: {string: {text: "{pos}/{end}", foreground: ffffff66}}

        content:
          map:
            margin: 10
            conditions:
              state == offline: {string: {text: offline, foreground: ff0000ff}}
              state == stopped: {string: {text: stopped}}
              state == paused: {list: *artist_album_title}
              state == playing: {list: *artist_album_title}
            on-click:
              left: mpc toggle
              right: mpd_add_random
              wheel-up: mpc seek -5
              wheel-down: mpc seek +5
              previous: mpc prev
              next: mpc next
              middle: mpd_add_random
            deco:
              stack:
                - overline: {color: e0d72eff, size: 3}
                - background: {color: e0d72e22}

{{< / highlight >}}
</details>

Bon là c'est un poil plus cemplexe.
On joue de la condition partout pour voir l'état de mpd et donc d'afficher différemment le contenu du module.

Le point assez sympa ce sont surtout les "on-click".
Ils permettent de controler mpd dans un peu tous les sens.

Ça remplace mon script [tsmpcd]({{< ref "fast-posts/23-tsmpcd" >}}) qui m'affichait ce qui passait.
Sauf que mon script savait reremplir la playlist quand elle était à sec ce que la barre ne peut pas faire :-/
Là j'ai mis un clic de molette pour rajouter 30 morceaux à la playlist…

Un ptit détail un peu déroutant : yambar ne se rafraîchit que lorsque c'est vraiment nécessaire.
C'est grâce à ça que ça ne bouffe que très peu de cpu.
Mais du coup concernant le module MPD, l'indication de progression de dans le morceau de musique n'est pas mis à jour en temps réel.
Juste une fois par minute.
Mais il est possible de forcer le rafraîchissement en changeant de workspace par exemple.
Ce qui au début me semblait comme un défaut, au final ne me gêne pas du tout.

### Module pipewire
Bon alors là je me suis pas fait chier j'ai repompé ce que j'ai trouvé sur le web.

<details open><summary>extrait de ~/.config/yambar/config.xml</summary>
{{< highlight "yaml">}}
 right:
    - pipewire:
        anchors:
          volume: &volume
            conditions:
              muted: {string: {text: "{linear_volume}%", foreground: ff0000ff}}
              ~muted: {string: {text: "{linear_volume}%"}}
        content:
          list:
            items:
              - string: {text: " "}
              - map:
                  conditions:
                    type == "sink":
                      map:
                        conditions:
                          icon == "audio-headset-bluetooth":
                            string: {text: "🎧  "}
                        default:
                          - ramp:
                              tag: cubic_volume
                              items:
                                - string: {text: "🔈  "}
                                - string: {text: "🔉  "}
                                - string: {text: "🔊  "}
                    type == "source":
                      - string: {text: "🎙   "}
              - map:
                  <<: *volume
              - string: {text: " "}
            on-click:
              left: wpctl set-mute 71 toggle
              wheel-up: wpctl set-volume 71 5%+
              wheel-down: wpctl set-volume 71 5%-
            deco:
              stack:
                - overline: {color: E02C6Dff, size: 3}
                - background: {color: E02C6D44}
{{< / highlight >}}
</details>

Le seul truc à faire gaffe, ce sont les commandes on-click qui s'appuient sur un id qui malheureusement est pas 100% fixe.
Parfois au reboot, l'id peut varier :-/

Bon ce n'est malheureusement pas possible mais j'adorerais vraiment, ce serait que le module puisse afficher chacune des applis qui produisent du son afin de pouvoir gérer leur volume indépendamment sans dégainer pavucontrol.

Bon on approche du bout, vous allez bientôt voir le résultat !

### Module clock

<details open><summary>extrait de ~/.config/yambar/config.xml</summary>
{{< highlight "yaml">}}
    - clock:
        date-format: "%d/%m"
        content:
          - string:
              text: " {date} {time} "
              foreground: ffffffff
              deco:
                stack:
                  - overline: {color: 2E8DE0FF, size: 3}
                  - background: {color: 2E8DE044}
{{< / highlight >}}
</details>

Bon ouai là c'est basique.
Rien à se foutre sous la dent.
Même pas d'on-click pour remonter le temps :-/

## Résultat
Allez vous avez été patient.
Je vous remercie et vous récompense !

{{< img src="yambar.jpg" alt="La fameuse bar avec ses quatres modules comme elle apparait en haut de l'écran" title="Bon alors ? Pas trop déçu ?" >}}

Voilà tout.
