+++
Author = "Lord"
Description = "Première étape de l'ajout d'un mode clair pour mon ptit blog. J'utilise les media queries du -media-prefers-color-scheme et des variables CSS pour arriver au résultat escompté."
Categories = ["meta", "ux", "css"]
menu = "main"
notoc = true
WritingDate = 2020-11-01T11:29:46+01:00
date = 2020-11-05T11:29:46+01:00
title = "CSS de jour comme de nuit"
editor = "kakoune"
TopWords=["accessibilité","web","css","media query","variables","dark","light"]
+++
Depuis toujours j'ai adopté un thême visuel très dark net crypto hacker pour mon blog.
J'ai toujours eu un ptit faible pour les interfaces sombres et du coup naturellement c'est ce vers quoi j'ai voulu aller pour mon ptit coin de web.

Sauf que bon j'ai appris récemment que notre cerveau avait (une très faible) latence supplémentaire quand il doit traiter des informations visuelles sombres.
Forcément, je ne voulais pas que mes pauvres lecteurs aient du mal à comprendre mes propos et je me devais donc d'agir.
En plus *certaines défaillances visuelles font qu'un site sombre n'est pas forcément accessible pour tout le monde*.

J'ai tenté à plusieurs reprises de faire un thême clair sauf que je me sens clairement pas l'envie de maintenir deux feuilles de style séparées.

L'arrivée récente de [-media-prefers-color-scheme](https://drafts.csswg.org/mediaqueries-5/#descdef-media-prefers-color-scheme) dans les specs du CSS m'a poussé à y re-réflêchir de nouveau.
Et j'ai donc repris ce que j'avais commencé dans la douleur : **une feuille de style CSS avec des variables** pour "m'alléger le boulot".

Franchement changer quelques couleurs par-ci par-là, c'est rien, hein ?
Il y en a pour une demi-heure et c'est torché, non ?

Bha non.
C'est galère.

On peut pas juste changer la couleur de fond et hop c'est fait.
Il faut *s'assurer que toutes les couleurs utilisées aient un contraste suffisant une nouvelle fois*.
Et globalement il faut du coup toutes les redéfinir.

Et puis c'est là qu'on se rend compte que le jaune c'est dur à poser sur un fond clair (tendant vers le blanc).
Le jaune est devenu mon némésis.
C'est vrai, autant sur un fond sombre c'est facile de trouver un jaune doré avec un bon contraste et pas moche mais sur fond blanc c'est une galère.
Le contraste est pourri ou alors visuellement c'est super moche.

## Variabilisation du CSS
Depuis pas si longtemps que ça, on peut utiliser des variables en CSS.
C'est l'outil parfait pour réaliser une base commune (la structure spatiale du site, la typographie) et de pouvoir par la suite jouer sur les couleurs via des variables redéfinissable.

La première étape consiste donc à créer en tête du CSS un block contenant toutes ces variables avec les couleurs actuelles.

<details><summary>extrait du neodark.css</summary>

{{< highlight "css" >}}
:root{
  --background:#272b30;
  --default-color:#bbb;
  --header-delimiter:#414;
  --bg-accent:#222;
  --url-color:#ea872d;
  --h2-color:#8aa;
  --posts-h1-a:#cac;
  --fast-h1-a:#99c3d1;
  --shares-h1-a:#ffa;
  --ideas-h1-a:#aff;
  --recap-h1-a:#9cd256;
  --category:#aeb8f9;
  --em:#8a8;
  --strong:#a8a;
  --kbd-samp:#fca;
  --tr-even:#333;
}
{{< / highlight >}}
</details>

Bon j'ai pas changé toutes les couleurs encore, mais déjà avec juste celle-là ça permet d'avoir une bonne base utilisable.
Maintenant que j'ai défini ces variables il faut les utiliser aux bons endroits bien entendu et là, la syntaxe est un peu longue mais tolérable.

<details><summary>extrait du neodark.css</summary>

{{< highlight "css" >}}
html{
 line-height:1.35em;
 background:var(--background);
 color:var(--default-color);
}
{{< / highlight >}}
</details>

Bon une fois qu'on a remplacé toutes les occurences partout c'est chouette mais ça ne créé pas un nouveau thême, on a juste tout mis dans des variables.

## Thême de couleur
Bon, c'est maintenant qu'on utilise la propriété CSS permettant de définir un thême clair ou sombre !
Ça y est !

<details><summary>extrait du neodark.css</summary>

{{< highlight "css" >}}
@media screen and (prefers-color-scheme: light){
  :root{
    --background:#eee;
    --default-color:#222;
    --header-delimiter:#fff;
    --bg-accent:#ddd;
    --url-color:#000;
    --h2-color:#388;
    --posts-h1-a:#7b56d2;
    --fast-h1-a:#5694d2;
    --shares-h1-a:#d2c656;
    --shares-h1-a:#ff0080;
    --ideas-h1-a:#56c6d2;
    --recap-h1-a:#85ce27;
    --category:#0062ff;
    --em:#0062ff;
    --strong:#7b56d2;
    --kbd-samp:#fff;
    --tr-even:#ccc;
  }
}
{{< / highlight >}}
</details>

La première ligne est une **media query** qui permet de n'appliquer les règles que dans certaines conditions.
La condition définie ici est le *prefers-color-scheme: light*.
Donc quand le navigateur indique qu'il préferre afficher un thême clair, ce sont ces régles CSS qui seront appliquées par-dessus les existantes.

Et voilà avec ça, vous avez, par défaut un site sombre mais avec un thême clair pour les gens ayant choisie un thême clair.
Il me reste à trifouiller et régler encore un peu pour réhausser du contraste de droite et de gauche et surtout trouver la formule magique pour les jaunes.

{{< img src="nuit.png" alt="capture d'écran de la version sombre classique du thême" title="Bon vous connaissez probablement cette version déjà" >}}
{{< img src="jour.png" alt="capture d'écran de la version claire du thême" title="Le nouveau thême clair pas encore parfaitement finalisé, beaucoup de soucis de contraste à améliorer." >}}
