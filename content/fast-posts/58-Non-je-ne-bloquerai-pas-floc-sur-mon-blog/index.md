+++
Author = "Lord"
Description = ""
Categories = ["web", "gafam"]
menu = "main"
notoc = true
WritingDate = 2021-04-20T18:37:47+02:00
date = 2021-04-20T18:37:47+02:00
title = "Non je ne bloquerai pas le FLoC sur mon blog"
subtite = "et c'est tant mieux !"
editor = "kakoune"
+++
Le web un peu techy et un peu à cheval sur la préservation de l'intimité numérique est en ébulition en ce moment concernant le FLoC.

## FLoC koikoukess ?
C'est le **Federated Learning of Cohort**, le nouveau jouet de Google pour remplacer certains usages des cookies pour traquer les visiteurs du web.
En gros c'est pour *regrouper les webaunautes dans des cases*.
Google annonce ça comme une techno pour protégér l'intimité des webaunautes pour ne plus traquer individuellement mais bon comme d'hab ça n'augure rien de vraiment bon.

Bref, *ce système se base sur le navigateur web et surtout son historique afin de pouvoir analyser finement toutes les visites de ses utilisateurs*.
Avant Google se basait sur les sites ouaib pour qu'il participe à l'espionnage des visiteurs, mais comme maintenant Google oscille entre 66% et 75% de parts de marché sur les navigateurs web bha …

{{< img src="thanos.jpg" alt="Meme de thanos avec son gant disant qu'il va le faire lui-même" title="C'est marrant comme le gant ressemble un peu à l'icône de Chrome, non ? non :-/" >}}

## On peut le bloquer côté site ouaib
Alors ouai, il existe visiblement un header HTTP pour empêcher un site ouaib d'apparaitre dans les listings servant à leur moulinette géante.

<details><summary>Header HTTP à renvoyé</summary>

Permissions-Policy: interest-cohort=()

</details>

Bon après c'est au bon vouloir de Chrome d'en tenir compte ou non.
Et puis … bha … pas trop moyen de savoir si ça change vraiment grand-chose.

## Pourquoi je le mets pas en place ?
Et bhé parceque si mes visiteurs ne veulent pas être fichés par Google ils n'ont qu'à pas utiliser Chrome.

Ptet qu'à un moment il va falloir commencer à se rebeller un peu face à Chrome/Google.
Tenter de protéger ses quelques visiteurs avec ce genre de ptite bidouille ne fait que légitimer les conneries de Chrome.

“Ha mais non c'est pas grave il suffit de désactiver.”

Ouai bha non.
Ras le cul, *les gens qui ne veulent pas être pistés ils utilisent pas Chrome*.

Petit rappel en passant : Chrome == Google == espionnage omniprésent

D'ailleurs les utilisateurs de Chrome, ce qui vous pend au nez c'est la suppression progressive de votre plugin antipub.
Vous allez en chier sur les sites de presse (parceque ouai ce sont les sites les plus hostiles pour les visiteurs).

Bon, sur qui j'ai pas craché ?
Ha ouai : les devs de navigateurs web !

## À quand un nouveau navigateur web complet et libre ?
Bon je vais pas vous cracher dessus parceque je sais que la tâche est herculéènne mais ça serait pas chouette un nouveau navigateur sur des bases saines (pas dérivé de Chromium, ni webkit, ni gecko) ?
Un navigateur indépendant de toute entité commerciale avec des devs du monde entier (un peu comme un kernel, wink wink).

Si un monstre comme le kernel Linux peut exister, pourquoi pas un nouveau monstre de navigateur web ?
*En 2021, c'est probablement plus important un navigateur web réellement libre qu'un kernel*…

Quelques années auparavant j'avais de grand espoir envers **Servo** mais bon comme d'hab Mozilla est toujours prêt à décevoir.
