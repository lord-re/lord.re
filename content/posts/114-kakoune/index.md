+++
Author = "Lord"
Description = "Découverte de kakoune un éditeur de texte TUI modal inspiré par Vi."
Categories = ["cli", "linux","software"]
menu = "main"
notoc = true
PublishDate = 2018-04-17T17:42:53+02:00
date = 2018-07-11T21:42:53+02:00
title = "Kakoune"
editor = "Kakoune"
jdh = "https://www.journalduhacker.net/s/sjcgq3/kakoune"
TopWords = [  "curseurs", "éditeur", "édition", "amp", "bar", "entrée", "sélectionner", "status", "clippy", "kakoune","vim","vi"]
+++
Après avoir un peu utilisé [Amp]({{< ref "/posts/72-amp-text-editor">}}) j'utilise désormais kakoune depuis quelques mois.
En fait à la base je n'avais pas l'intention de migrer aussi vite vers un autre éditeur mais pas de bol, une mise à jour de ncurses à rendu Amp inutilisable à cause de bugs graphiques dans tous les sens.
Une mise à jour était nécessaire mais du coup je suis allé voir un peu ailleurs voir ce qui se faisait.

J'ai été tenté par [Xi](https://github.com/google/xi-editor) mais je me suis rappelé d'un autre qui me faisait de l'œil depuis quelques années : [Kakoune](http://kakoune.org/).

## C'est pas du Vi mais c'en est pas loin non plus
{{< img link="114-welcome-to-kakoune.thumb.png" title="Welcome to Kakoune" src="*14-welcome-to-kakoune.png" alt="Capture d'écran de l'accueil de Kakoune avec Clippy indiquant le changelog important" >}}
Donc ce cher petit est modal (ouai j'essaye que ce genre d'éditeur mais j'aime beaucoup ce principe).
Il se base également sur des actions (ou verbes) comme par exemple supprimer/remplacer… mais contrairement à Vi, la syntaxe est dans l'autre sens : *d'abord on sélectionne le texte sur lequel on veut effectuer une action puis on choisi l'action.*
C'est le ptit détail qui a l'air assez insignifiant mais qui permet de mieux borner ses actions puisqu'*avant même d'effectuer une action je vois la sélection sur laquelle elle sera appliquée.*

## Par défaut
Kakoune est assez récent et n'est donc pas encombré d'un lourd héritage et surtout possède des réglages par défaut vraiment utilisables.
Après quelques mois, mon fichier de config ne contient que trois lignes.
Pas besoin d'aller fouiller dans les confins de la doc ou autre pour le rendre utilisable au quotidien.

Par défaut il y a la coloration syntaxique, par défaut il y a l'auto-complétion automatique, par défaut il y a une status bar bien foutue.
Bref par défaut c'est déjà suffisant pour la plupart des utilisations.

## Aide contextuelle
Il y a *toujours une petite aide contextuelle* sous forme du célèbre Clippy qui reprend enfin du service !
Mais si Clippy !
Le ptit trombone de Word 97 avec ses supers conseils !
Et bha il est là !
Et mine de rien ça aide vachement et évite d'aller voir la doc pour des ptits trous de mémoire réguliers.

Un exemple ?
Pour sauvegarder il faut taper <samp>**:w**</samp> puis <samp>Entrée</samp>, mais si vous n'appuyez pas tout de suite sur <samp>Entrée</samp>, vous verrez alors en bas de la fenêtre ceci :
{{< img link="114-clippy.thumb.png" title="Clippy the Almighty" src="*114-clippy.png" alt="capture d'écran de l'interface de Kakoune montrant la status bar et Clippy" >}}
Tout en bas il y a la status bar que je détaillerai plus loin.
Et juste au dessus sur fond jaune (le thême de couleur par défaut est pas des plus seyant) vous avez le Clippy qui vous indique à quoi correspond l'action en cours et les options possibles.

## Status bar
Dans tous les logiciels en <abbr title="Text User Interface, les logiciels en console avec interface graphique interactive">TUI</abbr> on retrouve souvent une status bar en bas.
Kakoune ne fait pas exception, voilà ce que vous y trouverez par défaut :

  - Le nom du fichier en cours d'édition
  - La position dans le fichier sous la forme Ligne:Colonne
  - Le <samp>[+]</samp> indique <abbr title="est-ce qu'il y a des modifs?, est-ce que c'est un nouveau fichier ?, est-ce que l'on est en débug ? est-ce qu'on enregistre une macro?">le contexte</abbr>
  - Le mode actuel
  - Le nombre de sélections (et donc de curseurs)
  - Les informations concernant le client/serveur

Et bien entendu vous pouvez changer tout cela pour afficher ce que vous voulez comme l'indique la [doc](https://github.com/mawww/kakoune/wiki/Status-Line).

## Multi-curseur
C'est une fonctionnalité qu'on retrouve de plus en plus souvent et c'est vrai que c'est pas mal utile quand même.
Au lieu de n'avoir qu'un seul curseur où écrire, vous pouvez en avoir plusieurs simultanément.

### exemple 1
Par exemple, juste au dessus j'ai fait une liste d'éléments alors que lors de la rédaction j'ai fait une phrase.
Du coup comment je l'ai découpée puis transformée en liste ?

Tout d'abord je sélectionne toute la ligne avec **<samp>x</samp>**, ensuite je lance la commande de sélection avec **<samp>s</samp>** ce qui ouvre un prompt en bas.
Là je rentre les éléments que je veux sélectionner pour y placer les curseurs, dans mon cas **<samp>,</samp>** pour sélectionner chaque virgule.
Après avoir validé avec <samp>Entrée</samp> je me retrouve avec tous mes curseurs.
Maintenant un petit **<samp>d</samp>** pour supprimer les virgules, puis passage en mode édition avec **<samp>i</samp>** et enfin **<samp>Entrée</samp>** pour ajouter les retours à la ligne.
**<samp>  - </samp>** pour créer les puces et voilà.

N'oubliez pas de virer tous les curseurs à la fin en appuyant sur la touche **<samp>Espace</samp>**. 

### Seek&Replace
Une fonction souvent utilisée est de remplacer une chaîne de caractère par une autre.
Sous vim ça se ferait avec le fameux **<samp>s/machin/truc/</samp>** avec éventuellement le **<samp>%</samp>** pour le faire sur tout le fichier en cours d'édition.

C'est absolument pas visuel et du coup ça a un fort potentiel de casse-gueulerie.

La méthode à la Kakoune pour ça est bien plus visuel :

Tout d'abord faut sélectionner la zone de texte où vous voulez l'appliquer (<samp>%</samp> pour tout le fichier).
Par exemple pour le faire de la ligne 10 à 18 on se place sur la ligne 10 avec **<samp>10g</samp>** puis on sélectionne jusqu'à la ligne 18 avec **<samp>18G</samp>** (remarquez le G majuscule qui permet de sélectionner).
Ensuite on démarre une sélection avec **<samp>s</samp>** puis vous tapez la chaîne de caractère à modifier **<samp>machin</samp>** et vous validez avec **<samp>Entrée</samp>**.
Vous voyez du coup toutes les occurrences qui seront affectées par vos modifs.
Et là **<samp>c bidule</samp>** pour changer le texte par "bidule".

C'est pas plus compliquée que la méthode vim et plus safe.

## Verdict ?
Vous vous rendez probablement compte que du coup dans kakoune il faut prendre les bons réflexes pour sélectionner le texte que l'on veux modifier, c'est l'élément crucial.
Une fois cette habitude acquise, *l'utilisation est assez simple et rapide*.

Il est bien plus avancé dans son dev que Amp par exemple.
Pour de l'édition de texte c'est franchement génial.
Pour coder j'imagine que ça ne plaira pas à tout le monde.

L'écosystème de plugin de vim est une sacrée force mais au final *j'aime pas installer des cargaisons de plugins* pour pouvoir me servir d'un éditeur de texte.
Le second avantage de vi(m) est son *omniprésence* (intégré à busybox toussa).
Ce qu'aucun éditeur de texte ne pourra jamais concurrencer.

Bref ces 5 derniers mois je l'ai pas mal utilisé et je vais continuer.

Tant pis pour Amp qui m'avait bien plu mais ton bug m'a fait goûter/adopter autre chose.

:wq
