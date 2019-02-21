+++
Author = "Lord"
Description = "Après le SPF, le DKIM, le DMARC, le MTA-STS, voilà le TLS-RPT. On est vraiment en dèche de consonne dans les technos mails mais bon on améliore notre sécurité."
Categories = ["mail", "tls", "dns" ]
menu = "main"
notoc = true
PublishDate = 2019-02-21T17:36:50+01:00
date = 2019-02-21T17:36:50+01:00
title = "TLS RePorTing sur votre serveur mail"
editor = "kakoune"
+++
Hey, je suis tombé sur une RFC assez récente l'autre soir.
La [8460 de septembre 2018](https://tools.ietf.org/html/rfc8460) qui permet de rajouter encore un ptit truc à votre stack mail.

## TLS Reporting
Lorsque votre serveur de mail échange avec d'autres serveurs de mail, il y a de forte chance qu'il tente de sécuriser ses communications.
Si c'est pas le cas, vous feriez mieux d'arrêter de lire cet article et de moderniser votre serveur de mail !

Bref, contrairement au web, les serveurs mails sont bien moins à la pointe de la crypto moderne.
Restreindre votre serveur mail à du TLS1.2 va vous isoler de beaucoup de monde malheureusement.
On est obligé de se taper de la vieille crypto pour pouvoir être compatible avec le reste du monde.

Mais bon, ça évolue quand même dans le bon sens petit à petit.
Et d'ailleurs cette RFC tente de pousser un peu plus en ajoutant du reporting.

Vous avez probablement mis en place **DMARC** (c'est à mettre en place en priorité) qui consiste à rajouter un *enregistrement DNS de type TXT* où vous indiquez aux autres serveurs mails comment traiter les mails en votre provenance.
Et bien là on rajoute un autre enregistement DNS de type TXT où vous indiquez une adresse mail pour recevoir des rapports d'erreurs concernant TLS.

Quand un serveur mail aura un souci de connexion TLS avec votre serveur mail, il vous enverra un mail (qui ignorra les erreurs TLS, sera signé via DKIM une fois par jour maximum) détaillant pourquoi ça a déconné.

  - Pourquoi est-ce que la négociation TLS a échouée ?
  - Est-ce que le certif est reconnu ?
  - Est-ce que le certif est expiré ?
  - …

Bref, vous saurez un peu mieux pourquoi votre conf TLS déconne.

Bon c'est vraiment très récent et donc quasiment pas déployé mais c'est ultra simple à mettre en place et ça bouffe rien.

## Mise en place

Allez on se fout sur le serveur DNS et on ajoute un champ *TXT* de la forme *_smtp._tls.votre.domaine. TXT "v=TLSRPTv1; rua=mailto:votre@mail.truc"* .
Si le rapport par mail vous saoule, vous pouvez opter par du web en *POST* avec *_smtp._tls.votre.domaine. TXT "v=TLSRPTv1; rua=https://votre.page/web"*

Bon perso, par mail ça me va bien.

Pour le faire c'est avec :

**<samp>knsupdate</samp>**

    server 127.0.0.1
    zone lord.re.
    update add _smtp._tls.lord.re. TXT "v=TLSRPTv1; rua=mailto:gradabuk@lord.re"
    send
    quit

Et voilà, vous êtes à la pointe vous aussi !

Il me tarde de recevoir un de ces mails pour voir :-D
