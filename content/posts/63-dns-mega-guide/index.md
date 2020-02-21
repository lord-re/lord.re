+++
Author = "Lord"
Categories = ["dns","réseau","adminsys","knot","dane","dnssec"]
Description = "Le guide ultime concernant le DNS. On y voit comment monter le bousin, comment le tenir à jour, comment avoir un truc moderne. Gérer le DNSSEC. Faire du DANE. "
date = "2017-10-27T13:05:06+02:00"
PublishDate = "2017-10-27T13:05:06+02:00"
lastedit = "2018-10-12T17:23:07+02:00"
menu = "main"
notoc = false
title = "Guide ultime du serveur DNS v1"
jdh = "https://www.journalduhacker.net/s/38cipq/guide_ultime_du_serveur_dns_v1"
TopWords = [  "ssh", "sshfp", "registrar", "clé", "dnssec", "knot", "dns"]
+++
Bon bon ces derniers temps je trifouille pas mal mon DNS. Pour les deux du fond qui viennent de se réveiller le DNS c'est l'annuaire de référence de l'Internet. Mais en fait c'est très réducteur de dire ça. En vrai le DNS c'est un système de base de données qui peut faire tout un tas de truc et pas uniquement convertir des noms en adresse IP. Allez, c'est parti pour le DNS Méga Guide 2017 !
<!--more-->

Bon il y aura quelques redites de précédents articles sur le sujet mais le but ici est d'aborder à peu près tout histoire d'être exhaustif.

## D'où ça vient ?
Historiquement lorsqu'on voulait contacter une machine sur le réseau Internet, il fallait connaitre son adresse. Le nombre de machine du réseau grandissant, un fichier texte était échangé pour trouver les autres machines du réseau. C'était très manuel mais peu efficace. Et là : PAF le DNS. Bref une base de donnée distribuée/répliquée/déleguée mondiale.

Le DNS est un arbre qui fonctionne par délégation. Typiquement ***www.lord.re*** devrait en vrai se dire ***www.lord.re.*** (remarquez le point à la fin). C'est un chemin qui se lit de droite à gauche.

- Donc on a la racine ***.*** tout à droite, c'est geré par l'**ICANN**.
- Ensuite ***.re*** qui est le TLD (Top Level Domain, aussi apellé extension d'un nom de domaine), c'est non plus geré par l'ICANN mais délegué à l'**AFNIC** (qui gère les domaines français dont le .re qui est le domaine de la Réunion).
- Puis on trouve ***.lord*** qui n'est plus geré par l'AFNIC mais par **moi** (car je le loue auprès d'un registrar).
- Et pour finir ***www*** qui pointe vers le serveur que je gère également, mais j'aurai pu le délégué à quelqu'un.

Bon maintenant on va aller beaucoup plus loin par la pratique. On va donc monter un serveur DNS faisant autorité sur votre nom de domaine.

## Se prendre un nom de domaine et lancer son serveur

Bon déjà on achète pas un nom de domaine, mais on le loue pour un à dix ans auprès d'un registrar (revendeur autorisé). La plupart des registrars proposent d'héberger le service DNS chez eux mais franchement… on préfère le faire soit-même !

Auprès de votre registrar vous aurez donc à remplir les **Glue Records**. C'est ce qui lie votre serveur DNS à votre domaine auprès du niveau supérieur. En gros c'est ce qui va permettre aux gens de contacter votre serveur DNS. Donc il va falloir indiquer le nom du serveur DNS ayant autorité sur la zone ainsi que son adresse IP. Une fois fait vous n'aurez quasiment plus rien à faire auprès de votre registrar. Dans mon cas le serveur DNS est *zapp.lord.re* qui a pour IP : *62.210.201.160* .

Bon maintenant installer son serveur DNS… Débrouillez-vous. Dans mon cas j'ai non pas choisis le vénérable Bind mais le brave **Knot** que je trouve bien plus sympa. Il vous simplifiera la vie au niveau de la configuration et gère **DNSSEC** tout seul comme un grand. Knot est fait par les gens de *Nic.cz* qui gèrent donc les noms de domaine tchèques .cz . Ce sont les mêmes gens qui ont fait le logiciel **Bird** qui est un logiciel de routage libre. Ils ont aussi fait les **Turris** dont l'[Omnia](https://lord.re/posts/44-turris-omnia/) qui est mon routeur actuel. Ce sont des fanas du réseau et de l'Opensource. Des gens biens. Ils poussent à fond la démocratisation de **DNSSEC** car ils ont fait des extensions pour les navigateurs afin de vérifier le [**DANE**](#tlsa) des sites que vous consultez.

## Confer Knot DNS
Bon déjà on l'installe et ensuite on créer le fichier de conf. Il est ultra simple et logique je vous le mets dans sa quasi-intégralité ici :

	server:
	    user: knot:knot
	    listen: [ "0.0.0.0@53", "::@53" ]
	log:
	  - target: /var/log/knot.log
	    any : info
	acl:
	  - id: acl_localupdate
	    address: 127.0.0.1
	    action: update
	control:
	    listen: knot.sock
	remote:
	  - id: localupdate
	    address: 127.0.0.1
	template:
	  - id: default
	    storage: /var/lib/knot/zones
	    acl: [ "acl_localupdate" ]
	    kasp-db: /var/lib/knot/kasp
	zone:
	  - domain: lord.re.
	    file: lord.re
	    dnssec-signing: on
	    dnssec-policy: default

Tout est bien rangé dans sa section, *acl* contient les règles d'accès (pour modifier), *template* permet d'appliquer des règlages similaires à plusieurs zones, et *zone* va contenir toutes vos zones (Thx Cpt Obvious). Bon du coup maintenant vos fichiers de zones vont devoir se fouttre dans */var/lib/knot/zones*. Knot va générer de lui même les clefs et chiffrer votre zone DNSSEC.

## Gérer la redondance
Monter un serveur DNS secondaire.

Cette partie sera ajoutée un peu plus tard ;-)

## Publication DNSKEY ou DS record chez le registrar

La seule chose qu'il vous reste à faire auprès de votre registrar va être de publier votre DS record ou la DNSKEY de la KSK chez votre registrar. Dis comme ça, c'est effrayant mais c'est pas bien compliqué. Cette opération permet de terminer la chaîne de confiance nécessaire à DNSSEC. Selon les registrar il va vous falloir soit le DS soit le DNSKEY complet.

- Pour obtenir le ***DS*** : **keymgr lord.re list** vous listera toutes les clés actives. Il faut repérer la ***KSK*** et noter son ***tag***. Et maintenant **keymgr lord.re ds 42754** (42754 étant le tag vu à la commande précédente). Et là vous devriez voir trois enregistrements. Votre registrar vous en demandera un, il s'agit en fait de la même chose mais selon trois méthode de hash différent et là, plus c'est long meilleur c'est pour votre sécurité.

- Pour obtenir le ***DNSKEY*** un simple **keymgr lord.re dnskey 42754** et voilà.

Vous devrez réiterer cette opération à chaque renouvellement de la KSK (à faire manuellement une fois tous les deux ans voir une fois par an). En gros DNSSEC s'appuie sur deux types de clés : la ***ZSK*** qui signe votre zone. Celle-ci a une taille relativement faible. Du coup on la change constamment (une fois par mois par défaut). Mais du coup pour pas se faire chier à la transmettre au registrar chaque mois, on utilise une autre clé, la ***KSK***. La KSK signe la ZSK. Et on publie uniquement la KSK au registrar. Celle-ci est plus longue et est changée beaucoup moins fréquemment.

À partir de maintenant vous n'entendrez parler de votre registrar que pour renouveller votre nom de domaine avant son expiration :-).

## Que mettre dans sa zone ?

On peut mettre tout un tas de truc, commençons par l'indispensable :

- ***SOA*** : Le Start of Authority est indispensable puisque c'est lui qui défini qui est le maître de la zone, le mail de contact et les valeurs d'expiration. Dans mon exemple :

		lord.re.          3600    IN      SOA     zapp.lord.re. lord.lord.re. 2015033233 3600 7200 3600 180

Donc le serveur master (ayant autorité) est *zapp.lord.re.*, le mail de contact est *lord.lord.re.* (remarquez la syntaxe étrange car l'arobase est remplacée par un point (il y a surement moyen d'avoir des adresse mail non parseable)). Vient ensuite le serial *2015033233* qui doit être incrémenté à chaque modification (vous oublierez et aurez des surprises) et les valeurs d'expirations.

- ***MX*** : Le Mail eXchange indique le(s) serveur(s) de réception des emails. On peut en mettre plusieurs et indiquer des priorités c'est pas mal. Vous pouvez bien entendu faire pointer ça vers d'autres domaines que le votre (héberger vos mails sur mx.truc.machin et pas forcément dans votre zone).

		lord.re.                2600    IN      MX      10 zapp.lord.re.

	Là on voit que le serveur de mail est sur *zapp.lord.re* et qu'il a la priorité *10*.

- ***NS*** : Le Name Server indique les serveurs DNS ayant autorité sur la zone. Généralement on pointe vers un nom de machine et faut que ce nom de machine ait un enregistrement A valide (l'ouroboros, m'voyez).

		lord.re.                3600    IN      NS      zapp.lord.re.

	Le nameserver de ma zone est aussi *zapp.lord.re.*

- ***A*** et ***AAAA*** : Il s'agit de l'enregistrement le plus classique. Vous liez un nom de machine à une adresse IPv4 (A) ou IPv6 (AAAA).

		lord.re.                600     IN      A       92.167.84.9

	Et enfin on voit que *lord.re.* pointe vers l'ip *92.167.84.9*.

Bon généralement on se contente de ça je verrai les enregistrements plus exotiques plus loin.

## Modifier sa zone

Il existe trois façon de modifier sa zone DNS.

1. La première est la moins élégante : éditer le fichier de zone et dire à Knot de recharger la zone depuis le fichier. Franchement pas terrible. En plus faut bien penser à incrémenter le serial. Je vous le recommande surtout pas.

2. La seconde est celle que j'utilisais pendant longtemps et que j'ai [déjà décrit en Mars 2015](http://lord.re/posts/38-update-dns) qui consiste à utiliser **nsupdate** (ou sa version made in knot, **knsupdate**). C'est bien, la syntaxe est pas trop affreuse mais franchement je m'en souviens jamais, je me retape mon article à chaque fois ou presque.

3. La dernière est plus récente et passe directement par **knotc** pour faire faire les modifs de la zone.


### 1 : Édition à la barbare

On ouvre le fichier */var/lib/knot/zones/lord.re*. On fait les modifs en faisant gaffe à la syntaxe, on _incrémente le serial_. On teste la syntaxe de la zone avec **knotc zone-check lord.re** et enfin on recharge avec **knotc zone-reload lord.re**. Voilà voilà.

### 2 : (k)nsupdate à l'interactive

On lance **knsupdate** ce qui va vous ouvrir un shell interactif.

		server 127.0.0.1 (ouai on pourrait l'utiliser à distance avec un peu de crypto)
		zone lord.re.
		update add|del lechamps 600 A 1.2.3.4 (selon si on veut ajouter ou supprimmer)
		send

Et voilà. C'est assez simple. On peut foutre les commandes dans un fichier texte à donner à manger à nsupdate également. Ça permet de scripter le truc même si la troisième méthode est meilleure pour scripter.

Et si vous voulez le faire à distance il va falloir d'abord sécuriser le truc :

  - 1) Créer une clé pour authentifier
  - 2) Renseigner cette clé dans la conf
  - 3) Donner les droits à cette clé de modifier la zone
  - 4) Utiliser cette clé à distance
  - 5) Profit

Voilà le détail des étapes:

  - 1) **<samp>keymgr -t nom-de-la-clé</samp>**
  - 2) À mettre dans votre */etc/knot/knot.conf*
{{< highlight yaml >}}  
	key:
  - id: nom-de-la-clé
    algorithm: hmac-sha384
    secret: euisrneuisrnesuinesunresuirnesiaunesiaurentauisretauisr
{{< / highlight >}}

  - 3) On donne le droit à cette clé de modifier votre zone :
{{< highlight yaml >}}  
  acl:
  - id: update-via-ma-cle
    key: nom-de-la-clé
    action: update
	zone:
  - domaine: lord.re.
    …
    acl: update-via-ma-cle
{{< / highlight >}}

  - 4) **<samp>nsupdate -y hmac-sha384:nom-de-la-clé:euisrneuisrnesuinesunresuirnesiaunesiaurentauisretauisr</samp>**
  - 5) Voilà voilà

### 3 : knotc à l'authentique

Tout va se faire via la commande spéciale knot :

		knotc zone-begin lord.re
		knotc zone-(un)set lord.re. truc.lord.re. 600 A 1.2.3.4 (que vous pouvez répéter autant de fois que le voulez)
		knotc zone-diff lord.re. (c'est optionnel mais ça permet d'avoir un résumé des modifs qui seront appliquées)
		knotc zone-commit lord.re.

et voilà c'est pris directement en compte.

## Comment questionner le DNS ?

Bon l'outil pour envoyer des requêtes et lire les réponses DNS le plus sympa est ***dig*** (ou kdig pour la version made in knot). Donc un ptit **dig lord.re** vous sortira :

	; <<>> DiG 9.11.2 <<>> lord.re
	;; global options: +cmd
	;; Got answer:
	;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 13708
	;; flags: qr rd ra; QUERY: 1, ANSWER: 1, AUTHORITY: 0, ADDITIONAL: 1
	;; OPT PSEUDOSECTION:
	; EDNS: version: 0, flags:; udp: 4096
	;; QUESTION SECTION:
	;lord.re.                       IN      A
	;; ANSWER SECTION:
	lord.re.                600     IN      A       92.167.84.9
	;; Query time: 13 msec
	;; SERVER: 10.0.0.254#53(10.0.0.254)
	;; WHEN: Wed Oct 11 19:03:54 CEST 2017
	;; MSG SIZE  rcvd: 52

Bon ça raconte quoi tout ça ? Les trucs importants sont le ***status: NOERROR*** qui vous indique dans ce cas que c'est bon. Vous trouverez souvent du ***NXDOMAIN*** qui veut dire Non eXistant Domain, bref ça n'existe pas (l'erreur 404 http quoi) et également le ***SERVFAIL*** qui indique un souci du serveur.

Ensuite les flags sont sympa surtout le ***ad*** qui indique que la chaîne DNSSEC est valide.

On trouve ensuite la ***QUESTION SECTION*** qui montre quelle était votre requête et la ***ANSWER SECTION*** qui est la réponse obtenue. On voit ensuite le temps qu'a mis la réponse à arriver ainsi que le serveur consulté.

Vous pouvez indiquer quel serveur utiliser en ajoutant ***@8.8.8.8*** par exemple. Vous pouvez également demander un autre type d'enregistrement en le spécifiant et vous pouvez également demander une réponse validée par DNSSEC. exemple : **dig lord.re @8.8.8.8 +dnssec MX** ou **dig @8.8.8.8 +dnssec lord.re MX** (c'est plus logique dans cet ordre je trouve).

Avec ça vous couvrez la majeure partie des utilisations.

## Les utilisations moins conventionelles
Traditionnellement on utilise donc plus souvent le DNS comme un simple annuaire pour traduire des noms en adresse IP. Mais on peut également se servir du DNS pour d'autres choses.

Un usage assez courant est le système de DNSBL : DNS Black List. C'est un système qui consiste à créer une liste noire de machines. C'est très utilisé dans les systèmes antispam. En gros on consulte un serveur DNS spécifique, en lui demandant *quel est l'adresse de machine.qui.spamme.com ?* et il répond avec une adresse IP de la forme ***127.a.b.c*** avec *a*, *b* et *c* qui correspondent à des valeurs prédéfinies. Si c'est différent de 0 il y a des chances que ce soit du spammeur. C'est un système au final très basique mais rapide et très léger à implémenter.

Voyons plutôt voir comment _nous_ on peut s'en servir. Petit à petit on a rajouté pas mal de nouveaux types d'enregistrements dans le DNS dont certains vraiment très utiles voir indispensables.

## Les enregistrements concernant SSH : SSHFP

Lorsque vous vous connectez à un serveur ***SSH***, il envoie son empreinte lors de la connexion. Cela vous permet de vous assurer que vous vous connectez à la bonne machine : si l'empreinte a changé par rapport à une session précédente votre client SSH va vous l'afficher. Le souci est donc lors de la première connexion : *Comment être sûr que la première connexion est sûre ?* Et bien en publiant l'empreinte dans votre zone DNS par exemple ?

L'empreinte SSH de votre serveur peut donc être collée dans un enregistrement ***SSHFP***. Pour la générer, sur le serveur SSH lancez la commande **ssh-keygen -r lord.re**.

	lord.re IN SSHFP 1 1 1516af909e7de59af0e4b7cbaefb81c5ddf36b70
	lord.re IN SSHFP 1 2 f144fd71beb47a02cc904e305cc35c6ffe034e67b92aa54d1e382c1c1900a104
	lord.re IN SSHFP 2 1 83664295d1e46c80cc3ba7865294cbd1649f6350
	lord.re IN SSHFP 2 2 c1c1de2b19e6d4e451a9057a3ccc40a53ca29b69c7e2dd006ff4e8884c062ee6
	lord.re IN SSHFP 3 1 1929f7d32788a5884d862d2c28a226c73fd62944
	lord.re IN SSHFP 3 2 990dfb4b2f3486fb6bf5e5e5a3dd02344da6f42ce5b02992385dfbde30c5d24d
	lord.re IN SSHFP 4 1 493848772bcb5b6225424e58e5274984d825f01a
	lord.re IN SSHFP 4 2 335d5e9ec2d901b7ffd693fe614f73e4ad0afa40c72d9867dadfd155016c0029

Vous obtiendrez les enregistrements tout bien formatté à coller dans votre zone. Maintenant il est conseillé de dire à votre client SSH de vérifier la présence de SSHFP, donc dans */etc/ssh/ssh_config* ajoutez l'option ***VerifyHostKeyDns yes*** (ou ask). Voilà un bon moyen simple d'améliorer un chouilla la sécurité de SSH. Faites le pour tous vos serveurs SSH.

## Les enregistrements concernant TLS : CAA et TLSA

Là on double le nombre de champs utiles !

### CAA

[Comme vu il y a peu](https://lord.re/posts/61-dns-caa/), les enregistrements ***CAA*** permettent d'empêcher la signature de certificats pour votre domaine par une autre ***CA*** que celle que vous voulez. Je le considère comme indispensable désormais. Il ne vous protègera pas d'attaque étatique (qui ont les moyens de forcer une CA à outrepasser ça) cependant pour tout ce qui est plus classique c'est une excellente défense. Bref, trois entrées dans votre zone :

	lord.re.                600     IN      CAA     0 iodef "mailto:lord-x509@lord.re"
	lord.re.                600     IN      CAA     0 issue "letsencrypt.org"
	lord.re.                600     IN      CAA     0 issuewild "letsencrypt.org"

La première ligne indique un mail à contacter en cas de comportement suspicieux. La seconde indique quelle CA est autorisée à signer des certs classiques alors que la troisième quelle CA est autorisée à signer des certificats de type wildcard (les certificats qui fonctionnent pour tous les sous-domaines).

### TLSA

Pour ***TLSA*** c'est un poil plus complexe. Il s'agit d'une des applications de la norme ***DANE*** (ou DNS Authentication of Named Entities) qui consiste à publier le certificat (ou son hash) d'un service utilisant TLS. En gros DANE pourrait permettre de se passer des CA en plaçant la confiance non plus dans un tier mais dans le DNS. Malheureusement c'est implémenté à peu près nulle part. Cependant on peut conjuguer les CA et TLSA pour accroitre la sécurité. Donc on créer un certificat, on le fait signer par une CA et on le publie dans sa zone DNS. On peut donc l'appliquer à n'importe quel service utilisant TLS : http, smtp, imap, irc, … bref à peu près tout.

Bon là on va pas se faire chier, on va faire comme tout le monde et utiliser [le générateur que tout le monde utilise](https://www.huque.com/bin/gen_tlsa).

- Donc là vous entrez les différents champs (3/1/1)
- Vous collez le certificat (pas la clé privée !)
- le numéro de port du service en question (443 pour https par exemple)
- le protocole utilisé (tcp pour https)
- le nom de domaine concerné par le certificat (www.lord.re par exemple ou juste lord.re)

Et pouf le bouton *generate* vous filera la jolie ligne à ajouter à votre zone. À noter que pour être conforme à DANE, il faut impérativement que votre zone soit validée via DNSSEC (c'est pas mon cas pour lord.re, pour une sombre histoire de registrar qui veux toujours pas accepter le DS record, bref -___- ).

## Les enregistrements concernant les mails : SPF, DKIM, DMARC, STS et OPENPGPKEY

Ici c'est la folie. Le mail étant un des plus vieux protocoles d'Internet, il y a pas mal de trucs qui s'y sont greffés pour combattre le spam et aussi améliorer l'authenticité des mails. Commençons gentiement.

### SPF

C'est le plus simple de la bande. Celui-là spécifie quelles sont les machines/ip qui sont autorisées à envoyer des mails en provenance de votre domaine. En théorie si vous avez une configuration classique, les seules machines qui enverront du mail en provenance de votre domaines seront les machines déclarées en MX.

Il existe un champ de type ***SPF*** mais il est [consideré obsolète](https://tools.ietf.org/html/rfc7208) (dommage), il faut placer ça dans un champs TXT.

	lord.re.				600	IN	TXT	"v=spf1 mx -all"

Ça veut dire les MX sont autorisés et tout le reste doit être jeté (le boulot de l'antispam). Rien d'autre à faire pour ça.

### DKIM
Le ***Domain Keys Identified Mail*** est un système de signatures cryptographiques qui va signer le mail et ses entêtes. Les serveurs SMTP traitant le mail vont donc devoir vérifier que ça coïncide avec la clé publiée dans le DNS. En gros ça empêche que le message et ses entêtes soient modifiés et cela atteste que c'est bien votre serveur qui sont à l'origine de ce mail.

Ce coup-ci il va falloir configurer votre pile mail pour qu'elle signe vos mails. Je vous laisse vous débrouiller pour ça (hors scope de cet article, mais sachez que rspamd sait très bien faire cela). Bref vous allez donc avoir une clé publique que vous allez publier dans un TXT avec cette allure :

	default._domainkey.lord.re.     3600    IN      TXT     "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC06MC2/9/YtSn9BS09oMN26UdKO6DMGlCWYsodQ8P+t2CzsSzqUJxaszJmWZglqZyXRjaCMAFUoOF7GiyhXhqM4rSLGxaPHfrLK7f9YlJYAnqdhzEJdEjP8/vkJoMTJxINP9gEBi+wGSGEhoha514NHHtZ4g+QbJZliahwAjl0BQIDAQAB"

Donc les serveurs mails qui recevront vos mails avec les entêtes DKIM vérifieront votre champ DNS qui va bien pour vérifier que c'est ok. Mais rien n'indique ce qu'ils doivent faire si ça ne correspond pas.

### DMARC
Ha bha le voilà le truc qui va indiquer aux autres serveurs que faire de vos mails si le SPF et/ou le DKIM déconne. ***DMARC*** est donc complémentaire aux deux précédents. C'est encore un enregistrement de type TXT qui a cette gueule

	_dmarc.lord.re.    600 IN TXT "v=DMARC1;p=none;pct=100;rua=mailto:lord-dmarc@lord.re;ruf=mailto:lord-dmarc@lord.re;sp=none;adkim=s;aspf=s"

C'est plutôt explicite :

- le ***p=none*** indique la politique que doivent adopter les autres serveurs vis-à-vis de vos mails. Avec ***none***, c'est indifférent. Si vous êtes absolument sûr de vos règlages vous pouvez mettre ***quarantine*** voir ***reject*** pour que ça soit carrément rejeté.
- Le ***rua*** et ***ruf*** vous permet d'être contacté par les serveurs mails pour recevoir des rapports
- Et enfin ***adkim=s*** et ***aspf=s*** indique que vous voulez une vérif stricte du spf et dkim, c'est-à-dire que le nom doit être parfaitement le même (le mode r pour ***relaxed*** permet d'émettre depuis un sous-domaine contrairement au ***strict***).

Mon conseil c'est de commencer pépère avec une politique à none et si dans six mois vous avez pas de soucis, de monter d'un cran en passant à quarantine et pourquoi pas plus tard à reject. Si c'est pas bon, vous risqueriez de vous tirer une balle dans le panard !

### STS
Celui-là c'est un ptit nouveau. Il est pas encore vraiment sorti de l'œuf à vrai dire, mais il est prometteur mais un peu chiant à mettre en place car il dépend du DNS mais aussi d'un serveur web… Ouai il va falloir mettre du json dans *.well-known* de votre serveur web. C'est pour ça que je l'ai pas encore mis en place mais je pense le faire à terme.

Donc en gros celui-là permet de spécifier comment doivent réagir les serveurs mails se connectant aux votres concernant la crypto : vous pouvez exiger de refuser la connexion si ce n'est pas chiffré. C'est donc vraiment très intéressant d'un point de vue protection de la vie privée de vos mails.

Ça a cette allure ```_mta-sts.lord.re.  IN TXT "v=STSv1; id=20160831085700Z;"```. En gros ça donne un numéro de politique à suivre. Ensuite il faudra aller piocher dans le json à quoi correspond la politique correspondant à cet id. À mon avis ça aurait pu tenir dans le DNS toussa mais bon…

### OPENPGPKEY
Celui-là non plus je ne l'utilise pas (en fait je ne chiffre pas du tout mes mails). Mais il permet de publier sa clé publique dans sa zone DNS. C'est un peu mieux que d'utiliser un serveur de clé publique. N'utilisant pas le truc j'approfondierai pas plus mais il existe [ce générateur](https://www.huque.com/bin/openpgpkey).

### Conclusion des mails
Pour résumer on se protège du spoof grâce à DKIM et SPF. On s'assure de l'intégrité de ses mails via DKIM et DMARC. On s'assure(ra) que personne ne puisse lire les mails grâce à STS (en dehors des serveurs émission/réception) et on s'assure même que les serveurs eux-mêmes ne puissent lire le contenu grâce à PGP. Voilà notre stack mail est blindée.

## Conclusion globale ?
Ouai vite fait une ptite conclusion. Le DNS contient des données qui sont publiques mais dont l'authenticité est de plus en plus critique. Modifier des requêtes DNS (enfin les réponses) à la volée pour modifier une clé PGP ou SSHFP ça pourrait avoir des conséquences assez désastreuses. C'est pour ça qu'il est indispensable de déployer ***DNSSEC*** sur votre domaine. Avec knot c'est vraiment simple. D'ailleurs est-ce que votre résolveur DNS actuel valide DNSSEC ?

## Liens utiles :
- [Générateur d'enregistrement OPENPGPKEY](https://www.huque.com/bin/openpgpkey)
- [TLSA generator](https://www.huque.com/bin/gen_tlsa)
- [TLSA check](https://www.huque.com/bin/danecheck)
- [DNSSEC check](http://dnssec-debugger.verisignlabs.com)
- [Documentation de Knot](https://www.knot-dns.cz/documentation/)
- [RFC mta-sts](https://www.ietf.org/id/draft-ietf-uta-mta-sts-10.txt)
