+++
Author = "Lord"
Description = "Il n'a jamais été aussi important de créer des ptits sites ouaib indépendants et fait maison. Tenir tête à Google et Facebook est faisable et l'un des moyens de le faire est du créer du contenu hors de leur escarcelles. Ça n'a jamais été aussi facile de le faire."
Categories = ["autohebergement", "web"]
menu = "main"
notoc = true
PublishDate = 2019-05-09T11:49:38+02:00
date = 2019-05-09T11:49:38+02:00
title = "Reconquérir le web"
editor = "kakoune"
TopWords = [  "facebook", "google", "style", "css"]
+++
Si vous me lisez, j'imagine que vous êtes déjà pas mal sensibilisé aux histoires de vie privée et d'indépendances numérique et des soucis que posent les GAFAM mais je vais quand même en remettre une couche.
Je ne vise pas tous les GAFAM mais principalement Google et Facebook qui sont à mon avis ceux qui font le plus de tort au web.

On lit régulièrement des diatribes à l'encontre des GAFAM.
Constamment les grands média mainstreams annoncent le dernier scandale en date de l'un d'eux.
Et pourtant rien ne change.

**Il faut dire que les grands média ont justement une part de responsabilité** : *ce sont les premiers à truffer leurs sites de trackers Facebook (et autres), à pousser les gens à liker, à faire du gringue à Google pour être le mieux placé (en allant jusqu'à héberger une partie de leur contenu chez eux, via AMP)…*
Bref, ils en retirent un profit certain et n'ont donc pas grand intéret à pousser les gens hors de ces plateformes.

Une autre plaie du web qui est réapparu à la face de pas mal de monde ces derniers jours c'est à quel point il est **gangrené par la publicité**.
Et c'est rien de le dire, la moindre page web pèse trois à quatre fois plus lourd si l'on désactive son anti-pub.
Le nombre de requêtes explose pour revendre vos habitudes de surfs
**Non seulement vous êtes vendu en pâture aux marketeux mais en plus, les performances s'écroulent à cause de ce merdier.**

Un troisième point qui m'irrite c'est plus un sentiment assez généralisé que l'on ressent en lisant des commentaires, des posts par-ci par-là comme quoi **“ le web est mort ”**.
Vraiment ?
Je n'en ai pas l'impression.

Dans les années 90 le web était bouillonnant, criblé de sites aux designs plus que douteux, abordant des sujets ultra variés.
Des sites de passionnés un peu débrouillards mais pas non plus experts informatiques.
Ça parlait de tout un tas de passions sans se prendre la tête avec des histoires de SEO, de retour sur investissement d'un site ouaib, de monétisation toussa toussa.
*Et bien cet esprit n'a pas disparu !*
Il a juste été noyé dans la masse.

Tous ces ptits sites pas toujours notables mais avec leur charme certain existent encore mais sont devenus ultra minoritaires *planqués au fin fond des index de Google and co*.
*Il est devenu bien plus dur de dénicher ces perles* mais pour beaucoup ils existent encore et surtout rien n'empêche d'en créer de nouveaux.

Bref, malgré ces trois points, je reste persuadé qu'il est assez aisé de les contrebalancer voir renverser.
Si vous voulez apporter votre petit pierre à l'édifice dans la lutte contre la mainmise du web et ses dérives, **créez un site ouaib !**

*Il n'a jamais été aussi facile d'avoir un site web !*

  - C'est moins cher qu'avant.
  - Il existe bien plus de logiciels pour vous aider à en faire.
  - Il y a bien plus de docs qu'auparavant.
  - Héberger un site est également plus simple.

**Google et Facebook préferent vous voir captifs de leurs services mais rien ne vous y retient.**
Il est vrai qu'à première vue, c'est super attirant de se baigner dans un écosystème tout gentiment mis à votre disposition sans même vous demander d'argent.
On vous propose des services mirifiques, avec des performances incroyables et sans limitations.
Mais tout ça c'est pour mieux vous engraisser, vous découper et vous revendre aux plus gourmands.

Tout le monde a quelque chose à raconter !
*Ça peut vous sembler con, être inintéressant, déjà vu mille fois mais racontez-le quand même.*
Écrire sera un peu difficile au début puis vous trouverez vos marques et ça viendra plus naturellement et la qualité s'améliorera.
Et si vraiment l'écriture c'est pas votre truc, postez des photos, vos dessins, vos idées, vos poêmes, votre journal (pas trop) intime sur votre site !
**Mais ne succombez pas au syndrôme de l'imposteur et lancez-vous !**

Au lieu de balancer les photos du dernier rejeton sur Facebook, faites-vous une petite galerie photo que vous enverrez à toute la famille.
Ne fichez pas le gamin à peine sortie du blister.

## Besoin d'un coup de pouce technique ?
Bon, vous n'y connaissez rien du tout du tout, vous n'avez pas de logiciel dédié mais vous voulez vous lancer ?
Allez je vais vous aider !

On va faire un site web minimal mais qui marchera très bien et pourra être étendu autant que bon vous semble.
*Vous n'aurez besoin d'aucun logiciel particulier, vous avez déjà tout ce qu'il faut sur votre ordinateur.*

On va créer un dossier que l'on va appeler <samp>*www*</samp> (bon en vrai on peut l'appeler autrement mais ça a du cachet).
Dedans on va créer un premier fichier texte que l'on nommera <samp>*style.css*</samp> qui va s'occuper de gérer la partie esthétique du site.
Et enfin un deuxième fichier texte que l'on nommera <samp>*index.html*</samp>.
Voilà jusque-là rien de bien compliqué.

### Le HTML minimal
**Le langage HTML est vraiment très simple et peut être appris par tout le monde en quelques minutes.**

Il fonctionne à base de balises que l'on ouvre et ferme avec dedans du texte.
Il existe beaucoup de balises différentes il suffit d'en connaître moins d'une dizaine pour parvenir à un résultat pas dégueu.

Voyons un exemple de page web fonctionnelle qui peut largement suffire pour tenir un site web simple.
Donc ouvrez le fichier *index.html* avec le bloc-note (pas avec Word, Writer ou autre, ça ne marcherait pas).
<details><summary>Voilà ce que vous allez mettre dans votre fichier <samp>*index.html*</samp></summary>
{{< highlight html >}}
<!DOCTYPE html>
<html>
	<head>
		<title>le titre de votre page</title>
		<link rel="stylesheet" href="style.css">
	</head>

	<body>
		<h1>votre page</h1>
		<p>coucou c'est votre page.</p>
		<p>Ceci est une ligne super longue de texte qui devrait déborder de tous les côtés mais c'est moche du coup on
fait en sorte qu'elle soit moins longue pour que ce soit plus simple à lire.
		Idéalement, faut que ça fasse dans les 80 caractères maximume de large.</p>
		<p>Vous pouvez faire des <a href="/seconde_page.html">liens</a> et même mettre des <img src="photos.jpg" alt="la photo mon chat"></p>
	</body>
</html>
{{< / highlight >}}
</details>

### Le CSS minimal
Le langage CSS, lui, sert donc à styliser votre page web.
Il permet de définir l'espacement entre les éléments, la couleur, la taille, le soulignement… bref tout ce qui change l'aspect esthétique du document.
**Le HTML c'est le fond, le CSS la forme.**

La syntaxe est vraiment très simple : d'abord vous indiquez le *sélecteur* (le type de balise sur lequel vous voulez agir) puis vous indiquez quelles propriétés lui affecter.
Il ne reste donc qu'à apprendre quelles sont les propriétés existantes.
En pratique avec une dizaine de propriétés on peut déjà parvenir à des résultats vraiment travaillés.

Tout comme pour votre page web, ouvrez le fichier *style.css* dans le bloc-note (ou équivalent, mais pas un traitement de texte).
<details><summary>Remplissons donc notre <samp>*style.css*</samp></summary>
{{< highlight css >}}
body{
  margin:auto;
  padding:1em;
  background-color:#222;
  color:#ddd;
  max-width:35em;
}
a{
  color:cyan;
}
{{< / highlight >}}
</details>
Rien que ça suffit à avoir un résultat, certe minimaliste, mais au moins utilisable sans se casser la tête.
Fun fact : si ça vous plaît vous êtes un minimaliste ;-)

### Résultat ?
Il vous faut ouvrir votre fichier *index.html* dans votre navigateur, soit en glissant le fichier dans la barre d'adresse, soit en faisant <samp>fichier/ouvrir</samp>

Bon c'est chouette tout ça, vous avez maintenant le début de votre site mais si vous voulez le partager avec le monde entier, il faut maintenant l'héberger.
J'ai déjà dédié [un ptit article à ce sujet]({{< ref "/posts/163-heberger-un-site-statique" >}}) qui vous donnera des pistes.
Il arrive parfois que les revendeurs de noms de domaine fournissent un peu d'hébergement gratuitement (une mise en bouche) qui peut être un premier pas.
