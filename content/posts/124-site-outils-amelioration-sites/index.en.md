+++
Author = "Lord"
Description = "Here are some tools to improve your website, your mail server and/or your dns server."
Categories = ["web", "mail","dns"]
menu = "main"
notoc = true
PublishDate = 2018-09-02T09:35:41+02:00
date = 2018-09-02T09:35:41+02:00
lastEdit = 2018-09-02T18:25:41+02:00
title = "Some webtools to improve your website / mail / DNS"
editor = "kakoune"
+++
There is a lot of websites trying to help you improve your website, your mail server or DNS server.
They try to promote good practice conterning accessibility, performances, security, SEO, reliability.

Most of them will analyze your site (or at least one page) and will give you a score and some advices to improve your score.
I like this concept.
*Gameification* to improve yourself.
Most of the time it's *free*, *fast* and *useful*.

So here is the list :

## Multiples
  - [WebHint](https://sonarwhal.com/) : A lot of different criterias in a beautifull interface and some advices you won't find elsewhere. Harder than others.
  - [Dareboost](https://www.dareboost.com/) : Very pretty and modern (he knows http2 for example), it analyzes performances, security and SEO.

## Security

  - [SSLLabs](https://www.ssllabs.com/ssltest/analyze.html) : it's probably the most famous to check your TLS setup. Try to at least get an *A*, it's not so hard, free and without any side effects and do it regularly as it evolves continually.
  - [CryptCheck](https://tls.imirhil.fr/) : way less popular but way faster and as reliable than the previous one. It can also check SMTP and XMPP.

## Accessibility

  - [Wave](http://wave.webaim.org/) : Quite good as it checks the structure of your site but can also check the contrast (a bit harder to have 0 warning but you should really try to).
  - [AChecker](https://achecker.ca/checker/index.php) : This one is exhaustive and can check the [WCAG](https://fr.wikipedia.org/wiki/WCAG). Very hard to have a perfect website but you can still improve a lot of different things easily.

## Performance

  - [Pingdom](https://tools.pingdom.com/) : Easy to understand and can test your website from different countries.
  - [GTMetrix](https://gtmetrix.com/) : More or less the same as Pingdom very famous.
  - [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) : This one is made by Google with their rules so listening to this one can be crucial for your SEO.

## SEO

  - [SEOSiteCheckup](https://seositecheckup.com/) : I think this one can be usefull. I don't give a shit…
  - [WooRank](https://www.woorank.com/) : The same but different.

## Misc.

  - [EcoIndex](http://www.ecoindex.fr/) : This one will test your website on the environnemental side. The better your score, the less negative impact you have.
  - [1and1 Website Checker](https://www.1and1.com/website-checker) : Not so good but still some good advices.
  - [PowerMapper](https://try.powermapper.com/Demo/SortSite) : This one is a free demo but it's very complete. It will check your performances, accessibility, SEO, syntax, spellchecking…
  - [NetRenderer](http://netrenderer.com/index.php) : If you care about Internet Explorer this can be handy but… it's 2018 !

## Not web but Mail

  - [MXToolBox](https://mxtoolbox.com/) : The real toolbox. You'll find most of the tools you need.
  - [Mail Tester](https://www.mail-tester.com/) : This one can test an outgoing email before sending it in a newsletters to check its spaminess.
  - [SMTP STS Check](https://www.fraudmarc.com/smtp-mta-sts-policy-check-2/) : This one will check your MTA-STS. If you don't know what it is, you don't need it.

## Not mail but DNS

  - [ViewDNS](https://viewdns.info/) : A classic network toolbox mostly focused on DNS. There exists a lot of alternatives to this one.
  - [ZoneMaster](https://www.zonemaster.net/) : A tool from AFNIC which could be usefull if you host your own zone and check everything.
  - [DNSSec-Analyzer](https://dnssec-analyzer.verisignlabs.com/) : This one will check your DNSSec deployement. If you care about DNSSec this one can really help you.
  - [DNSViz](http://dnsviz.net/) : Quite similar to the previous one but more graphical.
 
-------------------------

With all this you can have a great site/mail/dns.
I'll continue trying to improve my scores on these (mostly in accessibility.

-------------------------
**PS :**
Thanks to Pifyz, Pofilo et Cascador for submitting some of these !
