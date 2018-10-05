+++
Author = "Lord"
Description = "Voyons à quoi sert le DS record et aussi comment l'envoyer chez OVH et/ou chez Online."
Categories = ["dns", "dnssec","registrar","knot"]
menu = "main"
notoc = true
PublishDate = 2018-10-05T12:10:03+02:00
date = 2018-10-05T12:10:03+02:00
title = "Gestion de l'enregistrement DS chez OVH et Online pour votre DNSSEC"
editor = "kakoune"
+++
Étant actuellement en pleine migration de serveur, je fais pas mal d'adminsys ces derniers jours.

Dans le lot je bouge mon serveur DNS et j'en profite pour mettre à jour un peu mes zones DNS.
Et je vous ai déjà parlé de DNSSEC où je vous disais qu'à l'époque, on ne pouvait pas faire de DNSSEC avec un nom de domaine acheté chez Online.
Bha maintenant on peut.

DNSSEC est une chaîne de confiance : chaque niveau hiérarchique est relié au niveau inférieur.
Dans le cas de *lord.re.*, la racine *.* est liée à *.re* et ensuite *lord.re.* est aussi lié à *.re.* .
L'enregistrement DS est ce qui relie votre domaine au niveau hiérarchique supérieur.

C'est donc un enregistrement DNS particulier que votre registrar doit vous permettre de leur envoyer.

## Chez OVH
L'interface d'OVH a changé il n'y pas si longtemps que ça (encore).
C'est plus joli mais c'est toujours aussi lourdingue.
Leur système de robot qui planifie les modifs dans quelque temps et tout et ses messages d'erreurs peu explicites sont bien chiants.

Bref voilà comment il faut faire.

  - Tout d'abord rendez-vous dans votre domaine dans leur console d'administration.
  - Ensuite, dans l'onglet *DNS servers*, vérifiez que les serveurs déclarés ici correspondent bien à ceux déclarés dans votre zone (<samp>dig votre.domaine NS</samp>) sinon vous aurez le droit à une erreur du robot.
  - Ensuite rendez-vous dans l'onglet *DS Records*.
  - Cliquez sur *Edit*.
  - Le *Key tag* est donc le tag de votre KSK pour obtenir le votre, sur votre serveur DNS lancez **<samp>keymgr votre.domaine ds</samp>** ce qui vous donnera 3 représentation de votre KSK. Ça a cette gueule "votre.domain. DS XXXXX 13 1 YYYYYYYYYYYYYY". Le tag c'est le XXXXX
  - Le *Flag* c'est le type de clé, donc *257* pour les KSK et *256* pour les ZSK mais la ZSK changeant très souvent, contentez-vous de la KSK.
  - L'*Algorithm* est … l'algorithme de la clé. Knot par défaut vous sort l'algorithme *13* qui est *ECDSAP256SHA256*.
  - Et enfin la *Public key* est la partie chiante à récupérer avec **<samp>knotc zone-read votre.domaine @ DNSKEY</samp>** qui vous listera les différentes clés dont une de type *257* qui est votre KSK, il faut donc foutre le champ assez long qui se fini par *==*

{{< img src="ovh.png" alt="capture d'écran montrant le résultat sur l'interface d'OVH" title="Et voilà le résultat chez OVH" link="ovh.png" >}}

Une fois confirmé, ça créer une tâche planifiée que vous pouvez accélérer histoire de gagner 24h.

## Chez Online
Il y a peu c'était pas possible, mais il est désormais possible de publier l'enregistrement DS chez eux.

L'interface est plus zen et tant mieux.
Il y a ce qu'il faut et pas plus.
Les modifs sont quasi instantannées.

  - Rendez-vous dans la console admin de votre domaine.
  - Vérifiez dans *Manage DNS servers* que les serveurs déclarés ici correspondent à ce qui se trouve dans votre zone (<samp>dig votre.domaine NS @127.1</samp>).
  - Puis dans *Manage DNSSEC* ajoutez l'enregistrement DS
  - Sur votre serveur DNS lancez **<samp>keymgr votre.domaine ds</samp>** et on va considérer la dernière ligne qui est la meilleure niveau crypto.
  - Le *Key id* est le troisième champ de la commande.
  - L'*Algorithm* est à faire concorder avec ce que vous a donné la commande précédente dans le quatrième champ : vous aurez un chiffre (par exemple 13) pour savoir à quel algo ça correspond reportez-vous [au tableau de l'IANA](https://www.iana.org/assignments/dns-sec-alg-numbers/dns-sec-alg-numbers.xhtml) (ouai c'est dommage de pas avoir mis les numéros direct dans leur interface…).
  - Pour le *Digest Type* c'est comme l'étape précédente, reportez-vous au [tableau IANA](https://www.iana.org/assignments/ds-rr-types/ds-rr-types.xhtml) pour faire correspondre la valeur du cinquième champs avec le type demandé.
  - Et enfin *Digest* vous mettez le sixième champ.

{{< img src="online.png" alt="capture d'écran de l'interface d'administration d'Online" title="C'est un chouilla plus simple et plus beau que chez OVH, non ?" link="online.png" >}}

-----------------
Knot gérant toute la génération de clé tout seul, les registrars étant de plus en plus au fait de DNSSEC, il n'y a plus d'excuse de ne pas le mettre en service en 2018.

