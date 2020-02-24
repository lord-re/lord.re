+++
Author = "Lord"
Description = "Ajouter un nouveau critère pour trouver des articles similaires est relavitement simples dans Hugo. J'ai donc écrit un ptit script pour trouver les mots les plus fréquents dans un article afin de trouver les mots-clés."
Categories = ["hugo", "script"]
menu = "main"
notoc = true
WritingDate = 2020-02-21T19:02:35+01:00
date = 2020-02-24T16:02:35+01:00
title = "Amélioration des suggestions d'articles similaires via un script shell"
editor = "kakoune"
TopWords = [ "uniq", "grep", "tags", "top_words", "tail", "mots", "sort"]
+++
En bas des articles j'ai mis (depuis un bon moment maintenant) un lien vers des articles similaires.
Ça marche pas trop mal car ça se base sur les tags.
Le souci c'est que c'est très manuel.
Et donc c'est toujours chiant de trouver les bons tags à mettre.

Du coup j'ai voulu me simplifier la vie et affiner un peu ces résultats.
Pour ça je conserve les tags comme actuellement parceque ça crée des pages de tags et tout, mais j'ai ajouté un système supplémentaire assez équivalent mais qui est invisible et ne créer pas de page supplémentaire.
Ça me permet d'ajouter des tags invisibles et donc d'y mettre des trucs pas forcément pertinent au premier regard.

## Top_Words
Le principe est le suivant, je compte tous les mots afin de voir lesquels reviennent le plus dans un article.
Il y a de fortes chances que ça soit de potentiels tags.

Je fous ça dans le *frontmatter* et je demande à **Hugo** de les prendre en compte pour trouver les articles similaires.

Voyons ça de plus près.

## Élaboration du dico des mots bateaux
Vous vous doutez que les mots qui reviennent le plus sont les mots "inintéressants".
D'ailleurs voilà le TOP10 des mots qui reviennent le plus sur mon blog.

| # | ocurences | mot |
|:-:|:----:|:-:|
| 1 | 8995 | de |
| 2 | 5496 | est |
| 3 | 4908 | le |
| 4 | 4672 | un |
| 5 | 4045 | et |
| 6 | 3719 | à |
| 7 | 3626 | la |
| 8 | 3287 | les |
| 9 | 3024 | pas |
| 10 | 2856 | d |

Pour créer ce top j'ai utilisé la commande suivante :

<samp>tail ~/www/content/\*/\*/index.md -n +12 | grep -E '\w+' -o | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -g | less</samp>

Passionnant n'est-il pas ?
Bon globalement tous les mots de ce TOP10 (et en vrai même top 100 ou plus) sont inintéressants et n'apporte pas de contenu.

## Création d'un dico personnalisé
<samp>tail ~/www/content/\*/\*/index.md -n +12 | grep -i -E '\w+' -o| sort | uniq -c | sort -g | tail -n 500 | awk '{print $2}' | sort > ~/www/top_words</samp>

On hésite pas à fureter dedans et virer les faux-positifs.
D'ailleurs probablement qu'à terme j'y ajouterai certains mots manuellement.

## Script pour analyser les top_words d'un article
Ce script va donc utiliser le dico précédemment créé.
Il suffira de le lancer et hop il vous affichera un top des mots avec leur nombre d'ocurence.

Ensuite il donne la ptite ligne à copier/coller dans le frontmatter de l'article (flemme jusqu'au bout).

<details open><summary>/usr/local/bin/top_words</summary>
{{< highlight "shell" >}}
#! /bin/sh
tail "$1/index.md" -n +12 | grep -E '\w+' -o | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -g | grep -f /home/lord/www/top_words -v -w | tail -n 10

printf "TopWords = ["
virgule=" "
for line in $(tail "$1/index.md" -n +12 | grep -E '\w+' -o | tr '[:upper:]' '[:lower:]' | sort | uniq -c | sort -g | grep -f /home/lord/www/top_words -v -w -i| tail -n 10 | awk '{print $2}')
do
  IFS=""
  printf "%s \"%s\"" $virgule $line
  virgule=","
done
printf "]\n"
{{< / highlight >}}
</details>

Le script pourrait très probablement être amélioré mais pour un premier jet c'est amplement suffisant.

## Adaptation de la config d'Hugo
Il suffit de modifier la config du site pour prendre en compte ce nouveau paramètre du *frontmatter*.

<details open><summary>~/www/config.toml</summary>
{{< highlight "toml" >}}
[related]
  includeNewer = true
  [[related.indices]]
    name = "categories"
    weight = 20
  [[related.indices]]
    name = "TopWords"
    weight = 21
{{< / highlight >}}
</details>

Et le tour est joué, notre nouvelle variable a plus de poids que le précédent critère.

Bon j'imagine que les experts dans le traitement du langage et les programmeurs vont bien se marrer en voyant le truc mais à mon niveau ça fait bien le taff.
Ça me fait une petite commande de plus à lancer lors de la publication.
