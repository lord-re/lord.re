+++
Author = "Lord"
Description = "J'ai rajouté des ptits trucs sympatiques sur mon ordi sous nunux ces deux dernières années. sov, wob, pipewire, bemoji, superd. Voyons un peu tout ça."
Categories = ["sway", "ux","linux"]
menu = "main"
notoc = true
WritingDate = 2022-10-28T18:57:08+02:00
date = 2022-11-03T19:57:08+02:00
title = "Amélioration de mon environnement nunux vol.2"
editor = "kakoune"
+++
Il y a deux ans j'avais écrit [la première partie]({{< ref "posts/210-amélioration-du-confort-de-mon-environnement-linux" >}}) et ça ne devait être quun oneshot mais je me suis dit pourquoi pas lui donner une suite.

Je suis toujours sur l'excellent **Sway** qui est fiable efficient et qui mine de rien a réussi à se créer une bonne communauté.
Et ce dernier point n'est pas si anecdotique que cela.
Il est arrivé très tôt dans l'écosystème de Wayland et a attiré de nombreux devs qui sont particulièrement actifs.
C'est tellement vrai que dans les implémentations majeures des protocoles de Wayland on retrouve généralement la commu Gnome, la commu KDE et maintenant à égalité voir ptet presque au-dessus, la commu **Wlroots** qui est la base de **Sway** (et d'autres compositors).
Et grâce à cela, beaucoup de logiciels visent explicitement la compatibilité avec wlroots (et donc par extension Sway).
*Sway a réussi à ne pas rester un projet de niche et a une place prépondérante.*

Bon revenons-en au sujet principal : *mes ajouts ces deux dernières années*

## sov
Un outil au nom sexy (non) mais qui veut dire **S**way **OV**erlay qui permet d'*avoir un ptit aperçu des workspaces*.

En gros il va vous afficher tous vos workspaces et quelles sont les fenêtres et leur arrangement.
C'est tout.
C'est léger, rapide et pas ultra sexy mais c'est pas si mal franchement.

Je l'utilise depuis quelques semaines pour l'instant et c'est un peu à cause de lui que je vous fais cet article.

Une fois installé il a un fonctionnement un peu particulier.
En gros le logiciel tourne tout le temps mais il ne s'affiche que lorsqu'il reçoit un "1" dans un pipe.
Pour qu'il cesse de s'afficher, il faut lui envoyer un "0" dans le pipe.

Bon, donc il va faloir lui créer un pipe, écouter le pipe et nourrir le pipe.
Par chance on peut faire tout cela directement dans la conf de sway.

<details><summary>~/.config/sway/config</summary>

{{< highlight "shell" >}}
# On définit une variable pour plus tard
set $XDG_RUNTIME_DIR /tmp/1000-runtime-dir

# On supprime un éventuel pipe, on crée un nouveau pipe, on lance sov en le branchant sur le pipe
exec rm -f $XDG_RUNTIME_DIR/sov.pipe && mkfifo $XDG_RUNTIME_DIR/sov.pipe && tail -f $XDG_RUNTIME_DIR/sov.pipe | sov

# J'affiche sov lors d'un changement de workspace (en gardant le raccourcis pressé)
# Sway lance deux commandes : le changement de workspace puis l'envoi dans le pipe
# Le --no-repeat permet de ne lancer qu'une fois la commande quand le raccourci est pressé même si c'est maintenu appuyé

bindcode --no-repeat $mod+10 workspace 1; exec "echo 1 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --no-repeat $mod+11 workspace 2; exec "echo 1 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --no-repeat $mod+12 workspace 3; exec "echo 1 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --no-repeat $mod+13 workspace 4; exec "echo 1 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --no-repeat $mod+14 workspace 5; exec "echo 1 > $XDG_RUNTIME_DIR/sov.pipe"

# On cache sov lorsque le raccourci n'est plus pressé
bindcode --release $mod+10 exec "echo 0 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --release $mod+11 exec "echo 0 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --release $mod+12 exec "echo 0 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --release $mod+13 exec "echo 0 > $XDG_RUNTIME_DIR/sov.pipe"
bindcode --release $mod+14 exec "echo 0 > $XDG_RUNTIME_DIR/sov.pipe"
{{< / highlight >}}

</details>

C'est typiquement ce qui est montré en exemple sur [la page du projet](https://github.com/milgra/sov) mais c'est pratique à utiliser comme cela donc j'ai tout pompé et je vous le repropose.

Il est possible de configurer l'apparence du bousin ce que j'ai qu'un tout petit peu modifié mais sans plus.
Le fichier de configuration fourni est tout commenté de partout et est assez explicite.

{{< img src="sov.png" alt="Capture d'écran de sov montrant 5 workspaces avec les fenêtres" title="Voilà, j'ai mis du orange et du violet." >}}

## wob
Hoo quel programme au joli nom : **W**ayland **O**verlay **B**ar .
Il n'a rien à voir avec le dubstep, ce logiciel s'affiche en surimpression pour juste afficher une barre de progression.
C'est tout, pas de fioriture rien.

Ce logiciel est déjà dispo dans le <abbr title="dépot communautaire de gentoo">guru de Gentoo</abbr> mais sinon vous le trouverez sur [sa page](https://github.com/francma/wob)

Tout comme **sov**, il fonctionne avec un pipe et vous y envoyez une valeur de 0 à 100 et c'est tout.
Du coup vous pouvez vous en servir pour afficher par exemple le volume sonore ou la progression d'un truc qui se déroule.

Je m'en sers pour afficher le volume lorsque je le modifie et également la luminosité de l'écran.

La mise en place est très similaire à **sov**.

<details><summary>~/.config/sway/config</summary>

{{< highlight "shell" >}}
# On définit une variable pour plus tard
set $XDG_RUNTIME_DIR /tmp/1000-runtime-dir

# On supprime un éventuel pipe, on crée un nouveau pipe, on lance wob en le branchant sur le pipe
exec rm -f $XDG_RUNTIME_DIR/wob.pipe && mkfifo $XDG_RUNTIME_DIR/wob.pipe && tail -f $XDG_RUNTIME_DIR/wob.pipe | wob

# Modif de luminosité puis affichage de la barre
bindcode 233 exec "ddcutil setvcp 10 + 10 --bus 6 --sleep-timer 0.1" ; exec 'ddcutil getvcp 10 -t --bus 6 --sleep-timer 0.1 | cut -d" " -f4 > $XDG_RUNTIME_DIR/wob.pipe'
bindcode 232 exec "ddcutil setvcp 10 - 10 --bus 6 --sleep-timer 0.1" ; exec 'ddcutil getvcp 10 -t --bus 6 --sleep-timer 0.1 | cut -d" " -f4 > $XDG_RUNTIME_DIR/wob.pipe'

# Modif du volume sonore puis affichage de la barre
bindsym XF86AudioRaiseVolume exec amixer sset Master 5%+ | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > $XDG_RUNTIME_DIR/wob
.pipe
bindsym XF86AudioLowerVolume exec amixer sset Master 5%- | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > $XDG_RUNTIME_DIR/wob
.pipe
bindsym XF86AudioMute exec amixer sset Master toggle | sed -En '/\[on\]/ s/.*\[([0-9]+)%\].*/\1/ p; /\[off\]/ s/.*/0/p' | head
 -1 > $XDG_RUNTIME_DIR/wob.pipe

{{< / highlight >}}

</details>

Encore une fois ces exemples sont tirés de la page du soft, rien d'original.
C'est une esthétique un peu particulière (ça m'évoque les démos mais c'est vrai que ça ressemble aussi comme deux gouttes d'eau à la barre de progression de **mpv**.

{{< img src="wob.png" alt="une barre de progression en surimpression au milieu de l'écran" title="Du bling bling minimaliste." >}}

## Pipewire
La fois précédente je vous avais parlé de **PulseEffects**.
Et bien c'est fini.
Enfin pas tout à fait.

C'est devenu **Easyeffects** et ça ne fonctionne plus avec **PulseAudio** mais avec **Pipewire**.
Du coup j'ai dégagé le vilain Pulse que j'ai remplacé par le flambant neuf **Pipewire** qui fait la même chose mais en mieux et même plus.
En plus de gérer l'audio, il peut également gérer de la vidéo même si je vous avoue que pour l'instant je m'en suis pas trop trop servi si ce n'est pour faire un peu d'**OBS**.

Pour le lancer je passe encore une fois par le fichier de conf de **Sway**.

<details><summary>~/.config/sway/config</summary>

exec --no-startup-id /usr/bin/gentoo-pipewire-launcher

</details>

Ouai c'est tout.
Et ça suffit pour marcher.

La migration depuis Pulse est facile vu qu'il propose une API compatible donc tous les softs parlant à Pulse sauront parler à **Pipewire** sans rien changer.
C'est d'ailleurs à peu près le cas pour **Jack** également.

## Bemoji
Non seulement je m'embourgeoise mais en plus je me kikoo-ifie !
Il m'arrive de parfois "avoir besoin" d'emoji.

Mais bien entendu je n'en ai pas sur mon clavier et c'est là que **bemoji** arrive à la rescousse.
C'est un basique script shell qui utilise **bemenu** et **wlclip** pour permettre de chercher un emoji parmi la liste unicode et de l'insérer.

Alors déjà rendez-vous sur [leur dépot](https://github.com/marty-oehme/bemoji).
Une fois installé, le meilleur moyen de l'utiliser est de passer … par **sway**.
Oui je sais c'est encore lui qui va bosser.

<details><summary>~/.config/sway/config</summary>

bindsym $mod+a bemoji -t -e

</details>

Et maintenant à vous de 🔍chercher votre 🤔emoji favori et d'en insérer partout jusqu'à 🤮l'écœurement.

Ha et c'est pas un script si débile que ça.
Non non, il sait de lui-même générer sa base d'emoji (basé sur unicode) directement sur le 🔗web et également gère son <abbr title="ouai c'est pas vraiment le plus approprié ^__^">🧻</abbr>historique pour vous afficher vos favoris en 🥇premier !

J'ai juste un peu modifié l'apparence du bemenu pour que ça soit plus gros pour soulager mes pauvres 👀yeux.

(En écrivant ce paragraphe je me sens ridicule, mais au final en le relisant je trouve ça pas si débile de parsemer quelques émojis, ça aide à briser l'effet "wall-of-text" et rend au final le tout plus digeste.)

## Superd
Bon je vous en parle mais en vrai je m'en suis servi moins d'une semaine.

**Superd** est une sorte de **Systemd** mais spécialisé pour la gestion des services utilisateurs.
En gros tous les softs que je lance comme un porc dans ma session utilisateur seraient mieux gérés par ce bestiau.

L'idée est pas trop mauvaise, le souci c'est que … bha … ça lorgne un peu trop du côté de systemd à mon goût.
Le tout pour une plus-value assez discutable.

J'ai déjà l'habitude de créer ma session via un script dans **Qingy** et d'ensuite tout lancer depuis la conf de **Sway** (comme vous avez pu le constater).
**Superd** pourrait s'assurer que les softs se relancent proprement en cas de crash mais ça ne m'arrive jamais (ou presuqe).

Si ça vous intéresse allez [voir la page du projet](https://git.sr.ht/~craftyguy/superd) mais perso ça ne m'a pas convaincu.

J'aimerai juste un ptit logiciel qui lance tous les autres au lieu de passer par du <kbd>exec sway</kbd> pour que ça soit tout réuni quand je lance dans htop.
Mais c'est vraiment pas un gros besoin, c'est plus du gadget.

--------

Voilà, de nouveaux joujous pour personnaliser un peu votre nunux.

Ça rentre en contradiction avec ma phobie des process mais je tente de justement passer outre petit à petit.

