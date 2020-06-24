+++
Author = "Lord"
Description = ""
Categories = ["irc", "réseau","cli"]
menu = "main"
notoc = true
PublishDate = 2019-08-10T11:06:30+02:00
date = 2020-06-24T16:06:30+02:00
title = "IRC c'est simple."
editor = ""
+++
Rhaaa à chaque fois qu'on parle d'IRC on entend : **“IRC c'est compliqué”**

Mais en fait, c'est plutôt simple.
*IRC n'est pas plus compliqué que le web.*
Au contraire même.
C'est juste que le web tout le monde l'utilise pendant des heures depuis des années mais vous ne vous rendez pas spécialement compte de la complexité de la chose.
D'autant plus que chaque site est différent avec une interface qui peut varier du tout au tout.
Alors qu'IRC c'est un ensemble de réseaux où tout est identique (à l'exception de la gestion d'identité mais ça reste optionnel).

En apprenant juste quelques rudiments il est possible de se débrouiller sur IRC.
Bref, si vous apprenez les quelques commandes de base (moins de dix) vous pourrez vous débrouiller sur IRC (et depuis trente ans, elles n'ont pas changées et ne changeront probablement pas).

Et il existe même des logiciels qui planquent toutes ces commandes et remplacent ça par des jolies boutons pour diminuer la courbe d'apprentissage nécessaire.

## La force d'être standardisé
Contrairement à d'autres protocoles plus en vue comme *Skype*, *Discord*, *Slack*, *Mattermost* et pleins d'autres, *IRC est défini par une **RFC**, c'est-à-dire une norme d'Internet*.

Du coup, la façon de communiquer est strictement définie et documentée et [ce document](https://tools.ietf.org/html/rfc1459) (en vrai il y en a plusieurs maintenant) est disponible publiquement sur le web sans inscription ni paiement ni rien.
Il est donc possible pour à peu près n'importe qui d'écrire un logiciel compatible.

C'est pour cela qu'il existe une tripotée de logiciels différents pour se connecter à IRC.
Alors que pour les protocoles cités précédemment, il n'existe que le logiciel officiel.
Il y a bien des fois des tentatives d'avoir des logiciels alternatifs mais ceux-ci ne sont pas officiels et ont tendance à ne pas être bien vu par les éditeurs des logiciels officiels qui leur mettent des bâtons dans les roux, que ce soit techniquement ou légalement bloqué.

## La force d'être décentralisé
Un autre avantage, *c'est qu'IRC n'est pas contrôlé par une seule entité*.
Aucun risque d'une faillite ou d'une décision d'un point central qui impacterait les réseaux IRC.
Parceque oui, il n'y a pas 1 réseau IRC mais une myriade.
Donc dans le pire des cas 1 réseau tombe mais les autres seront toujours là.

Lorsque Microsoft décidera que Skype ne rapporte plus suffisamment, ils couperont sans trop y réflêchir ou bien rendra l'accès payant et c'est valable pour Discord ou les autres.
IRC n'a pas d'enjeu financier derrière et les réseaux sont en plus très souvent maintenus par des entités à but non lucratif.

## Bref, IRC c'est simple.
Ce qu'il faut savoir c'est qu'il y a des *réseaux irc*, constitués de *multiples serveurs*, contenant chacun de *multiples salons* avec dedans des *utilisateurs*.
On a fait le plus dur.

Et vous voulez voir à quel point c'est simple ?

**On va se connecter manuellement à un serveur irc et discuter sans même avoir de client irc mais en écrivant tout avec nos mimines.**

Bon il va vous faloir un client telnet/netcat/nc ou carrément on va être encore plus moderne et on va passer directement par **openssl**.

Dans un terminal entrez <kbd>openssl s_client -connect irc.geeknode.org:6697</kbd> .

<details><summary>Le serveur vous répond tout un tas de trucs</summary>
<pre>
CONNECTED(00000003)
depth=2 O = Digital Signature Trust Co., CN = DST Root CA X3
verify return:1
depth=1 C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
verify return:1
depth=0 CN = hivane.geeknode.org
verify return:1
---
Certificate chain
 0 s:CN = hivane.geeknode.org
   i:C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
 1 s:C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
   i:O = Digital Signature Trust Co., CN = DST Root CA X3
---
Server certificate
-----BEGIN CERTIFICATE-----
MIIGlzCCBX+gAwIBAgISA6LoBQCbzTgc5LavZKLAgJ7LMA0GCSqGSIb3DQEBCwUA
MEoxCzAJBgNVBAYTAlVTMRYwFAYDVQQKEw1MZXQncyBFbmNyeXB0MSMwIQYDVQQD
ExpMZXQncyBFbmNyeXB0IEF1dGhvcml0eSBYMzAeFw0yMDA0MjkwMjI1MDlaFw0y
MDA3MjgwMjI1MDlaMB4xHDAaBgNVBAMTE2hpdmFuZS5nZWVrbm9kZS5vcmcwggIi
MA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQDo8Bnlnw3/piIVTlEPWUka+vh/
EQEiByFv0Saxn/whNXcrhiejADoEqHpx2nzUiWEcDXXW+1sUr4GqikVQmJY9R8Z5
Jx8vP86rlTLHhHsgoXp4jtAbPO8BzsvqFI0KRPf6GRu83df5qQDL6M4wamy3KpOm
e0gnwGKbjbW8SSyyE1olOtk20rJC2gZhnIKtVrbYfkwnZysM9DKGRKI0y9fvgW1O
kLltFGNdWF5gc0fppgdKyghZMG+7HNbqDDn8dOQE6V6l+6ZaZD8dGIDpebywe3cQ
ZieEseDD8+jz/95KtWEFSn8dLQptRv5lzh3IzVJvtNRZnrgn4nsnUtpvynxC1+FO
MrAbpDxK76NzzuclQhcMDF8oti/AshlznsEL49efAT6azc1xCETvkVjGi/8oVK1/
Ow/yXucnO1+nVEnVuyvNTL3kX/8UAUKvEroSDAzq7/PFCH44GaKJNrfqSr/QWMlE
vAeMgeXbZ2jB5HP54E+esFsxuQl8xNNuxWpFEb+jGjLM/32w9uIAtWXFtTjQaZUr
thUKDf1UQFai01fX9pkcskfQqIX2vc3fdvub+8VPccMVYW60i9LzUaA8NG2RHjXs
muvBangMNbx4v1ugj9SpGlArRtHZCrmNmFfMd06aR0M5RX1lD9j6pPIE1oLiu4Vq
ox1rkX2U1OWDPyNGpwIDAQABo4ICoTCCAp0wDgYDVR0PAQH/BAQDAgWgMB0GA1Ud
JQQWMBQGCCsGAQUFBwMBBggrBgEFBQcDAjAMBgNVHRMBAf8EAjAAMB0GA1UdDgQW
BBShKUfc6De2x77U1WYMlTrdwqEzXTAfBgNVHSMEGDAWgBSoSmpjBH3duubRObem
RWXv86jsoTBvBggrBgEFBQcBAQRjMGEwLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3Nw
LmludC14My5sZXRzZW5jcnlwdC5vcmcwLwYIKwYBBQUHMAKGI2h0dHA6Ly9jZXJ0
LmludC14My5sZXRzZW5jcnlwdC5vcmcvMFgGA1UdEQRRME+CE2hpdmFuZS5nZWVr
bm9kZS5uZXSCE2hpdmFuZS5nZWVrbm9kZS5vcmeCEGlyYy5nZWVrbm9kZS5vcmeC
EWlyYzYuZ2Vla25vZGUub3JnMEwGA1UdIARFMEMwCAYGZ4EMAQIBMDcGCysGAQQB
gt8TAQEBMCgwJgYIKwYBBQUHAgEWGmh0dHA6Ly9jcHMubGV0c2VuY3J5cHQub3Jn
MIIBAwYKKwYBBAHWeQIEAgSB9ASB8QDvAHUAsh4FzIuizYogTodm+Su5iiUgZ2va
+nDnsklTLe+LkF4AAAFxw/d/IgAABAMARjBEAiAFBe3+77xwVk/PUmgBOGfes86i
XoqjJWfyPIl9g28pCAIgehMPGnSo3TabsFIE50MNk0RE3kor7EBxtbUXFVua0fgA
dgBvU3asMfAxGdiZAKRRFf93FRwR2QLBACkGjbIImjfZEwAAAXHD93/nAAAEAwBH
MEUCIQDttTwmykhjiGZvSCToiI3Wdfq4bE0Te0T7jv5YmxarSAIgdaLF2LtMW9pg
LIM3mR3Oi8ZRqLP3bKO8DT9Tj0FZ1WswDQYJKoZIhvcNAQELBQADggEBAJPyo0NZ
gsvyq28knOXevVuEz+/l5MGm4OVOLS45YZRcQkbZhrEWh6LKuAiyabIfXEIO3VqE
gUknlpab+ULFOuEc+4BR8EG63QkRBef8kahPGJI57MSO9yg6qOPIyrSWIAGy0XU9
tuEvRS8ISTUw3SyhpweAwYgzMpt6hbJ6edbuoRq+9yjgnq+/TwGxpLWhrngWJ7hZ
d6DYFb+encYcjoQt6qeDUWSEeWUubY7MDGWhDJSLpWvd5mXXmCa5QgGeWdxBNRoR
kvSk+5ZTW8oBP7s3jjYFZa+tie3bQ+tWal2Ets71Vt7SaUHU4Rt8TVILSvu8RLZ9
LWpdBOlbDJaIvos=
-----END CERTIFICATE-----
subject=CN = hivane.geeknode.org

issuer=C = US, O = Let's Encrypt, CN = Let's Encrypt Authority X3
No client certificate CA names sent
Client Certificate Types: RSA sign, DSA sign, ECDSA sign
Requested Signature Algorithms: RSA+SHA512:DSA+SHA512:ECDSA+SHA512:RSA+SHA384:DSA+SHA384:ECDSA+SHA384:RSA+SHA256:DSA+SHA256:ECDSA+SHA256:RSA+SHA224:DSA+SHA224:ECDSA+SHA224:RSA+SHA1:DSA+SHA1:ECDSA+SHA1
Shared Requested Signature Algorithms: RSA+SHA512:DSA+SHA512:ECDSA+SHA512:RSA+SHA384:DSA+SHA384:ECDSA+SHA384:RSA+SHA256:DSA+SHA256:ECDSA+SHA256:RSA+SHA224:DSA+SHA224:ECDSA+SHA224:RSA+SHA1:DSA+SHA1:ECDSA+SHA1
Peer signing digest: SHA512
Peer signature type: RSA
Server Temp Key: ECDH, P-521, 521 bits
SSL handshake has read 3714 bytes and written 516 bytes
Verification: OK
New, TLSv1.2, Cipher is ECDHE-RSA-CHACHA20-POLY1305
Server public key is 4096 bit
Secure Renegotiation IS supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1.2
    Cipher    : ECDHE-RSA-CHACHA20-POLY1305
    Session-ID:
    Session-ID-ctx:
    Master-Key: DCB0E95A32340C7509F73CDDB93C523917F5DE1A0CD221A005C9016F4D718EB986640BA161F3DE5B3ED32E75D60AB69B
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1592556345
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: yes
</pre>
</details>

Voilà, là vous avez juste établit une connexion réseau sécurisée.

Maintenant que la connexion réseau est établie, il faut parler dans le langage irc pour vous initier la session et vous connecter à un salon.
C'est un peu comme si vous aviez composé un numéro de téléphone pour le moment, maintenant vous allez commencer le dialogue en vous présentant et en faisant vos demandes.

<kbd>user $PSEUDO * * :$DESCRIPTION</kbd>  donc là vous remplacez $PSEUDO et $DESCRIPTION par ce  que vous voulez (vous pouvez vous contenter de remettre votre pseudo dans la description).

<kbd>nick $PSEUDO</kbd> là vous entrez le pseudo que vous voulez utiliser (ouai c'est redondant et la subtilité avec la commande précédente n'a que peu d'intéret mais faut le faire).

Là, le serveur devrait vous renvoyez un message de type <kbd>PING :$XXXXXXX</kbd> .
Vous avez quelques secondes pour lui répondre <kbd>pong :$XXXXXXX</kbd> en sachant que la valeur va changer à chaque fois.
Si vous ne le faites pas assez vite vous serez déconnecté et il faudra recommencer.

D'ailleurs même plus tard quand vous serez connecté il vous enverra des ping régulièrement.
Il faudra toujours y répondre promptement.

Une fois répondu avec le pong, le serveur vous connectera réellement et vous enverra tout un tas d'informations le concernant : son nom, sa version de logiciel, ce qu'il sait faire, sa population, un message de bienvenue, vos modes…

Maintenant vous allez pouvoir rejoindre un salon de discussion pour ça il suffit de taper <kbd>join #fediverse</kbd> et hop vous voilà connecté au salon.
Vous recevrez la liste des utilisateurs actuellement connecté au salon.

C'est bon, maintenant vous pouvez pouvoir envoyer des messages en entrant <kbd>privmsg #fediverse coucou tout le monde \o/</kbd> .
Ça y est votre message est parti.

Vous recevrez les messages du salon qui auront cette allure 
<pre>:Lord!Lord@geeknode.fuckyeah PRIVMSG #fediverse :hello</pre>

Si vous souhaitez envoyer un message à un utilisateur précis c'est presque pareil avec <kbd>privmsg $DESTINATAIRE salut à toi</kbd> .
Bon, bha finalement c'est simple, non ?
C'est juste du texte qui se balade comme ça, c'est vraiment basique.

------------

Donc pour résumer se connecter / rejoindre un salon / envoyer un message ça se résume à ça :

<kbd>openssl s_client -connect irc.geeknode.org:6697</kbd><br>
<kbd>user monpseudo * * :monpseudo</kbd><br>
<kbd>nick monpseudo</kbd><br>
<kbd>pong $XXXXXX</kbd><br>
<kbd>join #fediverse</kbd><br>
<kbd>privmsg #fediverse coucou le salon !</kbd><br>

Voilà, n'hésitez pas à tester cette manipulation, on se croirait un vrai hacker.
Ça ne nécessite quasiment aucune installation et puis c'est assez amusant de parler au serveur irc.

## Pour aller plus loin
Si vous souhaitez devenir un utilisateur régulier, il va vous faloir trouver un client IRC qui vous convient.
Il en existe directement utilisable dans le navigateur comme, par exemple [Kiwi IRC](https://kiwiirc.com/nextclient/) ou bien [The Lounge](https://demo.thelounge.chat/) (The Lounge est à héberger vous-même mais il propose cette démo qui semble limiter au réseau Freenode).
Si vous voulez un client graphique vous aurez [Hexchat](https://hexchat.github.io/) (dispo pour tous les OS) ou bien [Quassel](https://quassel-irc.org/) mais il est possible d'utiliser [Thunderbird](https://www.thunderbird.net/en-US/) ou bien l'illustre [mIRC](https://www.mirc.com/) (sous Windows). 

Le protocole en lui-même n'a pas de notion de comptes.
C'est géré par ce qu'on appelle les services et c'est parfaitement optionnel.

IRC utilise des *modes* pour donner des droits mais là aussi, on peut très bien utiliser irc basiquement pendant des années sans s'en soucier.

J'ai écrit une petite série de guides permettant d'en apprendre un peu plus sur les rouages. [IRC niveau 2]({{< ref "posts/52-irc-niveau2" >}})

Si vous êtes plus intéressé par la "culture" IRC j'ai également rédigé un ptit post concernant [Les us et coutumes d'IRC]({{< ref "posts/111-traditions-dirc" >}}).

--------------

Voilà, j'espère que j'ai pu démystifier certains points et vous convaincre que non c'est pas plus compliqué que le web bien au contraire.
Si vous voulez, je suis disponible en tant que lord sur le réseau irc.geeknode.org mais aussi irc.freenode.net, n'hésitez pas à venir taper la discut' (notamment sur #fediverse sur le réseau geeknode).
