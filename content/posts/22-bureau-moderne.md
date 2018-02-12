+++
Author = "Lord"
menu = "main"
Categories = ["libre","linux","ux","gentoo","i3"]
Description = "Des réflexions sur un bureau moderne sous Linux. Quelle philosophie et quels outils pour atteindre ces objectifs."
date = "2012-07-22T22:17:39+02:00"
title = "Un bureau moderne sous linux"

+++

Ouais un petit titre prétentieux et même trompeur diront certains (dont je ne fait pas partit, mais on s'en fout vu que ces certains n'ont pas la parole). Au final, je viens de réinstaller une gentoo sur mon bon vieux laptop d'il y a quatre ans. La petite arch qui y trônait a rendu l'âme (une sombre histoire d'update au bout de plusieurs mois sans servir) et du coup j'ai voulu revenir à cette bonne vieille gentoo. Je me retrouve avec toute une petite flottille sous gentoo, plus de traître à la maison.
J'ai au final réinstaller sur un schéma très proche de mon ordi fixe. J'ai utilisé un petit PXE pour booter une debian des familles. J'en ai d'ailleurs profité pour la mettre à jour après plusieurs mois d'abandon et elle n'a pas trop souffert. Gnome3 n'est pas si pourri que ça (tout du moins pas gnome-shell), avec un peu d'habitude et quelques jours passés avec, j'imagine qu'on doit en avoir une plutôt bonne maîtrise. Mais trêves de conneries allons droit au but : la gentoo en desktop moderne.

## Gentoo ! What did you expect ?
Un petit tour d'abord sur gentoo. On la dit en perte de vitesse mais que nenni. Cette distro est toujours au top et garde toujours ses atouts. C'est *stable*, ça fonctionne très bien, *peu de surprise*, *tout est bien rangé*, *la doc est excellente* et c'est *personnalisable à souhait*. La flexibilité !

Les paquets fournis de bases sont peu nombreux et peuvent être facilement remplacés pour la plupart. Le gestionnaire de paquet est un petit bijou et permet l'ajout de dépôt externe de façon ultra simple (c'est plus simple que chez noobentou). Bon je vais pas vous faire un paragraphe plus long, vous avez compris je suis un fanboy accompli.

Un desktop. Quand je dit ça, je l'oppose pas au laptop mais au monde des serveurs. *Je suis convaincu que linux (couplé à son gnou) est un OS parfait pour un desktop (même gentoo).* Tout peut y être fait appart jouer (et encore en chipotant on peut s'en sortir un peu même si ce n'est pas la panacée).

C'est un OS qui *supporte des tonnes de matos*, qui est *bidouillable de partout* avec un *choix d'environnement logiciel gigantesque*. Là où sous d'autres OS on en chie pour changer une icône, ici on peut tout modifier et *avoir un environnement qui ne peut que nous convenir*.

Je ne dit pas que c'est facile. Loin de là. Si on veux un environnement aux petits oignons parfaitement polis de partout ça va être long et il ne faudra pas être un débutant nunuxien. Pour ces personnes là, il faudra se tourner vers des distros qui ont fait ce travail à notre place. Mais qui du coup auront également pris les choix à notre place.

C'est donc un compromis. Mais la patience étant une vertu, la maîtrise d'un outil s'acquière avec le temps et surtout l'expérience dépend de l'investissement.

## Modern Desktop
*Bon au final c'est quoi un desktop moderne ?*

Je dirais que c'est un environnement informatique que l'*on maîtrise* au poil de cul. Où *chaque aspect nous sied* et où le compromis disparaît au profit d'une *satisfaction maximale*.

Je suis personnellement adepte de la perfection qui s'atteint lorsqu'il n'y a plus rien à enlever. Je veux un OS qui se contrôle parfaitement à la souris mais (et surtout) au clavier. Ne plus être contrait de chopper ce satané mulot est un confort qui s'apprécie avec le temps. Il m'arrive de temps à autre de chopper le raton après seulement une heure d'utilisation de l'ordi à cause d'un site ouaib mal branlé (genre celui que vous lisez).

Un point important de l'ergonomie est également une *cohérence dans les raccourcis claviers des différentes applications*. Je tente en effet de garder une certaine logique. Par exemple pour fermer mon navigateur j'utilise Ctrl-Q, pour fermer mon gestionnaire de fenêtre, je déclenche un joli Alt-Shift-Q, pour éteindre l'ordinateur c'est un voluptueux Alt-Q. En sachant que les raccourcis utilisant la touche Ctrl sont ceux du navigateur, la touche Alt servira pour les raccourcis du gestionnaire de fenêtre ainsi que du gestionnaire de login (étant donné qu'un seul à la fois à le focus, cela ne pose pas de soucis).

Actuellement mon utilisation se résume à de la navigation web et des applications en consoles. *Je n'ai quasiment aucune application graphique*. Ça ne fait pas très 2012 comme ça mais pourtant c'est très efficace. On trouve de plus en plus d'applications web (webmail, lecture vidéo, lecture de musique,...), ça devient un environnement quasi-complet.

D'ailleurs, *jetez-moi ces onglets de votre navigateur*. Pourquoi s'embêter avec cela ? Vous n'avez pas déjà un gestionnaire de fenêtre dont c'est le boulot ? Ça vous permettra de réduire le nombre de raccourcis à retenir/utiliser. Ça permet également une plus grande souplesse. Vous bénéficierez de toutes les joyeusetés de votre WM, des onglets, du stacking, du fullscreen, du floating, de la mosaïque...

Et *virez-moi cette barre d'adresse* également. Combien de fois vous sert-elle réellement ? Lorsque vous ouvrez une page, appuyez sur une touche pour indiquer que vous entrez une url (ce qui en plus prendra le focus sans utiliser la souris) et basta. Encore un gain d'espace et toujours plus prêt du minimalisme. Si vous avez du mal à le faire par vous même testez quelques temps un navigateur propre,simple et moderne tel que surf.

Bon allez, vu que j'ai déjà dévoilé un navigateur, voici la liste des principaux éléments d'un os moderne (toujours selon moi, je devrais pas le préciser puisque c'est mon "blog", mais bon).Voyons ça dans l'ordre d'utilisation.

## Login→Fenêtres→Terminal

### Login Manager
On commence par le login manager.

J'utilise **qingy**. C'est un login manager *très léger* et pourtant *très puissant*. Il remplace login/*getty/gdm/kdm/slim/orthos. Il a pas mal d'avantages. Déjà il est léger et possède peu de dépendances. Il peut être à la fois purement console ou bien graphique. Lorsqu'il est graphique, il ne tourne pas sous X mais sous DirectFB, ce qui permet lorsque l'on casse son X d'avoir au moins un login manager qui fonctionne (pas le cas de gdm et kdm). Même en mode console *il permet de choisir sa session*. On peut donc démarrer une session X (un wm, un DE) ou bien session texte (un shell, un script). Il peut *se souvenir du dernier utilisateur loggué*. Il peut *lancer X dans le tty d'origine* ce qui facilite les utilisateurs multiples simultanés. Il peut *locker votre session* lors d'une inactivité ou bien lors d'un changement de tty. Non il est juste parfait.

### Window Manager
Vient ensuite le gestionnaire de fenêtre (WM). J'ai trainé pendant un couple (huhu) d'année sous wmii. Il était vraiment bien mais au final son architecture exotique à la plan9 bien qu'intriguante était fatiguante.

Je me suis tourné vers l'un de ses successeurs : **i3**. C'est à mon goût ce qu'il se fait de mieux en tiling. Il a toutes les qualités qu'on peut en attendre. C'est *léger*, *rapide*, *simple* et le pire c'est que *ça marche* ! Il permet virtuellement *tous les layouts imaginables*. On peut empiler les fenêtres, les gérer comme s'il s'agissait d'onglet, mettre côté-à-côte, mettre l'une sur l'autre, combiner le tout plusieurs fois. Et tout ça au clavier avec un fichier de configuration très simple (pas de langage à compiler ni à connaître). On peut lui ajouter facilement des raccourcis pour gérer un lecteur multimédia, lui ajouter une barre avec des infos. On peut modifier l'apparence des bordures des fenêtres : 1pixel seulement, une barre de titre ou même sans bordure. Bref, c'est le WM en tiling parfait.

### Terminal
Pour l'émulateur de terminal le choix est assez simple. Il faut un terminal qui se débrouille bien en *unicode*, qui soit *léger*, *rapide*, *ne plante pas* et puisse être *pas trop moche* (je le regarde 8h/jour le pépère). J'ai choisis **rxvt-unicode** (urxvt pour les intimes). Il répond à tous ces critères et possède même un exotique mode *client/serveur* : urxvtd attend les connexions d'urxvtc. Vous avez du coup un seul démon qui tourne en mémoire et tous les clients disparaissent en lui (enfin je me comprends). Ce qui ne fait qu'un seul process pour tous les terms. Ils sont donc instantanés à l'ouverture et bouffe moins de ram.

## Web 3.5
Pour le navigateur, je vous ai quelque peu induis d'erreur en vous préconisant surf. Il est bien avec un bon moteur de rendu (webkit) mais il a quelques aspects un peu trop limites à mon goût.

Je lui préfère le bon vieil **Opera**. Et ouai il est pas opensource libre toussa. Mais putain ce qu'il est bien ! *Ultra personnalisable*, *léger*, *fait tout*, toujours *à la pointe des standards* (ou presque), *tout pleins de features*.

Je l'utilise d'une façon particulière : j'ai viré toute son interface. Il n'a plus aucune barre d'outil : pas de barre d'onglets vu que je ne les utilise pas, pas de barre d'adresse vu que ça ne sert que très peu, pas de barre de statut parce que, bhaaa, je sais pas trop à quoi ça sert... Pour les onglets je gère ça au niveau d'i3. Je règle Opera pour qu'il ne gère qu'une page par fenêtre et qu'il ouvre des fenêtre en lieu et place d'onglet. C'est ensuite i3 qui les gère à ma convenance selon l'humeur du moment. Je déplace les pages web d'un bureau à l'autre, à côté d'un terminal, ou bien stacké dans un coin... Pour la barre d'adresse, j'ouvre la fenêtre pop-up d'adresse par F2. Du coup je dois appuyer sur un bouton avant d'entrer l'adresse. Au final, ça ne rajoute qu'une touche, ce qui est généralement négligeable face à la longueur d'une URL.
Un reproche récurrent c'est le fait de ne plus "maîtriser" l'adresse. Les rares cas où j'édite une URL, je peux le faire en faisant réapparaître la barre d'adresse par F1.

Si votre coeur de libriste se déchire à la vue de la licence, vous pouvez vous rabattre sur surf, uzbl (tous les deux en webkit) ou bien vimprobable, pentadactyl (gecko) mais ce sera pas aussi souple/pratique/bien.


Bon bha je vous ai fait un roman mais au final c'est peut-être plus, comment dire ? ... personnel, blog, expressif, parabolique, que d'habitude. J'ai tout de même le sentiment d'oublier des choses. Je compléterait peut-être par la suite.


*PS février 2018 :*

Bon bha globalement c'est toujours vrai. J'utilise toujours qingy, i3, le terminal j'ai migré vers alacritty mais urxvt est toujours recommandable.

Par contre niveau navigateur… bha Opera c'est devenu de la merde en barre. C'est dommage. Du coup bha j'ai migré [une première fois chez Firefox]({{< ref "posts/24-navigateur" >}}) puis plus récemment sur [Qutebrowser]({{< ref "posts/64-qutebrowser" >}}).
