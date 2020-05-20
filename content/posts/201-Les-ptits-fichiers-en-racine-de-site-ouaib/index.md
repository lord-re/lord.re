+++
Author = "Lord"
Description = "Présentation de quelques fichiers que l'on retrouve à la racine de très nombreux sites web. Ils sont facultatifs mais peuvent être intéressant à lire et écrire si vous-même vous êtes webmaster."
Categories = ["web", "hébergement"]
menu = "main"
notoc = true
WritingDate = 2020-05-12T09:43:04+02:00
date = 2020-05-20T15:43:04+02:00
title = "Les ptits fichiers en racine de site ouaib"
editor = "kakoune"
TopWords = [  "ouaib", "syntaxe", "pub", "recherche", "robots", "txt"]
+++
Ouai j'ai pas trop su comment les appeler.
Je n'ai pas trouvé de nom, du coup je pourrai tenter ma chance…

… bha non je trouve pas.
Et vous ?

Je parle donc des quelques fichiers que l'on peut poser en racine d'un site à différentes fins. 
Ils sont optionnels, d'ailleurs j'en ai que deux de la liste (le troisième vous surprendra !).

Allez sans plus attendre, démarrons (vous sentez la hype montée ? non ! :-/ ).

## robots.txt
Ce fichier est à destination des … robots.
*Il permet de donner quelques instructions pour les trucs qui visitent votre site ouaib*.
Et quand je dis trucs ça peut être moteur de recherche, logiciel de web scraping ou juste des logiciels d'archivage.

Le but initial était d'indiquer quelles parties d'un site ouaib ne devaient pas être indexé.
Tout le contenu d'un site n'a pas forcément vocation à être public ou tout du moins facilement retrouvable.

Du coup, ce ptit fichier peut parfois receler des ptits trésors.
Ce qui a l'effet inverse de ce qui est escompté.

Le fichier a une syntaxe assez simple et peut même maintenant contenir d'autres informations pour les crawlers afin qu'ils indexent un peu mieux votre site.
Dans les trucs pas mal, il y a le fait de pouvoir spécifier votre *sitemap* (on le voit plus bas).

Une autre est également l'instruction <samp>Indexpage</samp> qui permet d'indiquer qu'une page est un index vers d'autres pages.
Ça permet à certains moteurs de recherche de mieux comprendre ce qu'ils sont en train de lire et donc de potentiellement mieux vous indexer.

Alors bien entendu tout ça, c'est pas une science exacte.
Le fichier n'est là qu'à titre indicatif, rien ne force les gens à prendre en compte ce fichier et à le respecter.
Et certaines instructions ne sont pas comprises par tout le monde.

Bref, le <samp>Disallow:</samp> qui vous permet d'exclure certaines pages des moteurs est à peu près compris de tous mais le reste c'est très aléatoire.
Et je le répète un coup encore, si vous ne voulez pas qu'un truc apparaisse sur le net, l'indiquer dans votre **robots.txt** confirme son existence et n'oblige en rien à être respecté.

## security.txt
Ce fichier à destination d'humains permet principalement d'*indiquer comment communiquer avec le webmaster (ce terme est tombé en désuétude :-/ ) à propos des failles de sécus*.
Il permet d'indiquer avec quelle adresse communiquer, dans quelle langue, avec quelle clé gpg.
Bref quelques informations de base.

Pour plus d'info vous avez [l'article de Y0no](https://y0no.fr/posts/decouverte-security-txt/).

Perso je n'en ai pas.
Faut dire qu'ayant un site statique et n'utilisant pas gpg et mon mail étant présent sur le site… ça n'apporterait pas grand-chose de plus.

## ads.txt
Ce fichier sert les sites commerciaux utilisant la pub.
Maintenant la pub sur le web fonctionne en grande partie sur un système d'enchère en temps réel.
C'est assez complexe (alors qu'un simple bloqueur de pub virra toutes ces merdes).
Bref il permet d'*indiquer quels sont les revendeurs autorisés pour les emplacements de pub*.

Ces fichiers sont globalement inintéressants à moins que vous ne cherchiez des noms de boites qui participent à la pollution du web.

## humans.txt
J'ai commencé l'article avec un fichier destiné aux robots, bah celui-là est destiné aux humains.
Et surtout il parle des humains derrière le site.
Donc c'est pour *présenter l'équipe qui construit le site que vous lisez*.

On peut donc y présenter les créateurs de contenu, les hébergeurs, les adminsys, l'équipe de la compta sans qui tout cela n'aurait pas été possible, remercier les mamans de chacun…
Bref, on peut y mettre un peu ce que l'on veut.

On peut y ajouter quelques informations plus génériques comme, par-exemple des liens vers les réseaux sociaux ou bien où est situé géographiquement le site.
On peut tout aussi bien présenter les outils utilisés pour créer/héberger le site.

Même sa syntaxe est pas spécialement gravée dans le marbre, c'est assez libre.
C'est au final plus proche de la page de remerciement qu'un truc technique.

## sitemap.xml
Celui-ci est un peu différent mais mérite tout de même sa ptite place ici.
Il est généralement construit automatiquement par les générateurs de site web et non à la main contrairement à tous les précédents.

Ce fichier est à destination des différents crawlers du web (moteur de recherche principalement).
*C'est une sorte de plan exhaustif du site ouaib*.
Il peut contenir un lien vers chacune des pages web avec à chaque fois la date de dernière modification.

La combinaison de ces deux informations permet aux moteurs de recherche de mettre à jour ses informations pour revenir indexer ou non les pages qu'il connait déjà.
Ce fichier est très souvent visité par crawlers et donc adapter leur comportement.

C'est donc très important de chouchouter ce fichier si vous voulez un bon SEO.
Sa syntaxe est assez stricte et la plupart des générateurs de sites font déjà un bon boulot pour le générer.


----------
Un jour, on pourrait aller explorer ce qu'on peut mettre dans le <samp>/.well-known/</samp> …
