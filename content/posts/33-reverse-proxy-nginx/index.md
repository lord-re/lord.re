+++
Author = "Lord"
Categories = ["software","tips","www","nginx"]
date = "2013-10-27T23:21:23+02:00"
title = "IP Proxy Logs Nginx Reverse"
Description = "Comment afficher l'adresse du client dans les logs lorsque son ptit nginx est derrière un reverse proxy ? Vous le découvrirez vite"
menu = "main"

+++
Le titre ne pourrait être plus explicite ! Vous avez remarqué comme lorsqu'on fait du reverse proxy, le backend ne voit plus que l'ip du frontend ?
C'est tout à fait logique puisque les requêtes proviennent exclusivement du serveur frontal qui fait son boulot.
Du coup ça peut être quelque peu dérangeant

## Dura lex sed lex
Vous n'êtes pas sans savoir qu'en France tous les fournisseurs de contenu sur le web doivent conserver les logs de connexion.
La loi n'est pas vraiment précise quant aux informations à conserver mais globalement, l'heure, l'IP et la ressource demandée est le minimum.
Et ça tombe plutôt bien c'est ce que font tous les serveurs web basiquement.
Donc pour éviter de se mettre en porte-à-faux vis-à-vis de la loi, il va falloir améliorer notre jolie config Nginx (ce sera surement un futur article).
Donc on va devoir dire à notre reverse proxy de rajouter un header dans sa requête indiquant la vraie IP de la requête.
```
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
```

À rajouter dans le *bloc server ou location* de votre reverse proxy
Ensuite maintenant que notre serveur de backend reçoit une requête avec le header qui va bien, il faut lui dire de s'en servir !
```
set real_ip_from A.B.C.D;
real_ip_header X-Forwarded-For;
real_ip_recursive on;
```
À rajouter dans le *bloc server* de votre vrai serveur web
Ça y est, un ptit reload et vos logs contiendront la vraie IP.
C'est également pratique dans le cas d'utilisation de PHP pour que lui aussi connaisse la vraie IP du client (logguer les éditions sur un Dokuwiki par exemple).

