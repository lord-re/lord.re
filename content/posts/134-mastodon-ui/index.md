+++
Author = "Lord"
Description = "L'interface web de Mastodon est excellente : elle est très personnalisable mais en plus est pratique. Cerise sur le gâteau : elle est jolie."
Categories = ["web", "ux", "fediverse","mastodon"]
menu = "main"
notoc = true
draft = false
PublishDate = 2018-10-18T21:01:39+02:00
date = 2018-10-21T10:01:39+02:00
title = "L'UI de notre cher Mastodon"
editor = "kakoune"
TopWords = [  "fédiverse", "colonne", "listes", "mastodon","pleroma"]
+++
*J'aime pas vraiment les réseaux sociaux web* (parceque le mail et irc sont aussi des réseaux sociaux, mais je déteste le mail aussi).
J'ai jamais ouvert de compte Facebook.
J'ai ouvert un compte truitteur juste pour un concours (ouai j'ai craqué) mais il n'a jamais servi.
J'ai bien eu un compte identi.ca pendant un temps avec mon propre serveur auto-hébergé mais ça n'a pas spécialement pris (la communauté était vraiment trop petite à l'époque).

Mais il y a presque deux ans *j'ai découvert Mastodon et le Fédiverse et le concept m'a bien plus plu*.
Je ne vous ferai pas l'affront de présenter Mastodon le Twitter libre décentralisé s'intégrant dans le Fédiverse qui compte plusieurs logiciels différents.

Bref c'est sympa et mine de rien *la communauté commence à être suffisamment grande pour que le Fédiverse soit intéressant*.
L'interface de Mastodon est vraiment pas mal du tout.
Le thême par défaut est sombre et c'est pas mal personnalisable et ça s'adapte bien aux écrans larges avec son système de colonnes.

Le Fédiverse est peuplé de pas mal de gens différents et de pas mal de bots.
Le souci c'est que certains sont de très gros posteurs qui auront tendance à non pas polluer parceque ce terme est trop péjoratif mais à remplir un peu trop votre *Home Timeline* (la timeline remplie par les comptes que vous suivez).
Du coup les mastonautes un peu moins prolixes auront tendance à ne pas trop apparaître dans votre *Home*.

C'est d'autant plus vrai que certains bots peuvent poster très très régulièrement (comme, par exemple [@FIP en direct](https://botsin.space/@FipNowPlays) qui annonce chacun des morceaux de musique à l'antenne donc toutes les 3/5minutes).
Le fait de suivre des gens sur différentes timezones c'est sympa mais du coup selon l'heure où l'on regarde sa *Home*, autant des fois tu ne tomberas que sur du contenu US, autant des fois ça sera que du contenu FR.
Mais du coup c'est un peu chiant pour retrouver le contenu FR de la veille quand les US ont bien tooté toute la nuit…

## Les listes à la rescousse
Heureusement pour tous ces soucis il existe une solution : **les listes**.

On peut créer des listes des gens que l'on suit.

Du coup je me suis créé une liste *Bots*, une liste *Fr* et une liste *En*.

Et par contre là, bha… faut se les faire manuellement.
Va falloir prendre chacun de vos abonnements et les classer dans telle ou telle liste.

{{< img src="masto-full.thumb.png" link="masto-full.png" alt="capture d'écran de mastodon avec les 3 colonnes de listes" title="Pas mal le résultat, non ?" >}}
## Tuto ?
Allez voyons ça vite fait.

Pour créer une liste il faut cliquer sur l'**Hamburger Menu** en haut à gauche. (mais si vous savez, l'icône avec les trois lignes parallèles, on la retrouve partout cette icône maintenant, faut vous y faire).

Dans la colonne *Getting started* tout à droite, vous avez maintenant **Lists**

{{< img src="mastodon-getting-started.thumb.png" link="mastodon-getting-started.png" alt="capture d'écran de la colonne en question" title="là" >}}

Vous entrez un **titre** pour la colonne et vous cliquez le chtit **+** puis vous cliquez sur la liste qui vient d'apparaitre juste en dessous.

Vous vous retrouvez désormais dans votre liste, il faut y ajouter les mammouths que vous suivez dans cette liste.
Pour ça cliquer sur la ptite icône de réglages tout en haut à droite et là **Edit list**.

Une fenêtre modale s'affiche avec un ptit champs de recherche.
Là vous entrez une partie du pseudo de la personne en question et dans la liste de résultat le ptit **+**.

Voilà vous avez peuplé votre liste.
Il ne reste plus qu'à la **Pin** pour devenir une colonne habituelle.

Une fois *pin*, vous pouvez la déplacer de gauche à droite avec les ptits **<** et **>**.

Si comme moi vous avez mis absolument tout le monde dans vos différentes listes (tiens d'ailleurs un compte peut être dans plusieurs listes, c'est bon à savoir), vous pouvez même virer la *Home* en l'**Unpin**.

## Apparté concernant les raccourcis claviers
Mine de rien l'interface pas mal utilisable juste au clavier.

Les **<samp>chiffres</samp>** vous permettent de sélectionner la colonne voulue.
Ensuite les flèches **<samp>haut</samp>** et **<samp>bas</samp>** vous permettent de faire défiler les toots.
**<samp>Enter</samp>** vous permet d'ouvrir un toot.
Et enfin **<samp>n</samp>** vous permet de démarrer un nouveau toot.
Et les deux derniers utiles sont **<samp>r</samp>** pour répondre et **<samp>f</samp>** pour foutre en favoris.

## Apparté concernant les performances
Si vous laissez tourner Mastodon dans un onglet constamment, vous allez vous rendre compte que le Mammouth broute le CPU allégrement.
Après quelques bidouillages et avec l'aide de [Lapineige](https://lapineige.fr/wp/ "Il est bien son blog lisez-le") et de [Sp3r4z](http://sp3r4z.fr/blog/ "Il est pas très rempli mais allez-y quand même") j'ai pu me rendre compte qu'on peut drastiquement diminuer l'appétit de la bête.
Dans les préférences de votre compte, décochez *Auto-play animated GIFs* et hop vous voilà grandement soulagé.
Sans ça, au bout de quelques heures, l'onglet qui me bouffait entre 20 et 40% de CPU ne consomme désormais plus que 8%.


------------------

L'interface utilisateur de Mastodon est vraiment bien.
En plus d'être jolie, elle est suffisamment simple et intuitive en utilisation basique tout en étant pas mal flexible.
Et la cerise sur le gâteau est la présence des raccourcis claviers bien branlés.

C'est d'autant plus rare pour un projet aussi jeune mais c'est très probablement une des raisons de son succès.

Et d'ailleurs profitez-en pour faire un bisou à votre admin d'instance et même lui payer une binouze.
