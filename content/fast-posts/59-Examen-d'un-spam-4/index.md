+++
Author = "Lord"
Description = "Rigolons un ptit coup avec encore un spam. Bon pas grand risque celui-là. Encore des optimiseur de SEO en bois."
Categories = ["mail", "spam"]
menu = "main"
notoc = true
WritingDate = 2021-05-06T11:46:29+02:00
date = 2021-05-06T11:46:29+02:00
title = "Examen d'un spam #4"
editor = "kakoune"
TopWords=["spam","seo","mail","arnaque"]
+++
Tiens faisait longtemps que je m'étais pas marré avec un spam.

<details><summary>Voilà le mail en question</summary>

<details><summary>headers</summary>

<pre>
Return-Path: <joseph@seooptimizes.com>
X-Original-To: lord-blog@lord.re
Delivered-To: lord-blog@lord.re
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by kif.lord.re (Postfix) with ESMTPS id 6D9D880806
        for <lord-blog@lord.re>; Thu,  6 May 2021 11:38:56 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so2680027wmn.2
        for <lord-blog@lord.re>; Thu, 06 May 2021 02:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=seooptimizes-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=hYiaduUXufafI2SqVZR7CoPYIzuNDrpWYn28Ban7iRM=;
        b=ScgzN+Oa6CGz5VD7h6pM5QUhJEBS2fBCM8hzDdjtp9IN7zqL8yq5JDw884dRxcVUI1
        vp1u48JfzhICfhFxK78bL/IToy0RS0ULJ6xdJh2v0AttdmadEhx7DFZWAvV7YLGy96oL
        2qzPVVwtZK4WAa1Q1NppNhOOK7b/5BIsfAMspebg8nzZ7a075PS+BW7xLpQRnviEunhA
        xB7vTN2nvN9rHDHLOk5DLri+OabKgk0VqoJobn+DDLRojZ+558XxVApJzHpkRiDDBjPq
        TMUxQEddgkILmqjc65lkMYRi+glfHIr0pePglg1IKWahY78SnXWkbXYUH60MIoiNQDrJ
        ukuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
        :to;
        bh=hYiaduUXufafI2SqVZR7CoPYIzuNDrpWYn28Ban7iRM=;
        b=h/UPNRrQrn+foaU+/iPy+YO94gV6vSCE1fn2o7A5Cm4GOmp3g3WDNPHJ4qevaO3Tbi
        r54mpC5pml+LbZriTmhX4SnsjbS1GF1tzGDc5AqNXnSKDo0w8h3FMjH5q/tLwy1Dlpd1
        QgLTTDTkEcQHxmrV35EbIcL2M27X6rvOMfsBI5ydRQNvXXc5+Go1JMMO1iEODVpMfT9+
        dxqYbTL8jvUu/TVncLiMuzM/BcbxWS34JXWSES8AvCZkkHQ7zVIlRmg+dVbQn8SywJjR
        BnjlfrNTLPc1MSoiK3LzPtD5uC9tch9RdlMjmjRdoQ4lwrp/pJwHOVuRJT3FaVO4tN5a
        Gn2Q==
X-Gm-Message-State: AOAM533/OZhNTr62hyIOFn68ylVW/zy0clg3bVKqyKuUDG9F56CmttJK
        TeiSCYS/V2pUkFDCP8y8ZGSGqEbkzOVMxdAi5Og8GOntDHM=
X-Google-Smtp-Source: ABdhPJwn1XkGTaR6MBmSIg/z5an/dL/qbXio19aj7xLCUp562WVzV5AM8iMfQ3dN0DpKRS6lR4B/P+VEqn7/ilB5mZ4=
X-Received: by 2002:a1c:b406:: with SMTP id d6mr2086815wmf.105.1620282505548;
        Wed, 05 May 2021 23:28:25 -0700 (PDT)
Received: from 52669349336 named unknown by gmailapi.google.com with HTTPREST;
        Thu, 6 May 2021 02:28:25 -0400
Received: from 52669349336 named unknown by gmailapi.google.com with HTTPREST;
        Thu, 6 May 2021 02:28:24 -0400
MIME-Version: 1.0
Sender: Joseph Thomas <joseph@seooptimizes.com>
From: Joseph Thomas <joseph@seooptimizes.com>
Date: Thu, 6 May 2021 02:28:25 -0400
X-Google-Sender-Auth: 1rt-BtY-9dTA1mdVQ42ciVNSjEY
Message-ID: <CAJiAyuZ3NQOjMxDTHucn06dua+vkvKe+q=2nTisnpgU8SuPZAw@mail.gmail.com>
Subject: Re : lord.re : Have Lots Of Error.
To: Lord-Blog <lord-blog@lord.re>
Content-Type: multipart/alternative; boundary="0000000000002dd8d505c1a36bd0"
X-Rspamd-Queue-Id: 6D9D880806
X-Spamd-Result: default: False [-2.00 / 10.00];
        ARC_NA(0.00)[];
        R_DKIM_ALLOW(-0.20)[seooptimizes-com.20150623.gappssmtp.com:s=20150623];
        FROM_HAS_DN(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        R_SPF_ALLOW(-0.20)[+ip6:2a00:1450:4000::/36];
        MIME_GOOD(-0.10)[multipart/alternative,text/plain];
        PREVIOUSLY_DELIVERED(0.00)[lord-blog@lord.re];
        RCPT_COUNT_ONE(0.00)[1];
        RCVD_COUNT_THREE(0.00)[4];
        TO_DN_ALL(0.00)[];
        DKIM_TRACE(0.00)[seooptimizes-com.20150623.gappssmtp.com:+];
        DMARC_POLICY_ALLOW(-0.50)[seooptimizes.com,none];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+,1:+,2:~];
        ASN(0.00)[asn:15169, ipnet:2a00:1450::/32, country:US];
        RCVD_TLS_ALL(-1.00)[]
X-Rspamd-Server: kif

Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

</pre>
</details>

<pre>
Dear lord.re Owner,
Hope you are doing well !

I’m Senior Digital Marketing Expert With 10+ Years Of Experience.

I Was Going Through Your Website That Your Website Has Lots Of Broken Links
As Well As Technical Error Which Breaks The Rules Of Google Algorithm.

Some Of Your Error On The Website: lord.re

·       4 Pages With *Harmful Broken Links*

·       No *Meta Tag* & *Title Tag*

·       Your Website Doesn't Have A *Canonical Tag.*

·       Your *Website* Doesn't Have A *Updated Sitemap.*

·       *Google Bot* Is Not Able To *Crawl* Your Website.

*Warning :*

Frankly Speaking If We Don't Fix These Error Then Its Create A Very Bad
Impact Over Your Website Visibility, Also Google Remove Your Expensive
Website From The Search Engine Because Your Website Don't Follow The
Algorithms Of Google.

Let Me Know If You're *interested* To Fix Those Error On Your Website
lord.re . Then I Will Assign A Digital Marketing Manager To Send You All
Your *Website Error With A Full Analysis Report *& Help You To Fix All
Those Error.

I’m waiting for your valuable response to makes the website search engine
friendly.

Best Regards,



*Joseph Thomas,*

*Senior Digital Marketing Expert*

*__________________________________________________________*

( Error Fixation Cost : $150 (One Time) To Fix All Those Errors Of Your
Website & Make It’s Search Engine Friendly. )

*( N.B : If You Are Really Interested To Fix All The Error Then Reply Me.
Because I Am Not Telling Any Fake Things OrDoing Any Spam. I Want To Help
Your Organisation. )*


[image: beacon]
</pre>
</details>

Bon alors déjà on peut commencer par cracher à la gueule de Google (ouai j'aime bien le faire).
Ils font chier le monde entier à pousser des technos pour contrer le spam (bon d'un certain point de vue c'est pas si mal) mais de l'autre ils se permettent d'émettre du spam…
Merci les gars on repassera.

Bon d'un point de vue purement technique, le mail est plutôt propre.
Il passe tous les filtres de l'antispam, il a une version HTML et une version TXT.

C'est plus sur le reste que ça me fait marrer.

Bon on voit que ça provient d'un certain *Joseph* de chez **seooptimizes.com**.
De bonne foi je vais regarder leur site ouaib.

Ma foi c'est un bien joli site générique comme on en voit partout.
Pas de quoi les blâmer non plus, hein.

Tiens c'est marrant ils mettent les photos de leur équipe sauf que visiblement notre cher *Joseph* n'a pas le droit à son quart d'heure de célébrité…
Est-ce qu'il y bosse réellement ?
Est-ce qu'il a le droit d'envoyer des mails à leur nom ?
Est-ce que leur site est fiable ?
Sont-ce des gens crédibles ?
Ça y est, ils viennent de me perdre comme client.
C'est balot !

Bon je suis quand même curieux, je vais voir un peu ce qu'il y a un peu plus bas.

{{< img src="experts.png" alt="Leur site ouaib indique 0 client, 0 expert, 0 experience, 0 award." title="Ha ouai avec de tels chiffres ça fait rêver. Js vous manque et votre réputation s'envole." >}}

Bon leur site donne pas trop confiance mais il est ptet super bien foutu quand même.
Après tout ce sont des experts en la matière, qui suis-je pour juger ?

Un coup de **GTMetrix** ? 
{{< img src="experts2.png" alt="noté E, performance 43% et structure 68%" title="Ouaip bha ça a l'air d'être de la merde leur site, non ?" >}}

Halala
On se marre.

Et des mails du genre de leurs concurrents j'en ai très régulièrement.
Des guignolos à la limite de l'arnaque.
J'aimerais bien tester une de leurs prestations un jour mais à 150€ ça fait cher l'expérience scientifique.
