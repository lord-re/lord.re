+++
Author = "Lord"
Description = "Un ptit script fait maison pour remuxer dans des mkv des vidéos avec leurs sous-titres et les métadonnées."
Categories = ["script", "shell"]
menu = "main"
notoc = true
WritingDate = 2021-08-10T21:10:13+02:00
date = 2021-08-10T21:10:13+02:00
title = "Remux : script pour muxer les films"
editor = "kakoune"
+++
Je vous l'ai teasé deux fois déjà donc voilà je me décide enfin à vous en parler un peu plus.

Je me suis concocté un petit script en shell pour remuxer les films.
Il m'arrive que l'on me donne des œuvres filmiques numériques mais que celles-ci ne contiennent de sous-titre et … bha j'aime bien avoir des sous-titres.

Du coup je me débrouille pour trouver ces sous-titres mais ensuite il faut les intégrer au fichier vidéo et ça peut vite être assez chiant.
Du coup je me suis fait un ptit script qui permet de faire ça et d'ajouter aussi en méta-données le titre et l'année du film.
Ça sert pas à grand-chose pour le moment mais un jour qui sait…

C'est un tout ptit script crasseux mais pleinement fonctionnel.
Il utilise **ffmpeg** pour le gros du boulot, **unzip**, **fzf** et **iconv**.

**fzf** permet de lancer le script sans avoir à lui foutre en argument le nom du fichier et tout.
C'est une fois dans le script qu'on sélectionne le fichier avec la super ptite interface console de **fzf**.

Une fois le fichier vidéo choisie, je demande s'il y a des subs anglais (je les prends systèmatiquement).
Si oui, je relance ptit coup de **fzf** avec le mode preview d'activé (pratique pour voir les premières lignes des subs).
Si le fichier sélectionné est un zip, on le décompresse et par flemme, j'ai relancé **fzf** pour relancer la sélection.
Tous les fichiers zip ne contiennent pas forcément le fichier bien nommé ou autre donc plutôt que de coder des trucs plus alambiqués autant refaire bosser l'utilisateur.

Ensuite on recommence à l'identique pour un sub français.
J'avais hésité à faire en sorte de pouvoir rajouter d'autres subs par la suite mais… bha … flemme.

Avant d'être intégré à la vidéo, les fichiers subs sont renommés mais surtout convertis en *utf-8* parceque selon les sources il y a souvent des surprises déplaisantes.

Ensuite je demande à l'utilisateur le titre puis l'année du film.

Et enfin la grosse moulinette de **ffmpeg**.
En gros on prend le fichier vidéo, on ajoute les deux fichiers de subs en leur mettant les bonnes métadonnées (en gros la langue du sous-titre pour éviter d'avoir à attendre que le sous-titre se déclenche pour savoir quelle est sa langue.
Ensuite, j'inclus les ptites métadonnées et je sors ça dans un mkv sans recompresser ni l'audio, ni la vidéo, ni le texte.

Et voilà.

C'est pas le script du siècle et pourrait être largement amélioré avec notamment la récup automatique de sous-titre via subliminal (beurk j'aime pas ce truc), meilleure gestion du nombre de subs et ptet d'autres trucs mais voilà pour mon usage ça fait le taff.

Voilà je vous pose le script à la suite si jamais vous voulez vous en servir :

<details><summary>/usr/local/bin/remux</summary>

{{< highlight "bash" >}}
#! /bin/bash
set -eo pipefail
workingdir=$(pwd)
map=0
ffmpeg_args=""

file=$(fzf --prompt "Fichier vidéo source ?")

echo "sub en ? Y / O "
read boolsuben

case "$boolsuben" in 
  "o" | "y" | "O" | "Y" )
    suben=$(fzf --prompt "Fichier sub EN" --preview='head -n 20 {}')
    if [ "${suben##*.}" == "zip" ]
    then
      echo "It's a ZIP !"
      unzip -d unzip_suben "$suben"
      suben=$(fzf --prompt "Fichier sub EN" --preview='head -n 20 {}')
    fi
    let "map=map+1"
    cp "$suben" sub.en.srt
    ffmpeg_arg_en1=$(printf "%s %s" "-i" sub.en.srt)
    ffmpeg_arg_en2="-map $map -metadata:s:s:0 language=eng"

echo -e "\n\n $ffmpeg_arg_en1"

    ## vérif et conversion du sub en utf8
    if [ -z $(file -bi "$suben" | grep -i "utf-8") ]
    then
      iconv --to-code=utf8 --from-code=$(uchardet "$suben") "$suben" --output="sub.en.srt"
#      vim -u NONE '+set fileencoding=utf-8' '+wq' "sub.en.srt"
    fi
  ;;
esac
   
echo "sub fr ? Y / O "
read boolsubfr

case "$boolsubfr" in 
  "o" | "y" | "O" | "Y" )
    subfr=$(fzf --prompt "Fichier sub FR" --preview='head -n 20 {}')
    if [ "${subfr##*.}" == "zip" ]
    then
      echo "It's a ZIP !"
      unzip -d unzip_subfr "$subfr"
      subfr=$(fzf --prompt "Fichier sub FR" --preview='head -n 20 {}')
    fi
    let "map=map+1"
    cp "$subfr" sub.fr.srt
    ffmpeg_arg_fr1="-i sub.fr.srt"
    ffmpeg_arg_fr2="-map $map -metadata:s:s:1 language=fr"

    ## vérif et conversion du sub en utf8
    if [ -z $(file -bi "$subfr" | grep -i "utf-8") ]
    then
      iconv --to-code=utf8 --from-code=$(uchardet "$subfr") "$subfr" --output="sub.fr.srt"
    fi
  ;;
esac


echo "Titre ?"
read title
echo "Année ?"
read year

/usr/bin/ffmpeg -i "$file" $ffmpeg_arg_en1 $ffmpeg_arg_fr1 -map 0 $ffmpeg_arg_en2 $ffmpeg_arg_fr2 -c copy -movflags use_metadata_tags -map_metadata 0 -metadata title="${title}" -metadata year=$year "${title}".mkv
{{< / highlight>}}

</details>

C'est assez cool à utiliser **fzf** pour avoir un semblant de ptite interface dans un script c'est chouette.
