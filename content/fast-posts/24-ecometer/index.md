+++
Author = "Lord"
Description = "Adaptation de mon site pour améliorer mon score ecometer. On va recourir à la pagination et on va la personnaliser."
Categories = ["meta", "hugo"]
menu = "main"
notoc = true
PublishDate = 2018-08-30T21:19:54+02:00
date = 2018-08-30T21:19:54+02:00
title = "Ecometer : De mauvais à plutôt bon en paginant."
editor = "kakoune"
TopWords = [  "flux", "label", "rss", "score", "pagination", "url", "paginator"]
+++
J'ai de loin maté [une conf concernant le GreenIT](https://www.paris-web.fr/2016/conferences/eco-conception-mon-site-web-au-regime.php) appliqué au web.
Habituellement le GreenIT est assez pipeau mais étonnamment j'ai trouvé ça plutôt cohérent.

Et du coup dans cette conf ils évoquent [EcoIndex](http://www.ecoindex.fr/) un site web analysant des pages web pour leur attribuer un score.
J'adore ce genre de truc !

Ici le score se base sur la performance environnementale.
La taille de la page, le nombre de requête, le nombre d'élément DOM et bha je crois que c'est à peu près tout.
Bon ça vaut ce que ça vaut (si pour générer la page il faut trente secondes de génération dans le langage X, c'est sûr que l'impact environnementale sera catastrophique).

Bref, tout confiant d'avoir un bon score je lance le test et j'obtiens **D** avec un **44.6**.
Pourtant tout est bien en dessous de la médiane sauf *la complexité de la page* où la médiane se trouve à 603 éléments alors que j'en envoie 2431 !
Bon bha va falloir améliorer ça pour donner l'exemple.

D'où ça vient ?
Tout simplement du fait que sur la page d'accueil je liste chacun des articles du site et que bha ça commence à faire.
Et c'est d'ailleurs peu pertinent d'afficher des articles d'il y a plus de dix ans…
Remédions à cela et vite !

## Paginons !
Bon donc on va juste afficher les 20 derniers items sur la home puis mettre les habituels liens précédents/suivants et compagnie.

Dans *layouts/index.html* on remplace le <kbd>range</kbd> par :

{{< highlight go >}}
{{ $paginator := .Paginate (where .Data.Pages "Type" "in" .Site.Params.sectionsInHomepage ) }}
{{ range $paginator.Pages }}
{{< / highlight>}}

Et ensuite il ne reste plus qu'à rajouter les liens de pagination donc dans ce même fichier à l'endroit qui vous convient ajoutez :

{{< highlight go >}}
{{ template "partials/pagination.html" . }}
{{< / highlight>}}

Et voilà ?
Non.

Le template de pagination made in Hugo me convenait pas du coup je l'ai retouché à ma façon donc maintenant on créer *layouts/partials/pagination.html* :

{{< highlight go >}}
<div class="pagination" style="text-align:right;">{{ $paginator := .Paginator }}{{ $.Scratch.Set "CurrentPage" .Paginator.PageNumber}}
{{ if gt $paginator.TotalPages 1 }}{{ if gt $paginator.TotalPages 4 }}<a href="{{$paginator.First.URL}}" aria-label="First">««</a>{{end}}
{{ if $paginator.HasPrev}}<a href="{{$paginator.Prev.URL}}" aria-label="Previous">«</a>{{end}}
{{ range $paginator.Pagers}} <a {{if eq ($.Scratch.Get "CurrentPage") .PageNumber}}style="font-size:1.3rem;font-weight:900;"{{end}}href="{{.URL}}">{{.PageNumber}}</a> {{end}}
{{ if $paginator.HasNext}}<a href="{{$paginator.Next.URL}}" aria-label="Next">»</a>{{end}}
{{ if gt $paginator.TotalPages 4 }}<a href="{{$paginator.Last.URL}}" aria-label="Last">»»</a>{{end}}{{ end }}
</div>
{{< / highlight >}}

Le rendu est beaucoup plus compacte que le template par défaut Hugo.

## Verdict ?
Et bha c'est pas mal du tout !

  - *La page d'accueil passe de 49.7Ko à 14.7Ko.*
  - Le score passe à un joli **A** avec **77.6** !
  - Le nombre d'éléments DOM passe de 2431 à 342.

D'ailleurs dans le même genre d'idée j'ai limité le nombre d'articles dans mon flux RSS.
Mine de rien rien que *le flux RSS représente près de 3Go de bande passante mensuelle*.
En sachant que les personnes déjà abonnées au flux RSS ne seront pas impactées, seuls les nouveaux abonnés ne verront que X articles lors de l'abonnement.

  - Je passe donc de 20 à 5 articles dans le flux RSS.
  - Le fichier fr passe de 188Ko à 52Ko.
  - le fichier en de 68Ko à 16Ko.

Une très belle réduction !

