+++
Author = "Lord"
Description = "Avec le temps vous allez accumuler un peu trop de toots et ça peut être pas mal de les supprimer. Voyons comment faire avec l'outil Ephemetoot qui fonctionne pour Mastodon ou Pleroma."
Categories = ["fediverse", "pleroma"]
menu = "main"
notoc = true
WritingDate = 2021-01-29T17:57:22+01:00
date = 2021-01-29T17:57:22+01:00
title = "Supprimer ses vieux toots sur Mastodon ou Pleroma"
editor = "kakoune"
TopWords=["pleroma","mastodon","fediverse","toot","pouet","maintenance"]
+++
Je me traîne mon instance [Pleroma]({{< ref "/posts/136-pleroma" >}}) depuis plus de deux ans maintenant.
Donc mon compte dessus a grandit grandit grandit et contient donc un peu trop de toots à mon goût.
Plus un toot est vieux moins il a d'intéret (sauf cas exceptionnel) du coup autant le dégager, non ?

Si on est administrateur soi-même, on peut le faire à la bourrin en allant direct tripoter ça dans la base PostgresQL.
Si on est simple utilisateur (ou si on ne se sent pas d'aller mettre les mains dans le camboui) on peut utiliser le logiciel **Ephemetoo**.

C'est un ptit soft en python utilisant l'API de Mastodon (et donc compatible Pleroma) pour demander la suppression d'un toot.
Il se configure pour ne toucher que les toots ayant un âge.
Il vous permet également d'en faire une sauvegarde locale sous forme de fichiers json.

## Supprimer ses vieux posts
Pour virer ses vieilles publications il existe un ptit outil en python bien sympathique : **ephemetoot**.

### Installation
Vous l'installez via <kbd>pip install ephemetoot --user</kbd> et ensuite il va vous faloir le configurer.
Mais avant il vous faut un token d'autorisation en lecture/écriture.

### Création de token pour Pleroma
Pour générer ce token vous pouvez utiliser [cette petite page web](https://tools.splat.soy/pleroma-access-token/).
Vous entrez l'url de votre instance, votre pseudo et dans le scope vous choisissez <kbd>read write</kbd>.
Vous cliquez sur *publish access_token* ce qui vous redirigera vers votre instance pleroma.

Vous vous y connectez et cela devrait vous donner votre token (une suite de caractères).

### Création de token pour Mastodon
Rendez-vous dans les **paramètres** de votre compte mastodon.
Dans **Development** cliquez sur <kbd>New Application</kbd>.

Là, renseignez un nom ("ephemetoot" fera très bien l'affaire) et cochez les cases suivantes :
  - read:accounts
  - read:statuses
  - write:conversations
  - write:statuses

Et <kbd>Submit</kbd> vous ramènera à la page précédente.
Maintenant, cliquez dans la liste sur l'application que vous venez de créer ("ephemetoot" ?) et là vous trouverez votre **access token**. 

### Configuration
Vous pouvez désormais lancer la commande <kbd>ephemetoot --init</kbd>
Vous répondez honnêtement à chacune des questions ce qui vous créera un fichier de conf.

<pre>
lord@hermes ~ <strong>ephemetoot --init</strong>

Create your config.yaml file.

For help check out the docs at ephemetoot.hugh.run

Access token: <strong>w××××sVLx0eZjqGI××××××××××××××××××cYpZCO0</strong>
Username(without the '@' - e.g. alice):<strong>lord</strong>
Base URL(e.g. example.social):<strong>pleroma.lord.re</strong>
Days to keep(default 365):<strong>50</strong>
Keep pinned toots?(y or n):<strong>y</strong>
Toots to keep(optional list of IDs separated by commas):
Hashtags to keep(optional list without '#' e.g. mastodon, gardening, cats):
Visibility to keep(optional list e.g. 'direct'):<strong>direct</strong>
Archive path(optional filepath for archive):<strong>/tmp/archives</strong>
</pre>

### FEU !
Il ne vous reste plus qu'à la lancer et au bout de quelques secondes vous devriez le voir bosser en évitant certains toots, en en supprimant plein et en archivant tout ça là où vous l'avez spécifié.


<pre>
lord@hermes ~ <strong>ephemetoot</strong>

============= EPHEMETOOT v3.1.0 ================
Running at Fri 29 Jan 2021 17:14:12 +0000
================================================

Fetching account details for @lord@pleroma.lord.re
Checking 3502 toots
👀 skipping direct toot - A3gwkp94Z6eZy8E9dQ
👀 skipping direct toot - A3ZRLkczlaBM284IEq
👀 skipping direct toot - A3RAUHHzBf7MBIacuu
👀 skipping direct toot - A3QC5jXf0p3fJgNyBU
👀 skipping direct toot - A3QBVsFNAaYttDjTY8
👀 skipping direct toot - A3MrrOQ689K7nx2x7Y
👀 skipping direct toot - A3MroxsvodfMveNLbE
👀 skipping direct toot - A3K8inRWqEQSYKK4lk
👀 skipping direct toot - A3JllaUPA3emIi1v6m
👀 skipping direct toot - A3AtgeHuf5CXqPhgci
👀 skipping direct toot - A3AtLX5aEQYPR6rrAe
👀 skipping direct toot - A3AsbTvFfmtmIJ4nC4
👀 skipping direct toot - A2u4EaCK4ThmrKad5k
📌 skipping pinned toot - A2QuN2EOvnn7w15zo8
👀 skipping direct toot - A2Ih1FLGeURHYcuMpk
👀 skipping direct toot - A2Cq50eExXR3mYtN44
👀 skipping direct toot - A2CpxT8BB1J3ntIfku
👀 skipping direct toot - A2CptiywIk45o3C18y
👀 skipping direct toot - A2CppX6OWnXbnsgIfQ
👀 skipping direct toot - A2Cpf0VeqqkRp8Tksy
👀 skipping direct toot - A2CpaTT7kqkwBu8GQK
👀 skipping direct toot - A2CpMWMqBGlJ7vXX2O
👀 skipping direct toot - A2CpBX8QzDbGK2YuXI
👀 skipping direct toot - A29kZEM7NPENmgYyFU
👀 skipping direct toot - A23tn3jbOcbdXJSO92
❌ deleting toot A23qUx0jM9vZbl8sO8 tooted 10 Dec 2020
❌ deleting toot A23jR3vizPSkEL01rM tooted 10 Dec 2020
❌ deleting toot A23feNA8Oa2VpIpZdQ tooted 10 Dec 2020
❌ deleting toot A23e3QN7Os7F6yioca tooted 10 Dec 2020
❌ deleting toot A23VPVcreCoEBpXibI tooted 10 Dec 2020
…
Removed 834 toots for lord@pleroma.lord.re.

---------------------------------------
🥳 ==> 🧼 ==> 😇 User cleanup complete!
---------------------------------------
</pre>

Voilà ça peut prendre pas mal de temps.
Mais au moins vous pourez regarder des emojis dans votre terminal.

Il peut arriver que le serveur vous envoie chier si ça va trop vite mais il existe l'option **--pace** pour contrer ça.

## BONUS : Mumuse avec les archives
Vous allez donc vous retrouverez avec tous vos toots dans des fichiers json dans le dossier d'archive que vous avez défini (*/tmp/archives/* dans mon cas).

Pour mon blog j'utilise un ptit script qui me liste les mots les plus fréquents et j'ai voulu faire passer ça sur mes toots pour voir un peu ce que ça donne.
Du coup il faut adapter un peu pour extraire les données.

<kbd>cat *.json | jq -r '.pleroma .content' > /tmp/total</kbd>

Le fichier */tmp/total* contient tous les textes de vos pouets.
Voilà, faites-en ce que vous voulez ;-)

