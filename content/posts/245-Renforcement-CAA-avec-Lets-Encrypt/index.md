+++
Author = "Lord"
Description = ""
Categories = ["dns", "sécu","tls"]
menu = "main"
notoc = true
WritingDate = 2023-10-23T14:14:57+02:00
date = 2023-10-23T14:14:57+02:00
title = "Bloquer la création de certifs TLS dans votre dos via CAA"
editor = "helix"
Audio = ""
Soustitre = ""
TopWords = [  "api", "certificat", "dns", "accounturi", "notify", "letsencrypt", "ca", "sh", "caa", "acme"]
+++
Allez hop, premier jour de congé et j'en profite pour remettre le nez dans le camboui de mon ptit bordel auto-hébergé.

Il vient de se passer un truc pas très ouf.
Jabber.ru (je connais pas mais j'imagine qu'ils fournissent des comptes xmpp à leurs utilisateurs) se sont fait trouer.
Mais ça a été fait plutôt bien.
En gros, un certificat TLS a été créé dans leur dos ce qui a permis d'intercepter du trafic sans que personne ne s'en rende compte.

Ce genre de truc est pas si difficile à faire et ça risque de devenir monnaie courante.
Là on s'en est rendu compte mais si ça se trouve c'est fait à grande échelle.
Bref, du coup j'ai voulu voir comment empêcher ce truc.

## CAA
Allez c'est une redite mais ce coup-ci on va blinder un peu plus.

Pour un ptit rappel n'hésitez pas à consulter [mon article de 2017]({{< ref "posts/61-dns-caa" >}}) mais en gros **CAA** est un type d'enregistrement DNS permettant de spécifier quelle <abbr title="Certificate Authority - Let's Encrypt par exemple">CA</abbr> est autorisé à créer un certificat TLS.

En gros avec ça, vous dites que seul Let's Encrypt a le droit de vous créer des certificats.

C'est pas mal, mais après ce n'est pas encore pleinement suffisant.
Il est également possible de définir quel compte <abbr title="Let's Encrypt">LE</abbr> a le droit de générer des certifs.

Vous ne le savez peut-être pas, mais chaque utilisateur de LE a un compte.
On ne le crée pas explicitement mais le logiciel s'en charge de lui-même.

On va donc créer un enregistrement CAA où l'on va dire que seul LE est autorisée à générer un cert et on va restreindre encore plus en spécifiant quel compte précis à le droit de le faire.

On va donc devoir trouver son "accounturi" qui correspond donc à votre compte.

### Choper l'accounturi
Avec **certbot** il suffit de faire <kbd>certbot show_account</kbd> ce qui vous donnera un joli <samp>Account URL: https://acme-v02.api.letsencrypt.org/acme/acct/XXXXXXXXXX</samp> ainsi que l'adresse e-mail associée.

~~Mais si comme moi vous n'utilisez pas **certbot** mais **acme.sh** il faut ruser.
Soit vous avez des logs présents dans *.acme.sh/acme.sh.log* soit vous allez devoir lancer un renew et farfouiller.~~

**Eragon** signale dans les commentaires que pour le récupérer c'est *~/.acme.sh/ca/acme-v02.api.letsencrypt.org/directory/ca.conf* que vous trouverez votre ACCOUNT_URL.

Votre accounturi est donc <samp>https://acme-v02.api.letsencrypt.org/acme/acct/XXXXXXXXXX</samp> .

Bon bha maintenant que vous avec cette info il ne vous reste plus qu'à éditer votre zone.

### Édition de la zone DNS
Bon alors déjà il est possible de mettre une adresse mail de contact en cas de souci.
Je ne crois pas que LE en tienne compte mais c'est possible que d'autres CA l'utilisent.
Avec un peu de bol, une CA pourrait vous envoyer un mail si quelqu'un tente de vous créer un certif dans le dos !

Ensuite il y a surtout deux enregistrements.
Un permettant de définir la création d'un certificat pour une entrée spécifique et un autre pour créer un certificat wildcard s'appliquant à tous les sous-domaine ('tention niveau sécu ceux-là sont plus touchy).

Voilà ce que cela donne pour moi.

{{< highlight "dns" >}}
lord.re.            	600	CAA	0 iodef "mailto:lord-x509@lord.re" 
lord.re.            	600	CAA	0 issue "letsencrypt.org;accounturi=https://acme-v02.api.letsencrypt.org/acme/acct/XXXXXX" 
lord.re.            	600	CAA	0 issuewild "letsencrypt.org;accounturi=https://acme-v02.api.letsencrypt.org/acme/acct/XXXXXX" 
{{< / highlight >}}

Si vous avez plusieurs machines et donc potentiellement plusieurs comptes LE il faut faire gaffe à faire ça comme il faut.

Ça semble suivre les CNAME d'ailleurs.
Si vous avec un CAA pour un enregistrement principal uniquement et des CNAME pour d'autres enregistrements ça semble respecter le CAA "global", ce qui est pratique.

Et surtout prenez garde : si vous avez un CAA  à un niveau supérieur, il prenra le dessus pour tous les niveaux inférieurs si vous n'en définissez pas un plus spécifique.
Je m'explique, si vous avec un CAA sur lord.re, il s'appliquera également sur sous-domaine.lord.re .
Donc pensez à bien redéfinir le CA sur les sous-domaines si ce n'est pas le même *accounturi*.

## Certificate Transparency
Le CAA nécessite la coopération des CA.
En théorie les CA doivent le respecter mais bon on sait jamais.

Un ptit rempart supplémentaire (mais qui nécessite encore la coopération de la CA) est le **Certificate Transparency** qui est en gros un log public de tous les certificats créé par une CA.
À chaque fois qu'une CA signe un certif elle publie l'info dans un log ce qui permet à tout un chacun de voir qui créer un certificat.

Il existe plusieurs sites pour consulter ça mais perso j'aime beaucoup [CRT.SH](https://crt.sh) qui est très simple et efficace.
Ils proposent en plus un flux rss ce qui permet d'avoir un œil distant sur cela sans s'en préoccuper plus.

## Monitorer le renouvellement des certifs
Bon j'avais bêtement un cron qui fait son boulot et je croisais les doigts.

Je me suis enfin décidé à vérifier un peu mieux tout ça.

Bon j'utilise **acme.sh** qui fait la même chose que **certbot** mais en beaucoup plus simple.
Ce n'est que du shell, facile à installer (pas trouzemille dépendances python) et facilement scriptable.

Ils gèrent plein de façons de notifier mais rien de ce qu'il propose me convient, j'ai donc fait un ptit script pour mon cas.

<details><summary>~/.acme.sh/notify/nib.sh</summary>

{{< highlight "shell" >}}

#! /bin/bash

# support nib

nib_send() {
  _subject="$1"
  _content="$2"
  _statusCode="$3" #0: success, 1: error 2($RENEW_SKIP): skipped
  _debug "_subject" "$_subject"
  _debug "_content" "$_content"
  _debug "_statusCode" "$_statusCode"

  _err "Not implemented yet."
  echo -e "\x033[TLS-KIF]\x0f STATUS : \x034 $_statusCode \x0f : $_subject \n          $_content " | nc destinataire port_destinataire -w 2
  return 0
}

{{< / highlight >}}

</details>

Suivi d'un <kbd>acme.sh --set-notify --notify-source kif --notify-level 2 --notify-mode 1 --notify-hook nib</kbd> et c'est tout bon

## Relative inutilité du bousin
Bon je ne pense pas que ça m'apporte vraiment beaucoup plus de protection.
Je ne pense pas être la cible de ce genre de bidouille.

Et si c'était vraiment le cas, bha ça ne fait que reporter une partie de la sécurité vers le DNS.
Bref, un attaquant déterminé (genre un État) ne serait probablement pas plus gêné que ça par ces protections.

Cela reste cependant rapide à mettre en place et sans trop de contrainte pour une architecture relativement simple.
