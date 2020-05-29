+++
Author = "Lord"
Description = "Les navigateurs web présentent un User-Agent plein d'info bidons. C'est principalement pour des histoires de compatibilité historiques. Est-il possible de repartir de 0 ?"
Categories = ["web", "culture"]
menu = "main"
notoc = true
WritingDate = 2020-05-25T10:17:55+02:00
date = 2020-05-29T10:17:55+02:00
title = "Continuer à mentir sur son web UA ?"
editor = "kakoune"
TopWords = [  "user-agent", "chrome", "firefox", "gecko", "khtml", "safari", "navigateur"]
+++
Le **User-Agent** est un logiciel qu'utilise un … utilisateur.
Dans le cas du web, c'est votre navigateur web.

## Quelques User-Agent dans la nature
Quand vous vous promenez sur le web, vous ne le savez ptet pas mais vous envoyez à chacun des sites que vous visitez le nom de votre navigateur.
Mais attention, c'est pas un nom simple et logique.

### Firefox
Par exemple si vous utilisez **Firefox**, il va pas envoyer <samp>Firefox 77</samp>, non non, il va plutôt envoyer <samp>Mozilla/5.0 (<abbr title="le système d'exploitation sous-jascent, ici un windows 10 en version 64bits">Windows NT 6.1; WOW64; rv:77.0</abbr>) <abbr title="Gecko c'est le nom du moteur de rendu de firefox, ici dans une version datée du premier janvier 2019">Gecko/20190101</abbr> Firefox/77.0</samp>

C'est pas super digeste pour un non-initié.
Mais en gros dans cet exemple ça donne l'information concernant l'OS, la version du navigateur, la version du moteur du rendu.
C'est plutôt précis et à peu près cohérent.

### Safari
Si vous êtes plutôt utilisateur de **Safari** sur Mac ça aura une allure de ce genre <samp><abbr title="ici, c'est faux, mais c'est conservé par habitude">Mozilla/5.0</abbr> (<abbr title="l'OS sous-jacent">Macintosh; Intel Mac OS X 10_9_3</abbr>) <abbr title="le moteur de rendu est effectivement webkit">AppleWebKit/537.75.14</abbr> (<abbr title="webkit est un fork de KHTML qui a été initié par l'équipe de KDE, cette information est vraie mais peu utile">KHTML</abbr>, <abbr title="ouai bha là, c'est historique, c'est pour indiquer que ça fonctionnait comme gecko il y a fort longtemps">like Gecko</abbr>) Version/7.0.3 Safari/7046A194A</samp> .
Ça devient un peu foutraque tout ça avec près de la moitié des infos qui sont fausses ou juste plus vraiment d'actualité.

### Chrome
Vous êtes encore plus diaboliques et utilisez le vrai **Chrome** sur un Windows ?
<samp><abbr title="Comme pour Safari, cette info est fausse mais utilisée historiquement pour contourner des sites mal fichus">Mozilla/5.0</abbr> (<abbr title="l'OS sous-jacent">Windows NT 10.0; Win64; x64</abbr>) <abbr title="Cette info était vraie jusqu'en 2013, lorsque Google a décidé de forker Webkit pour créer blink son moteur de rendu">AppleWebKit/537.36</abbr> (<abbr title="donc je résume, chrome utilise blink qui est issu de webkit qui lui est issu de khtml… c'est donc de moins en moins vrai">KHTML</abbr>, <abbr title="ouai par compatibilité on indique que KHTML se comportait comme Gecko le moteur de Firefox… ça date">like Gecko</abbr>) <abbtr title="ça c'est vrai !">Chrome/70.0.3538.77</abbr> <abbr title="Ça c'est faux">Safari/537.36</abbr></samp>
Là c'est digne d'un [bullshit artist]({{< ref "visionnages/the-greasy-strangler">}}). À peu près tout est faux…
Ça se fait passer pour Firefox, pour Safari, pour KHTML, bref pour tout le monde.
C'est une accumulation de croutes pour tenter d'être compatible avec des sites biens pourris.

### Edge
Bon allez pour le fun je vous montre celui d'**Edge** le navigateur méconnu d'une ptite startup États-Unienne :
<samp>Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.102 Safari/537.36 Edge/18.19582</samp> .
Toujours plus !
Il me tarde de voir ce que ça racontera dans vingt ans !

## But why ?
Si vous vous demandez pourquoi les navigateurs s'identifient comme ça, il faut remonter dans le temps.
Il n'y a pas si longtemps, les sites ouaib utilisaient des feintes pour construire leurs pages au lieu de se contenter de ce qui était standardisé.
Du coup, pour s'afficher correctement, ils tentaient de détecter quel navigateur était utilisé afin d'envoyer un contenu différent.

Mais les navigateurs évoluaient vite et se sont mis à s'imiter les uns les autres et ont tenté de deviner les logiques utilisées dans la détection pour forcer les sites ouaibs à leur envoyer le contenu prévu pour un autre navigateur.
Et ça s'est enchaîné…

## Et Donc ?
Les plus assidus auront remarqué que j'avais déjà parlé de ça il y a un an et demi dans [cet article]({{< ref "shares/13-browser-user-agent" >}}).
Du coup pourquoi je vous emmerde encore avec cette histoire ?
Et bien en fait j'avais envie d'écrire.

Ha et aussi parceque c'est revenu sur le tapis sur IRC l'autre jour et je me suis donc décidé à tenter le diable.
Dans l'article en conclusion j'avais dit que "ptet ben qu'oui, ptet ben qu'non, on peut rien y changer" .
J'aimerai pouvoir vous apporter une réponse un peu moins normande.

J'ai confé mon navigateur (le chouette [Qutebrowser]({{< ref "posts/64-qutebrowser" >}}) ) pour qu'il envoie comme information <samp>Quterbrowser</samp>.
Voilà, tout simplement.
Pas de fioriture.

## KoiKiKass ?
Et vous savez quoi ?
Après quelques jours, tout fonctionne bien.

Tout ?
Non !
Quelque part sur le web un petit fournisseur de services résiste aux bonnes pratiques et à la neutralité des navigateurs web.
Les gens derrière ces sites ouaib, mais est-il encore nécessaire de les présenter, y-a-t-il quelqu'un sur ce site qui ne les connais pas ?

Ha bon :-/
Ça va, baissez les mains, baissez les mains, je vais faire les <abbr title="c'est une référence à Asterix pour ceux qui ne l'aurait pas remarqué">présentations</abbr>.

Il s'agit de **Youtube**, un petit site de vidéo et **Google Maps**, un petit site de cartographie.
On peut probablement excuser leur difficulté à mettre à jour leurs sites ouaib pour s'adapter au web moderne…

Bref, fini le foutage de gueule.
*J'affirme clairement pas qu'aucun autre site ne déconnera, mais ces quelques jours je ne suis tombé sur aucun autre merdouillant parmi mes habitudes régulières de surf.*

Par exemple, Youtube change d'affichage et perd au passage le mode sombre.
Il ne permet plus de voir le livechat sur les vidéos en disposant.
Alors que, le même navigateur, s'annonçant différemment y arrive parfaitement.
C'est donc soit l'incompétence soit de la malveillance.
Google Maps perd l'affichage 3D sur la vue satellite.
*Est-ce vraiment de l'incompétence pour la boîte qui reçoit le plus de visite au monde et qui édite le navigateur le plus utilisé au monde ?*

Bref, je garde mon User-agent qui ment pas et je ne mens désormais qu'à Google.
Si vous voulez faire pareil avec **Qutebrowser** rendez-vous dans votre : 
<details><summary>~/.config/qutebrowser/config.py</summary>
<samp>config.set('content.headers.user_agent',"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/70.0.3538.77 Safari/537.36", '*://www.youtube.com/*')</samp>
</details>
voilà voilà.
