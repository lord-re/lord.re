+++
Author = "Lord"
Description = "Petit aide-mémoire pour la gestion du spamfilter sur unrealircd"
Categories = ["irc", "tips"]
menu = "main"
notoc = true
PublishDate = 2018-06-03T10:47:28+02:00
date = 2018-06-03T10:47:28+02:00
title = "Gérer les spamfilters sur UnrealIrcd"
editor = "kakoune"
+++
Unrealircd est un <abbr title="serveur IRC, c'est à dire un serveur de chat">ircd</abbr> très populaire qui a près de vingt ans désormais mais à connu un sursaut d'activité ces dernières années pour arriver en version 4.
On l'utilise notamment chez [Geeknode](http://geeknode.org/) sur les quelques serveurs du réseau.

Et comme tout réseau IRC qui se respecte, on subit régulièrement des relous qui viennent spammer les salons et les utilisateurs de façon plus ou moins créative.
Un groupe particulièrement chiant passe régulièrement pour faire leur propagande en floodant.

Bref un moyen de contrer leur spam est donc d'utiliser la fonction [Spamfilter](https://www.unrealircd.org/docs/Spamfilter) d'Unrealircd.

J'avais un peu survolé les différentes actions que peuvent faire un ircop [ici]({{< ref "/posts/55-irc-niveau-5" >}}) mais là c'est spécifique au spamfilter.

## Spamfilter
La syntaxe est à première vue assez simple mais pourtant toujours un peu spéciale.

### Lister
Déjà pour lister les filtres déjà existant : <samp>**/spamfilter**</samp>.
Ce qui vous sortira un listing de ce genre :

    10:26:33   geeknode  -- │ F simple cpnNPq kill 0 9842810 86400 "supernets" Lord!Lord@geeknode.fuckyeah :iяс.sцреяиетs.ояg сни sцреявоwl
    10:26:33   geeknode  -- │ F posix cpnNPq tempshun 0 25184053 86400 racisme Lord!Lord@geeknode.fuckyeah :*vap0r*freenode*
    10:26:33   geeknode  -- │ F posix cpnNPq kill 0 25696998 86400 supernets Lord!Lord@geeknode.fuckyeah :*SUPERNETS*
    10:26:33   geeknode  -- │ F posix cpnN tempshun 0 26141654 60 spam Lord!Lord@geeknode.fuckyeah :*www.icq-net.eu*
    
### Ajouter
Bon pour ajouter un nouveau filtre c'est assez simple si l'on suit la doc

**<samp>/spamfilter add -regex cnNPq kill 0 l0de_spammer \ [lL1][oO0][dD][eE3]\ </samp>**

En y regardant de plus près on voit quelques trucs chiants :

  - Le type de spamfilter commence par un *-* donc c'est pas juste <samp>regex</samp> ou <samp>simple</samp> mais <samp>-regex</samp> ou <samp>-simple</samp>.
C'est le truc que j'oublie à chaque fois.

  - Ensuite, dans la raison il faut remplacer les espaces par des underscore <samp>_</samp> (le «tiret du 8»).

  - Mais surtout dans la regex elle-même, on ne peut pas foutre d'espace, il faut les échapper avec "*<samp>\ </samp>*".

### Supprimer
Bon pour l'instant cet article n'apporte pas grand chose de plus que la page du wiki vous me direz.
C'est vrai. :-(

Mais mais mais je vais me rattraper tout de suite avec cette astuce de sioux !

En théorie pour supprimer un spamfilter vous devez faire exactement la même commande que lorsque vous en avez mis un en place.
Mais c'est pas forcément simple car lorsque vous les listez la syntaxe est pas exactement la meême.
C'est vite très chiant à retrouver.

Mais si vous faites **<samp>/spamfilter del</samp>** vous aurez un listing mieux foutu :

    10:41:56   geeknode  -- │ F simple cpnNPq kill 0 9843733 86400 "supernets" Lord!Lord@geeknode.fuckyeah :iяс.sцреяиетs.ояg сни
                            │ sцреявоwl
                            10:41:56   geeknode  -- │ To delete this spamfilter, use /SPAMFILTER del 0x7f7421b79b40
                            10:41:56   geeknode  -- │ -
                            10:41:56   geeknode  -- │ F posix cpnNPq tempshun 0 25184976 86400 racisme Lord!Lord@geeknode.fuckyeah :*vap0r*freenode*
                            10:41:56   geeknode  -- │ To delete this spamfilter, use /SPAMFILTER del 0x7f74216e0080
                            10:41:56   geeknode  -- │ -
                            10:41:56   geeknode  -- │ F posix cpnNPq kill 0 25697921 86400 supernets Lord!Lord@geeknode.fuckyeah :*SUPERNETS*
                            10:41:56   geeknode  -- │ To delete this spamfilter, use /SPAMFILTER del 0x7f74216dfe00
                            10:41:56   geeknode  -- │ -
                            10:41:56   geeknode  -- │ F posix cpnN tempshun 0 26142577 60 spam Lord!Lord@geeknode.fuckyeah :*www.icq-net.eu*
                            10:41:56   geeknode  -- │ To delete this spamfilter, use /SPAMFILTER del 0x7f74216dfd30

Et surtout ils donnent une commande avec un *id* pour le supprimer facilement \o/.

Joie et Félicité.

Bon bha voilà, l'article avait un peu d'intéret quand même (plus pour moi que pour vous car je n'arrive vraiment pas à mémoriser cette syntaxe et ce truc pour virer les anciens spamfilters).

Tiens et tant qu'à y être, pour les curieux qui se demandent à quoi ça ressemble quand un spamfilter se déclenche :

    11:16:29   united.geeknode.org  -- │ united.geeknode.org: [Spamfilter] lorddl!lorddl@LFbn-1-7920-9.w92-167.abo.wanadoo.fr matches filter '\ [lL1][oO0][dD][eE3]\ ': [PRIVMSG #testage: 'lode lode lode'] [l0de spammer]

On voit sur quel serveur était connectée la personne, son identité, la regex qui a déclenché, le message qu'elle a envoyée et enfin le message envoyé comme raison.

C'est pour ça que si ça déclenche, vous risquez de voir apparaitre des <abbr title="modérateurs sur IRC">ircop</abbr> quelques temps après ;-)
