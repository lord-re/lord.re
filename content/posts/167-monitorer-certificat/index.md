+++
Author = "Lord"
Description = "TLS est la pierre angulaire de la sécurité des services sur le net. Cela repose sur l'utilisation de certificatss TLS (SSL, x509). Il est important de monitorer la création et le renouvellement de ceux-ci."
Categories = ["adminsys", "tls", "sécu" ]
menu = "main"
notoc = true
PublishDate = 2019-05-28T12:13:58+02:00
date = 2019-05-28T12:13:58+02:00
title = "Monitorer ses certificats TLS"
editor = "kakoune"
+++
Pour une fois je vais essayer de pas parler de SSL (les habitudes toussa toussa) mais de certificat TLS (parceque <abbr title="sisi c'est le vrai nom !">x509</abbr> ça parle pas à grand monde).

Bref, Une grande partie de la sécurité des services sur Internet repose sur **TLS**, que ce soit du web, du mail, de l'irc, du …
Du coup pour sécuriser ça, on emploie des certificats que l'on fait signer par une **Autorité de Certification** ou **CA** en anglais.
Donc si je résume : *tout est sécurisé par TLS et tout repose sur les CA*.

Imaginez la pression qui s'exerce sur les CA.
Ce sont des cibles aussi bien pour les attaques des viles pirates mais également des nobles corsaires (commandités par un gouvernement).

Pour se protéger d'une vilaine CA, un propriétaire d'un nom de domaine peut mettre en place [CAA]({{< ref "/posts/61-dns-caa" >}}) ce qui empêchera (théoriquement) toutes les CA (sauf celle spécifiée) de signer un certificat pour ce domaine.
Les CA doivent respecter ce système depuis quelque temps maintenant.
Les gros navigateurs se chargent de ne plus faire confiance envers les CA ne respectant pas ça.

Mais on peut aussi pousser le bouchon un poil plus loin avec le **Certificate Transparency**.
Il s'agit d'un journal public, où toutes les CA consignent les certificats qu'elles signent afin d'avoir une trace.
Il est donc très intéressant de consulter ces logs publics afin de vérifier que personne n'a émis de certif dans votre dos.

Tout ce qui est manuel tombe à la trappe.
Heureusement [Cert.Sh](https://cert.sh) propose \*roulement de tambour\* … un **flux RSS** !
C'est basique, mais ça fonctionne.

Ça vous permet à la fois de *voir si votre renouvellement s'est bien passé, mais aussi que personne d'autre n'en a fait un*.

Perso, je le couple avec une notif IRC déclenchée par le script de renouvellement Let's Encrypt.

Voilà c'est tout bête mais malheureusement c'est rarement monitoré, même pour des services plutôt sensibles comme des banques, des fournisseurs de système d'exploitation et autre…
Tiens d'ailleurs, vous voulez un ptit [Wall of Shame](https://imirhil.fr/tls/) ?
