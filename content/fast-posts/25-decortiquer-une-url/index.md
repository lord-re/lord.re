+++
Author = "Lord"
Description = "Apprenons à lire une URL."
Categories = ["web", "vulgarisation","réseau"]
menu = "main"
notoc = true
PublishDate = 2018-09-07T12:02:24+02:00
date = 2018-09-09T10:02:24+02:00
title = "Décortiquer une URL"
editor = "kakoune"
+++
Un débat sur le web est en train d'éclater.

*Chrome pour fêter ses dix ans a décidé de ne plus afficher une partie des URL.*
Ils suppriment le fameux <samp>www</samp> dans la barre d'adresse.

C'est pour cela que ça s'insurge et compagnie, comme quoi c'est pas bien (effectivement c'est pas bien) et que c'est la faute des utilisateurs lambda qui ne savent pas lire une URL.

Voici donc un mini-cours pour savoir décortiquer une URL like a boss !

## Déjà, c'est quoi une URL ?
Bon déjà *URL* ça veut *Uniform Resource Locator* donc en gros c'est un moyen uniforme de trouver une ressource.
Une adresse qui pointe vers un seul truc, quoi.

C'est typiquement l'adresse d'un document trouvable sur le web (mais en vrai pas uniquement le web, mais passons).
C'est ce que vous êtes censé écrire dans la barre d'adresse de votre navigateur web.

Quelques exemples :

  - https://lord.re/
  - http://maps.google.fr/
  - https://octodon.social/@lord/100678423930565248
  - https://gitweb.gentoo.org/repo/gentoo.git/diff/games-fps/quake3-cpma/quake3-cpma-1.48.ebuild?id=c5c0ebe77f1380487e6d61226e74ef054f285ce3

## Mais alors, c'est quoi un nom de domaine ?
Bonne question !
Le nom de domaine est un identifiant désignant un ensemble de machines.
Une entité va se prendre un nom de domaine pour donner un nom à plusieurs ordinateurs.
Dans mon cas, mon nom de domaine est *lord.re* et dedans j'ai *bender.lord.re* qui est l'ordi du salon, *zapp.lord.re* qui est un serveur que je loue …

D'ailleurs, une même machine peut-être dans plusieurs domaines.
Être dans un domaine n'est qu'une vue de l'esprit, chacun pourrait s'amuser à intégrer un ordinateur distant dans son domaine : je pourrai me faire *google.lord.re* et faisant pointer ça vers un des ordinateurs de Google (ou ailleurs, c'est la base du phishing).

Les domaines sont hiérarchiques, ça s'écrit du moins important vers le plus important : *bender* est inclue dans *.lord* qui est lui-même inclue dans *.re*  (calmez-vous les puristes, je sais pour le point final).

## Allez, on décortique !

### Exemple 1 :
On prend donc la meilleure des URL : https://lord.re/

<span style="background-color:green;color:white;">https://</span><span style="background-color:red;color:white;">lord.re</span><span style="background-color:purple;color:white;">/</span>

Et voilà un "beau" décorticage !

  - <span style="background-color:green;color:white;">le protocole parlé, généralement HTTP ou HTTPS, mais ça peut en être d'autres</span>
  - <span style="background-color:red;color:white;">le nom de l'ordinateur.</span>
  - <span style="background-color:purple;color:white;">le fichier demandé (oui oui ça pointe vers un fichier particulier, ici la racine).</span>

Bon, cet exemple est simpliste.
Il y a peu d'intéret de distinguer le premier niveau du nom de domaine, vu que le nom complet de la machine est la partie rouge et bleue.
Prenons en un plus complexe.

### Exemple 2 :

<span style="background-color:green;color:white;">https://</span><span style="background-color:red;color:white;">gitweb.gentoo.org</span><span style="background-color:purple;color:white;">/repo/gentoo.git/diff/games-fps/quake3-cpma/quake3-cpma-1.48.ebuild?id=c5c0ebe77f1380487e6d61226e74ef054f285ce3</span>

C'est similaire :

  - <span style="background-color:green;color:white;">On est encore en HTTPS</span>
  - <span style="background-color:red;color:white;">Ici on parle à la machine gitweb.gentoo.org, c'est le nom de l'ordinateur qui va afficher la page web.</span>
  - <span style="background-color:purple;color:white;">Le fichier demandé tout ce long machin. En vrai ce sont des dossiers : il y a repo dedans gentoo.git dedans diff…</span>

## Et la polémique ?
*Au balbutiement du web (vers 1990), l'Internet existait déjà.*
Les noms de domaines existaient déjà et du coup des machines avaient déjà des noms simples à la *example.org*.
Ils ont à l'époque rajouté un site ouaib pour example.org, pour cela ils ont installé un nouvel ordinateur sur lequel ils ont créé le site.
Cette nouvelle machine a souvent été nommé *www.example.org* .

*www.example.org* et *example.org* sont deux machines différentes.
Du coup il était courant que le web ne fonctionnait que sur *www.example.org* et non sur *example.org*.
À l'époque, c'était donc nécessaire de distinguer les machines.

Le web se répandant et gagnant en popularité, il est devenu l'usage premier d'un nom de domaine.
Mais par habitude, la coutume de nommer le serveur web en *www.truc.machin* est resté.
Et maintenant, la tendance est de rediriger le trafic web de *www.truc.machin* vers *truc.machin* qui sont maintenant une seule et même machine.
**Mais ce n'est pas forcément vrai à 100% !**

Il arrive régulièrement que *www.machin.truc* et *machin.truc* soient deux ordinateurs différents affichant des pages web complètement différentes.
Une preuve ? https://pool.ntp.org et https://www.pool.ntp.org vous mèneront sur deux machines différentes avec deux sites ouaib radicalement différents.

En cherchant bien on doit pouvoir en trouver des dizaines.

Vous comprenez donc que la nouvelle idée de Google de **supprimer l'affichage du <samp>www</samp> dans une URL est une hérésie**.
*C'est comme si vous donniez votre adresse postale en omettant le numéro de rue.*
