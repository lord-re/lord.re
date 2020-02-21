+++
Author = "Lord"
Description = "J'ai horreur des ordis qui tournent avec trop de processus à mon goût. Je me sens vite débordé et impuissant quand j'en rencontre. C'est pour ça que j'allège le plus possible mes machines de ce point de vue."
Categories = ["linux", "gentoo","alpine","adminsys"]
menu = "main"
notoc = true
PublishDate = 2019-01-02T20:50:45+01:00
date = 2019-01-03T13:50:45+01:00
title = "Mon TOC des processus"
editor = "kakoune"
TopWords = [  "programme", "htop", "linux", "processus"]
+++
Je dois vous avouer que j'ai quelques obsessions.
L'une d'elle est le *nombre de processus qui tournent sur mes machines*.

Franchement c'est con et je l'écris avec une touche d'humour mais ça me travaille réellement.
Du coup quand je lance htop j'ai ça je suis content :

{{< img src="htop.thumb.png" alt="capture d'écran de htop montrant seulement 29 processus" link="htop.png" title="Seuls 30 processus qui tournent et 5 en root" >}}

Mais dès lors que je tombe sur un Debian/RedHat … je pleure et j'ai peur :

{{< img src="ubuntu.thumb.png" alt="le Htop d'ubuntu est interminable avec 247 tâches tournant." link="ubuntu.png" title="Quand je vois ça j'étouffe. Merci Simon ;-)" >}}

*Un programme contient forcément des bugs.*
Plus un programme est gros plus il en contient.
Le code parfait n'existe pas.

Du coup plus il y a de programmes, plus il y a de bugs.
*Et plus un programme est complexe, plus il contient de failles de sécurité.*
Et ce, même si le logiciel est ancien et bien maintenu et très populaire…
Il y aura toujours des failles et si ce n'est pas dans le logiciel en lui-même, ça sera son environnement (voir le cpu qui l'éxécute).

Et puis ça bouffe bien plus de ressources…
Même si nos machines d'aujourd'hui peuvent surement encaisser, ça m'attriste toujours autant que ce qu'on faisait il y a dix ans sur l'ordi… bha on le fait pas spécialement plus vite aujourd'hui.

Bref, les machines que j'administre doivent être allégées.
Au final je me retrouve dans un environnement où je sais ce que fait chacun des processus qui tourne et lorsqu'il se passe un truc louche je trouve rapidement le coupable.

**Alpine** s'inscrit parfaitement dans ce TOC car par défaut il n'y a quasiment pas de processus qui tournent et c'est un soulagement.
**Gentoo** est également la candidate parfaite par sa modularité exemplaire.

Un autre truc que je recherche : *diminuer le nombre de programme que fait tourner root*.
Root est tout puissant, donc moins il est sollicité mieux on se porte.

## Petit tour du proprio

  - **init** : c'est le processus lancé par le kernel au boot. Dans mon cas c'est *OpenRC*. C'est lui qui va démarrer tout le reste et se charger de dégager les processus morts.
  - **alacritty** : ce sont tous les émulateurs de terminaux que je lance. Il peut y en avoir un comme cinquante. Ça dépend de ce que je fais.
  - **zsh** : Ce sont les shells lancés dans les terminaux.
  - **XWayland** : c'est le serveur X11 de Wayland pour faire tourner les applications non natives (mon navigateur entre autre).
  - **qutebrowser** : Il apparait en tant que python 3.6 et de multiples QtWebEngineProcess (un par fenêtre). Là aussi c'est légitime et je ne peux pas m'en passer.
  - **ssh** : Le client SSH pour se connecter à mon client IRC.
  - **qingy** : C'est mon gestionnaire de TTY. Je le préferre à *getty* car il permet deux trois trucs en plus en étant tout aussi léger. Il permet par exemple de sélectionner parmis plusieurs sessions différentes. Il vérouille le tty lorsque vous en partez (en demandant un mot de passe au retour). Bref je n'en lance que 3 car j'ai pas besoin de plus de sessions simultannées.
  - **sway** : c'est [mon compositeur Wayland favoris]({{< ref "/posts/144-sway" >}}). C'est lui qui gère les fenêtres et le rendu.
  - **mpd** : mon lecteur de musique. Pas d'interface graphique et se pilote essentiellement avec des raccourcis via sway. Très souvent je fais tourner [tsmpcd]({{< ref "/fast-posts/23-tsmpcd" >}}) en plus pour gérer la playlist.
  - **udevd** : le gestionnaire de périphérique. Lui se charge de gérer les appareils dynamiquement (ajout d'un appareil usb par exemple). On pourrait un peu s'en passer (après le boot) mais c'est quand même moins pratique.
  - **slurp** et **grim** : sont les logiciels pour prendre la capture d'écran. [Slurp](https://github.com/emersion/slurp) permet uniquement de sélectionner une zone de l'écran et [grim](https://github.com/emersion/grim) lui prend une capture d'écran de cette sélection. Bref ils tournent sur le screenshot parceque… je prends le screenshot mais ils ne tournent pas en temps normal ;-)

## C'est pareil pour les serveurs

Quand j'administre un serveur, j'enlève tout ce dont je n'ai pas besoin.
Chaque service/processus en moins est une source de bugs et de failles en moins.
La machine devient plus simple à administrer.

C'est d'ailleurs un peu *pour la même raison que je n'apprécie pas systemd* (ouai je sais c'est hasbeen de continuer à ressasser ça).
Mais avoir des processus qui font des trucs un peu dans notre dos sans trop savoir pourquoi j'aime pas.
Les gains apportés par systemd ne justifient pas à mes yeux tout le merdier que ça entraîne.

Avec la mouvance actuelle des containers, j'apprécie la philosophie, que Docker a pas mal popularisé, d'*un container == un service*.
Du coup **Alpine** est une très bonne solution avec son userspace réduit au strict minimum

À cela si on rajoute les programmes compilés statiquement (ce qui est par défaut avec Go et Rust) on se retrouve avec des containers microscopiques et fonctionnels.
