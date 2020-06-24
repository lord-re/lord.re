+++
Author = "Lord"
Description = "MPV bien qu'étant le meilleur lecteur vidéo, on peut compléter ses fonctionnalités avec quelques scripts. La liste de ceux que j'utilise."
Categories = ["mpv", "linux"]
menu = "main"
notoc = true
PublishDate = 2018-11-08T17:53:27+01:00
date = 2018-11-08T17:53:27+01:00
title = "MPV et les scripts"
editor = "kakoune"
TopWords = [  "github", "youtube", "scripts", "mpv"]
+++
**MPV est de loin le meilleur lecteur vidéo** toute plateforme confondue à l'heure actuelle.
Et pas la peine de venir pleurnicher, VLC c'est bien gentil mais non merci : c'est largement moins bien foutu même si ça a des fonctionnalités exotiques utiles à moins de 1% des utilisateurs.

Bref je disais quoi ?
Ha ouai MPV c'est super.
Mais on peut encore un peu l'améliorer !
Et oui ma bonne dame, voyons ça de suite !
Et encore quelques points d'exclamations histoire de véhiculer un peu plus d'enthousiasme !!

## Les scripts
MPV peut recourir à des scripts pour ajouter des fonctionnalités.
Il en existe beaucoup en LUA quelques-un en Javascript et après un peu de vrac.

Ils sont à placer dans *~/config/mpv/scripts* et hop ça marche.
Oui c'est tout.

Bon après certains peuvent avoir des dépendances externes, d'autres peuvent nécessiter d'ajouter des raccourcis.
Bha ouai, un script qui ajoute de nouvelles fonctions c'est cool mais encore faut-il pouvoir déclencher ces nouvelles fonctions !

Puisque je suis quand même super gentil, je vous explique comment ajouter un raccourci.
Vous éditez *~/config/mpv/input.conf* avec la combinaison de touche suivi de l'action.
Un par ligne.

## Et concernant les subs ?
Et bha en fait quand vous regardez votre vidéo de vacances il peut s'avérer que vous êtes en présence de touristes (ou si vous êtes le touriste et que vous croisez des touristes) et du coup vous comprenez pas ce qu'ils racontent parcequ'ils ne parlent pas votre langue.
Il vous faut donc des sous-titres mais plutôt que de les chercher vous-même, autant mettre à contribution les Internets.

*Subliminal* est un logiciel spécialisé dans la recherche de sous-titre.
Vous voyez où je veux en venir ?
Et ouai, il y a un script qui vous permet d'utiliser subliminal et de vous mettre le sous-titre tout seul dans la vidéo juste avec une touche.
Il vous faudra donc installer subliminal de votre côté.
Ce script se nomme [autosub](https://github.com/vayan/autosub-mpv).
Une fois mis en place il suffit de choisir la langue en modifiant le fichier lui-même pour mettre un ptit *"fr"* qui va bien.
Et maintenant **<kbd>b</kbd>** et pouf ça trouve votre sous-titre et le démarre.

Et là, des fois, ça fait chier, le sous-titre est pas synchro avec le film.
Donc vous avez beau caler le sous-titre comme il faut à un instant t, bha deux minutes plus loin, c'est plus synchoro.
C'est rageant, hein ?

Et c'est là qu'on dégaine [fix-sub-timing](https://github.com/wiiaboo/mpv-scripts/blob/master/fix-sub-timing.lua) qui va vous permettre de très facilement régler ce souci :
Vous synchronisez une première fois le sous-titre et vous appuyez sur **<kbd>ctrl-w</kbd>**.
Vous laissez passer un peu de temps, vous resynchronisez le sous-titre et vous remettez un coup de **<kbd>ctrl-w</kbd>** et c'est bon il vous recalcule tout comme il faut et gère la vitesse du sous-titre et c'est tout bon.

## Quelques autres scripts kivonbien

### Pour les bourrins
Il m'arrive régulièrement de commencer une vidéo et de pas la finir.
Et de la reprendre plus tard.
Bon là de base, MPV peut reprendre la vidéo car si vous avez été prévoyant vous avez fait en sorte que lorsque vous appuyez sur **<kbd>q</kbd>** ça sauvegarde l'état de la vidéo avant de fermer.

Sauf que je suis un bourrin et je ferme MPV comme un porc en le killant voir en killant Xorg, bref il a pas le temps de sauvegarder.
C'est donc pour des gens comme moi qu'a été créé [Autosave](https://gist.github.com/Hakkin/5489e511bd6c8068a0fc09304c9c5a82) qui sauvegardera toutes les X secondes l'état.
Comme ça lorsque vous rouvrez la même vidéo ça reprend là où vous en étiez.

### Pour les sensibles
Pour protéger mes mirettes j'utilise *Redshift* (comme tout le monde j'espère) ça rougit l'écran pour moins vous bombarder les rétines.
En plus de ça je baisse drastiquement la luminosité de l'écran [via DDCUtil]({{< ref "/posts/50-controller-ecran/index.md" >}}).
Toujours est-il que la baisse de luminosité pour un film ne me chagrine pas, mais la teinte rougeatre m'horripile réellement.
Du coup [Toggle Redshift](https://repo.or.cz/q3cpma-dotfiles.git/blob_plain/HEAD:/.config/mpv/scripts/redshift_toggle.lua) vous permet de mettre en pause puis de relancer Redshift tout seul.

### Pour les Youtube Spectateurs
Un ptit [Youtube Quality](https://github.com/jgreco/mpv-youtube-quality) vous permettra d'un appui sur **<kbd>ctrl-f</kbd>** vous afficher un menu avec le choix pour la qualité des vidéos Youtube.
Par défaut Youtube-dl sélectionne la meilleure qualité disponible mais c'est pas toujours le plus judicieux.
Bref maintenant vous avez la solution, et vous pouvez le faire pendant la vidéo pour passer d'une qualité à une autre sans interruption.

-------

Bon c'est tout ce que j'utilise, mais il y en a [un petit paquet d'autres](https://github.com/mpv-player/mpv/wiki/User-Scripts).
Mais n'essayez pas pour autant de tous les mettre… car rappelez-vous l'adage : **plus vous en mettez plus ça va merder**.
