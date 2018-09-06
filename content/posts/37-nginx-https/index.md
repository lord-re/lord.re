+++
Author = "Lord"
Description = "Faire une config SSL propre de nginx en 2015"
date = "2015-02-21T12:03:50+02:00"
title = "Nginx HTTPS 2015"
menu = "main"
Categories = ["meta","www","adminsys","tips","nginx","tls"]

+++

Coucou ! Comme vous le savez surement, commencer un article par "coucou" c'est con.
Mais après tout pourquoi pas ?
Sous des apparences à priori banales, c'est finalement plutôt original (peut-être même inédit !) pour un article technique.
Et puis mine de rien ça permet d'avoir une intro qui va avec, donc on ne va pas s'en plaindre.
Bon donc vu que la folie des failles SSL et compagnie tend à se calmer pour le moment, c'est peut-être le bon moment de mettre à jour sa conf Nginx.
Donc on va tenter d'avoir la meilleure note possible sur le test de Qualys ssllabs.
Si comme moi vous pensez que les certificats x509 (SSL) font marcher une mafia (et aussi parceque vous êtes radin), vous ferez un certificat auto-signé.
Le navigateur râlera donc même si votre sécurité sera élevée.

## Hey ho Let's GO !
Bon on commence par générer les paramètres de Diffie-Hellman car ça peut prendre pas mal de temps (dix minutes sur une bonne machine).
Donc dans un term on commence un joli **<samp>openssl dhparam -out dh.pem 4096</samp>**.
Voilà vous pouvez compter les points si vous êtes patients, sinon vous pouvez passer à la suite.

Maintenant générons le certificat et sa clé : **<samp>openssl req -x509 rsa:4096 -keyout lord.re.key -out lord.re.cert -days 3650 -nodes -sha256</samp>** et voilà.
Ça va aussi mouliner un peu mais ça devrait le faire.
On peut donc passer à la suite.

Bon ce coup-ci on passe à la conf de Nginx.
Oh Joie ! J'aime Nginx.
Son fichier de conf n'est qu'illumination et fun.
Bref.
On va tripoter un block server :
*/etc/nginx/nginx.conf*
```
server {
  listen 443;
  server_name lord.re;
  ssl on;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers AES256+EECDH:AES256+EDH:!aNULL;
  …
}
```
Bon là c'est l'intro on va dire.
En gros on ne garde que les ciphers les plus solides.
Et on vire SSLv1,2 et 3.
Ces vieilleries on fait leur temps et devraient être bloquées partout (et pas uniquement pour https).

On continue par du classique :
*suite du /etc/nginx/nginx.conf*
```
ssl_dhparam /etc/nginx/dh.pem;
ssl_certificate /etc/nginx/lord.re.cert;
ssl_certificate_key /etc/nginx/lord.re.key;
```
Bon ça vous l'avez déjà vu dans tous les autres tutos (sauf peut-être le DH).
Le DH vous permettra de vous la péter (en plus de pas mal renforcer l'échange de clé).

Là on rajoute du bonus :
*toujours la suite du /etc/nginx/nginx.conf*
```
ssl_session_cache shared:ssl_session_cache:10m;
ssl_session_timeout 8h;
ssl_buffer_size 1400;
add_header Strict-Transport-Security max-age=157680000;
```
Donc là on définit un buffer de 10Mo pour garder les sessions en cache, donc plusieurs connexions depuis un même client seront gardées en mémoire et réutilisées.
Donc on évite pas mal de handshake SSL.
Bon ça vaut pas du vrai pipelining HTTP mais bon.
On rajoute égalemement un entête http permettant de faire le HSTS.
En gros le HSTS consiste à dire au client https de ne venir qu'en https pendant au moins la durée indiquée.
Donc votre navigateur de lui-même réutilisera HTTPS lors des prochaines visites.
Et ça, c'est chouette !

Bon bha maintenant j'espère que la génération du DH, de la clé et du DH a terminée, parceque maintenant yapuka ! Bon donc maintenant **<samp>systemctl restart nginx</samp>**.
Haha Hahahaha.
Bon non je déconne.
**<samp>/etc/init.d/nginx restart</samp>**.
Mieux.
Voilà vous pouvez maintenant vous la racontez avec votre super note au ssllabs.
Vous n'aurez pas de A+ car pour cela il faut de l'OCSP stapling (téléchargement de la liste de révocation des certifs toussa toussa) mais comme on utilise du certificat auto-signé, on a pas de CA donc pas de moyen d'indiquer la révocation d'un certificat.

