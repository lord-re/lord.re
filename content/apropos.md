+++
Author = "Lord"
Description = ""
Categories = ["", ""]
notoc = true
noread = true
nodate = true
nofooter = true
PublishDate = 2018-08-23T21:39:13+02:00
date = 2018-08-23T21:39:13+02:00
title = "Readme.txt"
editor = "kakoune"
+++
Vous voilà ici sur mon humble blog.

Vous êtes connectés directement à mon ptit ordi dans le salon.
J'espère que la vue vous plaît et que l'eau n'est pas trop chaude.

Je parle ici de ce qui me passe par la tête.
C'est-à-dire souvent des *trucs geeks et plus particulièrement des conneries sous nunux* (c'est comme GNU/Linux mais en moins sérieux).
Les articles sont sous licences *CC4-BY-NC-SA* mais tout se négocie ma bonne dame.

## Comment ça marche ?

Je poste au gré de mes envies donc avec un rythme potentiellement instable.

4 types de contenu différents avec des couleurs différentes et une ptite étiquette dans le coin supérieur gauche.

<section class="posts">
  <header class="post-header"><h1><a href="https://lord.re/posts/">Les posts</a></h1></header>
  <article>
    <p>Là ce sont des articles un peu travaillés, généralement assez long.
    Ça peut être des tutos aussi des fois, ou juste des découvertes, des récits.</p>
  </article>
</section>

<section class="fast-posts">
  <header class="post-header"><h1><a href="https://lord.re/fast-posts/">Les fast-posts</a></h1></header>
  <article>
    <p>Bien plus court et souvent en réaction à l'actualité.
    C'est moins réflêchis, plus instinctif.</p>
  </article>
</section>

<section class="shares">
  <header class="post-header"><h1><a href="https://lord.re/shares/">Les shares</a></h1></header>
  <article>
    <p>Où le but principal est de partager une image / une vidéo / un site ouaib.
    Peu de contenu de ma part.
    Et une légère tandance à l'archéologie numérique.</p>
  </article>
</section>

<section class="ideas">
  <header class="post-header"><h1><a href="https://lord.re/ideas/">Les Idées à la con</a></h1></header>
  <article>
    <p>Le nom est : idées à la con.
    C'est plutôt suffisant comme explication, non ?
    Des trucs auxquels je pense mais je sais pas trop quoi en faire.</p>
  </article>
</section>

<section class="recap">
  <header class="post-header"><h1><a href="https://lord.re/recap/">Les récaps mensuels</a></h1></header>
  <article>
    <p>Le log du blog.
    Faire un ptit point chaque mois de ce que j'ai vu/fait/matté/écouté.
    Un journal pas vraiment intime quoi.</p>
  </article>
</section>

<section class="visionnages">
  <header class="post-header"><h1><a href="https://lord.re/visionnages/">Visionnages</a></h1></header>
  <article>
    <p>Je tente de noter à chaud (si possible) mon ressenti sur les films.
    Ce ne sont pas des critiques ni des analyses, hein.</p>
  </article>
</section>

Parfois vous verrez du texte avec des ptits <abbr title="voilà ce genre là">zigouigouis</abbr>, passez la souris dessus histoire d'avoir un peu de complément d'infos (pas toujours pertinent).
Et si je mets des <kbd>commandes à copier</kbd> (comme là)la police est différente pour distinguer ce qu'il faut copier ou non.

Sur la gauche (ou en haut sur mobile), vous trouverez des icônes pour me mailer/m'irc/me rss/me tooter/ ou pour voir le site en version <abbr title="Une seule page contenant absolument tous les articles">monopage</abbr>.

## Pourquoi ce site ?

Bha disons que j'adore consommer du *contenu fait main* où l'on sent l'*artisanat*, la *passion*, la *joie du partage*.
Mais du coup au lieu de n'être qu'un simple consommateur j'ai toujours voulu apporter ma pierre aux dix fils.
Logiquement, j'ai commencé très mollement et expérimentalement en 2004.
En 2007 je m'y suis remis a l'arrache.

Vous remarquerez qu'il n'y a pas de date de publication pour les anciens articles tout simplement parceque je ne l'ai pas consignée à l'époque.
Depuis 2017, je m'y mets clairement plus fort qu'avant car j'y trouve un plus grand plaisir qu'avant.

J'ai ajouté la possibilité de *commenter* en aout 2018 histoire d'apporter un peu plus de vie au site et pour entendre ce que vous avez à (re)dire de mes conneries.
Et d'ailleurs les commentaires… je les héberge personnellement.
C'est votre contenu mais ça apparait sur _mon_ site, donc j'en fait un peu ce que je veux : si vous racontez des trucs qui me plaisent pas, ne vous plaignez pas de censure si je les dégage.
*Je suis chez moi je fais ce que je veux.*

Je tente également de traduire les articles en anglais (enfin ça y ressemble).
Mais c'est assez chiant à faire même si l'exercice est intéressant, donc je ne fais pas tout.

## Sous le capot

Il s'agit d'un site statique généré via [Hugo](https://gohugo.io).
Les articles sont écrits dans un éditeur de texte classique (souvent vim, parfois amp, une fois nano, maintenant kakoune).

Ce site respecte ses visiteurs.
**Je ne vous traque pas.**, ni ne monétise le blog d'aucune manière, c'est mon ptit joujou et passe-temps.
Le site *fonctionne sans aucune connexion extérieure* en dehors de très rares articles où j'inclus des vidéos que je n'héberge pas pour des histoires de bande passante et surtout de stockage.

Javascript n'est nécessaire que pour les commentaires mais si ça ne vous intéresse pas, *vous pouvez désactiver JS* sans aucun soucis :-)

*Je conserve les logs du serveur web pendant un an.*
Je les consulte parfois via [GoAccess](https://goaccess.io) afin d'avoir une vague idée du nombre de visite et tout mais rien de poussé.

Je tente d'avoir un site plutôt accessible, si jamais vous trouvez des points à redire à ce propos n'hésitez pas à me le signaler pour améliorer ça.

Le site utilise un thême fait maison avec également un CSS fait maison sous licence *CC4-BY-SA*.
J'essaye d'avoir un contraste suffisant avec une taille de texte très grande et une largeur de colonne de texte d'approximativement 80 caractères afin de faciliter la lecture.
C'est globalement sombre car je pense à vos pauvres petits yeux dans la pénombre.

En bas des articles vous aurez des liens vers des articles *+ récents* et *- récents*.
Vous aurez également un lien vers un *article aléatoire*.
Ce lien est généré par Hugo et donc ne change qu'une fois le site régénéré (donc à chaque fois que je poste un nouvel article, pas avant).

Comme déjà dit, c'est hébergé sur ma ptite connexion perso donc ça peut arriver qu'il y ait des downtimes plus ou moins conséquents mais bon… c'est pas trop grave.

Les sources du site web sont disponibles dans [ce repo](https://git.lord.re/lord/lord.re) (uniquement dispo via IPv6).

## Contact
Si vous voulez me contacter le mieux est de passer par <a href ="ircs://irc.geeknode.org" title="Contact via IRC sur geeknode" style="color:#3b95f0"><img src="https://lord.re/svg/chat.svg" class="svg3"> IRC</a> ou de me tooter sur le <a href="https://pleroma.lord.re/users/1" rel="me" title="Mon ptit compte sur le Fediverse" style="color:violet"><img src="https://lord.re/svg/fediverse.svg" class="spin svg3"><span class="rainbowverse">Fediverse</span></a>

Dans le pire des cas par <a href="mailto:lord-blog@lord.re" title="Contact par mail" style="color:#d25555"><img src="https://lord.re/svg/mail.svg" class="svg3"> Mail</a>  mais je peux passer plusieurs jours/semaines sans les consulter.
