+++
Categories = ["dns","network","adminsys"]
Tags = ["dns","network","adminsys"]
Description = "The ultimate DNS guide. How to set it up, how to maintain it, how to have a modern stack. Deploying DNSSEC and DANE."
date = "2017-10-27T23:05:06+02:00"
PublishDate = "2017-10-27T23:05:06+02:00"
menu = "main"
notoc = false
title = "Ultimate DNS guide v1"

+++
I'm revamping my DNS stack. For the two of you won't don't know what DNS is, it's the reference directory of the Internet. It's oversimplifying to say it like that. If fact DNS is a replicated, delegated big database. Translating an hostname to an IP is only of its purpose. Let's go for the 2017 DNS Mega guide !
<!--more-->

If you are the lonely regular english reader of my blog you'll see that there will be some redundant information from some previous blog posts but that's I want this article to be quite exhaustive.

## Where does it come ?
Historically, when you tried to reach a remote host on the Internet, you had to know it's IP adress. As the network grew it quicly became tedious to know all the adresses. So they used a text file containing the list of all the machines (the famous *hosts* file). Syncing it was complex and it was a manual task of sending floppies with the file. And then : BIM ! DNS was born. A new distributed/replicated/delegated mondial database !

DNS is organized as a tree where each branch is/can be delegated. As an example ***www.lord.re*** actually is ***www.lord.re.*** (notice the dot in the end). It's a path which must be read from right to left.

- First we have the root ***.*** on the far right. It's managed by the **ICANN**.
- The comes ***.re*** which is the TLD (Top Level Domain, aka domain name extension), which isn't managed by ICANN but delegated to **AFNIC** (which manage all french domains like .re (which is from La Réunion a french island in the Pacific Ocean).
- Then we find ***.lord*** which isn't managed by AFNIC but by **me** (as I rent the domain to a registrar).
- Finally ***www*** which targets my server which I also manage but i could have delegated to someone else.

Now we will go deeper in the technical side of it. We will setup an authoritative DNS server on my -your- domain.

## Take yourself a domain name and launch your server

First you won't buy a domain name but you'll rent it for one to ten years to a registrar (an authorized seller). Most of registrars can host your domain name but frankly… it's way funnier to do it ourselves !

In your registrar you'll have to fill the **Glue records**. It's what links your domain name server to the parent't zone. So you'll have to give the IP adress and hostname of your DNS server. In my case *zapp.lord.re* is the server and its adress is *62.210.201.160* . Once done, you'll mostly won't have any more contacts with your registrar (except for dnssec and renewing).

Now installing your DNS server… DIY. In my case I didn't choose the venerable Bind but the almighty **Knot** which i find way better. Setting it up is easier than Bind especially with **DNSSEC**. Knot is developped by *Nic.cz* which is the entity managing all *.cz* domains. They also developped **Bird** which is a routing open source software. They also build **Turris** routers like the [Omnia](https://lord.re/posts/44-turris-monia/) i'm using right now. They build lot of opensource softwares and many infrastuctures tools. They are pushing **DNSSEC** adoption with their browser extension to check [**DANE**](#tlsa) signatures from websites you are browsing.

## Confing Knot DNS
Once knot is installed you'll have to create the config file. The file is quite logic and straight forward. I'll put almost all of it there :

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

Everything is well sorted. Now you'll have to put your zones files in */var/lib/knot/zones*. Knot will generate all the needed keys and will sign your zone by itself.

## Gérer la redondance
Monter un serveur DNS secondaire.

FIXME

## Publishing your DNSKEY or DS Record to your registrar

The last thing to do with your registrar is giving them your DS record or DNSKEY of your KSK. Written like this it looks very hard but it's not. This is the last required step to complete the trust chain needed by DNSSEC. Depending of your registrar you'll give them the DNSKEY or the DS Record.

- To find your ***DS*** : **keymgr lord.re list** will show all your active keys. You must find the ***KSK*** et memorized its ***tag***. Now **keymgr lord.re ds 42754** (42754 is my ksk's tag). The command will give you three records. It's the three time the same but with different hash method. You'll have to choose one (the bigger the better).

- To get your ***DNSKEY*** it's the nearly the same story : **keymgr lord.re dnskey 42754** and there you go.

Each time you'll rollover (change) your KSK (it's recommanded to do it every year or two) you'll have to do it again. In fact DNSSEC use two type of keys : 

- ***ZSK*** (Zone Signing Key) which are used to sign each record in your zone. This key is quite small (to stay fast) so it must be renewed every month or so.
- ***KSK*** (Key Signing Key) is only used to sign the KSK. This key is way bigger than zsk so it can be used longer and can be published to you registrar to be in the parent's zone.

Now you can close your registrar's web interface and only get there to renew your domain in one year ;-)

## What to put in your zone ?

We can put many things in it, let's start with the most common one :

- ***SOA*** : Start Of Authority is a mandatory record which gives some required information about the zone, who is the master server, which mail to contact, the serial and some timeout valuess. Here is mine :

		lord.re.          3600    IN      SOA     zapp.lord.re. lord.lord.re. 2015033233 3600 7200 3600 180

The master server (or authoritative) is *zapp.lord.re.*, the contact mail is *lord.lord.re.* (notice the strange syntax. The arobase is replaced by a dot (it's easy to forge an invalid email adress)). Then come the serial *2015033233* which _must_ be incremented each time you'll edit your zone (you'll forget and will encounter strange behaviors) then some expiry values.

- ***MX*** : Mail eXchange gives server(s) to receive emails to your domain. You can have multiple servers give them different priorities. You can of course put servers from another domain than yours.

		lord.re.                2600    IN      MX      10 zapp.lord.re.

	Here we see that my mail server is *zapp.lord.re* and it's assigned priority is *10*.

- ***NS*** : Name Server will give the different DNS servers which know your zone. The main practice is to give hostname to at least two servers and also to have the associated A records to these hostnames (like the glue records seen previously).

		lord.re.                3600    IN      NS      zapp.lord.re.

	The (lonely) nameserver for my zone is (once again) *zapp.lord.re.*

- ***A*** and ***AAAA*** : They are the most famous records. They bind an hostname to an IPv4 (A) or IPv6 (AAAA) adress.

		lord.re.                600     IN      A       92.167.84.9

	Here we see that *lord.re.* can be found in *92.167.84.9*.

With this you'll have most of your required records. Later in this blog post we will see more exotics records.

## Editing your zone

There are three ways to edit your zone.

1. The first is the dirtiest : editing the zone file with your editor and tell Knot to reload the zone from the file. Not a good way to do it. Moreover, you must increment your serial. The problem is that knot will not update this file by itself so if there is an edit, your file won't be synced.

2. The second way is clean and standardized. I used it for years as [i've already written in March 2015](https://lord.re/posts/38/update-dns). It means using **nsupdate** (or it's knot variant **knsupdate**). It's clean, the syntax is understandable but i can't remember it. Each time i have to reread my article.

3. The third is more recent and is knot-specific : using **knotc** to do all the edits.

### 1 : Barbaric edits

You open the file */var/lib/knot/zones/lord.re* with your favorite editor and you edit it. You take care of the syntax and _don't forget to increment the serial_. Then you test the file with **knotc zone-check lord.re** and then you reload with **knotc zone-reload lord.re**. Job's Done.

### 2 : Interactive (k)nsupdate

You launch **knsupdate** which will result in an interactive shell.

		server 127.0.0.1 (you could edit a remote server by specifying its adress here)
		zone lord.re.
		update add|del lechamps 600 A 1.2.3.4 (choose if you want to add or delete a record)
		send

Done. It's fast and easy. You can also put all the commands in a text file and give it to nsupdate directly which is a good way to script it (but the third method is better to script).

### 3 : The Knot's way

You'll do everything in your shell with **knotc** :

		knotc zone-begin lord.re
		knotc zone-(un)set lord.re. truc.lord.re. 600 A 1.2.3.4 (you can specify multiple commands like this one)
		knotc zone-diff lord.re. (this is facultative but you'll get a little summary of the expected result)
		knotc zone-commit lord.re.

and there you go. No need to reload or increment serial.

## How to send DNS requests ?

You'll need to know a bit of a new tool : ***dig*** (or ***kdig*** it's knot's variant). It's a bit verbose but easy to use and understand. Here's the output of **dig lord.re** :

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

So what's interesting in all this ? Hmmm… ***status: NOERROR*** first. It means that there was no error (don't thank me, it's all for you). You will encounter other responses like ***NXDOMAIN*** which means Non eXistant Domain (the same thing as error 404 from http) and sometime ***SERVFAIL*** which means an error from the server (bad configuration, bad zone or else (read your logs)).

Next you'll check the flags. You'll want the ***ad*** flag which indicate that the response is DNSSEC valid.

Then you have the ***QUESTION SECTION*** which shows what's your request followed by the ***ANSWER SECTION*** which comes from the server. You also have the time it took to receive the answer and the adress of the server.

You can query a specific server by adding ***@8.8.8.8*** for example. You can also specify which record you want to get and also if you want to have a trustable answer with dnssec. **dig lord.re @8.8.8.8 +dnssec MX** or **dig @8.8.8.8 +dnssec lord.re MX** (i find this order more logic).

With this small howto you should be able to do almost all queries to debug all your dns problems !

## Other exotic uses of DNS

Most of the time we use dns as simple directory to translate hostnames to IP adresses. But there are other uses.

A frequent use is DNSBL systems : DNS Black List. It's a way to query public (or paywalled) blacklists thanks to DNS requests. It's quite popular among antispam systems. You just need to query a specifically designed dns server with the domain name of the sender mail server and the dns server will answer with predefined answers. For example *where is mail.sender.spam.com ?* and the dnsbl's response will be **127.a.b.c** where *a*, *b* and *c* corresponds to specific values indicating the spamminess level of the hostname. It's a fast system very efficient. A good layer on your antispam.

Let's see some cases _we_ will use. With time, we added a lot of new record types in the DNS which some are now crucial.

## Records related to SSH : SSHFP

When you connect to an ***SSH*** server, it will send its fingerprint. It's the only way to be sure the server IS the server you want and not another one : if the fingerprints changed from a previous session you SSH client will print you it's prettiest error message. But but but ! *How to know if the first time you connect to the server that its fingerprint is the good one ?* Well, just publish it in your DNS zone ?

Your SSH fingerprint can be put in an ***SSHFP*** record. To generate it, on your SSH server just send **ssh-keygen -r lord.re**.

	lord.re IN SSHFP 1 1 1516af909e7de59af0e4b7cbaefb81c5ddf36b70
	lord.re IN SSHFP 1 2 f144fd71beb47a02cc904e305cc35c6ffe034e67b92aa54d1e382c1c1900a104
	lord.re IN SSHFP 2 1 83664295d1e46c80cc3ba7865294cbd1649f6350
	lord.re IN SSHFP 2 2 c1c1de2b19e6d4e451a9057a3ccc40a53ca29b69c7e2dd006ff4e8884c062ee6
	lord.re IN SSHFP 3 1 1929f7d32788a5884d862d2c28a226c73fd62944
	lord.re IN SSHFP 3 2 990dfb4b2f3486fb6bf5e5e5a3dd02344da6f42ce5b02992385dfbde30c5d24d
	lord.re IN SSHFP 4 1 493848772bcb5b6225424e58e5274984d825f01a
	lord.re IN SSHFP 4 2 335d5e9ec2d901b7ffd693fe614f73e4ad0afa40c72d9867dadfd155016c0029

You have now a well formatted record to copy paste in your zone.

It's a good new default for ssh clients to check these records. In */etc/ssh/ssh_config* you should add ***VerifyHostKeyDns yes*** (or ***ask***). With this in place you have greatly reduced the ***TOFU*** threat of SSH (Trust On First Use). You should really do it for all your SSH servers).

## Records related to TLS : CAA and TLSA


### CAA

[As previously seen](https://lord.re/en/posts/61-dns-caa/), ***CAA*** records will avoid legit ***CA*** to sign a certificate for your domain if they are not the one you choose. I consider this new record almost mandatory now. It won't protect you from a rogue CA but that's not the same threat level. It can prevent another adminsys from using another CA behind your back. So here's the only three lines you'll need : 

	lord.re.                600     IN      CAA     0 iodef "mailto:lord-x509@lord.re"
	lord.re.                600     IN      CAA     0 issue "letsencrypt.org"
	lord.re.                600     IN      CAA     0 issuewild "letsencrypt.org"

The first line is the mail adress a CA will contact in case of an attempt to sign without consent. The second line designate the authorized CA for classic certs and the third for wildcard certificates.

### TLSA

***TLSA*** is a bit more complex. It's part of the ***DANE*** standard ([DNS Authentication of Named Entities](https://en.wikipedia.org/wiki/DNS-based_Authentication_of_Named_Entities)) which lets you publish your cert (or its hash) of a TLS secured service. The ultimate goal of DANE is to get rid of CA and putting the trust chain in the DNS. Instead of relying on a third party to attest your certificate is trustable this role is now in your DNS server and DNSSEC. Bad news : nothing implements it. Only postfix and some plugins for your browser, that's all. But you can have a CA and publish TLSA record. Braces and leather belt (french). You can use DANE/TLSA on any service relying on TLS : http, smtp, imap, irc, … anything.

We won't work to much, we will do as everybody and use [the popular well-made generator](https://www.huque.com/bin/gen_tlsa).

- You fill the fields (3/1/1)
- You paste your cert (not your private key !)
- You put the port number of your service (443 for https for example)
- the used protocol (tcp for https)
- and you add your domain (lord.re or eventually www.lord.re)

Pouf ! The *generate* button will create your record. To be valid with DANE, your zone **MUST** bet served with DNSSEC (in my case lord.re can't because of my registrar which can't take a DS record -___- ).

## Records related to emails : SPF, DKIM, DMARC, STS and OPENPGPKEY

Here is where the party is ! The email being one of the oldest Internet's use, it grew with lots of new protocols and other fancy stuffs. Most of what we will see are attemps to bring new features to mail mostly on the security side : authentication for the most part. Let's start slowly.

### SPF

The easiest of the band. This record will define wich machines/IP are authorized to send mails from your domain. Most of the time, you'll only expect to send mails from your MX machines.

There is an ***SPF*** record type but [it's now deprecated](https://tools.ietf.org/html/rfc7208) (too bad), in favor of a simple ***TXT***.

	lord.re.				600	IN	TXT	"v=spf1 mx -all"

It means *mx* machines are allowed whereas *all* are disallowed to send mails. It's just an information. When someone receive a mail they can look for this information.

### DKIM

***Domain Key Identified Mail*** is one step higher. It's a cryptographic system to sign your outcoming mails and it's headers. Receiving servers will check that you mail match the signature in your DNS's zone. It's a way to prevent another mail server to send mail from your domain. It's also a way to assure the receiver that your mail hasn't been modified by any intermediate server.

This time you'll have to setup your mail stack to sign outgoing mails. There are may ways to do this and as it's out of the scope of this article … well … you'll have to duckduckgo it (I use rspamd to do it with postfix). You'll get a public key that you have to publish in your zone in a TXT record : 

	default._domainkey.lord.re.     3600    IN      TXT     "v=DKIM1; k=rsa; p=MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC06MC2/9/YtSn9BS09oMN26UdKO6DMGlCWYsodQ8P+t2CzsSzqUJxaszJmWZglqZyXRjaCMAFUoOF7GiyhXhqM4rSLGxaPHfrLK7f9YlJYAnqdhzEJdEjP8/vkJoMTJxINP9gEBi+wGSGEhoha514NHHtZ4g+QbJZliahwAjl0BQIDAQAB"

Now that you've set up SPF and DKIM, other mails servers won't know what to do if your mails aren't DKIM-valid or if SPF isn't respected. 

### DMARC
Here is the way to tell other servers what to do if there is something wrong with SPF or DKIM. ***DMARC*** is the next step after SPF and DKIM. It's still a TXT record : 

	_dmarc.lord.re.    600 IN TXT "v=DMARC1;p=none;pct=100;rua=mailto:lord-dmarc@lord.re;ruf=mailto:lord-dmarc@lord.re;sp=none;adkim=s;aspf=s"

It's straight forward :

- ***p=none*** is the policy others must adopt. With ***none*** they do what they want. If you are sure about your stack you can put ***quarantine*** or even stricter ***reject***.
- ***rua*** and ***ruf*** is an email adress to contact to report any problem
- Last : ***adkim=s*** and ***aspf=s*** means that you want a ***s***trict check of SPF and DKIM. With this, your hostname must perfectly match (the ***r*** mode (for ***r***elaxed) lets you send with subdomains too).

My advice is to slow start with none and if everything works fine step up to quarantine and maybe later to reject. Don't go too fast or all your mails will fall in spam boxes.

### STS

This one is brand new. It's not official yet but it's promising even if it's a bit hard to deploy it. You'll need a web server where you'll put a bit of *json* in the *.well-known* directory of your web root. Because of that i didn't add it yet.

This new record is a way to inform other MTAs how to connect to your server : you can tell them to reject a plaintext connection. It's a good way to protect your privacy.

The record looks like this ```_mta-sts.lord.re.  IN TXT "v=STSv1; id=20160831085700Z;"```. 

It contains an id of policy which MTAs will have to fetch from your web server. It could have been written directly in the dns record but… no they decided to go overkill.

### OPENPGPKEY

I don't use this one either (in fact i don't use pgp for my mails). It's a way to publish public keys in your DNS's zone. From a certain point of view it can be considered better than relying on a Public Key Server. As I don't use theme I'll let you use [this generator](https://www.huque.com/bin/openpgpkey).

### Mail summary

Now you protect yourself from server spoofing thanks to DKIM and SPF. You make sure no one edit your mails on the fly thanks to DKIM and DMARC. You force your mails to never travel on plaintext with STS (except on the emmiting and receiving ends). And you make sure that servers themselves can't edit/read your mails thanks to PGP. You mail stack is now bulletproof !

## Global thoughts ?

Hmmm yes. DNS now can hold many public informations where authenticity is critic. Editing DNS requests on the fly can become a severe attack to your privacy and have heavy consequences (ssh spoof, mail spoof, tls spoof…). Deploying **DNSSEC** is not an option anymore. Using a validating DNS recursor is also of the utmost importance. Deploying HTTP service without TLS became non-sense sinc Letsencrypt came. Deploying DNS without DNSSEC is now the same.

## Interesting links :
- [OPENPGPKEY record generator](https://www.huque.com/bin/openpgpkey)
- [TLSA generator](https://www.huque.com/bin/gen_tlsa)
- [TLSA check](https://www.huque.com/bin/danecheck)
- [DNSSEC check](http://dnssec-debugger.verisignlabs.com)
- [Knot's Documentation](https://www.knot-dns.cz/documentation/)
- [RFC mta-sts](https://www.ietf.org/id/draft-ietf-uta-mta-sts-10.txt)
