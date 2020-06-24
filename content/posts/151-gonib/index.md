+++
Author = "Lord"
Description = "L'un des buts de coder GoNib était de réduire l'empreinte de NIB. Voilà comment je l'ai installé et mis en place. Le gain en valait largement la peine."
Categories = ["irc", "golang","alpine"]
menu = "main"
notoc = true
PublishDate = 2019-01-01T21:43:01+01:00
date = 2019-01-02T16:43:01+01:00
title = "Gonib et ce qu'il y a autour"
editor = "kakoune"
TopWords = [  "go", "irc", "tmux", "container", "nib", "gonib"]
+++
J'ai mis en service GoNib hier soir et il tourne désormais.

L'an dernier je vous parlais de [Nib]({{< ref "/posts/66-nib-irc-bot" >}}) mon Nano Irc Bot.
C'est mon assistant personnel qui même s'il ne parle pas, au moins ne m'espionne pas.
Il me permet de faire des trucs plus ou moins utiles via IRC.

Ce script était au final tout un tas de logiciels mis bout-à-bout via du script shell.
Ça marchait super bien mais je voulais un truc un peu plus propre et plus léger.
J'ai donc entrepris de le refaire en Go durant ses dernières semaines.

Et BAM ! GoNib !
Bon pour l'instant il fait pas tout ce que faisait l'ancien mais suffisamment pour le remplacer dès aujourd'hui.
Mais au delà du code que je vous ai déjà pas mal présenté dans les derniers articles, je vais vous montrer comment je l'ai mis en place.

## Compilation du code
Je le dev sur ma machine qui est un ordi classique sous l'architecture amd64, mais je compte le faire tourner dans un container sur mon routeur qui lui n'est pas en amd64 mais en *arm7*.
Pour crosscompiler du Go, rien de plus simple : **<kbd>GOARM=7 GOARCH=arm go build -ldflags="-s -w" gonib.go</kbd>**.

Voilà, on spécifie, l'architecture et c'est bon.
Pour le fun je rajoute les options <kbd>-s</kbd> et <kbd>-w</kbd> qui permet de générer un binaire plus petit.
Ça sert pas à grand chose mais quand même, j'aime bien.

## Création du container
Bon, je suis toujours dans ma période *Alpine Linux*, donc je créer un container en version 3.8.
Ensuite une fois dedans j'y installe **tmux**.

Il faut créer un service pour démarrer automatiquement au boot ce qu'il faut avec par exemple */etc/init.d/tmux* :

```
#!/sbin/openrc-run

name="Tmux Init"
command="/usr/bin/$SVCNAME"
command_user="nib"
pidfile="/var/run/$SVCNAME.pid"
command_args="new-session -d -n gonib '/home/nib/gonib -server=irc.geeknode.org'"

depend() {
        need localmount
}
```

On place ce service au boot avec **<kbd>rc-update add tmux</kbd>** et tant qu'à faire on peut virer tous les autres services du boot à l'exception de crond qui servira pour lancer certaines actions.

Il faut ensuite créer l'utilisateur *nib* avec **<kbd>adduser nib</kbd>**.

On place le binaire gonib dans */home/nib/gonib* et on le rend éxécutable et c'est bon.

## Lancer le container au boot
Sur *OpenWRT* pour lancer les containers au boot, il faut les indiquer dans */etc/config/lxc-auto* tout bêtement.

## Tester
Bon bha yapuka !

**<kbd>lxc-stop -n gonib</kbd>**

**<kbd>lxc-start -n gonib</kbd>**

Et là pouf dans la seconde qui suit votre gentil ptit nib va apparaitre sur votre salon favoris.

## Conclusion
Ça fonctionne pour le moment \o/

Bon j'ai toujours l'autre que je peux redémarrer au cas où mais j'ai confiance.

L'ancien container à base de Debian et tout le toutim pèse **384Mo**.
Le nouveau container à base d'Alpine fait **21.1Mo**.
Ça bouffe 10Mo de RAM pour tout le container.

Moins de pièces mouvantes, moins d'espace disque, moins de ram.
Une belle optimisation !

Il ne reste plus que l'épreuve du temps à surmonter.
