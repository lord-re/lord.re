+++
Author = "Lord"
Description = ""
Categories = ["meta", "compression","web"]
menu = "main"
notoc = true
draft = false
WritingDate = 2021-02-11T20:01:01+01:00
date = 2021-02-11T20:01:01+01:00
title = "Un peu plus de compression pour le blog : brotli+avif"
editor = "kakoune"
TopWords=["compression","gzip","brotli","static","nginx","blog","statique","webp","avif","av1","optimisation"]
+++
C'est marrant comme l'évolution technique de mon blog est au final dicté par les évolutions de mon hébergement mais aussi par l'évolution des navigateurs.
Bon en vrai, ça parait tout à fait logique mais je m'imaginais plus maître de mes choix mais force est de constater que je ne peux faire que ce que me permet l'environnement logiciel…

## Salade de Brotli
Bref, tout ça pour dire que j'ai enfin pu faire en sorte que mon ptit blog puisse utiliser la compression **brotli**.
C'est un algorithme de compression assez moderne se débrouillant vraiment bien.
Il permet d'être globalement un peu plus efficace que le vénérable **gzip**.

Bon, si vous utilisez les meilleurs paramètres de compression la différence n'est pas énorme mais c'est toujours bon à prendre.
J'avoue qu'à terme je pense ne garder que le brotli et ne pas garder le gzip mais je vais rester comme ça quelque temps d'abord.

### Côté serveur web
Les navigateurs savent tous lire des données compressées via cet algo.
Je ne l'ai pas mis en place plus tôt car mon serveur web ne pouvait pas l'utiliser comme je le voulais.
Mais avec **Alpine Linux** en version 3.13 on a enfin un paquet **nginx-mod-http-brotli**.
Ce paquet permet deux fonctionnements : 

  - soit on laisse nginx compresser à la volée les fichiers, ça ne nécessite aucune mise en place mais à chaque visiteur ça va faire bosser nginx, c'est pas un fonctionnement que je veux.
  - soit on lui fournit les fichiers en version normale mais également en version compressée en brotli et là du coup c'est plus léger en cpu.

Cette seconde façon de faire nécessite donc de compresser soi-même les fichiers à l'avance ce qui permet d'utiliser les options de compression les plus lourdes mais offrant donc les meilleures performances.
Je vous détaille comment le mettre en place.

Allez hop ni une ni deux <kbd>apk add nginx-mod-http-brotli</kbd> on se rend ensuite dans votre fichier de conf nginx :

<details><summary>léger extrait /etc/nginx/conf.d/lord.re</summary>

<pre>server{
	…
	…
	gzip_static on;
	brotli_static on;
	…
	…
}</pre>
</details>

Juste en rajoutant une ligne et hop.
Plus qu'à <kbd>/etc/init.d/nginx reload</kbd> et c'est bon c'est disponible.
Si les fichiers existent et que le navigateur sait gérer le brotli (il voit ça avec les headers) nginx les enverra au lieu des fichiers originaux.

### Côté compression
J'en ai [déjà parlé]({{< ref "posts/178-compression-gzip-static-nginx">}}) mais je vous en remets une ptite couche : j'utilise le chouette [static-compress](https://crates.io/crates/static-compress) qui est un ptit outil en rust fait exactement pour ce que je veux.

Pour le moment je l'utilisais pour le gzip mais il sait également sortir du brotli avec <kbd>static-compress -c brotli -e br -j 16 -q 11 "/tmp/www/public/\*\*/\*.svg" "/tmp/www/public/\*\*/\*.html" "/tmp/www/public/\*\*/\*.csv" "/tmp/www/public/\*\*/\*.css" "/tmp/www/public/\*\*/\*.txt" "/tmp/www/public/\*\*/\*.xml" "/tmp/www/public/\*\*/\*.json"</kbd> .

Bien entendu j'ai automatisé ça dans un hook git histoire de pas me faire chier.
Mais avec ça vous aurez tous vos fichiers avec leur ptite extension *.br*

Voilà pour cette partie.

## C'est l'avif !
**avif** est un nouveau format d'image avec un nom pourri.
Ces images utilisent en gros le même codec de compression que le format **av1** (le format du futur, j'en ai également [déjà parlé]({{< ref "posts/184-av1-est-utilisable" >}}) (cool j'ai plus besoin de me répéter, j'ai plus qu'à me citer !)).

Du coup ça compresse largement mieux que le jpeg et même un peu mieux que le webp.
Le webp est cool, c'est à peu près la même technique mais basé sur vp8.
Son seul souci c'est qu'il a mis dix ans a être accepté par Firefox (ça émanait de Google, est-ce que ça a joué dans la balance ? 🤷 ).

avif quant à lui est déjà [presque partout](https://caniuse.com/?search=avif) (c'est-à-dire Firefox et Chrome).
Et j'ai bon espoir que les autres navigateurs y passent aussi, le plus touchy sera probablement Apple qui semble s'orienter vers le truc similaire mais proprio de chez MPEG-LA.
Apple étant également membre de l'alliance AOM, on peut espérer qu'ils le supportent.

### Côté HTML
Mais bon support ou non, avec HTML5 les problèmes de format d'image se sont grandement simplifiés avec la balise *\<**picture**>* où l'on peut fourrer plusieurs *\<**source** srcset="" type="">*.
Du coup vous pouvez proposer la même image en *jpeg*, *webp* et *avif* et c'est le navigateur qui va prendre le format qu'il préferre.

Si le navigateur gère plusieurs formats proposés, il prendra le premier disponible donc pensez à mettre le format qui vous arrange le mieux en premier !

J'ai donc retouché mon *shortcode* hugo pour balancer les images à ma convenance :

<details><summary>layouts/shortcodes/img.html</summary>
{{< highlight "golang">}}
{{ $img := $.Page.Resources.GetMatch (.Get "src")}}
{{ $name_splitted := split $img.RelPermalink "." }}
{{ $name_base := index $name_splitted 0 }}
<figure>
  {{ with .Get "link"}}<a href="{{.}}">{{ else }}<a href="{{strings.TrimRight "en/" .Site.BaseURL}}{{$img.RelPermalink}}">{{ end }}
  <picture>
{{ if ( in "svg ico" (index $name_splitted 1) ) }}
    <img src="{{strings.TrimSuffix "en/" .Site.BaseURL}}{{ strings.TrimPrefix "/" $img.RelPermalink }}" alt="{{.Get "alt" }}" />
{{ else }}
    <source srcset="{{strings.TrimSuffix "en/" .Site.BaseURL}}{{ strings.TrimPrefix "/" $name_base}}.thumb.avif" type="image/avif">
    <source srcset="{{strings.TrimSuffix "en/" .Site.BaseURL}}{{ strings.TrimPrefix "/" $name_base}}.thumb.webp" type="image/webp">
    <img src="{{ strings.TrimSuffix "en/" .Site.BaseURL}}{{ strings.TrimPrefix "/" $img.RelPermalink }}" alt="{{.Get "alt" }}"/>
{{ end }}
  </picture>
  </a>
  <figcaption><h4>{{.Get "title"}}</h4></figcaption>
</figure>
{{< / highlight >}}
</details>

### Génération des images
Bon jai mon propre script shell pour générer mes miniatures.
Je vous l'ai déjà montré à l'époque mais je suis en ce moment en train de pas mal le modifier donc c'est trop tôt pour vous montrer un truc potable.

Le logiciel pour générer les images en avif que j'utilise est [cavif](https://github.com/kornelski/cavif-rs) qui est tout petit et ne fait qu'une chose.
Je l'utilise en l'appelant <kbd>cavif --quiet --quality 35 input.jpeg --output output.avif</kbd> et hop.

Vous allez voir que l'encodage prend un temps certain.
J'ai été très agressif sur la qualité et j'ai parfaitement conscience que j'ai choisie un réglage bien plus fort que sur les autres formats et que la comparaison est donc biaisée.
Cela dit je trouve la qualité obtenue largement suffisant pour des miniatures.

Voilà tout !

## Bonus

{{< img src="image.jpg" alt="une image qui sera présentée sur divers format" title="Si tout se passe bien vous devriez avoir le meilleur format que votre navigateur sait gérer.">}}

## PS
Ouaip, je sais que pour Firefox c'est pas encore supporté le avif, mais presque, ça sera dans la prochaine !

Je ne vous ai pas mis de galerie permettant de comparer entre les différents formats d'images à taille égale ou bien à qualité égale mais bon vous trouverez ça ailleurs sur le web ;-)

Ouai je sais j'ai mis un émoji, au moins on peut plus me traiter de boomer !
