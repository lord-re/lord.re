+++
Author = "Lord"
Description = "Je n'utilise pas un environnement de bureau tout construit mais avec différentes briques j'ai fini par me créer un environnement léger mais avec tout de même quelques trucs sympas. C'est principalement tourné vers Sway."
Categories = ["sway", "ux","linux"]
menu = "main"
notoc = true
WritingDate = 2020-10-13T14:57:55+02:00
date = 2020-10-13T14:57:55+02:00
title = "Amélioration de mon environnement nunux"
editor = "kakoune"
+++
Je vous ai déjà parlé de mon obsession pour avoir un environnement KISS avec le moins de processus qui tournent et compagnie.
Mais depuis quelques mois je vais un peu à contresens en m'ajoutant quelques outils pour améliorer le confort global.

J'utilise maintenant **Sway** depuis deux ans et j'en suis super satisfait.
C'est un compositor wayland reprenant le fonctionnement d'**i3** que j'ai étrenné pendant très longtemps avant.

En deux ans, l'utilisation de Wayland s'est grandement améliorée au point où il n'y a désormais quasiment plus de ptits comportements merdiques.
La majorité des bugs ont été corrigés, des fonctionnalités manquantes ont été implémentées toussa.

## Redshift
Bon je passe beaucoup d'heures devant l'ordi et parfois même un peu tard.
On en parle de plus en plus des troubles du rythme circadien qui serait en partie provoqué par les écrans et plus spécifiquement la lumière bleue qu'ils émettent.

Bon bha, vous vous doutez qu'en présentant le truc comme ça, c'est que je suis touché.
Et bha pas du tout.
Je dors très bien et facilement.

Mais bon, ça coûte pas bien cher de s'en prémunir préventivement.
Du coup [Redshift](https://github.com/jonls/redshift) est un outil bien connu sous nunux qui permet d'adapter la colorimétrie de l'écran en fonction de l'heure.

En gros vous lui donnez votre géolocalisation et il se débrouille pour savoir à quelle heure enlever du bleu (l'écran rougit pas mal).
Vous pouvez bien entendu adapter la puissance de l'effet pour plus ou moins impacter.

Par défaut c'est vraiment très rouge au point de rendre chiant à regarder tout ce qui est graphique (photo/films…).
Perso je l'ai un peu changé et je le lance directement via sway.

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id redshift -t 5700:3500 -m wayland -l XX.XX:YY.YY

</details>

Et hop !

Enfin presque, il vous faut une [version forkée de redshift](https://github.com/minus7/redshift) si vous utilisez sway parceque l'original ne sait bosser qu'avec X11.

Bon par contre je regarde pas mal de vidéos et là c'est assez chiant la colorimétrie foireuse du coup j'ai foutu un ptit script lua dans **mpv** afin de couper provisoirement Redshift automatiquement.
Vous pouvez mettre [ce script](https://git.sr.ht/~q3cpma/dotfiles/tree/master/.config/mpv/scripts/redshift_toggle.lua) dans *~/.config/mpv/scripts* pour vous aussi profiter de ce ptit raffinement.

## Pulseeffects
Depuis le confinement, j'ai adopté **PulseAudio** une des œuvres de l'illustre Lennart Poettering.
Pourtant j'aime pas tout son écosystème, j'aime pas sa façon de fonctionner, je n'ai besoin d'aucune de ses fonctionnalités.
J'ai qu'une carte réseau avec une seule sortie audio utilisée.

Alsa me convenait parfaitement.
Mais le truc qui m'a fait craqué c'est **PulseEffects** qui permet d'ajouter des effets sur l'audio sur tout le système.
J'ai de bonnes enceintes sauf qu'elles ont un son très neutre et être neutre c'est cool mais avoir un peu plus de basse c'est quand même bien mieux.

Du coup avec ce ptit outil je peux renforcer grandement les basses ce qui rend le son bien plus agréable.
Par contre c'est l'enfer sur terre ce truc.
Du GTK, du dbus, du dconf… tout pour te pourrir un environnement sain.

Pour le lancer sans avoir de fenêtre je le lance aussi via sway.

<details><summary>~/.config/sway/config</summary>

exec --no-starstup-id pulseeffects --gapplication-service

</details>

Bon pour le réglage faut le lancer normalement mais ça peut risquer de faire bugguer le son…

Pour éviter que ça sature dans tous les sens je baisse le volume des applis à 80%.

## Swayidle
Par défaut **sway** n'a pas de mécanisme de mise en veille/écran de veille ou autre.
C'est un poil gênant si vous avez tendance à laisser de côté l'ordi un long moment.

Du coup **swayidle** est la rustine qui permet de scripter des actions en fonctions d'évènements.
Si comme moi vous n'utilisez pas systemd, les seuls évènements possibles sont *timeout* et *resume* qui correspondent à un temps d'inactivité et le retour de l'activité.

Dans mon cas au bout de 10 minutes je fous l'écran en veille et en retour d'activité je réactive l'écran.
Basique mais suffisant pour le moment.

Encore une fois, je le lance via sway !

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id swayidle -w timeout 600 'swaymsg "output * dpms off"' resume 'swaymsg "output * dpms on"'

</details>

Je ne le fais pas mais sachez qu'il est possible de définir plusieurs actions à plusieurs timeout différents pour par exemple éteindre l'écran au bout de dix minutes, et pourquoi mettre tout l'ordi en veille au bout de trente minutes.

Bref, un ptit outil léger qui fait ce qu'on lui demande sans plus.
Il est généralement packagé directement avec sway (enfin selon la distro).

Là vous remarquerez vite que **mpv** est un bon citoyen et qu'il discute avec sway pour lui dire de ne pas se mettre en veille pendant qu'il tourne.
Par contre **Qutebrowser** … non, quand il lit une vidéo, bha sway n'hésitera pas à se foutre en veille au bout du timeout.
La parade que j'ai trouvé est de toucher la conf de sway pour inhiber la mise en veille lorsque Qutebrowser est en plein écran.

<details><summary>~/.config/sway/config</summary>

for_window [app_id="org.qutebrowser.qutebrowser"] inhibit_idle fullscreen

</details>
Et vous allez pouvoir laisser tourner votre navigateur tranquillou sans risquer que l'écran s'éteigne lors d'une vidéo.

## Bemenu
Lorsque j'étais encore sur i3 et donc le monde vieillissant de X11, j'utilisais le fameux **dmenu** sorti tout droit des esprits de chez [suckless](http://suckless.org/) chez qui j'aimais vraiment faire mes courses.
Il était vraiment cool mais n'a pas entamé de transition vers wayland et ne le fera probablement jamais officiellement (il me semble qu'il traîne un fork ou deux pour ça).
Du coup je suis allé voir la concurrence.

J'ai choisi un ptit nouveau nommé [bemenu](https://github.com/Cloudef/bemenu) et j'en suis très content.
Par défaut il a un thême (enfin deux trois couleurs quoi) qui me plaisent pas mal.

Je m'en sers pour sélectionner la musique, lancer des logiciels, récupérer mes mots de passe, lancer un film.
Ce que j'aime bien c'est qu'on peut lui filer tous les réglages en arguments du coup on peut se passer de fichier de configuration.

<details><summary>exemple d'appels via sway</summary>

bindcode $mod+26 exec "bemenu-run --fn 'Liberation Mono 17'"
bindcode $mod+27 exec "passmenu -l 10 -p 'Pass :' -fn 'Droid Sans Mono-15' -nb '#322'"

</details>

Je me suis aussi fait (enfin repompé du web, hein) la commande pour le choix de musique :

<details><summary>/usr/local/bin/mpdmenu</summary>

#! /bin/sh
mpc listall | bemenu -i -l 40 --fn 'Droid Sans Mono 26'| mpc insert

</details>

{{< img src="mpdmenu.png" alt="le haut de l'écran affiche la recherche et le bas tous les morceaux de musique correspondant" title="On le voit pas mais on peut faire de la recherche approximative" >}}

Simple mais parfaitement fonctionnel.

-------------

Bon bha voilà les quelques folies que je me suis autorisé.
C'est tout super léger sauf l'infâme Pulseeffects.
D'ailleurs si jamais quelqu'un sait comment obtenir un résultat similaire direct via Alsa ça me plairait bien.

Si vous avez des ptits outils légers qui améliore la vie je suis preneur (en sachant que je suis très pinailleur et que j'ai des besoins parfois exotiques, c'est pas pour autant que je les adopterai).
