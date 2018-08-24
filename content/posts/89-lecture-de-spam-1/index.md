+++
Author = "Lord"
Description = "Tiens donc, regardons un spam que j'ai reçu. Une tentative de phishinge pour Spotify."
Categories = ["mail", "spam"]
menu = "main"
notoc = true
PublishDate = 2018-03-26T19:14:44+02:00
date = 2018-03-26T19:14:44+02:00
title = "Examen d'un spam #1"
editor = "kakoune"
+++
Il y a quelques astuces pour reconnaitre un bon vieux spam tentant de vous arnaquer de l'ivraie mail (ouai pas le meilleur jeu de mot mais je le garde tout de même).

La première chose, dès qu'un mail n'est pas en texte pur mais est plutôt joli, il faut augmenter votre niveau de méfiance.
Et ensuite *regarder les sources du mail* pour y mener l'enquête.

Prenons un cas concret

    Return-Path: <bounces+45739-c346-lord=lordtoniok.com@sendgrid.net>
    X-Original-To: lord@lordtoniok.com
    Delivered-To: lord@lordtoniok.com
    Received: from o1678974x241.outbound-mail.sendgrid.net (o1678974x241.outbound-mail.sendgrid.net [167.89.74.241])
    (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
    (No client certificate requested)
    by zapp.lord.re (Postfix) with ESMTPS id 96D0937A17AC
    for <lord@lordtoniok.com>; Sat, 24 Mar 2018 22:01:59 +0100 (CET)
    DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=sendgrid.me; 
    h=mime-version:from:to:subject:content-type:content-transfer-encoding; 
    s=smtpapi; bh=y3xMdntpEBfP51yju0Z1DtULfXs=; b=a0+PaMVc8rP3hQ5zX9
    MLkNvySebfRH1UcTSdkmPdOr6oAXMiHy0NfH//1YGwF0Vg6dvQvZaNwUJS7LXnf5
    psldtb0GZrHdmHSs7Jz+qkWnNZg9dL/VYz2WASjn5uCDHZZyNKANEqYYQnMP/KXt
    D2JU1wM0VY4RjmSjsqvgXB9Fc=
    Received: by filter0610p1las1.sendgrid.net with SMTP id filter0610p1las1-21544-5AB6BC0D-18
    2018-03-24 20:58:53.846285796 +0000 UTC
    Received: from EtracSP (unknown [52.143.141.39])
    by ismtpd0004p1lon1.sendgrid.net (SG) with ESMTP id Ji-9QvLnSl2bux_zRpgMnQ
    for <lord@lordtoniok.com>; Sat, 24 Mar 2018 20:58:53.436 +0000 (UTC)
    MIME-Version: 1.0
    From: Spotify <noreply@spotify.ca>
    To: lord@lordtoniok.com
    Date: Sat, 24 Mar 2018 20:58:54 +0000 (UTC)
    Subject: Spotify Premium : Payment Failed
    Content-Type: text/html; charset=utf-8
    Content-Transfer-Encoding: base64
    Message-ID: <Ji-9QvLnSl2bux_zRpgMnQ@ismtpd0004p1lon1.sendgrid.net>
    X-SG-EID: ujb9mvUjVs4ifSCsYYNDLtD/z0w00wdSJh87rMmMAeUcQ8j2EBJKf6fHfkeRnMl7f1dZUqrJ3idbM3
    kQxOhCAYpn6ygWZ8MkoB5use3mUgU/zHMr55D0WCPT6qRQ3EPvLFaJqZqcXZX4aE3svITjhx7V+8GJ
    h10q6h2m4GiZSAf6WciZTBJds2Qb1zao5AypaYRM2xZyDI5z49Y9m4rZLg==
    X-Rspamd-Queue-Id: 96D0937A17AC
    X-Spamd-Result: default: False [2.48 / 10.00]
    RCVD_NO_TLS_LAST(0.00)[]
    ARC_NA(0.00)[]
    MIME_HTML_ONLY(0.20)[]
    FROM_HAS_DN(0.00)[]
    FORGED_SENDER(0.30)[]
    TAGGED_FROM(0.00)[45739-c346-lord=lordtoniok.com]
    R_SPF_ALLOW(-0.20)[+ip4:167.89.0.0/17]
    FROM_NEQ_ENVFROM(0.00)[noreply@spotify.ca,bounces@sendgrid.net]
    ASN(0.00)[asn:11377, ipnet:167.89.64.0/19, country:US]
    TO_DN_NONE(0.00)[]
    HTML_SHORT_LINK_IMG_1(2.00)[]
    RCPT_COUNT_ONE(0.00)[1]
    DMARC_NA(0.00)[spotify.ca]
    TO_MATCH_ENVRCPT_ALL(0.00)[]
    URIBL_BLOCKED(0.00)[t.co.multi.uribl.com]
    R_DKIM_ALLOW(-0.20)[sendgrid.me]
    BAYES_SPAM(0.38)[70.93%]
    MIME_BASE64_TEXT(0.00)[]
    PREVIOUSLY_DELIVERED(0.00)[lord@lordtoniok.com]
    RCVD_COUNT_THREE(0.00)[3]
    X-Rspamd-Server: mail

Je ne vous met que les entêtes, le reste on s'en fout dans un premier temps.

Vous remarquerez que Postscreen l'a laissé passé et que Rspamd également avec un score de 2.48/10 (quand ça atteint 10 c'est officiellement un spam).

## La loucherie

Le *Return-Path* et le *Received from* ne correspondent pas du tout à l'Émetteur du mail (le champs *From: Spotify*). L'antispam l'a remarqué et vous le signale avec FROM_NEQ_ENVFROM.

Il y a deux types d'entêtes mails.
Ceux écrits "manuellement" par l'utilisateur et ceux que l'on appelle les *Envelope Headers* qui sont écrit par les logiciels.

Évidemment les spammeurs vont manuellement mettre des entêtes bidons pour faire croire qu'ils sont légitimes (From: Spotify) mais le serveur mail lui envoi la vérité (en vrai il envoi son adresse IP qu'il ne peut pas vraiment modifier et le serveur de réception faire une requête DNS pour traduire cette adresse en nom).

Si jamais le doute persiste concernant la nature du mail, voyons à quoi il ressemble.

## Le mail en HTML

{{< img link="89-spam-mail.png" title="Non je n'ai pas affiché les images (et vous ne devriez pas non plus)" src="*9-spam-mail.png" >}}

Bon déjà *This message was sent to …*, c'est pas de bol c'est pas moi.

Ensuite une petite astuce de sioux : **passez la souris sur les liens et regardez vers quelles adresses ça mène** voilà des points à observer :

  - S'ils ne pointent pas explicitement vers le site en question
  - Si tous les liens pointent vers la même adresse
  - S'ils utilisent un raccourcisseur d'url

Chaque fois que vous avez répondu "Oui" vous pouvez augmenter votre niveau de suspicion.

Ha au fait, *si ça parle de pognon c'est rarement bon signe*. C'est obvious mais visiblement pas tant que ça…

Et dernier point, si vous n'avez pas de compte chez un tiers et que celui-ci vous contacte et vous annonce un soucis de paiement sur votre abonnement… c'est un des points les plus évidents.

Évitez également de charger les images dans les mails.
À partir du moment où vous chargez les images, votre navigateur se connectera au serveur du spammeur et pourra commencer à vous traquer.
Cela leur permet déjà de savoir que le mail envoyé a été reçu et que donc votre adresse est encore fonctionnelle et lue.
Qui plus est, ils peuvent chopper des infos sur votre client mail et éventuellement y trouver des failles.

Voilà pour cette fois.

