+++
Author = "Lord"
Description = ""
Categories = ["clavier", "bépo","ergol","ux"]
menu = "main"
notoc = true
WritingDate = 2024-01-06T15:42:06+01:00
date = 2024-01-07T15:42:06+01:00
title = "Migration de Bépo vers Ergol"
editor = "helix"
Audio = ""
Soustitre = ""
+++
Et si je changeais de layout clavier ?
Après tout j'utilise ce bon vieux bépo depuis fort longtemps maintenant, ç'en est devenu presque ennuyeux.
Et puis c'est devenu mainstream, ça a été standardisé.
J'ai besoin d'aventure, de frissons, d'exotisme.
Un truc rafraîssant mais underground mais attention faut un truc optimisé !

Je ne vais pas renier 15 ans de bépo pour perdre en confort.

Un peu par hasard, je suis tombé sur un toot d'un inconnu qui parle d'ergonomie et de disposition de clavier.
Bon les trucs basiques jusque là.
Sauf qu'à un moment ça évoque une nouvelle disposition clavier en plein chantier dont me n'avais jamais entendu parlé : **ergol**.

Hahaha ils espèrent faire mieux que bépo.
Pourtant il a été bien foutu en l'optimisant pour écrire le français avec de l'analyse statistique et tout, faire mieux me semble bien présomptueux.

Bon alors la philosophie a été un poil différente, au lieu de tout miser pour optimiser l'alternance des mains, ils optimisent pour limiter les déplacements des doigts et les enchainements étranges.
Cet article est le premier texte que j'écris donc je suis particulièrement lent et je ne peux donc pas jauger pour le moment.
Toujours est-il que les arguments qu'ils avancent me semblent pertinents.

Cette disposition a donc les mêmes objectifs mais pas les mêmes solutions.
Me revoilà donc à réapprendre à écrire en réflêchissant à l'emplacement de chaque lettre.
Chaque phrase me coùte, pour une fois je n'aurais pas besoin de me relire.

J'ai déjà l'impression que ça devrait me plaire.
Déjà les caractères spéciaux sautes de l'accès directe et laissent leur place pour les lettres plus utiles.
Mais surtout ce sont ces saloperies de chiffres qui eux sont en accès direct !
Alleliua !
Vraiment sur ce coup c'est la libération.

La majorité des accents se font via une touche morte disponible au milieu des lettres et du coup la touche altgr est libre.
Enfin plus tant que ça puisqu'on y retrouve les symboles mathématiques.

Je sens bien que ça a été pensé pour les claviers tout petiou genre le planck.
J'ai toujours trouvé ces claviers trop petit bien que charmant, mais qui sait, l'ergol me fera ptet changer d'avis.

Et d'ailleurs quel meilleur moment pour également changer le firmware du clavier ?
Je viens de bouger la touche <kbd>Backspace</kbd> et <kbd>Shift</kbd> ainsi que les touches multimédia.
Galères !!
(quelle idée de remapper backspace â ce moment là -__- ) 

## Ajustements nécessaires
Pour utiliser **Ergol** sous Linux, il faut un fichier .kbd mais pour le moment c'est à vous de le générer.
Pour cela, il y a **Kalamine**, un ptit soft en Python qui fait bien le boulot.
Il y a cependant un léger bug dans le fichier produit qu'il faut éditer en ajoutant une ligne.
Dans ergol.kbd, ajoutez <kbd>include "inet(evdev)"</kbd> dans la section <samp>xkb_symbols{}</samp> et grâce à cela vos touches multimédia fonctionneront.

Ensuite, il faut dire à **sway** d'utiliser ce fichier.
Sans surprise, on se rend dans *~/.config/sway/config* et dans votre <samp>input type:keyboard {}</samp> vous mettez un simple <kbd>xkb_file /votre/fichier/ergol.kbd</kbd> et le tour est joué. 

## Bilan au jour 2
C'est difficile.

Je déteste la lettre "f" qui est la plus chiante à atteindre.

Dans le genre, il y a "p" et "o" que j'inverse tout le temps, m'enfin ça devrait passer.

J'atteind laborieusement les 12 mots par minutes avec beaucoup de concentration.
C'est un retour 15 ans en arrière lors de ma migration vers le bépo, la gymnastique est laborieuse.

Les prochains billets de blogs seront plus courts ^__^
