+++
Author = "Lord"
Description = "Bon, je vous épargne le topo sur l'importance des backup. Voilà ce que j'ai mis en place à la maison pour sauvegarder mes données précieuses avec rsnpashot."
Categories = ["backup", "alpine","rsync"]
menu = "main"
notoc = true
WritingDate = 2020-03-14T22:45:02+01:00
date = 2020-03-14T22:45:02+01:00
title = "Mon ptit backup avec Rsnapshot"
editor = "kakoune"
TopWords = [  "n2", "rsnapshot", "script", "hc2", "ssh", "rsync", "backup"]
+++
J'ai raté le coche mais voilà : il est important d'avoir un backup de ses données.
D'autant plus pour les données que vous ne pourrez par retrouver ailleurs.

D'ailleurs **le RAID, ce n'est pas un backup**.
Voilà ça c'est dit.
Et aussi **testez la restauration de vos données régulièrement** histoire d'être sûr de vous.
Ça aussi c'est dit.

Dans mon cas j'ai *différents types de données* à backupper à la maison.

  - A) les données précieuses introuvables ailleurs : les photos et les papiers.
J'ai pas envie que ça se balade en clair partout et je ne peux absolument pas les retrouver ailleurs.
  - B)  les données chiantes mais pas non plus capitales : ce sont des données uniques qui servent pour le fonctionnement.
C'est par exemple des fichiers de configuration, les base de données de différents services, les mails, mon blog.
  - C) les données que j'aime bien ne pas perdre mais qui … bha … au pire ça se retrouve ailleurs.
C'est typiquement les partitions systèmes.
Si je le perds faut réinstaller et tout, ça bouffe du temps mais bon…
  - D) les données que j'aime bien mais qui sont rechoppable au pire.
Ce sont les fichiers… multimédias \*wink wink\*.

Les volumétries sont variées.
Le D c'est immense, donc on oublie de backup.

Pour le A, c'est non négociable, je dois le sauver coûte que coûte.
Le B c'est au final assez petit, je peux très facilement le stocker et le C… je vais pas tout backuper (pas mon ordi par exemple) mais les SBC ouaip.

Pour le A, je peux cependant recompresser les données (ce que j'ai déjà détaillé il y a un bail, ce qui m'a permis de réduire énormément le volume nécessaire).
Pour le B et le C c'est principalement du texte, donc si c'est stocké sur un système de fichier malin (qui compresse) ça va le faire.

## Où je sauvegarde
C'est assez peu courant mais j'ai choisi de mettre ça dans mon routeur sur un SSD en msata.
Ça tourne dans un conteneur Alpine avec rien d'autre que cron, rsync, rsnapshot et ssh d'installé.

Ça bouffe 25Mo de ram quand ça bosse pas donc c'est parfait.

J'ai un second backup sur une odroid hc2 dans mon appart.

J'ai un troisième backup sur une odroid hc2 chez ma mère.

J'ai un dernier backup chez C14 que ne met à jour que très rarement à partir d'un backup du routeur, que je rapatrie au préalable sur mon ordi, je vérifie quelques fichiers, je chiffre puis j'upload.

Je pense être à peu près safe.

## Rsnapshot : le papy autonome
Ça fait maintenant près de dix ans que je l'utilise.
Il n'est pas moderne.
Il n'a pas toutes les fonctionnalités de Borg.

Cela-dit, il n'est en vrai qu'un bout de perl pour servir d'interface (pas graphique) à rsync.
Il n'offre pas de crypto, donc pas de chiffrement.
D'ailleurs exit la déduplication également (enfin pas totalement non plus).

Il marche aussi bien en local (peu d'intéret) qu'en mode serveur.
C'est d'ailleurs ce point que j'adore : il n'a besoin que de *ssh* et *rsync* sur les clients.
Bref, que deux ptits outils disponibles partout.

Le gros de la conf consiste à choisir la rétention des backup, la définition des différents backup.
Il ne reste plus qu'à s'appuyer sur cron pour déclencher le truc.

## Conf basique
Une fois que vous l'aurez installé, vous aurez un fichier de conf par défaut.
Si votre distro est pas trop pourri, il devrait être pas mal commenté.
Ça fait office de doc.

Le truc à savoir c'est qu'il a une syntaxe tatillonne : **Il faut utiliser des tabs pour séparer les arguments !**
Une fois ce détail maîtrisé ça devrait le faire.

Je vous laisse vous balader dans le fichier de conf.

…

Les options que j'aime bien :

  - <samp>snapshot_root</samp> : l'endroit qui servira de racine à tous les backup
  - <samp>no_create_root</samp>: si jamais l'option du dessus se trouve être sur un support amovible cette option vous évitera une catastrophe si jamais vous avez oublié d'installer le média nécessaire.
  - <samp>cmd_preexec</samp> et <samp>cmd_postexec</samp> : ça permet de lancer des scripts en début et fin de backup. Je m'en sers pour les notifs vers irc.
  - <samp>retain</samp> : c'est là que vous indiquerez la rétention de vos différents backup
  - <samp>one_fs</samp> : histoire de pas dérouler l'arbre des montages.

## Définition d'un backup
Alors déjà vous allez devoir définir les intervales.
Bon c'est un peu … comment dire … particulier.

C'est pas vraiment un intervale de temps.
C'est plus un nom générique mais c'est vrai que souvent on retrouve les noms usuels du genre "daily"/"weekly"/"monthly".
Mais si vous ne déclenchez le backup "monthly" que tous les six mois… bha ça sera un backup bi-annuel et puis c'est tout.
Du coup chez alpine (et j'ai gardé cette convention) ils les ont nommés "alpha", "beta", "gamma", "delta".

Perso j'utilise que le "alpha" et "beta", je n'ai pas besoin de plus.

Quand vous allez définir un backup, il faut déjà s'assurer d'être capable de pouvoir se connecter sans mot de passe à la machine désirée.
Du coup ça veut dire utiliser des clés sans passphrase, d'ailleurs [je vous avais déjà parlé de la sécurisation de clé SSH pour cela]({{< ref "posts/187-ssh-key-restricted-rsync-backup" >}}).

### rsync ssh
Le backup classique qui consiste donc à copier les fichiers est au final assez simple.

<samp>backup  root@hc2:/      hc2/</samp>

Pensez bien à utiliser des tabulations !

Donc là on indique de se connecter en tant que *root* sur la machine nommée *hc2* (on peut mettre une ip, ou un nom complet) pour récupérer ce qui se trouve dans */* et on stockera ça dans le dossier *hc2/* (ouai je suis pas super inventif pour les noms).
Bref là c'est un backup complet.

--------- 

Un autre exemple : 

<samp>backup  root@n2:/       n2/     exclude=/var/lib/postgresql</samp>

Là on se connecte en tant que *root* à la machine *n2* pour récupérer ce qui est dans */* pour ranger ça dans *n2/* mais ce coup-ci on zappe volontairement le dossier */var/lib/postgresql* .

---------

Un troisième et dernier exemple !
<samp>backup  root@10.0.0.251:/storage        c2/     +rsync_long_args=--rsync-path=/storage/.kodi/addons/virtual.network-tools/bin/rsync</samp>

Là on se connecte en tant que *root* sur la machine *10.0.0.251* pour sauvegarder ce qu'il se trouve dans */storage*, on stocke ça dans *c2/* et on rajoute la ptite option qui va bien (là c'est une option pour indiquer où se trouve rsync sur la machine distante car il ne se trouve pas dans le path).

### Backup via script
Certaines données ne peuvent pas être simplement fait via rsync mais via un script.
Ça peut être à peu près n'importe quoi comme script.

C'est souvent le cas pour les bases de données par exemple.

Dans mon cas j'ai un postgresql qui me sert entre autre pour mon instance *ttrss* et mon ptit *pleroma* et deux trois autres ptits trucs.

Là je passe par : 

<samp>backup_script   /usr/bin/ssh root@n2 "/usr/bin/pg_dumpall -Upostgres" > pg_dump.sql     n2_postgres/</samp>

Vous comprenez vite qu'en vrai ce n'est pas un script mais juste une commande balancée à l'arrache :-)
Ici le script se connecte en ssh pour lancer une commande de backup postgres.
Le résultat n'est pas stocké sur la machine distante mais dans un dossier créé à l'occasion par rsnapshot qui ensuite balancera ça dans *n2_postgres/* .

Mon but était d'épargné autant que possible le stockage de la machine distante (c'est une eMMC, c'est plus solide qu'une carte SD mais tout de même loin d'un disque classique ou ssd).

## Tester / Lancer / Croner
Vous voulez voir si vous n'avez pas fait de connerie ?
Rhaaa ayez un peu plus confiance en vous !

<samp>rsnapshot -t alpha</samp>

Là vous verrez toutes les commandes qui seront lancées.
Vous pouvez même vous les noter et les lancer au cas par cas pour tester/débugguer.

Bon tout vous semble correct vous voulez déclencher un backup ?

<samp>rsnapshot alpha</samp>

Voilà ça va se dérouler devant vos yeux.

Bon bha maintenant il ne vous reste plus qu'à mettre cette commande dans votre cron pour que ça se déclenche à votre convenance.

Je lance ça une fois par semaine dans mon cas.

## Où qu'elles sont les données ?!
Dans votre fichier de conf, vous avez défini la racine des backup, rendez-vous là-bas.

Vous aurez donc un dossier *alpha.0*, au prochain lancement il sera renommé *alpha.1* et le nouveau backup sera lui *alpha.0* .
Quand vous aurez atteint votre nombre de backup, le plus ancien sera effacé.

Gardez à l'esprit que les fichiers ne sont pas réellement dupliqués entre les différents alpha.\* .
Les fichiers qui ne bougent pas d'un backup à l'autre ne sont en fait que des liens ce qui vous épargnera beaucoup de stockage.
Vous pourrez donc en garder un bon paquet sans que ça n'ait un gros impact.

Par contre avec le calcul de l'espace peut parfois être un peu étrange et du coup supprimer un backup peut en vrai ne pas libérer autant de place que ce qu'il semble prendre.

L'intérieur de ces dossiers est directement consultable, vous pouvez donc aller simplement consulter un fichier, voir ne restaurer qu'un dossier par exemple.
Et tout ça juste avec vos commandes classiques de votre shell, <samp>cp</samp>, <samp>mv</samp> et pourquoi pas un <samp>rsync</samp>.
