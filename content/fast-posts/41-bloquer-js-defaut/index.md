+++
Author = "Lord"
Description = "La découverte récente de nouvelles techniques pour traquer les lecteurs de sites ouaib pousse la toile à réagir pour se défendre. Quelles sont les solutions actuellement disponibles pour se protéger de cette nouvelle forme de pistage ?"
Categories = ["web", "sécu"]
menu = "main"
notoc = true
WritingDate = 2019-11-15T15:59:57+01:00
date = 2019-11-15T15:59:57+01:00
title = "Les trackers 1st-party : quelles solutions ?"
editor = "kakoune"
+++
Bon bha voilà qu'on est en train de se rendre compte que *non le RGPD ne nous protège pas tant que ça des violeurs de vie privée*.
Ptet même qu'au contraire ça a d'autant plus poussé les marketeux à dévelloper de nouvelles armes plus pernicieuses.

Je veux parler de ce que [Shaft](https://www.shaftinc.fr/escalade-traque-eulerian.html) et [Aeris](https://blog.imirhil.fr/2019/11/13/first-party-tracker.html) ont déniché.
En gros, contrairement à avant où les trackers/pubs (c'est pareil) étaient hébergés par les prestataires, ces prestataires fournissent désormais *un système faisant croire que leurs merdes sont hébergées directement sur le site que vous consultez*.

## 1st-party ?
First-party est un terme pour désigner que c'est du contenu issu du domaine que vous visitez.
Une page web c'est avant tout un fichier texte contenant des liens mais aussi incluant divers documents (des images, des vidéos, des morceaux de pages web, des scripts).

La magie du web fait que l'on peut aussi bien inclure des ressources provenant du serveur consulté mais aussi du contenu provenant de serveurs extérieurs (tiers ou "3rd-party").

C'est un détail anodin et technique à première vue, mais ça *contourne tous les systèmes antipub existants*.
Habituellement les bloqueurs de pubs s'échinent à rejeter les ressources extérieures au domaine consulté mais les nouveaux trackers sont désormais en first-party et sont donc distribués comme provenant du site d'origine.

En plus de contourner les protections typiques, ça tente de s'immiscer dans une possible faille du RGPD (mais tant qu'il n'y aura pas eu de procès à ce sujet ça restera incertain).

Bref, **des trackers sont à mêmes de contourner toutes les protections usuelles**.

## Quelles solutions ?

### Bloqueurs de pubs classiques ?

Bon il y a fort à parier que les bloqueurs de pubs vont s'adapter mais ça risque d'être une sacrée guéguerre.
À l'heure actuelle aucun n'est adapté pour les bloquer efficacement.

Et d'ailleurs tant que j'y suis, si vous devez en utiliser un, le plus recommandable est **uBlock Origin**.

Si vous êtes plus débrouillard vous pouvez lui ajouter **uMatrix**.
Il est d'ailleurs à même de vous protéger des 1st-parties, mais il faut le configurer manuellement pour chaque site pour l'instant.

### Bloquer le Javascript par défaut ?

Il est à mon sens de plus en plus recommandé de **bloquer le js par défaut**.
Ça pète plein de sites.
Ça protège pas complètement contre ce genre de pratiques (ça aide un peu mais c'est bien loin d'être ultime) mais ça vire les merdes les plus néfastes.

*Malheureusement cette solution ne peut pas être recommandée à tout le monde*.
Il faut déjà avoir un niveau certain de connaissances techniques sur le sujet et puis faut être prêt à constamment activer le javascript au moindre site mal foutu (de plus en plus répandu).

À une époque HTML permettait de fournir du contenu, CSS permettait de le mettre en forme et JS permettait d'ajouter quelques petits raffinements appréciables mais dispensables.
En 2019, beaucoup de sites ont fait le choix de ne pas afficher le moindre contenu sans JS.
Déjà d'un point de vue accessibilité c'est très souvent mauvais signe, ensuite concernant le référencement c'est pas toujours l'éclate mais en plus c'est très souvent signe de sites ultra lourds requérant plus de ressources que réellement nécessaire.

Bref, si vous possédez un site qui nécessite absolument Javascript pour afficher le moindre contenu vous méritez de regarder le trending Youtube jusqu'à la fin de votre vie !
Voilà j'ai fini de cracher sur JS.

### Blocage DNS ?
C'est possible mais compliqué.

C'est la solution prônée par Shaft.
C'est efficace, mais ça demande de mettre en place un *résolveur DNS dans son réseau*.
C'est pas la mère à boire mais c'est clairement pas à la portée de tout le monde.

Si vous avez un raspberry pi (même les plus anciens sont suffisants pour faire ça), ça peut être une bonne idée.
Vous serez à même de bloquer quasiment toutes les pubs classiques + ces nouvelles bouses.

### Blocage au firewall ?
Bon c'est la solution que j'ai préféré.

Dans mon cas, c'est la plus simple à mettre en place mais j'ai une installation particulière à la maison.
Et puis ça va nécessiter de mettre à jour de temps à autres pour suivre les évolutions des emmerdeurs du web.

J'ai donc ajouté quelques lignes dans mon <details><summary>script iptables du routeur</summary>
{{< highlight "shell">}}## Eulerian (tracking publicitaire)
/usr/sbin/iptables -I FORWARD -s 109.232.192.0/21 -j DROP
## Criteo (tracking publicitaire)
/usr/sbin/iptables -I FORWARD -s 178.250.0.0/21 -j DROP
/usr/sbin/iptables -I FORWARD -s 91.212.98.0/24 -j DROP
/usr/sbin/iptables -I FORWARD -s 91.199.242.0/24 -j DROP
/usr/sbin/iptables -I FORWARD -s 185.235.84.0/24 -j DROP{{</ highlight >}}</details>

Bon, c'est pas idéal non plus mais ça fonctionne pour l'instant mais nécessitera d'être tenu à jour régulièrement.

### Action en justice pour viol du RGPD ?
Ça peut aider mais c'est clairement pas du cours terme.
Perso, je le ferai pas car je me tiens aussi loin que possible des avocats mais si l'envie vous prend ça sera pour le bien de l'Europe entière.

### Boycotter les sites clients des boîtes qui ont ce genre de pratique ?
Faut taper là où ça fait mail mais bon ça reste illusoire.
Pour l'instant une des boîtes qui s'adonne à cette pratique affiche fièrement sa liste de client mais il y a fort à parier que lorsque le bad buzz se répandra un peu cette liste disparaisse.

Le seul moyen de détecter un site employant cette technique nécessite de pas mal fouiller, c'est difficilement automatisable (si ça l'est, mais ils ont la capacité de brouiller les pistes en changeant très régulièrement les noms utilisés).
Ça ne va mener qu'à une escalade inéxorable.

### ? 
Voyez-vous d'autres solutions pour l'instant ?
