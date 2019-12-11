+++
Author = "Lord"
Description = "SSH c'est la vie. On s'en sert souvent pour faire du backup afin d'accéder aux machines distantes. Cependant il y a quelques étapes à suivre afin de protéger l'accès SSH dans le cadre de connexions automatisés."
Categories = ["adminsys", "backup","ssh","cli","software"]
menu = "main"
notoc = true
WritingDate = 2019-12-11T17:17:56+01:00
date = 2019-12-11T20:17:56+01:00
title = "Restreindre des clés SSH pour du backup via rsync"
editor = "kakoune"
+++
Bon alors d'un point de vue sécurité utiliser SSH avec des clés c'est très bien.
Le problème c'est que si vous automatisez le backup (ce que vous devez absolument faire) c'est que votre clé privée ne peut pas avoir de passphrase (ça ne peut pas s'automatiser et être sécure ça).

Du coup ce qui est recommandé c'est de créer une paire de clé dédiées au backup sans passphrase.
Et d'ailleurs par la même occasion, utilisez des clés de type *ed25519* c'est plus moderne toussa toussa.

Donc dans un premier temps on génère les clés, puis sur les machines clients on va appliquer des restrictions.

## 1. Génération de clé SSH

<samp>ssh-keygen -t ed25519</samp>

Voilà c'est fait.
Vous pouvez vous regardez les clés (non ce n'est pas sale) avec <samp>cat ~/.ssh/id_ed25519 ~/.ssh/id_ed25519.pub</samp>

Elles sont belles, hein ?

## 2. Partage de la clé publique

Bon vous avez vos belles clés.
Maintenant vous allez coller la publique sur chacun des machines que vous backuppez : <samp>ssh-copy-id <abbr title="à adapter">user</abbr>@<abbr title="à adapter également">machine-client</abbr></samp>

## 3. Restriction des clés

Bon c'est chouette mais c'est pas super sécure : *votre clé sans passphrase peut se connecter aux différentes machines clientes et potentiellement être root et faire tout !*
C'est craignos.

Maintenant on va s'affairer à restreindre ce que peut faire notre clé.
Donc sur les machines clientes la première chose à faire est d'*éditer le ~/.ssh/authorized_keys*

Ce fichier contient une ligne par clé autorisée à se connecter en tant que votre utilisateur.
Trouvez la ligne concernant votre clé.

Ensuite les options doivent se mettre en début de ligne en les séparant d'une virgule (voir exemple en toute fin d'article).

### 3.1 Restreindre les facultés
Ensuite en début de ligne ajoutez des options de config SSH qui s'appliqueront donc lorsque cette clé se connecte.
Les options intéressantes sont les suivantes (non-exhaustif) : <samp>no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding</samp>.

Bon rien que ça c'est pas mal, ça évite quelques emmerdes mais ça n'évite pas tout.

### 3.2 Restreindre les commandes
Vous pouvez spécifier quelles commandes peut lancer une clé.
C'est chouette et permet de sacrément améliorer la sécurité.

Ça se fait avec un simple <samp>command="/votre/commande"</samp> .

### 3.3 RRsync
Il existe un ptit programme en perl adapté pour cet usage afin de restreindre les capacités de rsync nommé sobrement **rrsync**.
Alors certe, c'est une dépendance en plus, à installer sur chacune des machines clientes mais malheureusement c'est comme ça.

**rrsync** permet de limiter rsync à un mode *read-only* empêchant de modifier les fichiers sur la machine cliente.
Il y a également un mode *write-only* qui permet de ne pas lire les fichiers mais d'écrire uniquement (pratique dans l'autre sens mais plus exotique).

Il permet également de *restreindre les dossiers que rsync pourra atteindre*.
Avec une telle option, les connexions ssh avec cette clé seront cloisonnées au seul dossier que vous permettez.

Pour l'utiliser, éditez encore *~/.ssh/authorized_keys* et dans les options de votre clé, ajoutez <samp>command="/usr/bin/rrsync -ro /"</samp> et hop.

### 3.4 Restreindre les connexions depuis une adresse particulière
Bon c'est pas mal du tout déjà avec ça, mais bon imaginons que votre clé se retrouve dans la nature sans que vous le sachiez, un attaquant sera à même de backupper vos machines et donc d'y récupérer vos précieuses données.

Il est donc très appréciable de ne permettre l'utilisation de la clé à une/des adresse(s) précise(s).

Il suffit de rajouter <samp>from="a.b.c.d"</samp> et vous êtes tranquile.

## Exemple final 

Au final votre <details open><summary>*~/.ssh/authorized_keys*</summary>
{{< highlight "config" >}}
ssh-ed25519 AAAAC3N…………………n/euLPb lord@hermes
from="a.b.c.d",command="/usr/bin/rrsync -ro /",no-agent-forwarding,no-port-forwarding,no-pty,no-user-rc,no-X11-forwarding ssh-ed25519 AAAAC…………………………cJRwBwrc backup@backup_server
{{< / highlight >}}
</details>

Voilà avec ça, votre clé ne peut plus rien faire d'autre que du rsync en lecture seule.
Plus de commande, plus de tunnel, plus rien.

