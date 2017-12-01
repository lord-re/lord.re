+++
Author = "Lord"
notoc = true
menu = "main"
date = "2017-10-06T11:49:01+02:00"
PublishDate = "2017-10-06T11:49:01+02:00"
title = "Using CAA dns records to protect your TLS"
Tags = ["adminsys","sécu"]
Categories = ["adminsys","sécu"]
Description = "Enhancing your TLS stack thanks to this new dns record."

+++

There is a global move toward better crypto security since Snowden revelations. It's a good thing. More security and more privacy is a good thing to everyone. It's better when it's well done if not it's counter-productive. Letsencrypt is a big contributor to the actual trend by democratising x509 certs thanks to its easy to use protocol and it's very competitive pricing.

## Certificate Transparency
Like many ***CA*** (certification authority : the one who sign your certs), Letsencrypt adopted the ***Certificate Transparency***. It's a public log maintained by CA where they publish every certificate they issue. With this, you can't have your cert being signed without being published.

With this system, you'll be able to know if a trustable CA (ie : which participate to Certeficate Transparency) signed a certificate for you without you knowing it. It's a good way to know certificate spoofing.

## CAA
So Certificate Transparency is one big step toward better security but there is something new ! It's now possible for any domain owner to specify which CA is allowed to sign your certs ! Since September 2017, every CA **must** check if they are allowed to sign your cert. To do it they will check the ***CAA*** dns record of your domain.

If you didn't specify anything in your dns zone, any CA can sign a cert. It's another huge step to enhance your TLS security.

## How to ?
So you go in your dns zone and add a single line ```lord.re. CAA 0 issue "letsencrypt.org"``` and that's it. Only Letsencrypt is allowed to sign any cert from you.

You can even add another line to specify which CA is allowed to sign a wildcard cert : ```lord.re. CAA 0 issuewild "letsencrypt.org"``` It's pretty straight forward. Logic. You can even add more lines if you want to have more than one CA.

The last thing you can specify is an adress mail to contact to let CA notify you in case of a denied signature : ```lord.re. CAA 0 iodef "mailto:truc@votrema.il"``` and voilà !

## We supercharge more the dns role and we are still dependant from CA
More and more DNS contain sensible data. We already publish SSH public keys, we put TLS public keys too and now we publish authorized CA. It's more and more crucial to secure your DNS. ***DNSSEC*** become more and more essential. 

CA's role is still central. A rogue CA could still not publish signed certs to the public log… It could also not take into account CAA records… Their job still rely in trust. ***DANE*** is still relevant and it's quite sad that nobody try to implement it. Wouldn't it be great if ***TLSA*** records and ***CAA*** records would be checked by web browsers ?
