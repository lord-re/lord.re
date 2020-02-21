+++
Author = "Lord"
Description = "Connaissez-vous Sandstorm ? C'est une plateforme de cloud auto-hébergeable axée sur la sécurité. À l'instar de Yunohost vous pourrez monter différents services web en deux temps trois mouvements."
Categories = ["cloud", "autohebergement","web"]
menu = "main"
notoc = true
PublishDate = 2019-04-30T12:25:41+02:00
date = 2019-04-30T12:25:41+02:00
title = "Sandstorm : plateforme web-cloud libre auto-hébergeable"
editor = "kakoune"
TopWords = [  "etherpad", "pad", "grains", "sandstorm","cloud","autohebergement","web"]
+++
[Sandstorm](https://sandstorm.io) est un logiciel super.
Et en plus d'être super il est très sécurisé.
En plus de cela c'est facile à installer.
Malheureusement c'est pas connu et du coup ça meurt à petit feu du manque de communauté.

Sandstorm est une plateforme de cloud pour héberger tout un tas de services différents un peu à la manière de **Yunohost**, **Cozy**, **Cloudron** et d'autres.
Mais son fonctionnement est très différent.
Tout son dev a été orienté par une approche assez radicale de la sécurité que l'on ne retrouve pas vraiment ailleurs.

## Une architecture alien
Le cahier des charges lors de la création de Sandstorm se base sur l'isolation mais poussé à son paroxysme.
Et du coup on isole pas les services entre eux mais de carrément *isoler les grains*.
Les grains sont les objets : par exemple un pad, un partage de fichier, un kanban…

Je m'explique : Si par exemple vous avez besoin d'un pad (c'est ce que j'appelle un objet) pour noter des trucs, Sandstorm va vous démarrer un etherpad.
Bon jusque là, ça va.
Si par la suite vous avez besoin d'un autre pad (un autre objet), Sandstorm va vous démarrer un autre etherpad.

Et c'est là l'un des intérets majeur de la chose.
Au lieu d'avoir tous vos pads sur le même service, chaque pad sera une instance indépendante des autres.
Alors certe, quand vous en ouvrirez un, ça sera un peu plus long (on parle de dix secondes tout au plus).

{{< img src="sandstorm.thumb.png" alt="Capture d'écran d'un etherpad dans l'interface de Sandstorm" link="sandstorm.png" title="Voilà sur quoi on tombe lorsqu'on l'utilise" >}}


Si jamais votre pad se fait trouer, les autres pads ne le seront pas.
Le vice est poussé jusque dans les détails en faisant en sorte que chacun de vos grains ait une adresse unique impossible à deviner (mais moche).
Du coup, si vous partagez un fichier dans Jirafeau, les gens ne pourront pas tenter de deviner l'adresse d'autres fichiers…

Cela a donc énormément d'avantages en termes de sécurité mais du coup également quelques inconvénients : ça bouffe un peu plus de place sur le disque, ça bouffe un peu plus de ram (et encore), les applications doivent être adaptées (c'est le gros point noir).
Le système est tout de même suffisamment malin pour éteindre les services inutilisés au bout d'un certain temps.

Toujours concernant la sécurité, ils ont fait le choix de *ne pas utiliser de mot de passe pour l'authentification des utilisateurs*.
C'est un détail tout con mais c'est excellent je trouve.
Tout fonctionne par token : vous entrez votre adresse mail et vous recevrez un lien et/ou une suite de caractères à rentrer et voilà.
Rien à retenir, pas de compromission du mot de passe.
Bon par contre l'accès au mail devient crucial.

## Bon et du coup on peut y faire quoi dans ce Sandstorm ?
Il y a un bon ptit nombre d'applis.
C'est moins fourni que les autres car la communauté est plus restreinte, mais on trouve quand même de quoi s'occuper.

Dans mes favoris on retrouve **Etherpad**, **Wekan**, **Gogs**, **Tiny Tiny RSS** et **Telescope** mais il y en a pas mal d'autres.

Vous pouvez aller voir leur [App Market](https://apps.sandstorm.io) (c'est gratuit, hein).

Une fois une application installée, vous pouvez créez de multiples grains de ces applis.
Vous pouvez stocker un ensemble d'grains dans une *collection* pour pouvoir tous les retrouver facilement ou bien les partager d'un coup d'un seul.

Chacun de vos grain peut-être archivé par les utilisateurs (ça génère un fichier zip que l'on peut restaurer sur une autre instance par exemple) à tout moment.
Vos utilisateurs peuvent partager les grains en lecture seule ou bien avec des droits supplémentaires, c'est tout bien geré et à tout moment vous pour voir qui peut accéder à ce grain et vous pouvez en un clic révoquer un accès.

## Et où qu'on trouve ça ?
L'instance principale est [Oasis](https://oasis.sandstorm.io) et est devenue payante (elle était gratuite jusqu'à il y a six mois mais il faut désormais parvenir à payer l'infrastructure).

Mais surtout **vous pouvez héberger une instance** assez simplement.
Ils fournissent un script d'installation qui marche sur à peu près tous les Linux (même Alpine).
Par contre regardez ce que fait le script avant de l'installer, hein ! (on fait pas le sagouin qui curl |bash sinon je vais me fâcher !)

## Et c'est solide ?
Hmm je l'utilise depuis quelques années maintenant pour les ptits trucs dont j'ai un besoin ponctuel.
Quand j'ai pas envie de me faire chier à installer quelque chose, si c'est présent dans le market je l'installe, ça prend moins de trente seconde et j'ai pas à me faire chier à me demander si c'est sécure ou pas, quel mot de passe utiliser.
Je n'ai jamais eu de soucis (sauf l'appli telescope qui en fait vire les trucs trop ancien toute seule… mais c'est propre à cette appli et non Sandstorm).

Le seul point inquiétant c'est que la startup qui montait le truc s'est pété la gueule : ils n'ont pas réussi à établir un business-model suffisant.
Désormais certains ex-membres de l'équipe (dont le créateur de *Protobuf*) continuent de bosser dessus sur leur temps libre et du coup ça vie bien moins vite qu'auparavant sans pour autant être mort.

Bref, Sandstorm c'est une bonne plateforme de cloud qui peut très bien faire l'affaire pour une asso ou une ptite entreprise, une classe, un établissement scolaire (ça bouffe du LDAP et SAML).

L'installation est simple, la maintenance quasi nulle, et chacun peut backupper ses grains et cerise sur le gateau c'est tout sécure.
Bon je ne vous cache pas que je ne me fais pas trop d'illusion quant à la santé du projet suite à l'arrêt de la startup mais on sait jamais.
Un regain d'intéret et hop ça peut repartir…
Ha et je ne l'ai pas précisé mais, tout ça c'est du [libre](https://github.com/sandstorm-io/sandstorm), hein.


