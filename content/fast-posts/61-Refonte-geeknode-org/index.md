+++
Author = "Lord"
Description = "Comment j'ai retapé le site de Geeknode. Mot d'ordre : minimalisme. Peu d'entretien, de bonnes perfs, de l'accessibilité et que ce soit un peu joli."
Categories = ["web", "css","irc"]
menu = "main"
notoc = true
WritingDate = 2021-06-04T18:47:06+02:00
date = 2021-06-05T10:47:06+02:00
title = "Refonte de Geeknode.org"
editor = "kakoune"
+++
Le monde de l'IRC est très actif en ce moment avec pas mal d'actualité et pas mal de projets pleins de vie.
Et pour vous dire à quel point c'est tout plein de vie actuellement, *j'ai même refait le site ouaib de [Geeknode.org](https://www.geeknode.org)* !

## From dusk
Le serveur qui hébergeait le site a eu un ptit souci il y a quelque temps et on a donc récupéré les pages en allant les chopper dans les web archives.
Et en fait… on a fait ça comme des manches en ne récupérant que la page d'accueil et non toutes les autres innombrables (2) pages.
Et bha … le site était assez moche et daté.
À l'époque j'étais dans ma découverte de **Bootstrap CSS** et je le générais avec le générateur statique **wok**.

Bon par contre la web mode du printemps 2013 accusait son âge.
J'ai donc entrepris de refaire le site.

J'ai pris quelques décisions assez radicales.

Déjà je ne voulais *aucune ressource externe*.
Je veux un site ouaib qui puisse tenir des lustres sans aucune modif sans risquer de perdre des bouts.
Bref je veux *un truc facile à backupper et autonome*.
Ne pas permettre à qui que ce soit de tracker le très faible trafic web que l'on génère.

Donc pas de police extérieure, pas de javascript sur un CDN, pas de tracking Google/Facebook ou autre.
Bref, *une page respectueuse de ses visiteurs*.

Vu qu'on a très peu de contenu, je veux tout avoir dans un seul fichier.
Encore une fois c'est facile à sauvegarder et surtout ça a de très bonnes performances.
*Je veux un site ouaib qui soit très bien classé sur un peu tous les aspects : sécurité, performance, accessibilité*.

Il faut que le site soit accessible et fonctionne bien avec les navigateurs textes d'antan.
Après tout c'est un site à destination d'un public geek, on se doit d'être *irréprochable* sur ce point.
Et puis l'accessibilité devrait être une priorité pour tous les créateurs de site ouaib : le monde physique est difficilement adaptable à tous les handicaps donc autant faire en sorte que le monde numérique soit le plus agréable possible pour tout le monde.

Je n'ai pas utilisé de générateur de site statique ni même de site dynamique.
Il faut un truc *incassable*, ici pas de mise à jour d'outil qui risquerait de ne plus exister ou d'avoir des incompatibilités dans dix ans.
Et puis comme il n'y a presque pas de contenu une seule page et le tour sera joué.
*Le site n'aura probablement pas de mise à jour avant des lustres donc pas la peine de s'embêter avec différents outils qui seront obsolètes d'ici la prochaine mise-à-jour du site*.

## Till Dawn
J'ai donc dégainé mon fier **kakoune** et j'ai commencé par un squelette de page assez rudimentaire.

<details><summary>Premier jet</summary>
{{< highlight html>}}
<html lang='fr'>
 <head><title>Geeknode</title></head>
 <body>
  <main>
   <section class="header">
    <h1>bla</h1>
    <p>Bla bla</p>
   </section>
  </main>
 </body>
</html>
{{< / highlight >}}
</details>

Voilà, une structure basique mais efficace.
Il ne reste qu'à dupliquer les *&#x3C;section&#x3E;* avec les différents contenus et leur attribuer des classes différentes au cas où…

Bon si vous allez reluquer le code source de la page en question, vous remarquerez assez vite que l'indentation n'est pas à 100% ok mais le but est d'avoir un truc quand même pas mal lisible.

Une fois la structure faite il ne me restait plus qu'à rédiger le contenu.
J'ai piqué un peu d'inspiration chez [Libera](https://libera.chat) qui ont un tout nouveau site qui contient à peu près tout ce qu'il y a à savoir.
J'ai un peu sondé les utilisateurs (promis ça ne leur a pas fait mal) pour savoir ce qui pourrait les intéresser comme infos.

Voilà le contenu du site dans l'ordre :

  - Gros titre et adresse du réseau pour les pressés.
  - Présentation de l'asso
  - Politique de modération du réseau
  - Comment se connecter pour les débutants
  - Comment gérer son identité sur le réseau
  - Comment gérer un salon sur le réseau

Voilà.
Bon à chaque fois c'est assez concis et je pousse les personnes qui ne trouvent pas toutes les réponses soit vers de la doc plus poussée soit à venir directement en discuter sur le salon qui va bien.
*Le contact humain par claviers interposés c'est quand même pas mal*.

La grosse nouveauté du site c'est au final un peu de doc mais surtout *une politique de modération du réseau*.
On en avait déjà une entre nous mais on ne l'avait jamais mentionné sur le site.
Sur IRC une règle quasi universelle dans la gestion d'un réseau c'est que les IRCOP (les opérateurs du réseau à distinguer des OP qui ne sont opérateurs que d'un salon) ne doivent pas s'immiscer dans la gestion des salons.
*Chaque salon est géré par son équipe*.
Cependant on est conscient qu'un op n'a pas forcément une maîtrise totale d'IRC et peut donc venir nous demander un coup de main.

*Hors cas exceptionnel, nous n'utilisons pas les outils de modération dans les salons*.
Nous n'intervenons que lorsqu'une personne malveillante à un comportement nocif sur de multiples salons.
J'espère que le réseau soit neutre et que chacune des communautés hébergée sache se réguler d'elle-même pour résoudre ses problèmes en autonomie.

*Par chance, on n'a pas encore eu besoin de prendre quelconque mesure à ce propos et j'espère que ça perdurera*.
Je ne me vois clairement pas être ircop d'un réseau irc hébergeant une communauté de fachos/homophobes/sexistes/racistes, bref vous voyez le tableau.

## Structure CSS
Après le contenu et la structure vient le design.
*Et là j'ai voulu du très minimaliste niveau code, l'inclure dans le header et un truc simple*.

Là je me suis fait plaisir.
Le site est visuellement ultra simple mais j'ai utilisé du **flexbox**.
“Hey mais c'est plus vraiment un truc tout neuf et funky le flexbox !”
Ouai je sais mais j'ai pas trop eu l'occasion de l'expérimenter non plus.
Et là j'ai aussi mixé avec du **grid**.

Et bien que j'ai mixé ces deux grandes techniques tout le css reste minimaliste.

J'ai donc commencé par *reset les marges et les bourrages* à 0 histoire de pas me faire chier.
Ensuite je créé le *grid et dedans le flexbox*.
J'ai quand même pas mal tatonné mais j'ai obtenu un truc qui va me reservir un peu partout je pense.
Le but c'est d'avoir une section principale de la page qui est centrée sur l'écran.
Et dedans je fous tout le contenu à la suite.
C'est à mon sens le *design web classique* qui me plaît beaucoup et qui est efficace à mon sens.

## Peinture CSS
Bon une fois que le design structurel est fait il me restait plus qu'à peindre.
Bon bha comme d'hab je suis parti sur un fond gris sombre avec du texte blanc (pas immaculé mais pas loin).
Pour le fond j'ai expérimenté quelques trucs foireux puis j'ai eu envie de faire mumuse avec les dégradés coniques.

<details><summary><div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg)"><div style="background-color:#222;margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;"><p>Le contenu</p></div></div></summary>
{{< highlight html >}}
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg)">
  <div style="background-color:#222;margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;">
    <p>Le contenu</p>
  </div>
</div>
{{< / highlight >}}


Et franchement c'est pas mal du tout pour une petite page je trouve.
Le rendu est assez joli.
J'aime beaucoup ces rayures avec l'ombre déportée ça me chatouille la rétine.

Par contre sur une page à rallonge l'effet est moins sympa.
Et puis c'est quand même un peu tristouille ces couleurs.

</details>

Je suis donc parti sur cette base en y apportant quelques modifs.
J'ai décalé l'origine du dégradé conique, j'y ai ajouté de la couleur.
D'ailleurs je ne savais pas qu'on pouvait superposer les couleurs aussi facilement (et ouai "cascading" s'oublie assez vite).

<details><summary>
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);"><div style="background-color:hsla(0,0%,20%,0.93);margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;"><p>Le contenu</p></div></div>
</summary>

{{< highlight html >}}
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);">
  <div style="background-color:hsla(0,0%,20%,0.93);margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;">
    <p>Le contenu</p>
  </div>
</div>
{{< / highlight >}}

Et là pouf c'est tout mignon.
La bordure sur le contenu permet de renforcer l'ombre et donne un peu de relief.
Les rayures acentrées permettent de voir venir le bas de la page sur du contenu long.
Le dégradé linéaire permet de voir également la progression dans la page (même si c'est assez subtil je vous l'accorde).
</details>

Franchement le CSS à notre époque est devenu super cool.
Ici pour centrer la page ça prend que deux propriétés.
On peut parvenir à obtenir un rendu avec très peu de règles et sans ajouter tout un tas d'élément bidon à la page.
Les propriétés liées aux grilles et flexbox permettent d'avoir les agencements usuels très facilement.

## Voilà voilà
Bref, je suis à deux doigts de rajouter des rayures sur le blog !
Je suis assez fier du résultat même si j'imagine qu'il y a probablement moyen d'améliorer encore.

Vous pouvez bien évidemment allez voir à quoi ressemble [le site de Geeknode](https://www.geeknode.org). 


