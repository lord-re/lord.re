+++
Author = "Lord"
Description = "Alors que ça faisait trois mois que je subissais un ptit bug à la con dans qutebrowser, je me suis retrouvé à fouiller plus que prévu pour corriger le truc."
Categories = ["qutebrowser", "debug"]
menu = "main"
notoc = true
WritingDate = 2021-01-04T12:30:35+01:00
date = 2021-01-04T12:30:35+01:00
title = "La complétion Qutebrowser qui déconne : Mon premier rabbit hole de l'année"
editor = "kakoune"
TopWords=["qutebrowser","pdfs","sqlite","complétion","sql","historique","debug","url","select"]
+++
Le rabbit hole est une expression anglaise venant d'**Alice Aux Pays Des Merveilles** où la jeune Alice se retrouve à suivre le lapin pour s'engouffrer dans son terrier et finit dans un monde fantastique où elle y passe … beaucoup de temps.
Et bha là je viens de tomber dans un rabbit hole moi aussi.

Depuis quelque temps j'étais tombé sur un bug bien chiant de **Qutebrowser** : *quand je tapes une url, une recherche ou autre, ça se passe bien pour les premiers caractères, puis ça se stoppe, ça rame un ptit coup, puis tout arrive mais avec souvent certains caractères en double*.
Bon je m'en suis accomodé quelques mois mais là j'en pouvais vraiment plus.
C'est ultra rageant comme ptit bug à la con quand je suis un peu speed et que je tape une recherche simple et que je me retrouve à devoir revenir en arrière pour la corriger pour espérer tomber sur le bon résultat.

## Solution de merde

Virer le dossier de boulot de Qutebrowser fonctionne.
Un ptit <kbd>rm ~/.local/share/qutebrowser</kbd> et hop.
Le navigateur redevient performant comme dans le temps.

Mais forcément ça ne m'enchante guère puisque je perds tout l'historique des pages déjà visitées.

## Diagnostic plus poussé

Comme à mon habitude je suis allé pleurnicher sur le salon IRC, voir si certains ont une idée.
Mais j'avais déjà ma ptite idée.

Par chance, je tombe sur le dev principal.
Je lui demande si ça ne pourrait pas venir d'un historique un peu trop volumineux.
Mon fichier *~/.local/share/quterbrowser/history.sqlite* faisant 64Mo ce qui est pas mal mais pas non plus délirant.

Il me répond qu'il n'a aucun souci (forcément) et que le sien fait 335Mo donc la volumétrie ne devrait pas poser de souci.
Par contre il me suggère un réglage qui pourrait solutionner mes emmerdes :
<kbd>:set completion.web_history.max_items</kbd>

Et là je teste avec <kbd>500</kbd> et ça marche nickel.

Bon c'est cool mais ça n'explique pas pourquoi ça déconne.
Mon ordi est parfaitement capable de lire et filtrer un fichier de 64Mo de façon instantannée, pourquoi il n'y arriverait pas avec un fichier au format sqlite ?

Je me décide à bourriner pour trouver à partir de quelle valeur ça déconne.

  - <kbd>5000</kbd> ok
  - <kbd>10000</kbd> ok
  - <kbd>20000</kbd> nok
  - <kbd>15000</kbd> nok
  - <kbd>12000</kbd> nok
  - <kbd>11000</kbd> nok
  - <kbd>10500</kbd> nok
  - <kbd>10001</kbd> ok
  - <kbd>10100</kbd> nok
  - <kbd>10050</kbd> nok
  - <kbd>10030</kbd> ok
  - <kbd>10040</kbd> ok
  - <kbd>10045</kbd> ok
  - <kbd>10048</kbd> ok
  - <kbd>10049</kbd> nok

HAAA !
J'ai trouvé **LA** valeur.

Bon c'est cool mais j'en fais quoi ?

## Qutebrowser et sqlite

### Debug 
Bon je rembête un peu le dev sur le salon IRC et là il m'indique qu'on peut voir quelles sont les requêtes.
Pour cela, il suffit de lancer QB avec <kbd>qutebrowser --debug --logfilter sql</kbd>.

Et là dès qu'on ouvre la barre on a tout un tas de bordel qui s'écrit dont :


```
12:46:46 DEBUG    sql        sql:__init__:175 Preparing SQL query: "SELECT min(last_atime) FROM (SELECT last_atime FROM CompletionHistory ORDER BY last_atime DESC LIMIT :limit)"
12:46:46 DEBUG    sql        sql:run:208 Running SQL query: "SELECT min(last_atime) FROM (SELECT last_atime FROM CompletionHistory ORDER BY last_atime DESC LIMIT :limit)"
12:46:46 DEBUG    sql        sql:run:212 query bindings: {':limit': 10051}

12:46:46 DEBUG    sql        sql:__init__:175 Preparing SQL query: "SELECT url, title, strftime('%Y-%m-%d %H:%M', last_atime, 'unixepoch', 'localtime') FROM CompletionHistory WHERE ((url LIKE :0 escape '\' OR title LIKE :0 escape '\')) AND last_atime >= 1601542597 ORDER BY last_atime DESC"
12:46:46 DEBUG    sql        sql:run:208 Running SQL query: "SELECT url, title, strftime('%Y-%m-%d %H:%M', last_atime, 'unixepoch', 'localtime') FROM CompletionHistory WHERE ((url LIKE :0 escape '\' OR title LIKE :0 escape '\')) AND last_atime >= 1601542597 ORDER BY last_atime DESC"
12:46:46 DEBUG    sql        sql:run:212 query bindings: {':0': '%%'}
12:46:46 DEBUG    sql        debug:__exit__:302 Running completion query took 0.000212 seconds.
```
Et si on tape une lettre de plus :
```
12:47:17 DEBUG    sql        sql:run:208 Running SQL query: "SELECT url, title, strftime('%Y-%m-%d %H:%M', last_atime, 'unixepoch', 'localtime') FROM CompletionHistory WHERE ((url LIKE :0 escape '\' OR title LIKE :0 escape '\')) AND last_atime >= 1601542597 ORDER BY last_atime DESC"
12:47:17 DEBUG    sql        sql:run:212 query bindings: {':0': '%w%'}
12:47:17 DEBUG    sql        debug:__exit__:302 Running completion query took 0.00049 seconds.
```

### Compréhension des requêtes

Alors en analysant un peu le truc, même si vous êtes aussi doué que moi en SQL, il y a moyen de comprendre ce qu'il se passe.

Déjà on voit que la requête doit se lire sur deux lignes mais en gros c'est tout d'abord ça :

<kbd>SELECT min(last_atime) FROM (SELECT last_atime FROM CompletionHistory ORDER BY last_atime DESC LIMIT :limit)</kbd>

Avec *:limit* qui vaut <kbd>10051</kbd> dans mon exemple.

Cette requête retourne le plus petit de tous les *last_atime* des 10051 derniers éléments de l'historique.
Je pense deviner que ça correspond en gros au plus vieux timestamp des url que l'on a consulté dans l'historique.

Qutebrowser marque le timestamp de l'instant de consultation de chacune des url visitées.
Avec cette requête il récupère donc le plus vieux timestamp de la plus vieille url où l'on cherchera.

Dans un second temps, Qutebrowser va faire une seconde requête : 

<kbd>SELECT url, title, strftime('%Y-%m-%d %H:%M', last_atime, 'unixepoch', 'localtime') FROM CompletionHistory WHERE ((url LIKE :0 escape '\' OR title LIKE :0 escape '\')) AND last_atime >= 1601542597 ORDER BY last_atime DESC</kbd>

Celle-là est plus intimidante mais finalement n'est pas bien compliquée.
Cette requête récupère l'url, le titre de la page, convertit le timestamp en date lisible pour les humains parmis toutes les url de l'historique dont le timestamp est supérieur au timestamp récupéré à la requête précédente.

Ce qui est intéressant est la partie avec <kbd>((url LIKE :0 escape '\' OR title LIKE :0 escape '\'))</kbd> .
Le *:0* est pour l'instant vide, mais à chaque appui sur une touche supplémentaire, on va la voir s'ajouter ici, ce qui permettra à sqlite de filtrer dans l'url ou le titre ce qu'on tape.

C'est astucieux de laisser le boulot de recherche et donc de complétion à sqlite directement plutôt que de recoder ça.

Bon bha avec ça, je vais pouvoir me lancer moi-même à la recherche de l'élément foireux.

## Un ptit fix

Je dégaine un ptit <kbd>sqlite3 ~/.local/share/qutebrowser/history.sqlite</kbd> et c'est parti.
Je vous fais pas tous les tâtonnements mais je suis arrivé à trouver le bon *last_atime* de l'entrée qui fait chier et donc je l'affiche pour voir quelle est la ligne en cause :
<kbd>SELECT * FROM CompletionHistory where last_atime = 1601542534;</kbd>

<samp>qute://pdfjs/web/viewer.html?filename=tmp6airxyyx_mH7o+Rj08e6njE+ffgP3hPP...eHJlZgo4MDMxMDYKJSVFT0YK&file=&source=data:application/pdf;base64,JVBERi0xLjQKJe……………0YK|file|1601542534</samp>

Bon j'ai tronqué mais vous voyez le délire.
En fait je me suis retrouvé avec tout un pdf dans sa propre url et donc un truc de plus de 1Mo dans le champ url ce qui perturbait quelque peu sqlite (mais pas trop non plus).

Il ne reste plus qu'un ptit <kbd>DELETE FROM CompletionHistory where last_atime = 1601542534;</kbd> et le tour est joué.

**SQLite** respire et maintenant **Qutebrowser** respire aussi \o/

## Le repos bien mérité

Et là je me dis que j'ai laissé trainer ça pendant trois mois à m'emmerder alors qu'au final c'était résolu en une heure.
J'ai passé plus de temps à écrire cet article qu'à débugguer.

