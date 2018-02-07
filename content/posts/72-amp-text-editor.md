+++
Author = "Lord"
Description = "En ce moment je teste un nouvel éditeur de texte. Voilà quelques impressions sur Amp"
Categories = ["cli", "linux", "software"]
Tags = ["cli", "linux", "software"]
menu = "main"
notoc = true
draft = false
PublishDate = 2018-02-07T13:11:07+01:00
date = 2018-02-07T13:11:07+01:00
title = "Amp : un ptit éditeur de texte à la vi"
+++

J'utilise vi et ses dérivés depuis si longtemps que j'ai désormais une petite partie de ses commandes inscrits dans la mémoire musculaire.
C'est toujours amusant de voir des étudiants qui galèrent et hallucinent devant ma relative agilité alors que je n'ai pourtant qu'un niveau relativement faible en vimerie.
Bref ces derniers temps j'ai entendu parlé d'un nouvel éditeur de texte. **Amp**.

La fiche technique me parle pas mal : léger, taillé pour la console, inspiré par vi, une configuration par défaut moderne et bonus de la hype : c'est en rust.

Du coup ni une ni deux je git clone et je compile.

{{< figure src="/static/72-amp-landing.png" title="Arrivée dans amp" alt="" link="/static/72-amp-landing.png" >}}

Austère comme j'aime :-)

Bon et sinon ? Il va falloir lire un peu la doc parceque là c'est inspiré de vi mais les commandes ne sont pas pour autant du copié/collé de vi. La migration (si elle se fait) va être un peu douloureuse.

## Commandes en vrac pour se débrouiller un minimum

  - Ouvrir un fichier : ***espace*** puis c'est du fuzzy search à partir du dossier courant.
  - Fermer le fichier actuel ***q***
  - Sauvegarder ***s***
  - Passer en mode *insert* ***i***
  - Bouger dans le fichier *jump mode* ***j***
  - Chercher *search mode* ***/***

Bon je pense que c'est un peu le minimum à savoir dans un tout premier temps.

## Bon et ça ressemble à quoi en vrai ?

Et bien à ça :

{{< figure src="/static/72-amp-article.png" title="L'article en cours de rédaction (remarquez les fautes)" alt="Capture d'écran de l'interface d'amp" link="/static/72-amp-article.png" >}}

Bon alors déjà ça ressemble plus à ce qu'on est habitué à voir. Des *lignes numérotés*, de la *coloration syntaxique* (hmmm on en reparle un peu plus loin), une *barre de status* en bas indiquant le mode, le fichier en cours et parfois même d'autres infos.

Pas de quoi casser trois pattes à un canard.

### Réapprendre

Bon je l'utilise un peu plus pour voir un peu comment il s'utilise.
Je me heurte assez fortement à mes habitudes vimmiennes.
Il me faut tenter de ne pas penser à vi mais à cette nouvelle philosophie.
Un peu plus de lecture de doc et du coup je me rend compte qu'il faut un peu plus utiliser des *modes*.
Et surtout il faut regarder un peu les raccourcis par défaut.

### Command mode

Et là je découvre le *command mode* (que l'on atteint via ***0***).
Du fuzzy search (oui oui encore !) pour trouver un peu toutes les commandes existantes.
Toutes les commandes possibles y sont répertoriées et donc vous pouvez les débusquer assez simplement.

### Jump mode

Plutôt que d'ajouter de nombreux mots-clé pour se déplacer, ils utilisent une sorte de *hint mode* qu'on retrouve dans qutebrowser.
C'est à dire que lorsque vous êtes dans ce mode, amp va placer un peu partout des lettres jaunes dans votre texte.
Vous entrez les deux lettres placées à l'endroit où vous voulez placer le curseur et hop le tour est joué.
Une image ?

{{< figure src="/static/72-amp-avant-jump.png" title="Avant le jump mode" alt="Capture d'écran illustrant le jump mode" link="/static/72-amp-avant-jump.png" >}}
{{< figure src="/static/72-amp-pendant-jump.png" title="Une fois dans le jump mode" alt="Capture d'écran illustrant le jump mode 2" link="/static/72-amp-pendant-jump.png" >}}

Comme vous pouvez le constater il y a les lettres en jaune qui sont rajoutées un peu partout.
Du coup il vous suffit de tapper celle qui vous intéresse et hop votre curseur s'y téléporte.


### Trouver tous les raccourcis
Dans le *command mode* entrez *application::display_available_commands*, ce qui vous listera toutes les commandes et *application::display_default_keymap* pour afficher tous les raccourcis.
Ça devient vite indispensable lorsqu'on débute avec amp.

Bon donc au bout d'une semaine voilà un peu mon ressenti.

## Ce qui me plaît

*C'est rapide*.
Bon c'est pas non plus extraordinaire qu'un ordi de 2018 ne rame pas pour éditer du texte mais c'est toujours agréable.
Amp s'ouvre direct, les changements de modes sont instantannés, la recherche de fichier est sacrément réactive.
Bref c'est snappy !

*La config par défaut qui est bien branlée*.
J'adore *vi* mais franchement la config par défaut est un peu légère tout de même.
C'est quand même à la limite de l'utilisabilité par défaut.
Et franchement c'est un peu dommage pour un logiciel qui a le gigantesque avantage d'être dispo sur tous les os que j'accepte de toucher.
Là on se retrouve avec de la coloration de base, l'indication des modes clairement affiché, une barre de status utilisable.
La base minimale est utilisable directement.
Je dois avouer que je sais même pas s'il y a un fichier de configuration.
J'ai pas eu besoin d'aller le regarder pour faire mumuse pour le moment.


C'est *un projet en début de dev* avec du coup beaucoup d'activité sur le repo.
De nouvelles features arrivent.
Les bugs se font chasser assez vite (et il y a du boulot).
C'est assez sympa cette sensation de voir le logiciel s'améliorer chaque jour et de voir ces ptites améliorations continuelles arriver.
Et du coup c'est même assez facile de contribuer au logiciel. Sa documentation est pour l'instant… assez spartiate.
J'ai d'ailleurs contribué un peu à son amélioration et je continuerai probablement un peu.

De l'*audace dans la réinterprétation de vi*.
C'est déroutant au début et au final on trouve de sacrément bonnes idées.
Le *jump mode* est génial, c'est dans la même philosophie que QuteBrowser du coup je suis pas perdu.

Le *command mode* est génial.
Alors je vais avoir l'air de débarquer mais ce mode est génial et fait cruellement défaut à vi (je sens qu'on va me dire qu'en fait ça existe…).
Il paraît que cette fonctionnalité est de base dans emacs mais je n'ai jamais vraiment poussé emacs.
Je veux cette fonctionnalité partout maintenant !

## Ce qui me plaît moins

C'est *un projet en début de dev*.
Et du coup il y a des bugs.
La doc est très légère.
C'est un atout mais c'est un peu rebutant pour certains.
J'arrive tout de même à m'en accomoder.

C'est *pas un clone de vi*.
C'est également un atout mais un poil problèmatique quand on doit surpasser sa mémoire musculaire et que l'on réflêchit à "comment effectuer telle action ?".
Le truc qui m'irrite le plus sont le ***G*** et ***gg*** de vi qui ne fonctionnent pas. Je le fait tellement instinctivement que devoir faire autrement me déroute quelques secondes. (***J*** et ***K*** si vous les cherchez)

## Les quelques bugs que j'ai rencontrés
Bon rien de vraiment insurmontables, certains sont déjà corrigés (ou presques) d'autres sont déjà rapportés.
Pas de gros bugs qui crashent (tout du moins j'en ai pas rencontré) mais par exemple, vous ne pouvez sauvegarder votre fichier que s'il y a une ligne vide à la fin.

Ou bien si vous le lancez à la racine d'un dossier contenant beaucoup de fichier, il va tenter de tous les scanner pour faire le fuzzy search par la suite.
Il va donc se bloquer pendant quelques secondes (voir minutes).

Un truc plus étrange c'est lorsque le curseur atteind le bas de la fenêtre, la fenêtre ne défile pas et du coup vous n'avez plus qu'à tapper à l'aveuglette.
Il vous faut donc scroller manuellement avec ***,*** et ***m***.
Une habitude à prendre.

Le bug le plus chiant au final c'est la coloration syntaxique comme vous pouvez le voir sur les différents screenshots.
Elle est complètement foireuse pour le markdown, à l'agonie pour le xml, le html par contre est presque bien geré.
En gros les caractères spéciaux (d'échappement souvent) la mette à la peine.
N'étant pas codeur ça ne m'impacte pas trop mais j'imagine que pour quelqu'un vraiment habitué ça peut être complètement paralysant.

-----

## TL;DR

**Amp est vraiment sympa mais un peu jeune.**
À surveiller de près.
Je pense continuer à m'en servir pour bloguer et autre.

Vi gardera toujours l'avantage d'être disponible partout du moindre busybox à la bonne grosse gentoo des familles… Mais amp peut devenir une alternative sympatoche.

