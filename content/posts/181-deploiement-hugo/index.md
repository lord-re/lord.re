+++
Author = "Lord"
Description = "Avec le temps je me suis un peu amélioré dans mon utilisation d'Hugo pour générer le site ouaib. J'ai ajouté quelques raffinements pour rendre l'utilisation plus agréable tout en rajoutant un blogroll. Du coup ça me fait quelques étapes en plus pour générer le site ouaib mais je l'ai automatisé."
Categories = ["hugo", "git", "adminsys"]
menu = "main"
notoc = true
PublishDate = 2019-08-22T19:55:39+02:00
date = 2019-09-18T10:55:39+02:00
title = "Déploiement Hugo"
editor = "kakoune"
TopWords = [  "extension", "hugo", "sh", "thumbnail", "thumbname", "openring", "script", "web","autohebergement"]
+++
Je génère mon blog avec le logiciel **Hugo** directement sur mon ordi.
Un site ouaib c'est au final qu'un ensemble de fichiers textes et des images en plus.

Ça fait maintenant deux ans que j'utilise Hugo.
J'ai désormais dépassé [la phase de découverte]({{< ref "/posts/57-hugo-www" >}}) et je suis passé à une utilisation un peu plus avancée.
*J'ai un peu changé ma façon de l'utiliser*.

Du coup à chaque fois que je rédige un nouvel article voilà ce qu'il y a à faire :

  1. Création de l'article : <kbd>hugo new posts/super-article/index.md</kbd>
  2. Édition du fichier : <kbd>kak content/posts/super-article/index.md</kbd>
  3. Ajout des éventuelles illustrations : <kbd>cp /une/image.jpg ~/www/content/posts/super-article/</kbd>
  4. Ajout des fichiers dans git : <kbd>git add content/posts/super-article</kbd>
  5. Commit dans git : <kbd>git commit -m "[POST] publication : super-article"</kbd>
  6. Pousser les modifs sur le dépot git : <kbd>git push</kbd>
  7. Générer les <abbr title="Un script shell qui trouve les jpg et png, les recompresse et génère une version plus petite">miniatures</abbr> : <kbd>thumbnailer.sh ~/www/content</kbd>
  8. Générer le <abbr title="Les extraits vers des blogs extérieurs que l'on voit à droite">blogroll</abbr> : <kbd>openring/openring.sh</kbd>
  9. Génération du site en lui-même : <kbd>hugo</kbd>
  10. Compression des fichiers textes en gzip : <kbd>static-compress -c zopfli -e gz …</kbd>
  11. Compression des fichiers textes en brotli : <kbd>static-compress -c zopfli -e br …</kbd>
  12. Transfert du site fr vers le serveur web : <kbd>rsync -av ~/www/public/fr/ user@serveur:/destination/fr</kbd>
  13. Transfert du site en vers le serveur web : <kbd>rsync -av ~/www/public/en/ user@serveur:/destination/en</kbd>

Bon c'est des ptits trucs simples mais en gros les étapes 6 à 13 sont toujours les mêmes avec aucune intervention nécessaire.
Du coup j'ai automatisé tout ça.

Dans **git**, on peut lancer des scripts automatiquement lors de certaines actions, on appelle ça un *hook*.
Du coup, dans le *hook* qui s'exécute lors d'un push j'ai mis toutes les actions de 7 à 13.
Comme ça, lors du <kbd>git push</kbd> elles sont toutes lancées, je n'ai plus rien à faire.

Ça évite d'en oublier une, de se planter sur la syntaxe ou autre connerie du genre.

Pour faire ça, il suffit d'éditer le fichier *.git/hooks/pre-push* (qui se trouve à la racine de votre repo) et d'y mettre tout ce que vous souhaitez et c'est tout bon.

## Les scripts en question

Tout d'abord le hook qui lance un peu tout.
<details><summary>.git/hooks/pre-push</summary>
{{< highlight "shell" >}}
/usr/local/bin/thumbnailer.sh /home/lord/www/content
/home/lord/www/openring/openring.sh
/usr/bin/hugo
static-compress -c zopfli -e gz -j 16 "/home/lord/www/public/**/*.svg" "/home/lord/www/public/**/*.html" "/home/lord/www/public/**/*.csv" "/home/lord/www/public/**/*.css" "/home/lord/www/public/**/*.txt" "/home/lord/www/public/**/*.xml"
static-compress -c brotli -e br -j 16 "/home/lord/www/public/**/*.svg" "/home/lord/www/public/**/*.html" "/home/lord/www/public/**/*.csv" "/home/lord/www/public/**/*.css" "/home/lord/www/public/**/*.txt" "/home/lord/www/public/**/*.xml"
rsync -av /home/lord/www/public/fr/ www@n2:/var/www/lord.re/.
rsync -av /home/lord/www/public/en/ www@n2:/var/www/lord.re/en/
{{< / highlight >}}
</details>

Ensuite le script de génération des miniatures qui me sert aussi globalement et pas uniquement pour le blog.
<details><summary>/usr/local/bin/thumbnailer.sh</summary>
{{< highlight "shell" >}}
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
    jpegoptim -s "$1"
    check_replace "$1" "$thumbname"
  ;;
  png | PNG)
# Ce con de pngcrush a tendance à faire n'importe quoi si on lui dit de réécrire par-dessus les images, du coup on passe par un fichier temporaire qu'on renomme par la suite.
    pngcrush -warn "$1" "$1.tmp"
    mv -f "$1.tmp" "$1"
    /usr/bin/convert -resize 1224\> "$1" "$thumbname"
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
</details>

Et enfin le script de génération du blogroll.
<details><summary>openring/openring.sh</summary>
{{< highlight "bash" >}}
#! /bin/bash
# Je ne vous partage pas la liste parceque bon il y en a trop et ça pète l'affichage…
feeds=( 'https:// … feed.xml' 'https:// … index.xml' )

rand_feeds=( $(shuf -e "${feeds[@]}") )

choose_feeds(){
for index in 0 1 2 3 4 5
do
  selected_feeds="-s ${rand_feeds[$index]} $selected_feeds"
done
}

choose_feeds
echo $selected_feeds

/home/lord/www/openring/openring -n 6 \
$selected_feeds \
< /home/lord/www/openring/in.html \
> /home/lord/www/layouts/partials/openring.html
{{< / highlight >}}
</details>

## Utilisation
Donc maintenant, je me farcis les 5 premières étapes manuellement.
Quand je lance la sixième manuellement, les dernières se déroulent toutes seules.

Me reste plus qu'à ouvrir https://lord.re pour vérifier que ça a bien été poussé comme il faut et de constater les typos que j'ai ratées lors des relectures (toujours pareil).
