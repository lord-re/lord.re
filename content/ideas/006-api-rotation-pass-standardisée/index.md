+++
Author = "Lord"
Description = "Pouvoir changer de mot de passe de façon normalisé sur tous les sites serait un sacré gain de sécurité."
Categories = ["web", "sécurité"]
menu = "main"
notoc = true
PublishDate = 2019-02-19T20:29:24+01:00
date = 2019-02-19T20:29:24+01:00
title = "Protocole de renouvellement de mot de passe"
editor = "kakoune"
+++
C'est quand même con qu'en 2019, il n'y ait toujours pas de protocole pour pouvoir faire un changement de mot de passe.
Je m'explique.

**Il est indispensable d'utiliser des mots de passes différents pour chaque service**.

Mais pour ça, ça veut dire qu'il faut un gestionnaire de mot de passe.
Perso j'utilise [Password-store]({{< ref "/posts/36-gestionnaire-passwords" >}}) depuis plus de six ans maintenant et c'est génial.
Plus besoin de se souvenir de rien, on peut même s'en servire pour mémoriser d'autres trucs que des pass (des url, des numéros de trucs…) et tout est chiffré/versionné.

Le seul truc manquant aux gestionnaires de mot de passe est : **Un moyen de changer les pass**.

En ce bas monde il manque un protocole standardisé et déployé pour changer de pass facilement (et pourquoi pas ajouter d'autres trucs en plus genre suppression du compte et autres trucs).
Le souci c'est que chaque site ouaib, chaque service a sa façon de faire avec des en plus des restrictions différentes pour les mots de passe.

On pourrait donc imaginer un nouveau protocole assez simple : 

  - Le port 7709 en TCP. (je sais pas, ce chiffre m'inspire).
  - Un enregistrement DNS SRV genre *_pass._tcp.lord.re. TTL IN SRV 0 5 7709 pass.lord.re.*
  - Ça serait forcément en TLS bien entendu.
  - Lorsque le client se connecte, il s'auth (pas spécialement défini comment).
  - Ensuite le serveur répond les actions possibles.
  - Le client envoie une requête de changement de passe.
  - Le serveur acquiesce en répondant les conditions nécessaires (caractères minimum, tels types de caractères et tout, dans un format prédéfini).
  - Le client envoie son nouveau passe.
  - Le serveur confirme que c'est pris en compte.
  - Le client se ré-auth.
  - Si c'est OK, le serveur valide et coupe proprement la connexion et c'est tout bon.

On peut potentiellement ajouter de l'auth à plusieurs facteurs dans le lot même si ça enlèverait pas mal d'intéret (il faut autant que possible que ce soit automatisable).

Imaginez la joie de pouvoir changer de mot de passe sur tous les sites de façon sécurisée et super simple !
Au moindre petit soupçon, bam renouvellement et d'ailleurs pourquoi pas renouveler chaque mois ?

Ça serait tellement pratique, c'est le seul truc qui manque aux gestionnaires de pass.

### En passant
Arrêtez avec les restrictions sur les mots de passe.
Si vous en avez c'est que vous gérez mal votre système.

J'espère que vous ne stockez pas les mots de passe directement mais un hash, donc stocker 1,2,5,1000 caractères ça vous revient au même.
Pareil pour les caractères spéciaux, hein.

## Pass-rotate
Il existe un projet sur Github qui est un mélange de ce que je viens de raconter et de Weboob (mais si vous savez ! Le logiciel pour utiliser des services web en console ! ).
Bref un logiciel pour changer de pass tout seul sur différents sites sauf que pas de bol c'est pas très populaire donc ça supporte peu de sites et malheureusement c'est pas super actif comme projet.
Bref c'est [Pass-rotate](https://github.com/ddevault/pass-rotate) si ça vous dit de jeter un œil.
