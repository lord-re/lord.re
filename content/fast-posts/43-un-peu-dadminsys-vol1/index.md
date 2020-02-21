+++
Author = "Lord"
Description = "Un ptit weekend où j'ai fait deux trois trucs en adminsys linux"
Categories = ["adminsys", "weekend","dns","dane","alpine"]
menu = "main"
notoc = true
WritingDate = 2020-02-07T19:53:40+01:00
date = 2020-02-09T19:53:40+01:00
title = "Un peu d'adminsys vol.1 : Alpine 2020, Acme, Knot"
editor = "kakoune"
TopWords = [  "dns", "postfix", "sort", "alpine", "knotc", "nginx", "upgrade", "acme", "apk"]
+++
En ce tout début de weekend, je sais pas trop pourquoi j'ai eu envie de faire un peu d'adminsys.
Du coup je vais vous partager ce petit vrac.

## Upgrade d'Alpine qui accroche
J'ai donc commencé par upgrader une de mes machines à la toute dernière version d'Alpine.
Bref, le truc ultra basique et rapide.
Juste un passage de 3.10 à 3.11.

J'édite donc le */etc/apk/repositories* pour y changer le numéro de version.
Je lance un coup de <samp>apk update</samp> et quelques secondes après <samp>apk upgrade</samp>.
Tout se passe bien.

Je regarde les services qui tournent avec htop, je les redémarre un par un histoire d'être sur la dernière version.

Postfix passe.

Dovecot passe.

Nginx passe.

Postgres… Ha tiens je l'ai migré, je peux le dégager lui.
Je le coupe pour le moment (jamais trop prudent).

Knot passe pas.
Arg c'est dommage c'est un important lui.
Peut pas trop le foutre en vrac trop longtemps.

Bon visiblement il se plaint de truc bizarre.
Relançons un <samp>apk upgrade</samp> ouai ça sert à rien mais des fois que…

Tiens !
**apk** me sort *2 errors* mais c'est écrit en tout petit j'avions point vu !

Dans ce cas il faut <samp>apk fix</samp>.
Hmm il arrive pas à résoudre les erreurs et me sort un *secure_getenv : symbol not found* .

Ha tiens c'est aussi l'erreur que me sortait knot !
On avance !

Bon un ptit tour de DuckDuckGo…
Mouai rien de probant.
Allez je me sens sale mais go pour du Google.

Pas mieux.
Comme quoi c'est pas mieux que DuckDuckGo.

Bon bha quand le web n'aide pas vers quoi on se tourne ?
**IRC**

Allez je pose ma question sur *#alpine-linux* .
49secondes plus tard j'ai une première réponse.
On investigue un peu et là.
Tadaaaaaa un sauveur me sort la solution comme ça au bout de trois minutes.

<samp>apk upgrade -U -a -s</samp>
Me sort un listing de paquets pas super à jour.
Du coup un ptit <samp>apk upgrade -a</samp> et voilà !

Plus d'erreur, je peux relancer knot.
En moins de 5 minutes top chrono la communauté irc d'alpine m'a démerdouillé le truc.

Donc note à moi-même pour la prochaine fois : **Lors d'un upgrade de version chez Alpine il faut faire un <samp>apk upgrade -a</samp> pour vraiment tout upgrader.**

## Migration d'acme-client à acme.sh
Bon, une fois ce premier souci résolu, j'ai voulu me créer un nouveau vhost.

Je m'ajoute une nouvelle entrée dns avec **knsupdate**.
Ensuite je me fais le vhost au niveau de nginx.
Je le reload, j'ouvre mon navigateur, ça fonctionne nickel.

Du coup je vais pour lui coller du TLS.
Historiquement sur cette machine j'utilisais encore *acme-client* mais celui-ci n'est plus maintenu (sous BSD si).
Il n'implémente que Acme-v1 qui est la première version du protocole de LetsEncrypt mais pas de bol, seuls les renouvellements sont acceptés sur ce protocole.
Pour la création il faut passer à Acme-v2, du coup il me faut changer de client acme.

Mon nouveau chouchou du jour c'est **acme.sh** .
Tout en shell avec quasiment aucune dépendances.

Ça s'installe en deux deux, très simple d'utilisation et tout.
Et pour une fois je me suis laissé allé à la flemmardise et je le laisse même trifouiller la conf nginx tout seul.

Du coup je fais un coup de <samp>acme.sh --issue -d mon.domaine --nginx</samp> ça mouline quelques secondes.
Il m'indique ensuite où sont rangés les cert clé et compagnie.
Plus qu'à ajouter ça au fichier de conf nginx et à le reload.

Voilà c'était torché en deux minutes.
Mais du coup autant migrer aussi mes autres certs pour jarter *acme-client*.

Je fais exactement la même technique.
Me reste à mettre à jour mon script de cron.

J'ai pour l'instant fait un script qui s'amuse à relancer les différents services utilisant les certificats (postfix, dovecot, nginx, weechat).
Par contre j'ai pas tout de suite trouvé comment me faire des notifs vers mon bot irc.
Visiblement les hooks de notifications sont pré-établis.
On peut pas lancer une commande arbitraire du coup ça va être chiant.

## Un ptit tour sur Postfix
Je sais pas pourquoi mais aujourd'hui c'est revenu dans deux fois dans des discussions différentes dans des lieux différents.
Postfix mais surtout *Postscreen* a été un gros sujet du jour du coup.

Et j'ai d'ailleurs découvert une option permettant potentiellement zapper le greylist.
**postscreen_dnsbl_whitelist_threshold** 
Lorsqu'un serveur s'avère n'être présent dans aucune de vos DNSBL, alors les tests supplémentaires ne sont plus faits et le reste du traitement du mail est fait sans plus attendre.

Je l'ai mis en place ce soir, je verrai dans quelques jours si ça m'épargne un peu de greylisting.

## Un ptit tour du côté du DNS
Vu que j'ai regéneré les certificats Let's Encrypt de zéro il s'est passé un truc auquel je n'ai pas pensé.
Mes enregistrements TLSA n'étaient plus trop d'actualité et il me fallait les refaire.
C'est ce qui permet à **DANE** (le truc trop bien mais complètement ignoré) de faire son boulot.

J'ai tenté de me battre au début avec *knsupdate* mais c'est toujours un poil chiant.
Je sais pas si je suis particulièrement mauvais où bien il ne connait effectivement pas les enregistrements TLSA et donc refuse d'en ajouter…

Du coup je me suis rabattu sur *knotc* directement.
Je pense que je vais lui faire un peu plus honneur dans [mon guide sur le DNS]({{< ref "/posts/63-dns-mega-guide" >}}).

D'ailleurs j'en ai profité pour purger ma zone de pleins de trucs inutilisés et accumulés au fil des expérimentations.

Un ptit <samp>knotc zone-read lord.re.</samp> est particulièrement blindé.
Donc <samp>knotc zone-begin lord.re.</samp> et là on commence à couper dans le gras : <samp>knotc zone-unset lord.re. vieux.trucs.lord.re.</samp> .
On fait ça pour chacun des trucs à jarter.
Quand on a un peu tout fait, un ptit <samp>knotc zone-diff lord.re.</samp> et si c'est bon on lance <samp>knotc zone-commit lord.re.</samp> et c'est tout bon.

Bref, j'ai refoutu des enregrstrements TLSA kivontbien pour mes mails.

----------
Et voilà fin du weekend :-/
