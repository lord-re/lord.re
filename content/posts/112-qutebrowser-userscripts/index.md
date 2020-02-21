+++
Author = "Lord"
Description = "Utiliser des userscripts dans Qutebrowser nativement."
Categories = ["qutebrowser", "javascript","web"]
menu = "main"
notoc = true
PublishDate = 2018-07-01T09:45:56+02:00
date = 2018-07-01T09:45:56+02:00
title = "Les userscripts dans Qutebrowser"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/nmdzkj/les_userscripts_dans_qutebrowser"
TopWords = [  "qutebrowser", "scripts"]
+++
Qutebrowser est un [super navigateur]({{< ref "/posts/64-qutebrowser" >}}) mais sur certains points il est loin des ténors.
Son développement est bien plus lent que celui de Chrome et Firefox car c'est un projet bien plus petit avec bien moins de contributeurs et aucune entreprise commerciale pour pousser.
Il n'en reste pas moins tout à fait fonctionnelle et propose une alternative crédible au prix de maigres sacrifices.

Un des sacrifices à faire est l'absence d'extensions.
Mais on peut toute fois lui ajouter des userscripts.
Il s'agit de petits bouts de javascripts qui s'executent sur les pages web pour modifier le comportement de la page.

C'est un système qui se base à l'origine sur l'extension [Greasemonkey](https://www.greasespot.net/) créée en 2005 mais qui a été souvent remplacé par [TamperMonkey](http://tampermonkey.net).
Depuis, pas mal de navigateurs ont adoptés différents moyens pour être compatibles avec ces scripts.

## Dans QB
Donc Qutebrowser ne fait pas exception à la règle et est nativement compatible avec ces *userscripts*.
Pour les utiliser, rien de plus simple : **Placez les scripts dans .local/share/qutebrowser/greasemonkey** et voilà.

Super simple, rien à modifier ou autre.

Par contre faut le relancer…

## Où les trouver ?

Plusieurs sites.

Il y a [Greasy Fork](https://greasyfork.org/en/scripts) qui en propose pas mal mais je suis trop fan de l'interface.
Un meilleur site est [OpenUserJS](https://openuserjs.org/).

## Ceux que j'utilise

  - Pour Youtube j'utilise [Iridium](https://github.com/ParticleCore/Iridium) qui permet d'ajouter tout pleins d'options pour Youtube plus ou moins utile (dont la possibilité de continuer la vidéo même en changeant de page sur youtube).
  - Pour explorer son système de fichier local j'utilise [Supercharged Local Directory File Browser](https://openuserjs.org/scripts/gaspar_schot/Supercharged_Local_Directory_File_Browser) qui vous mettra une interface pas mal du tout lorsque vous ouvrez *file:///home/lord/* .
  - Celui-là ne m'a jamais servi car je l'ai découvert après en avoir eu besoin mais je l'ai au cas où : [Remove Web Limits](https://greasyfork.org/en/scripts/14146-%E7%BD%91%E9%A1%B5%E9%99%90%E5%88%B6%E8%A7%A3%E9%99%A4) empêche les sites de bloquer les clics droits, copier/coller et compagnie. Généralement les sites qui font ça je les contourne simplement par le fait que je n'active javascript qu'au cas par cas.

Voilà tout.
Il y en a des tas d'autres mais j'ai su rester raisonable.
