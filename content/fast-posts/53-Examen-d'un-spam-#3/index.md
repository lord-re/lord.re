+++
Author = "Lord"
Description = "Un ptit mail reçu en ce jour férié. Une tentative de phishing visant les clients d'online."
Categories = ["spam", "mail"]
menu = "main"
notoc = true
draft = false
WritingDate = 2020-11-11T22:30:19+01:00
date = 2020-11-11T22:30:19+01:00
title = "Examen d'un spam #3"
editor = "kakoune"
TopWords=["online","spam","mail","phishing"]
+++
En ce 11 novembre je reçois un ptit mail de la part d'Online comme quoi au moins un de mes domaines arrive à expiration et qu'il me faut passer à la caisse pour prolonger l'aventure.
Le mail me semble vite fait clean, je clique sur le lien donné pour effectivement renouveler.

Je tombe sur une page 404 de chez Online.
Donc à priori c'est étrange mais sans conséquence.
Ni une ni deux, mon premier réflexe est de signaler ça sur le salon IRC.
Et là, tintin tin je me demande si ce serait pas un peu plus louche en vrai.

Je regarde les headers et là ça devient super louche.
Du coup, je regarde le mail au format HTML et là ça se confirme c'est bien un spam de phishing.

**Le contenu du mail texte était identique au texte du mail HTML mais un des liens (celui poussant à agir) est différent.**

En fait par chance mon client mail (neomutt) m'affiche le mail au format texte ce qui m'a protégé pour le coup.
Par contre le *from* que neomutt m'affiche est forgé.
**Rspamd** l'a noté à 6.01/10 ce qui est déjà pas mal.

Bon je vous le montre en entier avec notamment les headers de rspamd qui montrent qu'il avait bien capté la supercherie.

<details><summary>le mail en question</summary>

```
Return-Path: <info@online.net>
X-Original-To: lord-blog@lord.re
Delivered-To: lord-blog@lord.re
Received: from mta3.canopegabon.com (mta3.canopegabon.com [85.214.29.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by kif.lord.re (Postfix) with ESMTPS id D695A807F6
	for <lord-blog@lord.re>; Wed, 11 Nov 2020 13:43:18 +0100 (CET)
Date: Wed, 11 Nov 2020 13:21:05 +0100
To: lord-blog@lord.re
From: "online.net" <info@online.net>
Reply-To: info@eu10.internet-es.com
Subject: [Online] Renouvellement de vos noms de domaine.
Message-ID: <7b4611aaad551596ff94b29895938ae0@online.net>
List-Unsubscribe: mailto:bounce180-kItnMezg254CXnq@online.net?subject=list-unsubscribe
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="1f17fd24f871cbcb69725d0a4fc959b29"
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D695A807F6
X-Spamd-Result: default: False [6.01 / 10.00];
	 HAS_REPLYTO(0.00)[info@eu10.internet-es.com];
	 R_SPF_FAIL(1.00)[-all];
	 DMARC_POLICY_SOFTFAIL(0.10)[online.net : No valid SPF, No valid DKIM,none];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	 REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	 TO_DN_NONE(0.00)[];
	 HAS_LIST_UNSUB(-0.01)[];
	 RCPT_COUNT_ONE(0.00)[1];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 RCVD_COUNT_ZERO(0.00)[0];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:~];
	 ASN(0.00)[asn:6724, ipnet:85.214.0.0/15, country:DE];
	 MID_RHS_MATCH_FROM(0.00)[];
	 GREYLIST(0.00)[pass,body];
	 PHISHING(1.52)[online.net->aksomev.de]
X-Rspamd-Server: kif
X-Spam: Yes

This is a multi-part message in MIME format.

--1f17fd24f871cbcb69725d0a4fc959b29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


ONLINE SASAssistance techniqueBP 438 - 75366 Paris CEDEX 08France
Tél : 01 84 13 00 00
Objet : Renouvellement de vos noms de domaine.
Madame, Monsieur,
Un ou plusieurs de vos domaines ou de vos hébergements arrivent bientot à expiration,
Pour proceder au renouvellement rendez-vous sur la page suivante:
https://console.online.net/commande/renouvellement/
En cas de non règlеmеnt sous 2 jours. votre compte sera définitivement fermé.
A trés bientot,
Si vous êtes perdus, nous avons de nombreux outils à votredisposition :
- Nos documentations sont disponibles en ligne à l'adressehttp://documentation.online.net- Si malgre les outils à disposition, vous n'avez pas trouvéréponse à votre question, notre assistance technique est a votredisposition depuis la rubrique "assistance" de votre consolede gestion Online.net (apres authentification)
Nouveau :Des partenaires d'infogérance sont à votre disposition pourvous fournir un service technique clef en main.Pour plus d'information, contactez nos partenaires :http://documentation.online.net/commercial/infogerance
--L'assistance Online.net


--1f17fd24f871cbcb69725d0a4fc959b29
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<HTML>
<BODY><P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, A=
rial, Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-T=
RANSFORM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; OR=
PHANS: 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,=
255); TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius:=
 0px; font-variant-ligatures: normal; font-variant-caps: normal; -webkit-te=
xt-stroke-width: 0px; text-decoration-style: initial; text-decoration-color=
: initial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radiu=
s: 0px" size=3D2 face=3DTahoma>ONLINE SAS<BR style=3D"text-shadow: none; bo=
x-shadow: none; border-radius: 0px">Assistance technique<BR style=3D"text-s=
hadow: none; box-shadow: none; border-radius: 0px">BP 438 - 75366 Paris CED=
EX 08<BR style=3D"text-shadow: none; box-shadow: none; border-radius: 0px">=
France</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>T=C3=A9l : 01 84 13 00 00</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Objet : Renouvellement de vos noms de domaine.</FO=
NT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Madame, Monsieur,</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Un ou plusieurs de vos domaines ou de vos h=C3=
=A9bergements arrivent bientot =C3=A0 expiration,</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Pour proceder au renouvellement rendez-vous sur la=
 page suivante:</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><A style=3D"COLOR: rgb(0,0,204); OUTLINE-WIDTH: 0px; OUTLINE-STYLE: no=
ne; OUTLINE-COLOR: invert; text-shadow: none; box-shadow: none; border-radi=
us: 0px" href=3D"http://one5.aksomev.de/" rel=3Dnoreferrer target=3D_blank>=
<FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px" siz=
e=3D2 face=3DTahoma>https://console.online.net/commande/renouvellement/</FO=
NT></A></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>En cas de non r=C3=A8gl=D0=B5m=D0=B5nt sous=C2=
=A02 jours. votre compte sera d=C3=A9finitivement ferm=C3=A9.</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>A tr=C3=A9s bientot,</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Si vous =C3=AAtes perdus, nous avons de nombreux o=
utils =C3=A0 votre<BR style=3D"text-shadow: none; box-shadow: none; border-=
radius: 0px">disposition :</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>- Nos documentations sont disponibles en ligne =
=C3=A0 l'adresse<BR style=3D"text-shadow: none; box-shadow: none; border-ra=
dius: 0px"></FONT><A style=3D"COLOR: rgb(0,0,204); OUTLINE-WIDTH: 0px; OUTL=
INE-STYLE: none; OUTLINE-COLOR: invert; text-shadow: none; box-shadow: none=
; border-radius: 0px" href=3D"http://documentation.online.net/" rel=3Dnoref=
errer target=3D_blank><FONT style=3D"text-shadow: none; box-shadow: none; b=
order-radius: 0px" size=3D2 face=3DTahoma>http://documentation.online.net</=
FONT></A><BR style=3D"text-shadow: none; box-shadow: none; border-radius: 0=
px"><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px"=
 size=3D2 face=3DTahoma>- Si malgre les outils =C3=A0 disposition, vous n'a=
vez pas trouv=C3=A9<BR style=3D"text-shadow: none; box-shadow: none; border=
-radius: 0px">r=C3=A9ponse =C3=A0 votre question, notre assistance techniqu=
e est a votre<BR style=3D"text-shadow: none; box-shadow: none; border-radiu=
s: 0px">disposition depuis la rubrique "assistance" de votre console<BR sty=
le=3D"text-shadow: none; box-shadow: none; border-radius: 0px">de gestion O=
nline.net (apres authentification)</FONT></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>Nouveau :<BR style=3D"text-shadow: none; box-shado=
w: none; border-radius: 0px">Des partenaires d'infog=C3=A9rance sont =C3=
=A0 votre disposition pour<BR style=3D"text-shadow: none; box-shadow: none;=
 border-radius: 0px">vous fournir un service technique clef en main.<BR sty=
le=3D"text-shadow: none; box-shadow: none; border-radius: 0px">Pour plus d'=
information, contactez nos partenaires :<BR style=3D"text-shadow: none; box=
-shadow: none; border-radius: 0px"></FONT><A style=3D"COLOR: rgb(0,0,204); =
OUTLINE-WIDTH: 0px; OUTLINE-STYLE: none; OUTLINE-COLOR: invert; text-shadow=
: none; box-shadow: none; border-radius: 0px" href=3D"http://documentation.=
online.net/commercial/infogerance" rel=3Dnoreferrer target=3D_blank><FONT s=
tyle=3D"text-shadow: none; box-shadow: none; border-radius: 0px" size=3D2 f=
ace=3DTahoma>http://documentation.online.net/commercial/infogerance</FONT><=
/A></P>
<P style=3D'FONT-SIZE: 12px; FONT-FAMILY: "Lucida Grande", Verdana, Arial, =
Helvetica, sans-serif; WHITE-SPACE: normal; WORD-SPACING: 0px; TEXT-TRANSFO=
RM: none; FONT-WEIGHT: 400; COLOR: rgb(0,0,0); FONT-STYLE: normal; ORPHANS:=
 2; WIDOWS: 2; LETTER-SPACING: normal; BACKGROUND-COLOR: rgb(255,255,255); =
TEXT-INDENT: 0px; text-shadow: none; box-shadow: none; border-radius: 0px; =
font-variant-ligatures: normal; font-variant-caps: normal; -webkit-text-str=
oke-width: 0px; text-decoration-style: initial; text-decoration-color: init=
ial'><FONT style=3D"text-shadow: none; box-shadow: none; border-radius: 0px=
" size=3D2 face=3DTahoma>--<BR style=3D"text-shadow: none; box-shadow: none=
; border-radius: 0px">L'assistance Online.net</FONT></P></BODY></HTML>


--1f17fd24f871cbcb69725d0a4fc959b29--

```

</details>

Bref, je remercie mon client mail de privilégier les mails au format texte.
Le phishing marche principalement par les mails html, donc c'est un argument de plus pour ne pas utiliser ce format.

**Il y a donc des tentatives de phishing à l'encontre des clients Online actuellement.**
