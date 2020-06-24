+++
Author = "Lord"
Description = "DNSSEC en lui même est un protocole sympa mais il permet surtout d'utiliser DANE. DANE permet de fortement améliorer la sécurité de services Internet."
Categories = ["dns", "dnssec","sécu","knot"]
menu = "main"
notoc = true
PublishDate = 2018-10-08T22:35:56+02:00
date = 2018-10-11T15:35:56+02:00
title = "Reflexe Dane"
editor = "kakoune"
TopWords = [ "ksk", "tlsa", "dane", "certificat", "dns", "dnssec"]
+++
J'ai déjà plusieurs fois abordé DNSSEC et une fois survolé DANE mais je vais en remettre une couche.

Bon déjà reprenons vite fait du début.

## DNSSEC c'est quoi donc ?
Il s'agit d'un ajout au protocole DNS ajoutant de la crypto permettant d'assurer l'intégrité des réponses DNS.
Le but est de s'assurer que les données que vous échangez avec votre résolveur sont authentiques, elles restent toute fois lisibles, le but n'est pas de rendre votre trafic DNS illisible par votre FAI !
Si vous utilisez un résolveur DNS qui valide DNSSEC vous pouvez être assuré qu'une réponse est authentique si elle a le petit flag **ad** (quand vous utilisez la commande dig).

Ça se base sur tout un système de crypto à base de clés publiques et privées qui sont changées régulièrement (le roll) avec deux principaux types de clés : 

  - les **KSK** qui sont les key signing key qui servent à signer d'autre clés
  - les **ZSK** qui sont les zone signing key qui servent à signer les enregistrements de votre zone

*DNSSEC est une chaîne, signer votre zone c'est bien mais pas suffisant.*
Il faut que la zone parente soit elle aussi signée et surtout il faut un ptit morceau sur la zone parente qui lie votre zone (DS).
Si ce n'est pas le cas la chaîne de certification n'est pas complète et donc pas de DNSSEC.

Une fois tout ceci mis en place (c'est pas bien compliqué, franchement faite-le !), les infos présentes dans votre zone peuvent être distribuée de façon sûre.
On peut donc s'amuser à y mettre des données un poil sensibles.
Sensibles mais publiques.
*Le DNS ce sont des données publiques.*
Mais alors pourquoi sensibles ?

Bha sensible dans le sens où maintenant qu'on peut s'assurer qu'elles n'ont pas été alteré, *ces données peuvent attester de l'authenticité d'une information* (typiquement attester que tel certificat est LE certificat utilisé par un service).

## DANE
DANE est exactement l'application de ce principe : *le certificat utilisé par tel service est celui-ci*.
Le logiciel peut donc vérifier que le certificat présenté par le service est bien identique au certificat publié dans le DNS.

DANE permet donc d'assurer à un utilisateur qu'il n'est pas en train de subir une attaque de type Man-In-The-Middle.

DANE repose donc sur DNSSEC mais également sur le fait que ça doit être implémenté par chaque logiciel voulant l'appliquer (logique).
Malheureusement, *aucun logiciel grand public ne l'utilise*.
Ça serait pourtant un sacré pas en avant dans la sécurisation du web.

Le jour où Chrome l'adopte le reste de l'industrie s'y mettra mais avant… œuf/poule.

## Pondons l'œuf !
### DNSSEC
Et voilà \o/ DNSSEC est en place.
Bon en vrai c'est un tout petit peu plus compliqué.

Avec Knot, dans votre fichier de conf où vous déclarez vos différentes zones, vous devez attribuer une politique de signature.
Celle par défaut peu convenir mais perso j'ai pas envie de me faire chier à changer la KSK trop souvent donc j'ai défini ma mienne : 

    policy:
      - id: ecdsa
        algorithm: ecdsap384sha384
        zsk-lifetime: 7d
        ksk-lifetime: 700d
        ksk-size: 384
        zsk-size: 384

puis dans votre zone :

    zone:
      - domain: lord.re.
        file: lord.re
        dnssec-signing: on
        dnssec-policy: ecdsa

Et voilà Knot va se démerder en créant les clés les faire tourner et tout.

Maintenant vous [transmettez le DS chez votre registrar]({{< ref "/posts/129-DNSSEC-chez-ovh-et-online" >}}).
Pour l'instant Knot ne va pas commencer à rouler les clés tant que le DS n'est pas publié.
Une fois fait il faut lui signaler avec **<kbd>knotc zone-ksk-submitted lord.re</kbd>**.

Voilà votre zone devrait être bien signée et tout, vous n'avez plus rien à faire jusqu'au prochain roulement de KSK dans 700 jours (mettez un rappel).

### TLSA
DANE c'est le gentil nom de la technique mais en vrai il s'agit juste d'un enregistrement de type **TLSA** dans votre zone DNS.
Prenons un cas concret : **lord.re** .

On va utiliser le [générateur habituel](https://www.huque.com/bin/gen_tlsa).

Donc là si comme tout le monde vous avez un certificat signé par LetsEncrypt, le mieux est d'utiliser un **TLSA 312** qui a l'avantage de ne pas devoir être renouvelé tous les 90 jours quand le certificat est renouvelé.
*Les enregistrements TLSA 312 s'appuient sur la clé publique qui n'est pas modifiée à moins de manuellement en régénérer une.*

Donc, il faut copier/coller votre certificat **cert.pem** dans l'emplacement prévu dans le générateur.
Avec acme-client ça se trouve dans **/etc/ssl/acme/lord.re/cert.pem** .

Le numéro de port dépendra du service que vous voulez protéger par cette technique.
Pour le web c'est **443** et le protocole **tcp**.

Et enfin entrez le nom de la machine qui héberge le service **lord.re** dans l'exemple.

Ça vous pond une longue ligne à ajouter à votre zone.
Sur votre serveur DNS hébergeant la zone DNS vous pouvez : **<kbd>knsupdate <br>server 127.0.0.1<br>zone lord.re<br>update add _443._tcp.lord.re 600 TLSA 3 1 2 enriuetjesuisuntrèsmauvaisgénérateurd'aléatoireuirnse==</kbd>**

Et voilà :-)

Et maintenant on le teste sur [Le webtest de sidnlabs](https://check.sidnlabs.nl/dane) si c'est pour un serveur web ou sur bien sur [le webtest de sys4](https://dane.sys4.de/) si c'est pour du mail.

## Le réflexe
Bon c'est franchement pas dur.
Ça se fait en près de deux minutes.

Maintenant il faut chopper le réflexe : **À chaque fois que vous créez un nouveau certificat ou que vous utilisez un certificat existant sur un nouveau service, pensez à ajouter l'enregistrement TLSA qui va avec.**

Si le réflexe est adopté par de nombreux sysadmin l'implémentation par les logiciels pourrait avoir lieu un de ces jours (admirez l'optimisme).

Bon pour cet article j'ai volontairement planté mes zones DNS afin d'expérimenter et tout mais au moins c'est clean et dans ma tête et pour vous.

