+++
Author = "Lord"
Description = "Quelques sites/outils pour améliorer votre site ouaib et votre serveur mail."
Categories = ["web", "mail"]
menu = "main"
notoc = true
PublishDate = 2018-09-02T09:35:41+02:00
date = 2018-09-02T09:35:41+02:00
lastEdit = 2018-12-03T21:09:41+02:00
title = "Quelques sites/outils pour améliorer votre site"
editor = "kakoune"
jdf = "https://www.journalduhacker.net/s/rad4ru/quelques_sites_outils_pour_am_liorer"
+++
Il existe de plus en plus de sites promouvant de bonnes pratiques pour le web.
Ça peut être à propos de l'accessibilité, ou bien de la sécurité ou des performances.

Ils vont donc analyser votre site (ou au moins une page) et vous attribueront une note, et proposeront des conseils pour améliorer votre jouet.
J'adore ce concept.
Un peu de *gameification* (attribution du score) pour un *cercle vertueux*.
En plus c'est généralement assez *rapide* et *pertinent*.

Donc voilà une ptite liste de différents sites du genre :

## Multiples
  - [WebHint](https://sonarwhal.com/) : un peu de tout avec une très jolie interface et des conseils qu'on retrouve pas ailleurs. Plus poussé que les autres du genre.
  - [Dareboost](https://www.dareboost.com/) : Très joli et assez moderne (il gère http2 par exemple), il analyse un peu la sécurité et le SEO également.

## Sécurité

  - [SSLLabs](https://www.ssllabs.com/ssltest/analyze.html) : est probablement le plus connu pour juger votre mise en place de TLS. Visez au minimum du *A*, c'est vraiment pas compliqué et c'est gratuit et n'a aucun effet secondaire.
  - [CryptCheck](https://cryptcheck.fr/) : moins connu mais beaucoup plus rapide et tout aussi pertinent que le précédent. Il peut également vérifier votre serveur SMTP et XMPP.

## Accessibilité

  - [Wave](http://wave.webaim.org/) : Assez complet concernant à la fois la structure du site mais également la vérification du contraste (et là c'est dur de n'avoir aucune alerte !).
  - [AChecker](https://achecker.ca/checker/index.php) : très complet aussi et s'intéresse beaucoup à la norme [WCAG](https://fr.wikipedia.org/wiki/WCAG). Dur d'avoir un site parfait également mais pas mal de ptits trucs sont corrigeables sans difficulté.

## Performance

  - [Pingdom](https://tools.pingdom.com/) : Joliment fait et permet de tester depuis plusieurs coins du globe.
  - [GTMetrix](https://gtmetrix.com/) : Très connu aussi celui-là et complet. 
  - [PageSpeed Insights](https://developers.google.com/speed/pagespeed/insights/) : forcément c'est made in Google donc si vous voulez être bien vu, il faut avoir un bon score sur celui-là.

## SEO

  - [SEOSiteCheckup](https://seositecheckup.com/) : J'imagine qu'il est pertinent. Perso je m'en fous un peu…
  - [WooRank](https://www.woorank.com/) : À peu près pareil qu'au-dessus.

## Vrac

  - [EcoIndex](http://www.ecoindex.fr/) : Celui-là vous jugera sur l'aspect plus environnemental de votre site.
  - [1and1 Website Checker](https://www.1and1.com/website-checker) : Bon ça vaut pas grand-chose mais certains conseils sont toujours bons à prendre.
  - [PowerMapper](https://try.powermapper.com/Demo/SortSite) : Alors celui-là c'est qu'une démo mais est pas mal complet. Il fait un peu d'analyse de perf, de l'accessibilité, de l'utilisabilité, un peu de SEO, de la conformité de syntaxe…
  - [NetRenderer](http://netrenderer.com/index.php) : Si jamais le rendu de votre site ouaib sur Internet Explorer vous intéresse…
  - [HTML Validator](http://validator.w3.org/) : le classique du W3C pour valider la syntaxe de votre HTML.
  - [CSS Validator](http://jigsaw.w3.org/css-validator/) : la même mais pour le CSS.
  - [Down or Not](https://www.websiteplanet.com/fr/webtools/down-or-not) : permet de tester si un site déconne pour tout le monde ou juste pour vous.

## Pas du web mais du Mail

  - [MXToolBox](https://mxtoolbox.com/) : Il fait un peu tout concernant le mail.
  - [Mail Tester](https://www.mail-tester.com/) : est pas mal pour tester un mail avant d'envoyer dans une newsletter voir à quelqu'un point il ressemble à du spam.
  - [SMTP STS Check](https://www.fraudmarc.com/smtp-mta-sts-policy-check-2/) : Pour tester votre implémentation de MTA-STS.

## Pas du Mail mais du DNS

  - [ViewDNS](https://viewdns.info/) : la trousse à outil classique qu'on retrouve sur d'autres sites du même genre.
  - [ZoneMaster](https://www.zonemaster.net/) : outil de l'AFNIC très sympas si vous avez un serveur DNS pour vérifier que la conf soit correcte.
  - [DNSSec-Analyzer](https://dnssec-analyzer.verisignlabs.com/) : Celui-là vous permettra de vérifier que votre conf DNSSec est correcte.
  - [DNSViz](http://dnsviz.net/) : Assez similaire au précédent mais un peu plus graphique.
 
-------------------------

Bon avec ça, normalement vous avez très probablement de nombreuses pistes d'amélioration pour votre site et un peu aussi pour votre serveur mail.
Je vais tenter de grappiller quelques points pour l'accessibilité encore.

-------------------------
**PS :**
Merci à Anna, Pifyz, Pofilo, Cascador et Tuxi pour leurs propositions !
