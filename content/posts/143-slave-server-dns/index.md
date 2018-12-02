+++
Author = "Lord"
Description = "Bon vous vous auto-hébergez vous avez votre nom de domaine et tout c'est bien. Pas de bol votre serveur DNS tombe en panne, toute votre infra disparaît ! Heureusement avec le DNS vous pouvez avoir de la redondance via un (ou plusieurs) serveurs esclaves. Voyons ça de plus près."
Categories = ["dns", "knot","adminsys","autohebergement"]
menu = "main"
notoc = true
PublishDate = 2018-12-01T17:55:34+01:00
date = 2018-12-01T17:55:34+01:00
title = "Monter un server esclave Dns"
editor = "kakoune"
+++
Si vous avez un nom de domaine à vous (et j'espère que si vous êtes sensibilisé à votre identité numérique vous en avez un) il y a deux possibilités :

  - soit vous laissez la tâche d'héberger votre zone à un prestataire (souvent celui qui vous a vendu le nom de domaine)
  - soit vous l'hébergez vous-même.

Bon, personnellement *je pense qu'il vaut mieux que vous l'hébergiez vous-même*.
Soit dit en passant, je vous ai déjà concocté un [joli guide concernant DNS]({{< ref "/posts/63-dns-mega-guide" >}}) plutôt complet.
J'ai rien contre le fait de laisser un prestataire le faire.
Je n'ai, à vraie dire, jamais vraiment entendu d'histoire de magouille/mauvaise gestion/d'usurpation ou autre saloperie à ce propos.
**Mais héberger son domaine est vraiment super simple, ça demande peu de ressource, pas vraiment contraignant.**
C'est vraiment le B.A.BA de l'auto-hébergement.


Et qui dit auto-hébergement, dit ?

…

Panne.
Merci de suivre !

Bref, *un jour où l'autre votre serveur se viandera* et vous serez marron.
Par chance, comme la plupart des anciens protocoles de l'Internet, *DNS a été pensé pour être vraiment résilient*.
Il est très facile d'avoir plusieurs serveurs à même de répondre pour votre zone.

C'est une architecture Maître-Esclave où vous allez avoir votre serveur Maître qui connaît les informations concernant votre nom de domaine et qui les enverra aux serveurs esclaves qui recopieront ces informations et les communiqueront aux clients.

*D'un point de vue de l'utilisateur, il ne verra pas de différence selon si l'info parvient d'un serveur esclave ou du maître.*
Il arrive d'ailleurs parfois que le Master ne soit pas joignable depuis Internet mais uniquement par un réseau privé et que donc seul les serveurs esclaves soit utilisés par les clients.

Vous pouvez avoir autant de serveur esclave que vous le voulez.
Si jamais le maître tombe les serveurs esclaves seront toujours à même de fonctionner et vice versa.

Dans la suite je vais plutôt utiliser le terme zone DNS à la place de domaine.
Allez on met ça en place !

## Knot sur le master
On commence par modifier le serveur maître.

### Rajouter un remote

Un remote est tout simplement un serveur distant avec lequel on interagira.
Rien de bien méchant : 

{{< highlight "yaml" >}}
- id: slave_server
    address: 123.321.123.321
{{< / highlight >}}

C'est tout.

### Ajouter une ACL

Les ACL sont les régles définissants les droits que vous allez attribuer à une zone.
En gros vous voulez autoriser votre zone à envoyer les modifs vers le serveur esclave.

{{< highlight "yaml" >}}
  - id: acl_slave
    address: 123.321.123.321
    action: ["transfer","notify"]
{{< / highlight >}}

### Confer la zone

Bon jusqu'à présent vous avez ajouté des options globales à votre configuration Knot.
Maintenant il faut affecter des options sur votre zone.

Soit vous mettez toutes les options dans un template que vous affecterez à vos zones, soit vous mettez les options à chacune de vos zones (le template permet d'appliquer les mêmes réglages à plusieurs zones d'un coup).

{{< highlight "yaml" >}}
template:
  - id default
  acl: [ "acl_localupdate", "acl_slave"]
  notify: slave_server
  …
{{< / highlight >}}

Là c'est un extrait du template par défaut où on affecte l'ACL que l'on a créé précédemment.
Et ensuite on indique qu'il faut notifier le remote créé précédemment.

Le notify permet à votre master d'indiquer au slave qu'il doit rafraîchir ses infos car le master vient de modifier la zone.

### C'est bon
Ouai c'est tout mais faut penser à reload avec un ptit **<samp>knotc reload</samp>**.


## Knot sur le slave
Et maintenant on configure votre serveur esclave.

### Rajouter un remote

Ça ressemble beaucoup à la même chose que tout à l'heure vous allez me dire !
Bha ouai.

{{< highlight "yaml" >}}
- id: master_server
    address: 123.321.123.321
{{< / highlight >}}

Ce coup-ci le remote est obligatoire et n'est pas là juste pour que ce soit clair.

### Ajouter une ACL
{{< highlight "yaml" >}}
  - acl: acl_master
    address: 123.321.123.321
    action: notify
{{< / highlight >}}

### Confer la zone
{{< highlight "yaml" >}}
  - domain: mon.domaine
    master: master_server
    acl: acl_master
{{< / highlight >}}
    

### Et on reload !

## Le master et le slave sont prêts et maintenant ?

Voilà c'est fait votre zone est maintenant répliquée sur un autre serveur qui peut prendre la main si votre serveur tombe en panne.
Vous pouvez le tester avec l'outil **Dig** pour voir si le serveur esclave répond : **<samp>dig votre.domaine @serveur.esclave</samp>**

Bon si vous voulez que ça fonctionne il reste deux étapes capitales : 

  1. *Rajouter un enregistrement* **NS** *dans votre zone pointant vers votre serveur esclave*.
  2. *Informer également votre registrar pour que ça soit pris en compte*.

## C'est super mais…
Haa non pas d'objection !

### J'ai pas les moyens de me payer un autre serveur !
Ha bha il suffit de demander à vos amis geeks.
Héberger une zone pour un pote ça coûte absolument rien.

Et si vous avez pas d'amis bha… demandez-moi !
**Je vous ferai une petite place volontier.**

### Ha mais c'est gentil mais j'utilise Bind…
*Ça marche même si les serveurs maîtres et esclaves n'utilisent pas les mêmes logiciels* vu que c'est un fonctionnement de base du protocole.
Vous pouvez avoir du *Bind* et du *Knot* et du *NSD* par exemple.
C'est d'ailleurs pas mal d'avoir des implémentations différentes (en cas de bugs, tous les serveurs ne seront pas impactés).

Vous trouverez des tutos pour faire de même avec Bind dans le pire des cas ;-)

### Beurk c'est pas secure !
Rhaaa mais si c'est possible !
Juste que j'ai pas envie de vous faire un article fleuve mais [la doc existe](https://www.knot-dns.cz/docs/2.7/singlehtml/#slave-zone).

### Hey mais mon DNSsec est foireux sur le slave !
Ouai.
Et pour l'instant j'ai pas la solution car non il ne faut pas filer sa KSK au slave (on ne peut pas avoir autant confiance envers le slave).
