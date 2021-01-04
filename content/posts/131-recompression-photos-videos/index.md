+++
Author = "Lord"
Description = "Deux miniscripts pour recompresser les photos et les vidéos."
Categories = ["backup", "compression"]
menu = "main"
notoc = true
PublishDate = 2018-10-14T19:00:28+02:00
date = 2018-10-15T22:00:28+02:00
lastEdit = 2021-01-04T16:00:24+02:00
title = "Recompresser ses photos et ses vidéos"
editor = "kakoune"
TopWords = [  "bash", "mogrify", "qualité", "script", "jpeg", "photo","image","png","jpg","parallel","pngcrush"]

+++

**J'ai changé mon script pour les photos, je vous ai mis le nouveau en fin d'article !**
------------

Ces derniers temps je suis en pleine migration de serveurs et donc je bouge pas mal de données.
Je vous en ai parlé, j'ai recompressé tout plein de photos persos mais également les vidéos.

La compression par défaut de l'appareil photo est pas super optimisée.
Et pour les vidéos c'est pire encore.

Bref voilà comment j'ai gagné énormément de place sans forcément perdre en qualité.

**Avant de commencer j'ai un backup des données d'origines que je ne toucherai pas avant … longtemps.**

## Photos
Pour les photos j'ai fait un ptit script tout simple : 

{{< highlight "bash" >}}
#!/bin/bash
du -ch "$1"
parallel --eta -j 32 /usr/bin/mogrify -sampling-factor 4:2:0 -interlace JPEG -colorspace RGB -quality 85 "{}" ::: "$1"/*.JPG
parallel --eta -j 32 /usr/bin/mogrify -sampling-factor 4:2:0 -interlace JPEG -colorspace RGB -quality 85 "{}" ::: "$1"/*.jpeg
parallel --eta -j 32 /usr/bin/mogrify -sampling-factor 4:2:0 -interlace JPEG -colorspace RGB -quality 85 "{}" ::: "$1"/*.jpg
du -ch "$1"
{{< / highlight >}}

Tout d'abord il donne la taille des données, ensuite je recompresse en parallèle les photos en JPEG en bonne qualité et enfin il redonne la taille après compression.
C'est plutôt rapide et simple.

Mais méfiez-vous, la commande *mogrify* qui recompresse, supprime le fichier d'origine (pour ça qu'il faut backup avant).

En moyenne, les photos deux fois plus légère que ce que pond l'appareil photo (les photos issues de téléphones sont déjà plutôt bien compressées).

## Vidéos
Là, le processus est plus manuel.
Les vidéos de mon appareil sont dans un format à la con (du H264 en preset High, enrobé dans de l'AVCHD).
Et en plus j'ai une légère tendance à la tremblotte, donc quitte à réencoder les vidéos je vais les stabiliser.

Il y a donc une passe d'observation de la vidéo, puis une passe de stabilisation et encodage.

{{< highlight "bash" >}}
#!/bin/bash
for i in $PWD/*.MTS

do
  echo "Processing vid $i ...${i%.*}"
	ffmpeg -i "$i" -vf vidstabdetect=stepsize=6:shakiness=4:accuracy=15:result=/tmp/transform_vectors.trf -f null -
	ffmpeg -i "$i" -vf vidstabtransform=input=/tmp/transform_vectors.trf:zoom=2:smoothing=10,unsharp=5:5:0.8:3:3:0.4 -c:v libx265 -crf 28 -c:a aac -b:a 128k "${i%.*}.mp4"
	rm /tmp/transform_vectors.trf
done
{{< / highlight >}}

Ouai… je sais… j'ai choisi d'encoder en h265… c'est un format bardé de brevets et autres saloperies made in MPEG-LA, mais l'encodage est bien plus rapide que l'AV1 ou le VP9, la qualité est top et je sais pertinemment que dans dix ans je serai capable de le décoder…
Je verrai dans quelque temps si ça vaut le coup de le refaire en AV1 (j'ai toujours le backup des originaux).

Ici je conserve la vidéo originale et je vérifie manuellement que la nouvelle est bonne (la stabilisation m'inspire moyennement confiance, même si au final je n'ai eu aucun souci à déplorer).
Le gain sur les vidéos varie *entre 2x plus petit et 10x plus petit avec une moyenne aux alentours de 7x plus petit à qualité égale* et en étant bien plus stable.

Voilà, je suis passé de près de 500Go à près de 200Go avec tout ça

Prochaine étape : l'archiver quelque part.

## PS 04/01/2020
J'ai quelque peu changé mon script pour générer les miniatures.
Il marche mieux en vérifiante si les miniatures sont effectivement plus petites que l'original (des fois c'est pas toujours le cas).

{{< highlight "bash" >}}

#!/bin/sh

check_replace(){
# Si le thumbnail généré est plus gros que l'original (ça arrive régulièrement surtout avec les png) on garde l'original et on le copie comme si c'était le thumbnail.
  size_orig=$(stat -c %s $1)
  size_thumb=$(stat -c %s $2)
  if [ "$size_orig" -lt "$size_thumb" ]; then
    rm "$2"
    cp "$1" "$2"
  fi
}

thumbnail(){
  echo -en "Processing image \e[0;34m$1\e[0m :"
  extension="$(echo $1 | awk -F\. '{print $NF}')"
  thumbname="$(dirname $1)/$(basename -s .$extension $1).thumb.$extension"
  thumbwebpname="$(dirname $1)/$(basename -s .$extension $1).thumb.webp"

# Si une image est un thumbnail on la considère comme déjà bien traitée.
  if [[ $1 == *".thumb."* ]]; then
    echo -e " \e[0;31m est un thumb !\e[0m"
    return 0
  fi

# Si une image a déjà un thumbnail, on la considère comme déjà traitée et donc on y retouche pas.
  if [ -f "$(dirname $1)/$(basename -s .$extension $1).thumb.$extension" ]; then
    echo -e " \e[0;31ma déjà un thumb !\e[0m"
    return 0
  fi

  case "$extension" in
  jpg | jpeg | JPG | JPEG )
    /usr/bin/convert -resize 1224\> -quality 55 "$1" "$thumbname"
    /usr/bin/convert -resize 1224\> -quality 55 "$1" "$thumbwebpname"
    jpegoptim -s "$1"
    check_replace "$1" "$thumbname"
  ;;
  png | PNG)
# Ce con de pngcrush a tendance à faire n'importe quoi si on lui dit de réécrire par dessus les images, du coup on passe par un fichier temporaire qu'on renomme par la suite.
    pngcrush -warn "$1" "$1.tmp"
    mv -f "$1.tmp" "$1"
    /usr/bin/convert -resize 1224\> "$1" "$thumbname"
    /usr/bin/convert -resize 1224\> -quality 55 "$1" "$thumbwebpname"
    pngcrush -warn "$thumbname" "$thumbname.tmp"
    mv -f "$thumbname.tmp" "$thumbname"
    check_replace "$1" "$thumbname"
  ;;
  esac
  echo -e "\e[0;32mOK\e[0;m"

}

export -f thumbnail
export -f check_replace

find $1 -name '*.jpg' -or -name '*.jpeg' -or -name '*.JPG' -or -name '*.JPEG' -or -name '*.png' -or -name '*.PNG' | parallel --jobs 16 thumbnail

{{< / highlight >}}

Perso je l'ai placé dans */usr/local/bin/thumbnailer* et je l'utilise en faisant <kbd>thumbnailer /le/dossier/voulu</kbd> .
Il vous fera tous les sous-dossiers également, méfiez-vous.
