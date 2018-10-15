+++
Author = "Lord"
Description = "Deux miniscripts pour recompresser les photos et les vidéos."
Categories = ["backup", "compression"]
menu = "main"
notoc = true
PublishDate = 2018-10-14T19:00:28+02:00
date = 2018-10-15T22:00:28+02:00
title = "Recompresser ses photos et ses vidéos"
editor = "kakoune"
+++
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
