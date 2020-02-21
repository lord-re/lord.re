+++
Author = "Lord"
Description = "Si vous commencez à envisager de prendre un VPN, avant d'en choisir un tout de suite, méfiez-vous : en fonction de votre but, les solutions proposées pourraient s'avérer contre-productives."
Categories = ["réseau", "vulgarisation"]
menu = "main"
notoc = true
PublishDate = 2019-01-22T22:17:39+01:00
date = 2019-01-23T22:14:39+01:00
title = "Deux grands types de VPN"
editor = "kakoune"
TopWords = [  "appareil", "commercial", "trafic", "privé", "ffdn", "passerelle", "box", "publique", "ip", "vpn","internet","routeur"]
+++
Ça a commencé autour d'une [discussion sur le Fédiverse](https://framapiaf.org/users/Troupier/statuses/101461668076007826) et comme visiblement ça a plu, je me suis dit qu'en parler ici un peu plus longuement pourrait le faire.

Dans la vie il y a **2 types de VPN** :

  - *Le VPN strictement commercial*. Lui c'est le VPN, il vous sert de passerelle à vous mais aussi à tous pleins d'autres clients qui vont se partager cette connexion.
  - *Le VPN made in la FFDN*. Lui c'est le gentil VPN, il vous sert de passerelle mais vous garantit un net neutre à vous et rien qu'à vous. Il n'est pas partagé.

De ça il découle donc une très grande différence mais avant de voir déjà faisons un ptit peu de vulgarisation sur ce qu'est un VPN.
Tout le monde en parle mais pas grand monde sort une bonne définition de la chose donc c'est partit pour un ptit cours de réseau !

## VPN : Koikoukess

### Déjà c'est quoi une IP ?

Donc sur l'Internet mondial, chaque machine qui se dit connectée au réseau l'est par le biais d'*au moins une adresse IP dite publique*.
Historiquement il n'y avait que les adresses de type IPv4 mais maintenant on rencontre de plus en plus fréquemment des adresses de type IPv6 (la distinction n'a pas trop d'intérêt, retenez juste que IPv6 permet beaucoup beaucoup plus d'adresse que IPv4 qui est limité lui à 4 milliards).

Une adresse IP publique est donc unique sur Internet et n'est donc présente qu'à un endroit.
C'est un moyen pour identifier une machine.

### La passerelle Internet

Bon donc tout bon Fournisseur d'Accès Internet qui se respecte fournit une adresse IP publique par client.
Cette adresse est affectée à la box du client.

Mais généralement les clients ont plus d'un appareil à relier à Internet.
Chacun des ordinateurs, téléphones, téléviseurs, IOTrucs se connectent à Internet via la box
La box, en vrai, c'est un routeur (mais le nom est bien moins sexy) qu'on appelle souvent *passerelle*.

*Chaque appareil a donc une adresse IP privée locale sur votre réseau* (souvent en 192.168.1.x) avec lequel il discute avec la box pour aller sur Internet.

### Comment la box répartit les données ?
Pour savoir quel est le destinataire local, il faut savoir que **l'utilisation d'Internet est dans la très grande majorité des cas des réponses à des sollicitations de votre part.**

Donc quand votre machine sollicite une machine sur Internet :

  - la box va garder en mémoire que c'est tel appareil qui contacte tel serveur.
  - le serveur répond à votre adresse IP publique
  - la box reconnait que c'est une réponse à une sollicitation qu'elle a transmise auparavant 
  - Elle se remémore que c'est votre appareil qui a sollicité et donc que c'est pour vous la réponse.

Ce mécanisme ne fonctionne donc que pour les connexions sortantes.

**Pour une connexion entrante, la passerelle n'a aucune idée de l'appareil destinataire.**
C'est dans ces cas que vous devez "ouvrir un port"/"natter"/"rediriger le trafic" (notez les guillemets).
Vous devez donc indiquer "*Les connexions en provenance d'Internet à destination du port X sont à envoyer à l'ordinateur Y*".
Ce mécanisme est mis en place car vos appareils se partagent une seule adresse IP publique.
Chacun aurait son IP publique, il n'y aurait pas besoin de faire ça (IPv6).

En bref **la box fait la traduction entre vos adresses IP privées (interne à votre réseau) et votre adresse IP publique (utilisée sur Internet)**.

### Et donc un VPN c'est ?
Bha justement j'ai tourné autour du pot et j'ai pas sorti le mot magique exprès.
*Votre réseau interne avec vos adresses IP privées (locales, internes) on appelle ça un réseau privé (ou LAN).*

Et un VPN c'est un Virtual Private Network.
C'est donc un réseau privé virtuel, virtuel dans le sens *il existe mais à un endroit où il ne devrait pas vraiment*.
**Au lieu d'avoir votre réseau privé à un seul endroit, vous en aurez des bouts un peu plus loin sur Internet et non pas tout chez vous de votre côté de la box.**

Donc votre réseau privé virtuel sera composé de votre réseau privé habituel (tout ce qui est raccordé de votre côté de la box) + ce qui est raccordé au VPN.

Et c'est pile ici que la distinction entre les différents types de VPN se fait.

## VPN de type commercial pour l'anonymat
Ce type de VPN est le plus populaire car il répond à des objectifs assez recherchés :

  - **Cacher son IP publique**
  - **Utiliser une IP publique d'un autre pays**
  - **Outrepasser une censure Internet**
  - **Chiffrer votre connexion**
  - **Anonymiser votre trafic Internet**
  - **Pas de logs**

Déchiffrons un peu ce qu'ils font.

*Ils vous fournissent une IP publique différente de la vôtre*.
Ils en proposent généralement plusieurs.
Si vous vous rappelez le chapitre précédent, il s'agit en fait d'une passerelle qui vous est mis à disposition.
Au lieu d'utiliser votre passerelle locale, vous allez utiliser la passerelle du fournisseur de VPN.

Donc vu de l'extérieur ça ne sera plus l'IP publique de la box qui sera vue mais celle de votre fournisseur de VPN.

Il faut savoir qu'il existe des bases de données faisant la correspondance entre une adresse IP publique et une adresse géographique.
C'est grâce (à cause de cela) que certains services vous disent que vous ne pouvez pas accéder à tel contenu dans votre région du monde.
Les fournisseurs de VPN ont donc vite compris qu'il y avait un business possible en revendant des *accès à des passerelles utilisant des  IP à différents points du globe* pour outrepasser ce genre de restrictions.

**Le chiffrement de la connexion ne sera pas assuré de bout en bout !**
Les données seront chiffrées entre votre client VPN et le serveur VPN, au-delà ça ne sera pas chiffré !
En gros vous allez chiffrer les données que vera votre fournisseur d'accès Internet.
<abbr title="Ouai je sais j'insiste mais c'est primordial !">Les données seront en clair après le serveur VPN </abbr>!

Bon et concernant l'anonymisation du trafic, il n'en est rien.
Si vous consultez votre compte facebook, VPN ou non, vous ne serez pas anonyme.
Si vous avez tous vos cookies habituels dans votre navigateur, VPN ou non, vous ne serez pas anonyme.
*Le VPN en lui-même n'anonymise rien.*
**Seul votre comportement et des réglages dans votre navigateur peuvent vous anonymiser !**
(et si c'est ce que vous recherchez, penchez-vous plutôt sur TOR)

Et *concernant les logs, bha on ne peut que tenter de leur faire confiance*.
Sachez que dans certains pays (dans l'Europe notamment), les logs sont obligatoires.
Faut pas espérer qu'une entreprise se rende hors la loi pour vendre du VPN à 8€/mois…

## VPN à la FFDN
Bon, déjà pour ceux qui ne connaissent pas la FFDN jetez un coup d'œil à [leur site ouaib](https://www.ffdn.org/).
C'est le regroupement des **F**entils **F**ournisseurs **D**accès au **N**et qui sont pour la plupart des FAI associatifs.

Certains proposent des offres de VPN qui sont radicalement différents :

  - **Fournissent une IP publique fixe**
  - **Garantissent un accès Internet neutre**
  - **Chiffrement de votre connexion**

Ici **1 IP publique = 1 abonné**.
Du coup tout le trafic en provenance de cette adresse IP est uniquement votre trafic Internet à vous.
Pas de partage avec d'autres inconnus.
Niveau traçabilité c'est à l'opposé complet de l'anonymat

**La FFDN s'appuie sur une charte poussant chacun de ses membres à appliquer la neutralité du net.**
Elle est créée en grande partie autour de ce principe.
Les grands FAI commerciaux ont déjà prouvés à maintes reprises que la neutralité du net n'était pas un de leurs objectifs et l'ont bafoué plusieurs fois (et continuent encore actuellement).
Bref la FFDN, elle se bat pour la promotion de la neutralité du net qui est un critère crucial à la Liberté d'expression.

*Concernant le chiffrement, bha là par contre c'est kif-kif avec les fournisseurs de VPN commerciaux*.
Le chiffrement de la connexion est fait entre le client et le serveur VPN, pas au-delà !
L'utilisation d'un VPN ne doit pas vous induire un sentiment de sécurité absolu !

## Les VPN d'entreprise
Bon je les aborde vite fait juste pour être complet mais voilà…

Une grosse entreprise possède généralement un Intranet avec des ressources internes, des machines de stockage de fichiers, des imprimantes, des serveurs internes…
Bref toutes ces ressources elles sont dans son réseau privé.
Mais physiquement c'est très probablement réparti entre plusieurs succursales, sièges sociaux, datacenters.
Bref le but du jeu est de regrouper tout ça dans un seul et même réseau.

Et en bonus, elle peut permettre à ses employés distants de raccorder leur propre machine à ce réseau.

Et bha… c'est avec un VPN qu'on fait ça… voilà voilà.
Sauf que là au lieu de juste vous permettre d'utiliser une passerelle distante, on vous donne accès à tout un réseau privé et de ses ressources.

## Et du coup où je veux en venir ?
Ouai pourquoi j'ai voulu écrire cet article déjà ?

Ha oui ! J'me rappelle !

Quand quelqu'un demande de l'aide dans le choix d'un VPN, proposer directement un VPN de la FFDN ou un VPN commercial est contreproductif.
Ces deux types de VPN ont des buts diamétralement opposés.

**Les gens cherchant à cacher ce qu'ils font de leur connexion n'ont que peu d'intérêt à prendre un VPN nominatif de la FFDN alors qu'un VPN commercial est tout indiqué (encore que …).**

**À l'inverse, quelqu'un cherchant à auto-héberger des services ne pourra pas le faire avec un VPN commercial et devra se tourner vers ce que propose la FFDN.**

----------------

Voilà, bon c'est un peu plus long que prévu.
J'ai simplifié le tout et il y a donc des approximations.

Bien sûr il existe des fournisseurs commerciaux de VPN qui garantissent la neutralité du net, bien sûr certains permettent d'avoir une IP fixe nominative mais c'est l'exception.
