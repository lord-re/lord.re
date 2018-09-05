+++
Author = "Lord"
Description = "Mozilla commence à restreindre les fonctionnalité de Firefox aux pages chargées via HTTPS"
Categories = ["actu", "firefox", "sécu"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-01-17T13:00:08+01:00
date = 2018-01-17T13:00:08+01:00
title = "Mozilla annonce commencer à restreindre les nouvelles fonctionnalités aux pages chargées via HTTPS"
jdh = "https://www.journalduhacker.net/s/fr0wmw/mozilla_annonce_commencer_restreindre"
+++
Dans sa quête pour un web plus sûr, [Mozilla vient d'annoncer](https://blog.mozilla.org/security/2018/01/15/secure-contexts-everywhere/) qu'une bonne partie **des nouvelles fonctionnalités de Firefox ne seront utilisables qu'uniquement sur des pages web accédées via HTTPS**.

Autant je suis favorable à l'utilisation de HTTPS au maximum, autant ce n'est pas forcément possible de l'utiliser absolument partout. 

Il existe de nombreux cas où HTTPS n'est pas utilisable. Trois exemples qui me viennent, mais on doit pouvoir en trouver d'autres :

  - Si le serveur n'a pas accès à Internet, faire de l'HTTPS est compliqué voire impossible. (Sisi on peut faire du web sans être sur Internet)
  - Si la machine cliente n'a pas moyen d'être à la bonne date l'HTTPS n'est pas possible non plus. (de nombreux appareils n'ont pas d'horloge interne fonctionnant sans courant comme les raspberry)
  - Quand on se connecte à une machine plus très à jour avec une version pas si vieille que ça d'openssl mais tout de même trop vieille et donc incompatible…

C'est d'ailleurs pour cette raison que contrairement aux recommandations actuellement à la mode, je ne redirige pas le trafic HTTP vers son équivalent HTTPS. C'est un choix que je laisse au client. Au visiteur de choisir s'il veut bénéficier de plus de sécurité ou non.

Bref j'espère que Mozilla n'ira pas plus loin en retirant des fonctionnalités actuelles aux pages non sécurisées.


