+++
Author = "Lord"
Description = ""
Categories = ["golang","code"]
menu = "main"
notoc = true
WritingDate = 2024-10-06T20:31:00+02:00
date = 2024-10-06T20:31:00+02:00
title = "Inclure les sources d'un programme en Golang"
editor = "helix"
Audio = ""
Soustitre = ""
+++
Je suis un piètre programmeur.
C'est pas mon boulot, c'est pas ma formation et … ouai bon j'ai pas à me justifier.
Je suis également un piètre scripteurs.
J'utilise linux depuis longtemps et oui j'ai eu besoin de scripter des trucs.

## /bin/sh -> golang

C'est très souvent moche, surement gavé de bugs mais ça fini parfois par tomber en marche suffisamment pour que je m'en serve.
Et c'est un peu con mais autant que possible je veux que mes ptits scripts aient le moins de dépendances possibles et si possible posix.

C'est con parcequ'au final ces scripts ne bougent pas.
Je les utilise là où je les écris.
Ils ont rarement l'occasion de voyager vers d'autres machines mais bon je tente autant que faire se peut de m'astreindre à les rendre facilement utilisable.

Le problème des scripts c'est qu'au bout d'un certain moment ça devient un peu le merdier.
Le shell posix monte assez vite ses limites et on se retrouve à devoir appeler plein de programmes rendant le script au final peu portable.
Bha ouai parceque bon si n'importe quel shell peut parser et exécuter votre script c'est cool.
Mais si votre script nécessite des dizaines de programmes différents c'est de suite moins compatible et portable.

Et c'est en grande partie pour ça que j'aime le langage Go (golang pour les non-intimes).
Ça produit un gros binaire statique sans dépendance.
On le colle là où on a besoin et ça juste marche.
C'est d'une élégance rare !

Rien à installer, pas d'interpréteur avec plein de versions et tout.
Pas de libs à déployer.
Non tout se retrouve dans votre binaire que vous poussez là où il y a besoin.

## Je suis bordélique et un sagouin

Ne codant que très rarement, j'ai aucune organisation propre pour gérer mes ptits programmes.
Pourtant j'ai tout ce qu'il faut pour faire ça proprement.
J'ai une instance gitea qui tourne dans mon routeur.

Mais j'ai la flemme, j'y pense pas sur le moment.
Et du coup ce qui devait arriver arriva : j'ai perdu les sources de certains de ces ptits programmes (des gros scripts on va dire).
C'est balot, c'est pas grave mais c'est un peu chiant quand même.

Du coup j'ai eu besoin de trouver une solution.
Donc au lieu d'utiliser git, je me suis dit qu'il serait plus intelligent de juste inclure les sources de mon programme dans le programme lui-même pour qu'il puisse les ressortir en cas de besoin !
Et ouai, du coup si j'ai le binaire, j'ai également ses sources à portée de main.

## Implémentation

Je le fais en deux parties.

  1. Inclure un fichier texte (les sources) en tant que string
  2. Parser les args pour afficher les sources avec --source

<details><summary>Le code !!</summary>

{{< highlight "golang">}}

import (
  _ "embed"
)

//go:embed nom_du_fichier_source.go
var source string
var viewsource bool = false

func main(){
  flag.BoolVar(&viewsource, "source", false, "View source")
  flag.Parse()

  if viewsource {
    fmt.Print(source)
    return
  }

}

{{< / highlight>}}

</details>

Et voilà juste ça à foutre dans votre ptit programme et c'est bon !
La syntaxe est un peu étrange avec le import bizarre et le commentaire ensuite qui n'en est pas vraiment un.
Mais bon ça fonctionne.

Bien entendu ça ne fonctionne qu'avec les programmes avec un seul fichier de source.
Mais rassurez-vous, jamais je ne me permettrai de commettre du code sur plus d'un seul fichier !

Maintenant j'ai plus qu'à penser à inclure ça à chaque fois :-D
