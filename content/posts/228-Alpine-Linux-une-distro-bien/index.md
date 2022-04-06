+++
Author = "Lord"
Description = ""
Categories = ["linux", "alpine"]
menu = "main"
notoc = true
WritingDate = 2022-04-02T11:51:09+02:00
date = 2022-04-06T11:51:09+02:00
title = "Alpine Linux : bien même en dehors des containers"
editor = "kakoune"
+++
Quand on parle Linux, il y a très vite les histoires de choix de distribution.
Et déjà il y a un truc que je comprends ce sont les gens qui testent constamment de nouvelles distributions linux.

Bon j'arrive à comprendre que l'on teste des distros qui ont fait des choix assez exotiques :
  - une FHS non standard (comme par exemple GoboLinux)
  - un userspace qui sort vraiment de l'ordinaire (NixOS, Alpine…)
  - des configurations très spécifiques (les distros pour appliances)
  - une architecture extraordinaire (QubeOS)

Mais si c'est juste pour tester une énième distro classique je ne vois pas vraiment l'intéret.
Ne vous méprenez pas, je n'ai rien contre les distributions linux, au contraire je pense que c'est un plutôt bon exercice de créer une distribution.
Un peu comme on s'essaye à LFS, se faire une ptite distro à soit doit être vraiment très formateur.
*Il y a bien plus d'intéret à créer ce genre de distro qu'à les utiliser* à mon sens.

Fin de la digression.

Bon bha ça fait des années que je parle par-ci par-là de cette distribution Linux et je n'ai pas pour autant présenté cette ptite chose ici.
Cette distribution a quelques particularités bien sympatiques.

## Ce que je n'utilise pas mais …

### Docker
Alpine a *explosé en popularité parcequ'elle est pas mal utilisé par Docker* du fait de sa ptite taille.
Du coup forcément quand il faut la dupliquer et la distribuer, avoir une faible taille est un sacré atout.
Mais elle existait bien avant l'avènement de Docker !

Et d'ailleurs je ne l'utilise jamais avec Docker mais c'est grâce à ce biais que j'ai découvert Alpine.

### Diskless
Un point fort de cette distro c'est de *proposer dès son installation un mode* **diskless**.
Ce mode permet un fonctionnement assez exotique on va dire.

*Au lieu d'installer votre OS sur le disque dur, vous le foutez sur un support amovible en mode lecture seule*.
Quand ça boot, les données sur ce support sont balancées en RAM et il n'est plus utilisé.

Vous vous rendez vite compte que l'inconvénient d'un tel système c'est que forcément les modifs que vous faites ne seront donc pas conservées au reboot.
Si vous installez un logiciel, si vous modifiez une configuration bref quoi que vous fassiez, au prochain reboot vous perdez tout.
Alors déjà, dans certains cas c'est un avantage.

Mais, ils ont bien entendu prévu quelque chose pour ce genre de cas : l'**apkovl** (c'est bien "ovl" et non "vol", ce qui veut dire overlay et non volume) couplé à **lbu**.
C'est un système permettant d'avoir une persistance des données.
En gros **apkovl** est une surcouche de données qui va donc contenir toutes les modifications que vous avez apporté au système figé.
Et **lbu** est le logiciel qui va vous permettre de gérer cette surcouche sans vous prendre la tête.

Avec ce système vous avez le meilleur des deux mondes.

Bon, dans mon cas j'utilise quasiment jamais ce système, je fais des installations classiques mais dans le cas de containers où sur de petits appareils ça peut être pratique.

## Ce que j'apprécie

Ouai je vous ai fait le tour de quelques particularités cools mais que je n'utilise pratique jamais.
Voyons maintenant plutôt ce que j'apprécie et utilise.

### Apk
C'est *le gestionnaire de paquets classique mais très bien foutu et particulièrement rapide*.

Bon, si vous connaissez Debian et ses dérivés vous n'aurez qu'une lettre à changer, c'est déjà pratique.
On retrouve les classiques <kbd>apk update</kbd> et <kbd>apk upgrade</kbd> pour installer c'est <kbd>apk add</kbd> et pour virer <kbd>apk del</kbd> et le fameux <kbd>apk search</kbd>.
Avec ça vous pouvez déjà bien vous demerder.

Bon jusque-là rien de transcendant.
Mais à l'utilisation vous allez très probablement est très étonné de la vitesse du bestiau.
Avec une connexion fibre, l'installation de ptits logiciels consoles est quasi instantané.
C'en est même à se demander si ça a réellement marché tellement c'est rapide.

Je déconne pas, plusieurs fois j'ai attendu sans me rendre compte qu'en fait la commande était passée directement.

### Proche de Gentoo
Mon nunux est Gentoo depuis plus de quinze ans maintenant.
C'est mon nid douillet depuis si longtemps j'ai vraiment du mal à aller voir ailleurs.

Mais dans Alpine je retrouve certains éléments de Gentoo bien que les deux distros soient bien différentes.
Déjà Alpine utilise des paquets binaires ce qui est (je ne vous le cache pas) parfois un peu déconcertant quand on a l'habitude de trifouiller les USE de chacun des paquets installés.

Mais **apk** utilise un fichier *world* comme Gentoo.
Le système de gestion des dépendances est assez similaire.
En gros quand on veut installer un paquet, apk ajoute une ligne avec le nom du paquet dans le fichier world.
Ensuite apk calcule toutes les dépendances et agit en conséquences.

Il est d'ailleurs possible de trifouiller à la main le fichier world pour y ajouter/enlever les logiciels que vous voulez puis de lancer un ptit <kbd>apk fix</kbd> qui se chargera d'ajouter et virer les paquets nécessaires.

Bon c'est pas forcément la façon de faire recommandé mais ça fonctionne très bien.

Dans les autres similarités il y a l'utilisation d'**OpenRC** pour la gestion des services.
Pas de systemd ici mais ce bon vieil init qui marche très bien.
Et pour ceux qui ne connaissent pas et qui sont satisfait de la simplicité d'utilisation de systemd et ses fichiers unit, sachez que ce n'est pas vraiment plus compliqué (même au contraire).

<details><summary>Un petit exemple de fichier d'init pour acpid</summary>

{{< highlight "shell" >}}
#!/sbin/openrc-run

name="busybox acpid"
command="/sbin/acpid"
command_args="$ACPID_OPTS"
pidfile="/var/run/acpid.pid"
start_stop_daemon_args="-g wheel -k 027"

depend() {
        need dev localmount
        after hwdrivers modules
        keyword -vserver -lxc
}
{{< / highlight >}}

Voilà, c'est une syntaxe plutôt légère mais (bon ça se voit pas dans cet exemple) mais il est possible d'y rajouter du script shell classique si vraiment il y a besoin de faire du plus exotique.
*On a donc des init assez proches des fichiers unit de systemd niveau complexité mais avec plus de flexibilité*.

</details>

### Légèreté de la base
*Une fois une Alpine inastallée, vous n'aurez pas des processus dans tous les sens*.
Vous n'aurez d'ailleurs quasiment rien.
Pas tout un tas de daemon qui font des choses dans votre dos.

Non, c'est à vous d'ajouter les briques qui vous sont nécessaires.

En passant, *vous n'aurez pas les GNU coreutils habituels*.
Ici, toutes les commandes de bases habituelles sont issues de **busybox**.
Donc le **top**, le **df**, le **mkdir** … bref, tous ces outils basiques sont des implémentations différentes de la plupart des distros.

Ça peut apporter quelques déconvenues au passage.
Certaines options que l'on ne retrouve pas (pour **date** ça me froisse un peu, je vous l'avoue).
D'ailleurs aurevoir bash par défaut et dites bonjour à mon ptit ami **Ash** qui est pas mal mais à qui il manque certaines petites fonctionnalités mais rien de bien méchant.

## Les côtés moins ragoûtants

### Musl
Un choix assez clivant des devs est d'avoir *tout basé sur* **musl libc** qui est une alternative à **glibc** (la GNU Libc utilisé un peu partout).
Si vous n'êtes pas dev ça vous parle peut-être pas.
Mais en gros tous les programmes en C sont compilés via un compilateur et utilise tout un tas de fonctions standards.
Et bien ici, ces fonctions standards sont issues de **musl** qui est un poil différent de **glibc**.

À l'usage immédiat, pas de différence.
Par contre dans la pratique en tant qu'utilisateur il peut y avoir quelques points rebutants.
Un programme compilé avec la glibc ne tournera pas sur un système où se trouve musl.
Bon, en vrai on peut installer une couche de compatibilité mais pour certains programmes ça peut être chiant.
En gros tous les programmes pré-compilés refuseront de tourner ici.
Exit tous les softs proprios (à moins biensûr qu'ils fournissent une version musl, ce qui est techniquement possible mais peu probable).

Bon en vrai, dans mon cas, ça ne me gêne pas vraiment.
Je n'utilise pas de logiciels proprios et je me contente à 95% de ce qui se trouve dans les dépots.

### Conf réseau
Contrairement à Gentoo qui utilise **netifrc**, ici, c'est la merde à base de */etc/network/interfaces* .
*C'est-à-dire une syntaxe mochtoc, tout un tas de dossiers et tout*.
Et le pire, c'est que si on modifie ça, un restart du service est assez hasardeux.

### Ennuyant
*Ça marche bien.*
Les mises-à-jour ne cassent rien.

Du coup, bha on s'y ennuie.
Aucune surprise.
*Quasiment pas de maintenance*.

### Grsec t'es-tu où ?
Il y a fort longtemps, GrSec était là, de base.
Du coup d'un point de vue sécurité c'était un bon gros point positif.

Maintenant que GrSec n'est plus libre, forcément Alpine ne l'a plus.
Bon, c'est triste mais c'est comme ça.

## Voilà tout
*La communauté est grandissante*.
Du coup son wiki devient plus conséquent, le nombre de paquet s'étoffe.
Il y a même un dépot communautaire contenant pas mal de logiciels permettant d'utiliser Alpine en tant qu'OS de bureau.

*Pour des serveurs elle me semble idéale*.
*Elle a très peu de parties mobiles, une surface d'attaque très réduite*.
De ce fait elle est véloce, rapide à prendre en main, facile à backupper.

Elle est bien en container mais aussi en serveur plus traditionnel.
Elle est la base de **PostMarketOS** une distribution linux pour téléphone mobile qui petit à petit commence à se faire un nom.

À mon sens c'est *une bonne base pour débuter sous Linux*.
Le fait qu'une installation de base ne contienne que très peu de logiciels installés permet de mieux comprendre chacune de ses briques.
Il est en effet très possible de lancer **top** et de se renseigner sur chacun des processus qui tourne afin de comprendre à quoi ils servent.
Ça permet de démystifier pas mal de chose et donc de bien apprendre.
La même chose sur une ubuntu serait un calvaire sans nom.


