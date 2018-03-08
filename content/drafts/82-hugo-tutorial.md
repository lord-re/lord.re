+++
Author = "Lord"
Description = ""
Categories = ["", ""]
menu = "main"
notoc = true
draft = true
PublishDate = 2018-03-07T12:46:32+01:00
date = 2018-03-07T12:46:32+01:00
title = "Créer un blog statique Hugo de A à Y"
editor = ""
+++
Je vois que ces derniers jours Hugo commence à attirer de nouvelles personnes du coup pourquoi pas vous proposer un article un peu plus en profondeur sur ce que j'ai compris d'Hugo.
Je vous ai déjà fait un [retour sur mon utilisation d'Hugo]({{< ref "fast-posts/09-modifs-blogs-hugo" >}}) mais là ça va plus être sous le capot.

Je vais vous montrer comment faire ses premiers pas pour se monter un blog simple comme le mien avec un thême fait maison.

Tout d'abord voilà un ensemble de facts que j'ai accumulé.

  - Hugo n'est pas un moteur de blog mais un générateur de site web statique.
Vous pouvez en faire autre chose qu'un blog.
Et du coup par défaut il ne fait pas forcément un blog.
Par défaut d'ailleurs il ne fait pas grand chose.

  - Hugo fonctionne avec des sections.
Vous pouvez avoir une section blog, une autre pour des articles, encore une autre pour des recettes de cuisines et une dernière pour les livres que vous avez lus.
Chaque section peut être “indépendante” dans le sens où vous allez appliquer un *template* différent.

  - Un thême Hugo n'est pas juste une couche graphique.
Un thême Hugo peut définir la structure de votre site.
Il est difficile de faire quelque chose non prévu par le thême sans le retoucher.

  - Créer un thême peut être un peu ardu la première fois si vous n'avez jamais pondu de html/css.

  - Créer un thême est relativement aisé, surtout si l'on repart d'un thême existant que l'on tord jusqu'à décider de repartir de 0 avec ce que l'on veux exactement.

  - Hugo gère super bien les sites multi-langues pour peu que vous traduisiez le contenu.

  - Migrer de Wordpress à Hugo n'est pas chose aisée.

  - Comme tous les générateurs de sites statiques, Hugo pond des sites facilement hébergeable, très performants et sans soucis de sécurité.

  - Hugo a des mises à jour très régulièrement qui apporte de nouvelles fonctionnalités souvent dispensables.
Pas la peine de rusher les mises à jour : il n'y a pas de risque de faille de sécurité exploitable depuis votre site ouaib.

  - Hugo fournit des messages d'erreurs globalement assez clair si vous vous lancer dans la création d'un thême.
Il vous indiquera généralement les caractères qui lui posent soucis (tel fichier, telle ligne).

  - La [doc d'Hugo](http://gohugo.io/documentation/) est super bien foutue.
Toutes les fonctions sont documentées, souvent avec des exemples, parfois même des vidéos.

  - La [collection de thêmes](https://themes.gohugo.io/) est plutôt conséquente.
Méfiez-vous beaucoup de thême utilise des fonts externes, des JS, du facebook/twitter…

  - Hugo génère par défaut un flux RSS tronqué.
Il est aisé de trafiquer le flux RSS pour qu'il soit complet, ne contiennent que les X derniers articles…

  - Hugo possède un serveur web integré vous permettant de tester votre site ouaib en live quand vous faites des modifs.
Il peut même vous emmener directement sur la page ayant été modifiée automatiquement dès que vous changer un fichier.

Bon après ces quelques remarques globales, attaquons nous à la création d'un blog basique avec la création d'un thême.

## Créer la structure de votre site
Bon sur votre machine personnelle, on va créer un dossier blog et maintenant tout se fera à partir de ce dossier.
**hugo new site ./** Et voilà votre dossier peuplé de nouveaux dossiers.

  - archetypes : contient les éléments qui seront automatiquement rajouté quand vous créerez un nouvel article
  - config.toml : fichier texte où se trouve la configuration de votre site
  - content : contiendra vos articles
  - data : ?
  - layouts : contient les squelettes des pages qui seront générés
  - static : contiendra les données statiques ajoutées à votre site (les images,js, css,…)
  - themes : où vous pourrez mettre les différents thêmes hugo
 
## Créer un article
Afin de pouvoir expérimenter au plus vite, on va déjà créer un article bidon pour votre site.

Avant le premier article on va créer une section blog : **mkdir content/blog**.
Désormais tous vos articles de blog on les rangera dans ce dossier.

Créons l'article : **hugo new blog/welcome.md** .
La chose à prendre en compte c'est que vous ne placez pas explicitement votre nouvel article dans *content*, il le fait de lui même.
Quand vous utilisez la commande *hugo new*, ça sera automatiquement dans *content*.

Maintenons ajoutons du contenu à l'article : **vim content/blog/welcome.md**
Et là vous devriez vous retrouver avec déjà quelques lignes dans votre article.

    ---
    title: "Welcome"
    date: 2018-03-07T12:15:24+01:00
    draft: true
    ---
   
Ces données proviennent en fait du fichier *archetypes/default.md* fournis par défaut.
Dans le jargon on apelle ça le *frontmatter*.
Donc par défaut le titre de votre article sera tiré du nom du fichier donné par la commande *hugo new*.
La date est donc la date de la création du fichier et par défaut votre fichier est à l'état de *brouillon*.
Par défaut, hugo ne génère pas les pages à l'état de brouillon.
Pour la suite, *mettez draft: false*.

Vous pouvez bien évidemment changer ces infos.
Toute les infos que vous mettez entre les “---” seront des méta-données qui seront potentiellement utilisées mais non inclue dans l'article.
Vous pouvez rédiger en dessous votre article en utilisant la [syntaxe MarkDown](https://learn.netlify.com/en/cont/markdown/).

Bon après avoir ajouté un peu de contenu à cet article on va commencer les choses sérieuses : générer une page web !

## Configuration
```
                   | EN
+------------------+----+
  Pages            |  4
  Paginator pages  |  0
  Non-page files   |  0
  Static files     |  0
  Processed images |  0
  Aliases          |  0
  Sitemaps         |  1
  Cleaned          |  0
Total in 21 ms
```
C'est tout de même mignon ce petit tableau récapitulatif !
Bon alors premièrement, votre site est probablement pas en anglais donc va falloir lui dire qu'il se plance.

Allez, voyons le *config.toml*

    baseURL = "http://adresse.de.votre.site/"
    languageCode = "fr-fr"
    DefaultContentLanguage = "fr"
    title = "le nom de votre site"
  
On pourra se contenter de ces réglages pour le moment.
Et du coup si vous relancez la commande **hugo** vous verez que vous générez désormais du français !

### Paramètres fait maison

Hugo n'est pas chiant, si vous voulez rajouter des paramètres qui vous serviront pour votre thême, en plus [des paramètres existants](http://gohugo.io/getting-started/configuration/).
Pour cela il suffit de faire ça sous la forme :

    [params]
       mon_param_a_moi = "machin"
       
Vous pourrez les utiliser via .Site.params.mon_param_a_moi mais on verra ça mieux un peu plus loin.

## Génération

Après avoir généré votre site, vous devriez voir un dossier *public* contenant quelques sous-dossiers et fichiers :

```
   public
   ├── blog
   │   └── index.xml
   ├── categories
   │   └── index.xml
   ├── index.xml
   ├── sitemap.xml
   └── tags
       └── index.xml
       3 directories, 5 files
```

La section *blog* a été créé avec dedans un *index.xml*, le dossier *categories* est automatiquement créé et contiendra les différentes catégories de vos articles de blog.
*sitemap.xml* est le [sitemap](https://fr.wikipedia.org/wiki/Sitemaps) de votre site automatiquement généré par hugo pour vous permettre d'être bien vu par les moteurs de recherche.
*tags* est à l'image de *categories* et sera rempli tout seul au fur et à mesure.
Tous les *index.xml* sont des flux rss.

Mais du coup … je comprends pas … elles sont où les pages web ?

Pour l'instant vous n'avez pas donné d'instruction à Hugo sur la façon de générer les pages web.
Du coup en bon fainéant… il a rien foutu.

## Layouts 
Le lait youte est l'agencement des pages.
En gros c'est le squelette HTML de vos pages que vous allez demander à Hugo de remplir avec le Markdown de vos articles.

On va commencer par le minimum absolu.

Dans *layouts/index.html* :
```
<html>
  <body>
    coucou
  </body>
</html>
```

Je vous avais prévenu c'est vraiment peu.
Maintenant on regénère via **hugo** et on voit qu'on a désormais *public/index.html* qui existe.
Et comme par hasard il contient exactement la même chose que défini dans le *layouts/index.html*.

Ajoutons la magie d'Hugo :
Toujours dans *layouts/index.html* :

```
<html>
  <body>
{{ range .Data.Pages }}
    <h1>{{ .Title }}</h1>
    {{ .Content }}
{{ end }}
  </body>
</html>
```


Et maintenant refaites un ptit coup de **hugo** et observez votre nouvel *public/index.html*
```
<html>
  <body>
    <h1>Welcome</h1>
    <p>coucou</p>
  </body>
</html>

```
Voilà, votre tout premier résultat tangible.
Voyons ce qu'il s'est passé.
*{{ range .Data.Pages }}* indique à hugo d'itérer sur toutes les pages de contenu que vous avez créé.
Donc dans notre cas uniquement le fichier *content/blog/welcome.md*.
Il s'agit d'une boucle qui s'exécutera pour chacun des items jusqu'à la fermeture qu'est {{ end }}.
Et dans cette boucle on récupère le {{ .Title }} qui est donc le *title* que vous avez mis dans le frontmatter de l'article.
Et enfin {{ .Content }} est le rendu du MarkDown se trouvant hors du frontmatter de l'article.

C'est pas bien compliqué.

## Partials
Hugo vous permet d'utiliser des morceaux de html que vous allez pouvoir inclure par la suite.

**mkdir layouts/partials** et ensuite éditons *layouts/partials/header.html*
```
<!DOCTYPE html>
<html lang='{{ .Site.Language.Lang }}'>
  <head>
    <title>{{ .Title }}</title>
    <meta http-equiv="content-type" content="text/html; charset=utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
    <meta name="description" content="{{ .Description }}">
    <meta name="keywords" content="{{ range .Params.Tags }}{{ . }},{{ end }}">
    <meta name="author" content="{{ .Params.author }}">
    {{ .Hugo.Generator }}
    <link rel="stylesheet" href="{{ .Site.BaseURL}}css/style.css">
    <link href="{{ .Site.RSSLink }}" rel="alternate" type="application/rss+xml" title="{{ .Site.Title }}">
    <link rel="icon" type="image/x-icon" href="{{ .Site.BaseURL }}favicon.ico">
  </head>
```
Expliquons vite fait :
donc *{{ .Site.Language.Lang }}* sera remplacé par la langue de la page en question.
Si vous avez la même page dans différentes langues cette variable sera ajustée en fonction.

*{{ .Hugo.Generator}}* sera remplacé par la version de Hugo.

Plusieurs fois vous trouverez *{{ .Site.BaseURL }}* c'est la variable définie dans *config.toml* à la racine de votre site.

Bref maintenant yapuka inclure ça dans votre layout : *layouts/index.html* en ajoutant juste 
```
{{ partial "header.html" . }}
```
Un ptit coup de **hugo** et on observe le résultat.
Le *partial* est inclue dans votre page web avec ses variables qui sont bien remplacées.

Il nous reste encore un détail à voir et vous serez à même de vous débrouillez comme de grandes personnes.

## List/Single pages
Hugo repose sur deux principaux types de pages : les *list pages* et les *single pages*.
Les *single pages* sont les pages affichant un item d'une section (dans notre cas un article de blog).
Les *list pages* sont les pages listant les items d'une section (tous les articles du blog).

Jusqu'à présent, dans notre exemple, nous n'avons que travaillé que la home page du site en bidouillant *layouts/index.html*.
On va donc générer la page pour un article de blog.

**mkdir layouts/blog** puis éditons *layouts/blog/single.html*
```
{{ partial "header.html" . }}
<body>
	<header>
    <h1><a href="{{ .RelPermalink }}">{{ .Title }}</a><h1>
    <p class="meta">{{ .Date.Format "02/01/2006" }}</p>
  </header>
	<main>
    {{ .Content }}
  </main>
</body>
</html>
```
Bon ça reste assez simple (notez comme j'amène de nouveaux éléments que progressivement…).
*{{ .RelPermaLink }}* est le lien vers l'article.
*{{ .Date.Format }}* lit le paramètre *date* de l'article et le met au format *"02/01/2006"*.
J'avoue que cette désignation est assez étrange mais bon vous trouverez [ici](http://gohugo.io/functions/format/) plus d'explication sur les formats possibles.

Impatients de voir le résultat ? **hugo** puis là vous aurez encore plus de fichiers \o/
```
public
├── blog
│   ├── index.xml
│   └── welcome
│       └── index.html
├── categories
│   └── index.xml
├── index.html
├── index.xml
├── sitemap.xml
└── tags
    └── index.xml
    4 directories, 7 files
```   
Vous avez maintenant un dossier blog avec à l'intérieur un *index.html* qui se trouve être votre *single page* de l'article.
Vous y trouverez comme prévu ce que vous avez mis dans *layouts/blog/single.html*.

Il ne reste donc plus qu'à faire la *list page* de la section blog :-)

*layouts/blog/list.html*
```
{{ partial "header.html" . }}
<body>
  <main>
  <h1>Mon blog moche</h1>
  {{ range .Data.Pages }}
    <header>
      <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
    </header>
    <article>
      {{ .Summary }}
    </article>
  {{ end}}
  </main>
</body>
</html>
```
Peu de nouveauté.
*{{ .Summary }}* ne vous sortira pas l'article en entier mais juste le début.
Une fois votre site généré vous aurez désormais un *public/blog/index.html*.

## Petite pause dans l'apprentissage
Bon on a un truc qui marche pas trop mal.
Plus qu'à raffiner.

Déjà pour se simplifier la vie dans un autre terminal lancez **hugo server --navigateToChanged -F -D**.
Cette commande lance le ptit serveur web interne d'hugo en générant les article avec une date dans le futur (-F) et les articles en brouillons (-D).
Une fois lancée, ils vous indiquera quelle adresse ouvrir dans votre navigateur (généralement http://localhost:1313).
À chaque modification, vous serez redirigé vers la page éditée.

Encore pour se simplifier, on va améliorer *archetypes/default.md* pour y rajouter quelques infos intéressantes :
```
+++
Author = "Lord" (enfin si vous voulez m'attribuer tout votre mérite)
Description = ""
Categories = ["",""]
Tags = ["",""]
title = "{{ replace .Name "-" " " | title }}"
date = {{ .Date }}
draft = true
+++
```
Voilà, la description vous permettra de remplir le *<meta>* de la page, et *Tags* également ce qui améliorra sensiblement le SEO.

Bon on teste ?

Créez un second article sur votre blog avec **hugo new blog/le-second-article.md** puis éditez-le pour y mettre un peu de contenu.

Si tout va bien, votre *frontmatter* (les métadonnées en haut du fichier contenant votre article) devrait être pré-rempli.

## Peaufinnage 

### La page d'acceuil
Bon c'est pas mal mais du coup vous remarquerez qu'on a fait une connerie au début : quand on a commencé à faire le layout, on a fait *layouts/index.html* qui est votre homepage comme un sagouin.

Pour l'instant votre page d'accueil liste tous vos articles mais les affiche en entier ce qui est vite indigeste.
Le plus simple est de juste copier *layouts/blog/list.html* et de le mettre à la place de *layouts/index.html* et ça sera plus cohérent.

### Liens vers les articles suivant/précédent
C'est assez simple à jouter automatiquement.
On édite *layouts/blog/single.html* pour rajouter :
```
  <footer>
    {{ if .PrevInSection }}article précédent : <a href="{{ .PrevInSection.RelPermalink }}">{{ .PrevInSection.Title }}</a>{{ end }}
    {{ if .NextInSection }}article suivant : <a href="{{ .NextInSection.RelPermalink }}">{{ .NextInSection.Title }}</a>{{ end }}
  </footer>
```
Le *if* n'affichera que s'il existe un article précédent/suivant.

### Un peu de style 
Bon pour l'instant c'est pas super beau.
Il va vous falloir dégainer votre plus joli CSS et le coller dans les ressources statiques.
Donc **mkdir static/css** puis éditez *static/css/style.css* à votre convenance.

### Un flux RSS complet
Le template de génération de flux RSS par défaut ne place que le {{ .Summary }} d'un article.
Pour le modifier il va falloir modifier le layout par défaut : **mkdir layouts/_default/** et éditer *layouts/_default/rss.xml**
```
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>{{ if eq  .Title  .Site.Title }}{{ .Site.Title }}{{ else }}{{ with .Title }}{{.}} on {{ end }}{{ .Site.Title }}{{ end }}</title>
    <link>{{ .Permalink }}</link>
    <description>Recent content {{ if ne  .Title  .Site.Title }}{{ with .Title }}in {{.}} {{ end }}{{ end }}on {{ .Site.Title }}</description>
    <generator>Hugo -- gohugo.io</generator>{{ with .Site.LanguageCode }}
    <language>{{.}}</language>{{end}}{{ with .Site.Author.email }}
    <managingEditor>{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}</managingEditor>{{end}}{{ with .Site.Author.email }}
    <webMaster>{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}</webMaster>{{end}}{{ with .Site.Copyright }}
    <copyright>{{.}}</copyright>{{end}}{{ if not .Date.IsZero }}
    <lastBuildDate>{{ .Date.Format "Mon, 02 Jan 2006 15:04:05 -0700" | safeHTML }}</lastBuildDate>{{ end }}
    {{ with .OutputFormats.Get "RSS" }}
        {{ printf "<atom:link href=%q rel=\"self\" type=%q />" .Permalink .MediaType | safeHTML }}
    {{ end }}
    {{ range .Data.Pages }}
    <item>
      <title>{{ .Title }}</title>
      <link>{{ .Permalink }}</link>
      <pubDate>{{ .Date.Format "Mon, 02 Jan 2006 15:04:05 -0700" | safeHTML }}</pubDate>
      {{ with .Site.Author.email }}<author>{{.}}{{ with $.Site.Author.name }} ({{.}}){{end}}</author>{{end}}
      <guid>{{ .Permalink }}</guid>
      <description>{{ .Content | html }}</description>
    </item>
    {{ end }}
  </channel>
</rss>
```

### Faire un lien entre articles
C'est un peu une base du web de faire des liens entre les pages.
Pour pointer vers un autre article il suffit de un lien de la sorte :
```
[ceci est un lien]({{ < ref "blog/welcome" > }})
```


## Alors ?
Bha alors vous avez une base fonctionnel pour un blog statique pondu par Hugo.
C'était pas la mère à boire.
Et normalement avec tout ça vous pouvez déjà pas mal vous en sortir.
Une prochaine fois on vera comment héberger le bousin ;-)
