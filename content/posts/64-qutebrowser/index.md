+++
Author = "Lord"
Categories = ["web", "www", "qutebrowser", "software"]
Description = "Petite présentation de Qutebrowser. Un navigateur webkit/blink utilisant Python et QT5 avec une interface à la vim."
Tags = ["www","web", "qutebrowser", "software" ]
date = "2017-11-08T16:03:10+01:00"
menu = "main"
notoc = true
title = "Qutebrowser"
jdh = "https://www.journalduhacker.net/s/lzm6ml/qutebrowser"

+++

Voilà quelques mois maintenant, j'ai migré sur Qutebrowser. C'est un ptit navigateur peu connu qui ne se démarque pas par son moteur de rendu (encore qu'en fait si !). Il a la particularité de pouvoir tourner avec plusieurs moteurs de rendu différents. Il se distingue surtout par son interface utilisateur qui se veux absolument pas intuitive mais c'est clairement sa force.

## MoteurS de rendu

Il propose en effet plusieurs moteurs. Tout d'abord le bon vieux webkit, tout du moins dans sa déclinaison Qt. Mais celui-là est sur le déclin et devrait disparaître à terme. Il y a ensuite webkit-ng qui est le successeur de webkit. Bon j'avoue c'est un peu pareil… Et puis il y a également qt-webengine. Haha !

Vous le connaissez pas celui-là ! Et en fait il s'agit de Blink, le moteur de chrome/chromium mais légèrement retouillé pour Qt. Donc bon c'est quand même un dérivé de webkit mais plus moderne. Bref. Selon votre distribution, vous pourrez (ou pas) choisir le moteur de rendu à utiliser. Perso j'utilise qtwebengine.

## L'interface

Tout l'intéret de QuteBrowser est son interface utilisateur. Elle est inspirée par des addons Firefox ne pouvant pas être reproduit via la nouvelle API de Firefox 57 : Vimperator et Pentadactyl. L'idée de l'interface est de virer le plus possible l'interface graphique et d'utiliser massivement le clavier. Exit les boutons, aurevoir la barre d'adresse, ciao la souris !

Toutes vos interactions se feront donc au clavier. Le seul élément d'interface restant est la *status bar* en bas qui contient l'adresse de la page actuelle ainsi, que la position actuelle dans la page (en haut, à 10% du haut, tout en bas, bref pour savoir si vous pouvez descendre encore) ainsi que le numéro d'onglet de la page actuelle.

{{< figure src="qute1.png" title="Interface de qutebrowser" alt="capture d'écran de l'interface de qutebrowser" >}}

Comme vous pouvez le voir, c'est dépouillé.

Tout se fait donc avec des raccourcis claviers mimant le fonctionnement de **vim**. Donc le fameux ***hjkl*** (que je n'utilise pas) pour se déplacer. Le ***G*** et ***gg*** pour aller en fond de page ou au début.

Un système très important c'est le ***f*** qui va vous permettre de *hinter* les liens. C'est à dire que chaque lien de la page va se voir attribuer un repère que vous aller taper pour l'ouvrir. Dans mon cas j'ai modifié le comportement par défaut pour utiliser le mode *number* (**:set hints.mode number**). Il me suffit donc d'appuyer sur **f** puis d'entrer quelques lettres du lien en question, s'il n'y a pas d'ambiguité, la page s'ouvre. Si plusieurs résultats sont possibles chaque résultant restant aura un numéro attribué qu'il me suffira d'écrire :

{{< figure src="qute2.png" title="Activation du hint" alt="capture d'écran de l'interface de qutebrowser" >}}
{{< figure src="qute3.png" title="Une fois tappé home" alt="capture d'écran de l'interface de qutebrowser" >}}


Ça peut paraître lent et contre-intuitif au début mais au bout d'une heure ou deux c'est au final très rapide. Surtout si l'on est déjà vimiste.

## Utilisation

### Éditer du texte

Tout comme vim, qutebrowser est modal. Par défaut vous êtes en *mode normal*. Si vous vous mettez dans un champs de texte (via ***f*** par exemple), Qute devrait de lui même passer en *-- INSERT MODE --* mais parfois c'est pas le cas (merci js) du coup faut l'activer en appuyant sur ***i***. Pareil si vous êtes sur une page web utilisant des raccourcis claviers il faudra passer en mode insertion.

C'est bien gentil mais bon si on doit éditer du texte un peu long pour un wiki ou votre webmail, que ne rêve pas d'utiliser vim directement (ou éventuellement emacs (ouai ou nano)) ? Et bha c'est possible avec ***^e*** dans un champs de texte. Ça lancera la commande d'édition où vous pouvez mettre ce que vous voulez. Personnellement je lance un terminal avec vim. Une fois le texte édité, vous enregistrez/quittez et hop ça apparait magiquement dans qute ! (vous pouvez choisir quel éditeur avec **:set editor.command '["alacritty", "-e", "vim", "{}"]'** ).

### La status bar

Tout comme vim, vous pouvez y lancer des commandes en commançant par **:** . Par exemple pour modifier un réglage c'est **:set content.javascript.enabled false** . En sachant qu'il y a de l'autocomplétion plutôt efficace.

C'est aussi elle qui va vous permettre de taper une recherche/adresse. Soit vous lancez la commande **:open** soit vous tappez ***o*** qui fait la même chose. Si vous voulez éditer l'adresse de la page actuelle c'est ***O***. Par défaut ça effectuera une recherche sur le moteur par défaut.

### Recherche

Par défaut si vous entrez une adresse qui en fait n'est pas une vraie url, qute vous enverra sur la page de recherche correspondant à ce que vous avez tapper dans le moteur par défaut.

Vous pouvez cependant rajouter des raccourcis vers d'autres moteurs de recherche. Par exemple **:open w linux** vous enverra sur la page wikipedia de linux, **:open y slayer** vous enverra vers les résultats youtube de Slayer. Pour obtenir ce résultat voici le réglage à mettre dans **:set url.searchengines '{"DEFAULT": "https://duckduckgo.com/?q={}", "w": "https://fr.wikipedia.org/w/index.php?search={}", "y": "https://www.youtube.com/results?search_query={}"}'**

### Réglages

Vous pouvez modifier tous les réglages via **:set le.nom.du.réglage** . C'est vraiment super sauf quand vous savez pas trop comment s'apelle le réglage en question. Si l'autocomplétion ne trouve pas ce que vous voulez vous pouvez vour rabattre sur l'adresse particulière : [qute://settings](qute://settings) où vous trouverez tous les réglages existants.

### Les onglets

Les onglets dans qute s'apellent des buffers (comme dans vim). Comme déjà [raconté en 2012](https://lord.re/posts/22-bureau-moderne/), je n'utilise plus d'onglets mais des fenêtres toutes indépendantes que je gère au niveau de mon WM. Pour ça Qute est très conscilient avec **:set tabs.tabs_are_windows** qui est l'option la plus explicite :-)

## Conclusion

C'est franchement un bon navigateur qui remplace sans trop de soucis vimperator. Certaines fonctionnalités sont pas encore là mais 90% des fonctionnalités sont là. Faut bien garder à l'esprit que c'est un navigateur assez jeune et dont le dev est aussi assez jeune. Par contre la communauté autour du projet grandit petit à petit.

Les évolutions futures sont prometteuses. Le dev principal souhaite donner la possibilité d'avoir des réglages différents par domaines. Le but à terme est de recréer un uMatrix pour Qutebrowser. C'est pile poil ce qui me fait le plus défaut depuis l'abandon de firefox.

Le dev est d'ailleurs très accessible sur irc et j'ai déjà discuté avec lui d'une éventuelle possibilité de migrer vers le moteur de rendu servo. Selon lui c'est possible mais c'est pas du tout dans les objectifs actuels.

Ce navigateur est une bonne bouffée d'air frais face aux mastodontes et montre qu'il existe des alternatives crédibles.

 


  - Le [dépot github](https://github.com/qutebrowser/qutebrowser/)
  - Le [site officiel](https://www.qutebrowser.org/)

## Astuce concernant les vidéos

Personnelement j'aime pas spécialement regarder des vidéos dans le navigateur mais je suis un gros consommateur de vidéo en ligne, que ce soit des sites de replay ou plus classiquement youtube voir twitch. Ce que je fait c'est qu'une fois une page ouverte contenant une vidéo intéressante, j'utilise la touche ***m*** pour filer la page à MPV afin qu'il s'en débrouille pour m'afficher la vidéo.

J'ai également ajouté un mode de hint où la page choisie ne s'ouvre pas dans qute mais est directement passée à MPV, du coup ça m'évite d'ouvrir la page puis de la filer à MPV. Pour ça j'ai choisi **Fm**.

**:set bindings.commands '{"normal": {"F": null, "Fm": "hint links spawn --detach mpv {hint-url}", "m": "spawn --detach mpv {url}"}}'**
