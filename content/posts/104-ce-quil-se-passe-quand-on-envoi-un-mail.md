+++
Author = "Lord"
Description = "Après ce qu'il se passe quand on ouvre une page web, ce qu'il se passe quand on envoie un mail !"
Categories = ["internet", "vulgarisation", "mail", "réseau"]
menu = "main"
notoc = true
PublishDate = 2018-05-23T12:07:11+02:00
date = 2018-05-29T12:07:11+02:00
lastEdit = 2018-06-04T23:09:17+02:00
title = "Ce qu'il se passe quand on envoie un mail"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/yuyuhb/ce_quil_se_passe_quand_on_envoi_un_mail"
+++
On m'a soufflotté dans l'oreille que ce sujet pourrait être intéressant.
Et effectivement ça l'est.
Enfin… si on s'y intéresse…
Bref…

Quelles sont les étapes qui se passent, par où va transiter les données.
Voyons tout ça.

Pour l'exemple, je vais aborder le cas suivant :

**Un mail envoyé depuis un client mail type thunderbird via mon serveur auto-hébergé vers un utilisateur gmail.**

## 1 - Rédaction du mail
La partie la plus normale consiste donc à rédiger le texte de votre email.
Il s'agit des données à proprement parlé.

C'est un *simple texte* ce qu'il y a de plus basique ou bien du *texte au format HTML*.
Dès lors que vous ajoutez du formattage à votre texte (du gras/italique/couleur/taille de police/…) c'est du HTML.
De lui même, l'éditeur de texte va donc transformer votre texte vers le format HTML pour apporter toutes ces subtilités.
Votre destinataire va donc de voir "interprêter" ce texte HTML pour l'afficher avec parfois des résultats différents selon le logiciel.

Au passage, lorsqu'on rédige un mail en HTML contenant des images, celles-ci ne sont pas incluent à proprement parlé il ne s'agit que de liens.
Votre lecteur de mail va suivre ces liens pour au moment de la lecture pour vous afficher les images..
C'est un moyen de voir si les mails sont consultés ou non et d'éventuellement vous profiler (en envoyant une adresse unique à chaque mail).
*Il est donc préferrable de désactiver l'affichage automatique des images dans les mails.*

## 2 - Ajout des pièces jointes
Étape que l'on réalise généralement lors d'un second mail de type “Oups voilà les pièces-jointes oubliées précédemment”.

**Le mail est un protocole de type texte.**
Cela veux dire que toutes les informations transportées le sont sous forme de texte, aussi bien les métadonnées que les données.
Il faut donc transformer votre fichier en texte avec le [codage base64](https://fr.wikipedia.org/wiki/Base64) qui consiste en 64 caractères alphabetiques permettant de coder n'importe quelles données.

Cependant, c'est loin d'être optimisé :

    cat 99-ce-quil-se-passe-quand-on-ouvre-une-page-web.md| base64 | wc -c
    23939
    cat 99-ce-quil-se-passe-quand-on-ouvre-une-page-web.md| wc -c
    17720

*Un même fichier une fois passé en base64 est près d'un tier plus lourd que l'original.*
Cela explique pourquoi certaines fois des fichiers juste en dessous de la limite de taille maximale ne passent pas.

## 3 - Ajout des méta-données utilisateurs
Bon votre mail contient votre texte et d'éventuelles pièces-jointes, c'est chouette mais ça va pas aller bien loin.
Il faut donc un destinataire, voir plusieurs destinataires cachés ou non.
Vous allez aussi mettre un sujet à votre mail.
Et dans certains cas indiquer quelle est l'adresse d'envoi (si vous en avez plusieurs) et/ou de retour.

*Ce sont les méta-données que vous entrez manuellement.*

Mais ce ne sont qu'une partie des méta-données du mail puisque votre logiciel va en rajouter ainsi que les différents serveurs qui traiteront votre mail.

## 4 - Connexion vers le serveur d'émission
Bon bha ça y est vous avez cliqué sur le bouton d'envoi et du coup votre logiciel va commencer à parler à une autre machine !

Votre client mail est appelé un **MUA** pour *Mail User Agent* dont le boulot est de converser avec un **MTA** pour *Mail Transfert Agent* qui lui est chargé de réellement envoyer/recevoir des mails.
Votre client mail donne tout simplement le mail fraîchement préparé au serveur SMTP qui lui a été configuré, en parlant le protocole **SMTP** (certains logiciels apellent ça serveur d'envoi).

Le protocole SMTP est également un protocole texte assez ancien (plus ancien que le web) mais a connu quelques évolutions comme notamment l'authentification et le chiffrement).
Historiquement le port utilisé était le 25 mais c'est généralement le port 587 qui est désormais utilisé dans le cas d'envoi de mail.
*À l'usage il s'est créé une distinction entre l'envoi de mail et la réception.*

Un serveur de mail n'avait pas de notion d'envoi de mail mais juste de transfert, en gros il reçoit un mail sur le port 25 sans savoir si ce mail provient d'un autre serveur de mail ou s'il provient d'un logiciel d'envoi de mail.
Avec le temps on a rajouté de l'authentification pour l'envoi de mail ce qui nécessite un traitement différent et donc un port différent.

À noter que certains FAI bloquent les connexions vers le port 25 aussi bien dans un sens que dans l'autre, à des fins de luttes contre le spam.
Ce blocage est dans le meilleur des cas débrayable et parfois non, ce qui vous empêche d'utiliser un serveur mail autre que celui de votre FAI.

Dans notre exemple, thunderbird se connecte donc à notre serveur de mail auto-hébergé (dans mon salon, donc sans requête DNS).

### 4.1 - Connexion TCP vers le serveur d'émission
Mon serveur est configuré de sorte qu'un mail émis depuis une de mes adresses perso ne peut se faire que s'il y a authentification.
Il faut donc se connecter au port dit de *soumission* (puisque on y soumet notre mail) c'est à dire le port TCP 587.

Pour l'instant c'est donc dans mon réseau local.
Je ne part pas tout de suite sur le réseau des réseaux.
Il s'agit d'une connexion TCP classique en trois parties : *“Connexion ?”*, *“Ok tu peux te connecter.”*, *“Merci, on est connectés.”*.

### 4.2 - Chiffrement de la connexion
Même s'il s'agit d'une connexion sur mon réseau locale, vu qu'il y aura authentification, je préferre chiffrer la connexion.
Déjà parceque ça ne mange pas de pain et ensuite ça permet d'avoir la même chose aussi bien en local qu'en distant via un réseau non sûr.

**D'ailleurs de manière globale, ne considérez aucun réseau comme sûr, une machine vérolée volontairement ou non est si vite arrivée…**

### 4.3 - Auth
Bon la connexion est désormais sûre, il ne reste plus qu'à Thunderbird de vous identifier via les identifiants/mot de passe configurés.
Cette étape permet au serveur d'émission de n'accepter des mails en votre nom que si les identifiants sont bons pour éviter l'envoi de spam dans votre dos.

Si l'une des deux étapes précédentes échoue, votre serveur vous enverra probablement bouler sans ménagement et coupera la connexion TCP ce qui vous gratifiera d'un joli message d'erreur dans votre Thunderbird.

## 5 - Vérifs de base antispam avant émission
Internet c'est la jungle et je pense que vous connaissez tous à peu près l'ampleur du spam.
Bref tout le monde tente de s'en protéger le plus possible.
Ne pas recevoir de spam c'est bien, ne pas en envoyer soi même c'est mieux !
Si votre serveur a la malheur d'en envoyer vous serez très vite blacklisté de partout il vous faut donc vous protéger pour ne pas finir en tant qu'*Open relay*.

Bon déjà on s'est authentifié, c'est le minimum syndical.

Ensuite il existe tout plein de petits réglages sur le serveur afin de limiter les possibles fuites.
Ce sont principalement des ptites restrictions sur les adresses IP autorisées à se connecter ou bien quels domaines sont autorisés à envoyer du mail…
Bref rien de bien méchant, c'est du vite vu par le serveur.

Il est même possible de faire passer le mail sortant dans un antispam mais je ne l'ai pas mis en place personnelement mais sachez que c'est possible afin de vraiment s'assurer que ses utilisateurs n'envoient pas de spam.
Sur une installation conséquente c'est quasiment indispensable pour ne pas transmettre du spam à la première machine vérolée.

Dans un second temps, le mail va être signé par le serveur d'émission en fonction du domaine d'émission du mail : il s'agit du **DKIM** le *Domain Key Identified Mail*.
C'est une signature qui atteste que le mail provient bien du serveur de mail autorisé par mon nom de domaine (dans mon serveur DNS, j'ai annoncé que les mails provenant de mon domaine sont signés par telle clé).
Contrairement à GPG, cette signature vaut pour tous les mails du domaine, ils ne chiffrent pas le message et ne garantissent pas de l'identité de l'émetteur mais l'identité du nom de domaine d'émission.
Toutes les personnes utilisant le même nom de domaine pour émettre leur mail auront la même signature.

Qui plus est cette signature atteste de l'intégrité du mail : il prouve qu'à partir de votre serveur d'émission jusqu'à la lecture, le mail n'a pas été modifié. (Par contre entre le logiciel rédigeant le mail et le serveur d'envoi par contre pas de certitude mais c'est généralement un segment de confiance.)

Bref, cette signature sera placée dans l'entête du mail et sera utilisée par les serveurs intermédiaires et finaux afin de vérifier que votre mail soit bien légitime.
Elle ne sert pas directement aux utilisateurs et n'est donc que rarement montrée.
**Cette signature atteste uniquement de l'authenticité du serveur d'émission et de l'intégrité du mail à partir du serveur d'émission.**
Elle ne prouve rien concernant l'utilisateur lui même, uniquement le serveur !

Si tout se passe comme il faut, votre mail est donc consideré comme légitime par votre serveur de mail et est donc signé.
Votre serveur de mail va donc transferer ce mail au serveur du destinataire

## 6 - Trouver le serveur de destination
Bon, votre mail est donc prêt à partir, mais à partir où ?
Votre serveur de mail va donc trouver quelle machine gère les mails de votre destinataire et qui qui c'est qui doit faire ça ?
C'est *le DNS* !

Bon truc@gmail.com ça veux dire l'utilisateur truc sur le domaine gmail.com, ça devrait être plutôt simple pour le moment.
Du coup votre serveur de mail va demander aux serveurs DNS “À quelle machine je dois me connecter pour envoyer des mails pour gmail.com ?” ce qui correspond à *“Quels sont les enregistrements MX pour gmail.com ?”*

Les **MX records** sont donc les machines en chargent de la réception du mail : un ptit **dig gmail.com in MX**

    ; <<>> DiG 9.12.1 <<>> gmail.com in MX
    ;; global options: +cmd
    ;; Got answer:
    ;; ->>HEADER<<- opcode: QUERY, status: NOERROR, id: 48789
    ;; flags: qr rd ra; QUERY: 1, ANSWER: 5, AUTHORITY: 0, ADDITIONAL: 1
    ;; OPT PSEUDOSECTION:
    ; EDNS: version: 0, flags:; udp: 4096
    ;; QUESTION SECTION:
    ;gmail.com.                     IN      MX
    ;; ANSWER SECTION:
    gmail.com.              3581    IN      MX      5 gmail-smtp-in.l.google.com.
    gmail.com.              3581    IN      MX      10 alt1.gmail-smtp-in.l.google.com.
    gmail.com.              3581    IN      MX      20 alt2.gmail-smtp-in.l.google.com.
    gmail.com.              3581    IN      MX      30 alt3.gmail-smtp-in.l.google.com.
    gmail.com.              3581    IN      MX      40 alt4.gmail-smtp-in.l.google.com.
    ;; Query time: 0 msec
    ;; SERVER: 10.0.0.254#53(10.0.0.254)
    ;; WHEN: Wed May 23 15:48:51 CEST 2018
    ;; MSG SIZE  rcvd: 161

Donc là on voit que pour gmail il y a cinq réponses indiquant donc 5 machines à contacter par ordre de priorité du plus petit au plus grand.
Je vais donc devoir tenter de me connecter à *gmail-smtp-in.l.google.com.* et si cette machine ne répond pas je passe à *alt1.gmail-smtp-in.l.google.com.* et ainsi de suite.
C'est un système qui permet d'avoir plusieurs machines redondantes assez facilement (si seulement un même mécanisme était utilisé pour d'autres protocoles comme le HTTP…).

Bon c'est bien gentil mais c'est une demi réponse ça, il me faut une adresse IP, il faut donc faire une requête DNS pour connaitre l'adresse IP de *gmail-smtp-in-l.google.com.*, ce qui va me donner *74.125.133.27*.

Si jamais le domaine à qui vous tentez d'envoyer un mail ne possède pas de MX record, votre serveur tentera de se connecter directement à l'adresse IP rattaché au domaine directement.
Mais bon il faut vraiment être un très mauvais administrateur pour ne pas mettre de MX record à un serveur de mail.

Comme d'habitude on peut voir que le DNS est toujours un point sensible pour la confidentialité et que le choix d'un résolveur DNS peut avoir d'importantes conséquences pour le respect de la vie privée.

## 7 - Interconnexion des serveurs émission/réception
Allez hop, votre serveur d'émission va se connecter donc au serveur de réception pour transmettre votre mail.
Une connexion **TCP** va être établie et parfois ça sera chiffré, parfois non.
Globalement le chiffrement progresse énormément ces dernières années au point d'être quasi systématique.

Il va quand même falloir montrer patte blanche pour prouver que vous n'êtes pas un vil spammeur.

La base de la base c'est de *parler le protocole SMTP correctement*.
Certains spammeurs utilisent des logiciels pas très très respectueux du standard et se font repérer et dégager facilement.

Votre serveur va donc transferer votre mail donc avec ses méta-données et les données.
Et ensuite bha le serveur de réception fait un peu ce qu'il veut.

### 7.1 Greylisting
Une méthode très efficace de virer du spam est de faire du greylisting.
*Le serveur de réception va dire “Je suis pas dispo réessaye plus tard”.*
Et cinq minutes plus tard votre serveur d'émission va retenter et ça marchera.

La plupart des spammeurs se découragent facilement (ça leur permet de ne pas perdre de temps à retenter…) mais les mails légitimes, eux, retenteront.
Cela engendre par contre un délai de quelques minutes dans la réception des mails mais rapelez-vous : **Les mails ne garantissent absolument pas de délai de livraison !**
Avec un peu de chance ça sera dans quelques secondes mais rien dans le protocole n'empêche de le livrer quelques jours plus tard sans aucun message d'erreur ou autre.

Il me semble que cette technique n'est pas employée par Gmail mais assez courante chez les auto-hébergeurs du fait de son efficacité redoutable.

### 7.2 Différentes vérifications
Chaque serveur possède des règles différentes pour l'acceptation des mails.

Certains ne font que le strict minimum (c'est à dire vérifier que le destinataire existe bien), d'autres imposent des tailles maximales pour les mails, d'autres utilisent des systèmes de réputation…
Chacun fait sa tambouille.

Dans les grands classiques on trouve la consultation de listes noires publiques via le DNS, ce que l'on apelle les **DNSBL**.
On y vérifie que l'adresse IP de votre serveur d'envoi n'est pas présent dans cette blacklist.
C'est donc potentiellement encore un endroit potentiel de fuite d'information : votre mail n'est pas envoyé aux fournisseurs de DNSBL, juste l'ip de votre serveur, ce qui peut être couplé avec l'ip du serveur de réception faisant la requête DNS.
Le risque est minime cela-dit.

Vous obtiendrez parfois un mail de réponse de la part de *Mailer Daemon* vous indiquant pourquoi (ou pas) votre mail à été rejeté et ce mail peut prendre jusqu'à une semaine pour arriver…

## 8 - Fin de l'émission
Bon bha ça y est votre serveur d'émission a fini son boulot et donc maintenant le destin de votre mail n'est plus entre ses mains.
Votre serveur peut couper la connexion et se rendormir paisiblement.

Voyons donc ce que fait le serveur de réception désormais.

## 9 - Antispam

### 9.1 SPF
Le serveur de réception va faire la vérification du **SPF** qui permet de *s'assurer que le serveur qui a émit le mail est bien autoriser à émettre des mails*.
Pour cela, le serveur de réception va faire une requête DNS particulière qui lui donnera la liste des serveurs autorisés à émettre des mails pour votre domaine.
Si le serveur d'émission ne fait pas parti de cette liste, votre mail sera rejeté pour soupçons de spam.
Encore une fois, le DNS va être utilisé.

Il y a encore un potentiel de fuite d'information : le serveur de mail réceptionnant votre mail enverra une requête à son serveur DNS lui indiquant de vérifier quels sont les machines autorisées à envoyer du mail pour tel domaine.
Le serveur DNS peut donc deviner que votre domaine à envoyer un mail à tel autre domaine.

### 9.2 DKIM
Tout à l'heure, votre serveur a ajouté une **signature DKIM** sur votre mail et maintenant le serveur de réception va la vérifier.
Ça permet de s'assurer que le mail reçu provient bien de votre serveur de mail.
*Donc le serveur de réception regarde le mail, et vérifie que la signature correspond bien à ce qui se trouve dans l'enregistrement DNS du DKIM.*
Seul votre serveur peut créer une signature valable pour votre domaine.

En gros SPF assure que le serveur a le droit d'envoyer des mails et DKIM prouve que le mail provient bien du domaine.
C'est deux technique complémentaires permettant de limiter l'envoi de spam en votre nom.

Si en 2018 vous n'avez pas de SPF et de DKIM fonctionnel, vos mails finiront quasi-systèmatiquement dans les spams, à juste titre.
Là encore le DNS joue un grand rôle et se trouve être une potentielle fuite de données.

### 9.3 Antispam basique
Encore un peu d'antispam mais ce coup-ci ça se base non plus sur le serveur d'émission mais sur les méta-données et les données du mail lui-même.

Là *le mail va être analysé selon pleins de critères variés.*

  - Est-ce que la date d'émission est crédible ?
  - Est-ce que ça parle pas un peu trop de pognon ?
  - Est-ce que ça utilise des caractères louches ?
  - Est-ce que les entêtes correspondent bien ?
  - …

C'est aussi bien des points techniques que des points plus "humains".
À chaque réponse on obtient **un score** positif ou négatif.

### 9.4 Filtre Bayésien
Là on pousse encore un peu plus l'antispam en faisant une analyse statistique sur les mots présents dans le mail.

Si votre mail insiste un peu trop sur la longueur des membres, ou bien s'attarde un peu trop sur d'éventuels gains financiers ou tout autre sujet à la mode, le filtre Bayésien va reconnaître des *motifs récurrents* et encore une fois attribué un *score de probabilité*.

On cumule ce score à celui précédemment obtenu et à la fin on fait le compte et le résultat final détermine si c'est un spam ou non.

En fonction de ce score le mail sera soit supprimmé, soit placé dans les spams, soit aura le droit d'arriver dans la boîte du destinataire.

Ici le logiciel antispam a accès au mail complet.
~~Cela pourrai poser un soucis de confidentialité cependant ce filtre n'est pas sous-traité à ma connaissance.~~
Bon bha finalement on me signale que si certaines entreprises sont spécialisées dans l'antispam et reçoivent donc les mails en live pour les analyser et délibérer si oui ou non il s'agit d'un spam, donc c'est encore une fois une fuite potentiel pour votre mail.

## 10 - Livraison locale
Le serveur du destinataire a donc accepté le mail et effectué tous ses tests d'antispam, il faut donc maintenant transférer le mail au **LDA**, le *local delivery agent*.
Ce logiciel a pour but de ranger et stocker le mail.

Son rôle premier est donc de *trouver à qui le mail doit être livré* (il peut y avoir des alias ou des redirections par exemple).

Son second rôle ensuite est de *ranger le mail au bon endroit* en fonction de règles définies par le service mais qui peuvent également être écrites par l'utilisateur.
Par exemple le mail va être classé dans les newsletters ou bien vous avez créez une règle pour indiquer que tous les mails en provenance de tel utilisateur doivent être placés dans un dossier prédifini.

Mais n'oublions pas que le mail est à destination de Google.
Il est donc fort probable qu'en interne l'architecture de Gmail soit très complexe et ne soit pas un seul petit serveur mais bien une armada complète pour le stockage (redondant et backuppé) avec répartition de la charge pour pouvoir supporter des millions d'utilisateurs mais cette partie est trop complexe pour cet article.

Bon il y a tout de même une étape cruciale encore.

## 11 - Indexation
Le but de Google est, comme tout le monde sait, d'aider à chercher dans vos mails.
Non pas vous aider vous, mais aider les clients de Google.
*En tant que marchandise vos mails sont donc lus et analysés et un profil est établi en fonction de tous vos mails.*
Vous êtes donc placé dans différentes cases en fonction de votre courrier.

Vous êtes inscrits sur tel site, vous prenez des vacances à tel endroit, vous conversez avec telle personne, vous vous êtes abonnez à tel newsletter, vous supprimmez systèmatiquement les mails de telle origine, vous effectuez régulièrement des achats sur tel site…

En bonus toutes ces informations permettent à gmail de vous afficher rapidement les résultats de recherche dans votre montagne de mail.

Bref ce service coûte très cher mais par chance est très facilement rentabilisé par Google.

## 12 - Consultation
Bon bha maintenant votre destinataire va vouloir lire votre mail, Gmail étant un webmail avant tout, votre utilisateur va devoir ouvrir la page avec son navigateur web et se tapper [toutes les étapes classiques]({{< ref "/posts/99-ce-quil-se-passe-quand-on-ouvre-une-page-web" >}}).
Le webmail a le rôle de **MUA** ici.

Et voilà ! 
On y est arrivé.

## TL;DR

Chemin d'un mail : **MUA**→**MTA**→**MTA**→**LDA**→**MUA**
Avec dans quelques cas des risques de fuites de données de votre mail (surtout du côté des DNS et des MTA).

Si vous vous autohébergez, vous pouvez à peu près garantir les deux premières étapes pour la confidentialité de votre mail tout au mieux.
Si vous ne vous auto-hébergez pas vous ne pouvez garantir que la première étape au delà … bha … bonne chance.

**Si vous voulez mieux, il va falloir chiffrer votre mail ;-)**
