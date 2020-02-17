+++
Author = "Lord"
Description = ""
Categories = ["meta", "mail","spam"]
menu = "main"
notoc = true
WritingDate = 2020-02-17T12:01:13+01:00
date = 2020-02-17T12:01:13+01:00
title = "Examen d'un spam #2"
editor = "kakoune"
+++
J'avais déjà fait un épisode il y a désormais [fort longtemps]({{< ref "/posts/89-lecture-de-spam-1" >}}).
Et là j'en ai reçu encore un (j'en ai eu d'autres entre temps, hein) qui m'a fait tiquer.

Je suis tout fier d'utiliser un générateur de site statique, j'ai écrit pas mal d'articles à ce sujet.
Un des buts est que c'est ultra simple à héberger et que ça a des perfs biens meilleures que les sites dynamiques.
Je suis également tout fier d'être auto-hébergé et je pousse au maximum les gens à en faire autant.

Et là on me démarche pour me faire installer un pauvre Wordpress de merde et qu'il faudrait que je l'héberge chez Amazon…

Bon j'imagine que les spammeurs ne lisent pas mon blog, ils ont juste récupéré l'adresse mail et envoyé un truc bateau, mais c'est tout de même un peu dommage qu'ils ne poussent pas leur "enquête" afin de regarder quel générateur j'utilise (c'est dans les premières lignes de la page ouaib) et quelles sont les perfs (un test de vitesse est assez rapide à réaliser).

Bref, je vous laisse voir ça :

<details><summary>headers</summary>
<pre>
Return-Path: <contact@wpoptim.co>
X-Original-To: lord-blog@lord.re
Delivered-To: lord-blog@lord.re
Received: from GBR01-LO2-obe.outbound.protection.outlook.com
        (mail-eopbgr100111.outbound.protection.outlook.com [40.107.10.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by kif.lord.re (Postfix) with ESMTPS id BC16680DFD
        for <lord-blog@lord.re>; Mon, 17 Feb 2020 11:04:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
        b=mplATnPloY+VsLMG393OVbGNkl3c1miOHBJpB5iHd2rLKobxxJvTKhuyxzUQdSNfluUg/rNdLmn9INiPQVCvAo1dUQuwW74nCZ0GGGqK/hRQK9SY3j9naKgwuVGG0glrUGCGgD4XthgrC4jCrb7O7lOZsPAtJp+sv2ITOR8d+o1nnsa3EAAvm85edOduUSE45gYz8mHKW6VWdxxOiUHkheFxOufrK8BebwfYF1wEnYL8G8y6Lxa0fpU1A7+A+GmI7tq3Hh9wc00qZmK39pAP9NlBbMjuUwNRVe7JWT6tbYzmbHAxnCgoVkIoKvI76sIrlGx3hqBnb/Fv0/UtmauA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
        s=arcselector9901;
        h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
        bh=s4WGpamVwMebN2Os2VAaq0yjP55f5fOigOLvGcMDxNU=;
        b=ej+jH9zAUK6+TYny1BlPoRQueIVtEHmqTNh6NpoPpTmSgIMcRqnqH9uzqnPqwke4pclXvICqqF3QTwnLPU9KRZHU23gbeClRaWgeVIFi1Qy3F8EsCDisMB7XZwUFmbcUUnhsLJAErDGrWASlQsqUE7gSMdyNkMtk6PErD0cAOIHOPtgMohrIko6wC7ou7dAP797ShcmT81+uBy5skCPMPKWPoayjI8aEzyHtRqBVkdalXX1mgX2NbrRY9f1D204aqZG+ZOvVXZWiaR4EVpuL1EwLeuar6WoJCj1keOh8cWKBJUm7M4zk1WkDDQk7ms3LphoN496g7/0qZUdTvXcqcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
        smtp.mailfrom=wpoptim.co; dmarc=pass action=none header.from=wpoptim.co;
        dkim=pass header.d=wpoptim.co; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wpoptim.onmicrosoft.com; s=selector1-wpoptim-onmicrosoft-com;
        h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
        bh=s4WGpamVwMebN2Os2VAaq0yjP55f5fOigOLvGcMDxNU=;
        b=fJ0jhNQ+9Dlrx4B+5GHgafWgACmcI7zzwVByW6EGZfNfknyoKdKX9J2Vhxu3FhGpeqWebux46z/Y3EXspqAuGn3U2IHY/0jP7rIVS5vKCVb5buGDidP+NhmPyyQTW3CSF2KEI5DD7P2vKpq+wAYie1K2CcypC/ZcW+7HbPCe0Hk=
Received: from CWLP123MB2979.GBRP123.PROD.OUTLOOK.COM (20.180.144.79) by
        CWLP123MB3057.GBRP123.PROD.OUTLOOK.COM (20.180.144.142) with Microsoft SMTP
        Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
        15.20.2729.25; Mon, 17 Feb 2020 10:04:34 +0000
Received: from CWLP123MB2979.GBRP123.PROD.OUTLOOK.COM
        ([fe80::1505:2353:23eb:f92]) by CWLP123MB2979.GBRP123.PROD.OUTLOOK.COM
        ([fe80::1505:2353:23eb:f92%6]) with mapi id 15.20.2729.032; Mon, 17 Feb 2020
        10:04:34 +0000
Received: from bot (188.27.235.97) by VI1PR06CA0150.eurprd06.prod.outlook.com
        (2603:10a6:803:a0::43) with Microsoft SMTP Server (version=TLS1_0,
        cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2729.22 via Frontend Transport;
        Mon, 17 Feb 2020 10:04:34 +0000
From: WP Optim <contact@wpoptim.co>
To: "lord-blog@lord.re" <lord-blog@lord.re>
Subject: 😨 lord.re - Speed report
Thread-Topic: 😨 lord.re - Speed report
Thread-Index: AQHV5XmnPDzhe1z6VkSi1mtPL8RVHw==
Date: Mon, 17 Feb 2020 10:04:34 +0000
Message-ID: <88b70bb42e14caff2eadf6d028c2a869@bot>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-clientproxiedby: VI1PR06CA0150.eurprd06.prod.outlook.com
        (2603:10a6:803:a0::43) To CWLP123MB2979.GBRP123.PROD.OUTLOOK.COM
        (2603:10a6:400:51::15)
authentication-results: spf=none (sender IP is )
        smtp.mailfrom=contact@wpoptim.co;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eea5a767-e1d8-454c-1fea-08d7b390ca4e
x-ms-traffictypediagnostic: CWLP123MB3057:
x-microsoft-antispam-prvs:
        <CWLP123MB30575139AAD395CBCA0E46D4D0160@CWLP123MB3057.GBRP123.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0316567485
x-forefront-antispam-report:
        SFV:NSPM;SFS:(10019020)(39850400004)(396003)(136003)(366004)(346002)(376002)(189003)(199004)(956004)(66574012)(478600001)(33716001)(966005)(9576002)(64756008)(4744005)(66446008)(66946007)(66556008)(66476007)(81166006)(81156014)(5660300002)(8936002)(71200400001)(108616005)(86362001)(9686003)(186003)(316002)(55016002)(2906002)(6496006)(26005)(6916009)(52116002)(24736004)(493
+534005)(14943795004);DIR:OUT;SFP:1102;SCL:1;SRVR:CWLP123MB3057;H:CWLP123MB2979.GBRP123.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wpoptim.co does not designate
        permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
        b5q1x3Ux9mc0f+e+KUrC2YRdeKaQM69i7Sqz/JeYqEcgT7nDWXZ/YrJ8QzZ4doiwsUl9fdI6b8cEm3FZ7E6GSnyOqh/Pw8pH9bGUz10BbxcgJdKdt49y7WxlfF3E3/fZ+tU+ut2OWrEueezvO2jkRynabq3hiCNu1209h58LKEyRj3MHpC+KmKSVnsY7V4s+paxOXL/hcCfe0H+Ae8AwteltYxbseO7UITgaNawjOz2WImRxwYAM0XdPtaCDPVwkM5FlJJUYxu5cV+c21P9mD5tkwcTfH/kjJgT+N8ng2sURbQsHJsPY9/bPPJyd/7H1h4xbkTeGDXmfvaZGSYgAHZfv0gTfrgjoaKBTQvlPU4EpyshhI221dAv
+/2Jc21PpdGz3LnuX47sMFxetSUnDEtCo0eUbFO33Y158lZQ+5u9HOiDOi1G4vx81V90FLK2LnhX4Hjt9apEz4n1+5xcOwE3c0vOlxn/eDdq3gENa5195p0OPSKL3o37UdrDHSyo4JzKJgFi7OG3yVk0eJPkL106HnXvx/HcwkuZvPoEaIMz2kXr5O5Ucqz2I5Pf1Voff4QF+b8omWEsDyUMOkhapU1hWrgnX3kXUmoxP6JEfpm28=
x-ms-exchange-antispam-messagedata:
        +1f6U2V0HTuyg2gto5A2wGVXEAYqOkhbZNuTDYnyyyv0tzyaQSZA1HH5e2WnkR2srzfbxd49vjF2mh2u28b0CNCu/vd1pzJtqFd/5jMnYyBZStrsrclCdYiid13YoAcr4QQ37FsrwCjfuOitLg4TpA==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
        boundary="_000_88b70bb42e14caff2eadf6d028c2a869bot_"
MIME-Version: 1.0
X-OriginatorOrg: wpoptim.co
X-MS-Exchange-CrossTenant-Network-Message-Id: eea5a767-e1d8-454c-1fea-08d7b390ca4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2020 10:04:34.8408
        (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5b44ec05-8deb-41cf-83ee-1e0419556989
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rudfrbUtwTIiC5eyYlnVB0BjhC28GDwAU5oe0B+XjI/EpSsaqRSUno2tfwM/S4pAl8eEEopKV2EdVrXUdrcR1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB3057
X-Rspamd-Queue-Id: BC16680DFD
X-Spamd-Result: default: False [-0.88 / 9.00];
        RCVD_TLS_LAST(0.00)[];
        BAYES_SPAM(0.02)[49.67%];
        R_DKIM_ALLOW(-0.20)[wpoptim.onmicrosoft.com:s=selector1-wpoptim-onmicrosoft-com];
        FROM_HAS_DN(0.00)[];
        R_SPF_ALLOW(-0.20)[+ip4:40.107.0.0/16];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        MIME_GOOD(-0.10)[multipart/alternative,text/plain];
        DMARC_NA(0.00)[wpoptim.co];
        RCPT_COUNT_ONE(0.00)[1];
        RCVD_COUNT_THREE(0.00)[4];
        DKIM_TRACE(0.00)[wpoptim.onmicrosoft.com:+];
        MIME_BASE64_TEXT(0.10)[];
        TO_DN_EQ_ADDR_ALL(0.00)[];
        RCVD_IN_DNSWL_FAIL(0.00)[111.10.107.40.list.dnswl.org:server fail];
        FROM_EQ_ENVFROM(0.00)[];
        MID_RHS_NOT_FQDN(0.50)[];
        ASN(0.00)[asn:8075, ipnet:40.64.0.0/10, country:US];
        MIME_TRACE(0.00)[0:+,1:+,2:~];
        ARC_ALLOW(-1.00)[i=1]
X-Rspamd-Server: kif

Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
</pre>
</details>

> Hello there!
> 
> Your website, lord.re was recently checked on our Speed Test.
> 
> Optimization report →<http://bit.ly/39FzlSg#190927179328fea61f57>
> http://bit.ly/39FzlSg#190927179328fea61f57
> 
> We found multiple bottlenecks and opportunities to optimize performance. This has a high impact on search engine visibility and bounce rate!
> 
> How we can help:
> 
>   1.  Fully managed hosting, custom optimized for WordPress, using single tenant private servers. 
>   Powered by Amazon Cloud platform, making websites run blazing fast.
> 
>   2.  Unlimited migrations free of charge.
>     
>   3.  1400 pre-built sites, created using the best premium WordPress themes, available for all our customers at no cost.
>       
>       
> Interested in fixing your site?
>       
>       
>       
> .....
>       
> Maria T. - WordPress Expert
> WP  Optim - Running on AWS Amazon


Voilà voilà.
C'est pas trop un examen au final.
D'ailleurs le mail est sacrément clean.
