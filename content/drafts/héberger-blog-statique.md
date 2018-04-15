+++
Author = "Lord"
Description = ""
Categories = ["", ""]
menu = "main"
notoc = true
PublishDate = 2018-03-10T22:53:49+01:00
date = 2018-03-10T22:53:49+01:00
title = "Héberger Blog Statique"
editor = "kakoune"
+++
Dans [l'épisode précédent]({{< ref "posts/82-hugo-tutorial" >}}), on a créé un blog mais maintenant il reste des étapes avant d'avoir vos premiers visiteurs.

## Le nom de domaine
Élément capital de votre blog !

### Se prendre un nom de domaine
Avoir un nom de domaine à soit est à mon sens essentiel pour maîtriser un minimum son identité numérique.
Ça ne coûte pas bien cher.
On peut s'en tirer dans les environs de 10€ par an.
Bref s'en priver serait dommage surtout que c'est techniquement très simple désormais.

La plupart des registrars (loueurs de nom de domaine) vous proposeront d'héberger eux même le serveur DNS sans avoir à dépenser quoi que ce soit.
Vous perdez un peu en autonomie mais au moins vous pouvez pas faire de connerie et aurez quelque chose de fonctionnel et sans maintenance en 5minutes.

Il existe de très nombreux registrars.
En France, puis au au-delà, vous trouverez (sans ordre particulier) [OVH](https://www.ovh.com/fr/domaines/), [Gandi](https://www.gandi.net/), [Online](https://www.online.net/en/domain), [Namecheap](https://www.online.net/en/domain), …
Bref il y a de quoi faire.

Mais méfiez-vous, le choix du registrar [peut s'avérer fatal]({{< ref "fast-posts/10-la-terrible-dependance-envers-registrar" >}}).

### Squatter un nom de domaine
À défaut d'investir dans votre propre nom de domaine, vous pouvez squatter un *sous-domaine*.

Il existe pas mal de gentils fournisseurs de sous-domaine gratuits qui seront plus ou moins flexibles.
Vous trouverez par exemple [netlib.re](http://netlib.re/), [eu.org](https://nic.eu.org/register.html).

Mais également de nombreux hébergeurs pourront vous héberger et fournir un sous-domaine comme par exemple [github.io](https://pages.github.com/).

Bref il y a pas mal de choix allant du gratuit bienveillant au gratuit moins bien veillant et aussi du payant.

## Héberger le site
Héberger un site statique est l'hébergement le plus simple qui soit.

Pas besoin de mettre en place d'intepréteur php encore moins de base de données.
Un simple serveur web sans configuration particulière fera l'affaire.

Pas besoin d'une machine surpuissante pour pouvoir tenir la charge.
Pas de mises à jour intempestives, votre site n'est qu'une pile de fichiers textes sans risque d'injection/exploitation distante/CSRF… bref c'est peinard et ultra performant.

### Auto-héberger
Ça c'est le mieux pour votre indépendance.
Vous fouttez votre site à la maison, sur un serveur, un vieux laptop abandonné, un raspberry, un nas.
Vous installez un serveur web, vous placez vos fichiers dans le bon dossier, vous faites pointer le nom de domaine vers votre IP, un peu de NAT sur votre routeur (redirection du port 80 et 443 vers votre serveur) et c'est parti.

Si votre blog ne contient que du texte vous pourrez l'héberger même sur une connexion adsl moisie sans soucis.
Par contre dès que vous mettrez des images/sons/vidéos ça peut devenir génant surtout si vous commencez à avoir pas mal de visiteurs.
Mais ne nous voilons pas la face, pour un blog perso, ça n'arrive que rarement, vos visiteurs seront prêt à patienter quelques secondes s'ils ont fait l'effort de trouver votre blog.

Dans le pire des cas il est aisé de migrer vers un hébergement plus musclé par la suite.
C'est donc une solution sympatique au moins pour débuter (ça fait plus environ 12 ans que je débute).

### Héberger son site sur une plateforme prête à l'emploi
Vous allez dépendre du bon vouloir de votre hébergeur mais au moins vous aurez très probablement de meilleures performances réseaux que sur une connexion ADSL.
Qui plus est, vous n'aurez plus de configuration à faire sur le serveur web et aurez quelqu'un vers qui vous tourner en cas de panne.

Encore une fois on trouve des hébergeurs gentils bien veillant comme les [chatons](https://chatons.org/) ou bien des hébergeurs commerciaux plus ou moins cher.
Héberger un site statique ne devrait pas vous coûter plus de 5€/mois.

Chaque hébergeur a un fonctionnement un peu différent pour l'envoi des fichiers mais ils proposeront pour la plupart une doc simple d'accès pour vous guider.
Ça pourra être de l'envoi en ftp ou bien une interface web.

### Louer un serveur
Cette solution peut paraître overkill mais ça peut être une bonne occasion de s'y mettre :-)

Encore une fois pleins de choix possibles.
De la simple machine virtuelle à 2€/mois au serveur dédié à plusieurs centaines d'euro mensuelles…

Si le but est juste d'héberger votre blog, encore une fois, le plus petit des VPS (machine virtuelle) devrait faire l'affaire.

Installation d'un serveur web (caddy, nginx, apache,…), posage des fichiers au bon endroit configuration du serveur web (indiquer le nom du site et l'emplacement des fichiers au minimum) et voilà
Si c'est votre première fois, en deux/trois heures c'est jouable.
Il y a de très nombreux tuto sur le web pour faire ça.
Pour un utilisateur plus technique ça ne vous prendra qu'une petite demi heure.

La maintenance est très légère.
Une fois configuré une première fois vous n'aurez probablement rien de plus à faire.

## Verdict
On peut héberger un site statique en quelques minutes et gratuitement en passant par de multiples prestataires ou bien on peut investir un peu pour rester indépendant et/ou avoir un hébergement plus performant.
Ça reste globalement simple et à la portée de n'importequelle personne prête à investir un peu de temps dedans.

Si jamais vous vous lancez dans l'aventure n'hésitez pas à me communiquer l'adresse de votre joli blog (même s'il est pas si joli, c'est pas grave). Je me ferai une joie d'être votre premier visiteur :-)
