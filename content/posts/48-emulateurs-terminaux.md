+++
Author = "Lord"
Description = "Petit récap des émulateurs de terminal."
date = "2017-02-21T15:27:50+02:00"
title = "Tour d'horizons des émulateurs de terminal"
menu = "main"
Categories = ["software","libre","linux","cli"]
Tags = ["software","libre","linux","cli"]

+++

Coucou 2017 o/ . Et si l'on explorait les terminaux pour nunux. Enfin explorer… on va se contenter d'en présenter quelques-un un peu moins connu que la normale.

## Mes exigeances envers les terms
Ne pas planter. Hoooo non ! Le term ne peut pas planter. Ensuite faut qu'il se fasse oublier. Le term ne doit pas se voir, ce n'est qu'une fenêtre vers le reste du système. Il doit être léger. J'ouvre beaucoup de term. J'en ai pas loin d'une dizaine ouverts assez fréquemment donc bon s'ils bouffent trop de ram ça va pas le faire. Il doit être rapide. Sur ce point en fait c'est un poil gadget on pourrait croire mais au final pas tant que ça, si le term bouffe du cpu, c'est pas une bonne utilisation de mes ressources.

En résumé : *fiable*, *pas de GUI*, *léger* et *rapide*. Et les features exotiques ? mouai pas besoin. À vrai dire le scrollback (voir l'historique) est à la limite de l'exotique à mon goût, donc le split, les onglets pas besoin, c'est le boulot du Window Manager. Allez faisons le tour.

## Les classiques : pourquoi ils sont nuls ?
Bha ils sont populaires.

Bon c'est presque la raison principale. Déjà les terms d'environnement graphique non merci. Généralement ils sont plombés de dépendances à en gerber. Devoir télécharger des dizaines et des dizaines de dépendances pour me retrouver avec un term bloatés et qui traînent la patte c'est pas mon genre. Donc Aurevoir Gnome Terminal et tous ses potes basés sur la libvte (ouai Terminator, en dehors de ton nom, tu n'as rien pour toi vieux). Ils sont lents en plus. Aurevoir Konsole de chez kde trop de dépendances. Aurevoir aussi tous les terms "enroulable" à la guake and co.

Le seul classique qui vaille un poil le coup ce serait bien **xterm**. Le bon vieux basique des familles. Il est dispo partout c'est une grande force, il a peu de dépendances et il est le standard de facto donc bon toujours le garder sous la main. En dehors de ça il est lent et paraît que le code est à chier. Il est plus trop trop maintenu mais bon. Il fait le taff.

## La valeur sûre
Comment ne pas citer la famille des rxvt ? Créé à la base parcequ'xterm était bloaté (et ça date pas d'hier pourtant) il a connu de nombreux rejetons. Le plus célèbre et le plus intéressant encore aujourd'hui est **urxvt** ou **rxvt-unicode** : un fork plutôt bien gaulé. Rapide, Fiable, Configurable pour ne pas avoir de GUI, super léger en ram surtout dans son mode daemon (plusieurs terms dans un seul process). Bref il répond quasiment tous mes critères. Il connait même des variantes pour avoir des onglets pour les amateurs.

À noter : comme xterm sa conf est dans un fichier *.XRessources* du coup avec les autres applications X simples. Et ça c'est bien !

## La nouvelle vague du term indépendant
Historiquement on a donc eu le passage d'xterm vers la famille rxvt. Ensuite la vague des terms à base de vte. Et maintenant une nouvelle vague de terms indépendants (ou non). Une des grandes nouveautés est l'arrivée du Truecolor (couleur 24b, soit toutes les couleurs habituelles). Contrairement au système précédent qui fonctionne avec une palette prédéfinie (mais configurable), là l'application peut tout simplement spécifier la couleur qu'elle veut afficher.

Dans le désordre, je commence par **Termite**. Ouai je commence par un term VTE alors que j'annonçait ne pas en parler… bref. Bha heu je l'aime pas spécialement mais bon il est assez souvent cité dans les terms "à la mode". Il est pensé pour être utilisé en tiling et tente d'être plutôt basique. M'enfin.

**Terminology**, un marginal qui se la pète mais qui au final est un poil lent, nécessite pas mal de dépendances pour des features exotiques. Je salue la prestation mais bon au final c'est bien trop bling-bling. J'ai pas envie de le démolir mais bon je le recommande pas non plus. Après si vous utilisez l'environnement Enlightenment… pourquoi pas vu qu'il en fait parti mais sinon …

Parceque c'est le plus drôle de tous, il a le droit à une petite place ici : **Cancer**. Ouaip Cancer terminal. C'est fin et joyeux. Il est en rust et plutôt simple. Il gère sixel c'est assez marrant mais franchement gadget. Je l'ai pas testé plus que ça.

Un de mes chouchoux est **st**. C'est un term très simple. Pas de fichier de conf. Si on veux modifier un règlage il faut le faire dans le config.h et recompiler. Et au final ce fichier est suffisamment bien foutu et la compilation est tellement rapide que c'est pas vraiment plus long que d'éditer un fichier de conf habituel. Je l'ai très longtemps utilisé. C'est fait par les braves gars de chez Suckless qui ont à cœur de développer des outils le moins bloatés possibles avec très peu de lignes de codes. Il est rapide et gère même le truecolor. Par contre pas de scrollback, ça peut gêner au début mais on s'y fait très bien. Je l'ai gardé quelques années sans soucis.

Mais j'ai découvert un ptit nouveau, le surprenant **Alacritty**. Il est simple, pas de GUI, un ptit fichier de conf bien commenté, peu de features à la noix et un peu plus gourmand que St. Codé en rust, sa particularité est d'être le plus rapide. Et bha… c'est vrai qu'il est rapide le con ! Tout l'affichage est en fait en OpenGl. Mais du coup lui faire bouffer des dizaines de lignes devient instantanné. On peut même refaire mumuse avec la libcaca en "Haute résolution" (ouai en choisissant une font toute petite pour avoir des pixels assez petits et c'est plutôt fluide). Il est très jeune et du coup encore un peu brut de décoffrage (des ptits soucis graphiques dans de très rares cas) mais du coup il est possible d'influencer un peu son developpement. Une petite communauté s'est déjà formée. Je pense qu'il a pas mal d'avenir. Bref c'est mon nouveau jouet du moment.

Bon je vais aussi vous causer de **Notty**. Lui est encore plus exotique car il tente de s'attaquer aux standards. Lâs de devoir se conformer à ECMA48 (le protocole que les terms suivent dont la dernière évolution date de 1991 (oui, c'est pas tout neuf)) et tente de pousser quelques innovations bien venues comme par exemple pouvoir créer et utiliser des éléments d'interfaces et s'échapper un peu des caractères. Bref un vaste chantier mais s'il gagne un peu en popularité pourrait apporter un renouveau bien senti. À savoir qu'Alacritty a déjà quelques affinités envers notty. Wait&See

## La quête de l'outil parfait

Comme souvent, j'aime bien chercher des alternatives : linux au lieu de windows, gentoo au lieu de debian, bépo au lieu d'azerty, i3 au lieu de gnome, alacritty au lieu de Terminator… Et souvent on trouve des pépites : des logiciels un peu rugueux mais au final ça tombe bien je ne suis pas tout lisse. Si ma rugosité est en phase avec la rugosité de l'outil ça devient parfait \o/ Donc n'hésitez pas à tester d'autres logiciels plutôt que de vous contenter des softs les plus connus.
