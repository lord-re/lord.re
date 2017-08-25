+++
Description = "Abordons une conf de nginx avec php plutôt proprette"
date = "2014-03-11T23:36:06+02:00"
title = "Monter un hébergement de site web propre et performant."
menu = "main"
Categories = ["software","libre","tips","www"]
Tags = ["software","libre","tips","www"]

+++
***Update 2017 :*** *Avec un peu de recul c'est pas mal depuis la conf de nginx a subtilement changé, c'est globalement compatible mais pas optimal. Qui plus est j'aborde pas le ssl, http2, …*

Héberger un site web c'est simple emerge apache2 et zouuu ça marche. C'est bien gentil mais ça a des perfs de merdes, c'est crado toussa. Et s'il l'on prenait un peu de temps pour faire un truc au propre ?
Préparons le FS
Déjà on va faire tourner notre serveur web avec un user bien différent du système (nginx ou www-data) et donc on va lui créer son home : */home/nginx*. On va ensuite faire une petite place pour les logs dans /var/log/nginx/ que l'on linkera dans */home/nginx/LOGS* histoire de retrouver ça vite fait. Créons un dossier pour notre premier site ouaib : */home/nginx/lord.re*. Vous le comprenez vite, nos prochains vhost seront au même endroit ;-) . Préparons un peu le fs pour les confs. On se rend donc dans */etc/nginx/* et créons un dossier vhosts. On prendra soin de créer un fichier skel contenant la conf de base qui sera repris pour les autres vhost. Bon bon ça y est cette partie est propre.

## Vhost aifair
Nginx permet d'inclure des fichiers de confs à la volée et aussi d'utiliser des variables. On va donc tenter de rationaliser au mieux les confs. Créons donc le fichier de conf général : */etc/nginx/nginx.conf*.
```
…
user nginx nginx;
worker_processes 1; (mettre le nombre de CPU)
…
http {
…
include /etc/nginx/vhosts/*;
}
```

Donc à partir de maintenant chaque nouveau site aura sa conf séparée à la manière de debian.
*/etc/nginx/vhosts/lord.re*
```
server {
listen :80;
server_name www.lordtoniok.com lordtoniok.com bender.lordtoniok.com www.lord.re lord.re bender.lord.re;
access_log /var/log/nginx/lord.re.access_log main;
error_log /var/log/nginx/lord.re.error_log info;
root /home/nginx/lord.re/;
autoindex on;
}
```
Voilà une conf de base que l'ont étoffera.

## Vive le static cacheable gzipable
Une première optimisation easy qui fera gagner pas mal de bande passante et rendra votre site bien plus snappy est la mise en cache. Tous vos visiteurs mettront en cache des parties de votre site pour ne pas les retélécharger à chaque changement de page et à chaque visite. Donc faisons en sorte que le navigateur de vos visiteurs cache. Deux solutions s'offrent à vous : gérer la mise en cache dans chaque vhost ou bien créer un fichier de conf pour le cache que vous incluerez dans chacun de vos vhosts (protip : c'est la bonne solution pour flemmarder).

*/etc/nginx/cache.conf*
```
location ~* \.(js|css|png|jpg|jpeg|gif|ico|html|htm|pdf)$ {
expires 1w; (votre contenu sera considéré comme valable une semaine un F5 forcera un retéléchargement rassurez-vous)
}
```

Et maintenant dans chaque vhost vous pouvez ajouter un include de ce fichier de conf et zouuu vous avez une jolie mise en cache.
Bon pour réduire la conso de bande passante et rendre votre site encore snappier : compressons ! Donc on va faire en sorte que les fichiers non compressés soient zippés à la volée par nginx avant d'être envoyé au client. Ces règlages se trifouillent dans le bloc http de nginx :

*extrait du /etc/nginx/nginx.conf*
```
gzip on;
gzip_min_length 500; les fichiers de moins de 500octets ne seront pas impactés
gzip_buffers 4 8k;
gzip_types text/plain text/css text/javascript application/javascript application/x-javascript;
gzip_vary on; au diable ie6
```
On constate facilement des différences de 50% dans la taille de pages web. Avec ça vous aurez un joli gain de perfs.

## − PHP − Un mal nécessaire
Bon tant qu'à parler conf nginx autant aborder la mise en place de PHP. Une fois installé (avec FPM bien entendu et en fonctionnement). La conf pourra (comme la mise en cache) être mise dans un fichier séparé à inclure.
*/etc/nginx/php.conf*
```
location ~ \.php$ {
fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
include fastcgi_params;
fastcgi_pass unix:/tmp/php.socket;
}
```
Bon bha voilà vous avez une conf bien poussée. Si vous voulez aussi voir comment faire du reverse proxy il y a déjà [un article]({{< ref "posts/33-reverse-proxy-nginx.md" >}}).
