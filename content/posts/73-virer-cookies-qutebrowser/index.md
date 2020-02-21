+++
Author = "Lord"
Description = "Petite technique pour virer les cookies d'un site dans QuteBrowser"
Categories = ["web", "software", "tips", "qutebrowser", "cookies"]
Tags = ["web", "software", "tips", "qutebrowser", "cookies"]
menu = "main"
draft = false
notoc = true
PublishDate = 2018-02-13T17:12:32+01:00
date = 2018-02-13T17:12:32+01:00
title = "Virer les cookies d'un site précis dans Qutebrowser"
TopWords = [  "rss", "table", "webengine", "champs", "from", "tiny", "cookie", "qutebrowser", "cookies"]
+++
Je vous ai déjà chanté [les louanges de mon cher Qutebrowser]({{< ref "/posts/64-qutebrowser" >}}) mais ce coup-ci on va passer sous le capot.

Alors que je démarre la bête et qu'il restaure la session habituelle (mail, musique, rss et affaires courantes) : SURPRISE !
Mon instance Tiny Tiny RSS m'affiche un message bien moche.
En gros soit un header est foireux (j'en doute) soit le cookie envoyé par le navigateur est trop gros et du coup fout la merde.
La seconde option est la plus plausible.

Du coup il faut tripotter les cookies de Qutebrowser.
Pour l'instant il n'y a pas de moyen officiel de se servir dans la boîte à cookies et d'y piocher allègrement ceux qu'on veux.
Donc allons voir un peu les entrailles de la bête pour bouffer ce délicieux cookie.

Personnellement j'utilise le moteur ***QtWebengine*** du coup les cookies sont planqués dans une base sqlite dans : *~/.local/share/qutebrowser/webengine/cookies*.

On ne peut donc pas ouvrir le fichier avec un éditeur de texte et éditer à l'arrache.
Dépoussiérons les vieilles notions apprises lors des cours de Base de Données.

Bon commençons par le début :

    sqlite3 ~/.local/share/qutebrowser/webengine/cookie

Là on ouvre la base de données et on se retrouve dans un shell avec des commandes propre à sqlite.

Tiens ! **.help** apparemment peut nous aider !

Chouette il n'y a pas trop de commandes et c'est plutôt bien expliqué.

Bon à vue de nez on doit pouvoir trouver des infos intéressantes via **.tables**

Ouai c'est pas mal.
On a donc la *table cookies* et la *table meta*.
Un ptit coup de **select * from meta;** nous apprend qu'on s'en fout complètement de cette partie et qu'on trouvera ce qu'on est venu trifouiller dans l'autre table.

**select * from cookies;** et là on voit notre longue liste de cookies !
On va se régaler avec tout ça.

On repére que les lignes contiennent d'abord un nombre.
Serait-ce un index ?
Puis le nom du site visiblement.
Puis d'autres champs pas spécialement compréhensibles.

Comment trouver à quoi correspondent les différents champs ?

On fouille on fouille.

Hmmm

**.schema**

Haa là c'est plus clair.
Le premier champs est donc la *creation_utc* (donc c'est pas un index), le second *host_key* et ensuite des champs propre au cookie lui même (comme *secure*, *httponly*, last_access_utc*, has_expires*,…).

Bon bha pour Tiny Tiny RSS je peux dégager intégralement le cookie.

On peut donc lancer un joli :

    delete from cookies where host_key = "le_domaine_a_jarter";

Et hop, on relance Qutebrowser pour tester.

C'est bon ça marche \o/

## TL;DR

    sqlite3 .local/share/qutebrowser/webengine/cookies
    delete from cookies where host_key = "your_domain";
