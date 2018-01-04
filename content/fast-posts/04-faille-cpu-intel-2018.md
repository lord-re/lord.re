+++
Author = "Lord"
Description = "La monoculture c'est rarement bien et ce coup-ci c'est chez les CPU qu'on s'en rend compte en ce début 2018"
Categories = ["actu", "drama","hardware"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-01-02T22:05:14+01:00
date = 2018-01-02T22:05:14+01:00
title = "Une faille de sécurité béante touchant tous les cpu Intel"
+++
Les monocultures ont de nombreuses fois prouvées qu'elles étaient un risque et pas uniquement dans l'informatique. En agriculture c'est pareil… faire pousser uniquement une seule espèce de plante est risqué. Le jour où une maladie ou bien un insecte/animal un peu gourmand s'abat sur vous, vous perdez absolument tout. Bha là c'est pour les processeurs qui prennent cher.

## Monopole d'Intel
Depuis plusieurs décennies Intel a une position de leader qui par moment ressemble à un monopole. C'est le cas depuis dix ans. Alors qu'AMD sort enfin la tête de l'eau en 2017 avec sa nouvelle architecture Ryzen après près de dix ans de désert, Intel est quasiment seul sur le marché des serveurs (gamme Xeon) et ne laisse que des miettes à AMD sur le laptop/desktop. Et d'ailleurs depuis 6 ans, les gains de perfs des CPU Intel sont vraiment faibles. Mon ordinateur actuel a déjà 7 ans et n'est toujours pas vraiment dépassé (mais bon c'est un autre débat). Mais du coup ce monopole est donc une monoculture des cpu à architecture amd64.

## Et donc ?
Bha apparemment il y aurait une faille de sécurité assez sévère trouvée très récemment. Les informations ne sont pas encore complètement publiée de partout, il y a un embargo. En gros elle **impacterait tous les ordinateurs embarquant un cpu Intel** récent (de ces dix dernières années).

Cette faille serait carrément dans l'architecture même du cpu. Un correctif logiciel pour le kernel Linux existe mais le fix ne serait pas sans conséquences. On parle de **pertes de performances de 5 à 50%** sur certains *syscalls*.

Les informations complètes seront diffusées un peu plus tard une fois que les correctifs auront été poussés un peu partout.

L'information comme quoi AMD ne serait pas impacté est arrivé dans un second temps (un [second patch](https://lkml.org/lkml/2017/12/27/2) à vrai dire).

{{< figure src="/static/meltdown.min.svg" title="Logo officiel de l'attaque meltdown" link="/static/meltdown.min.svg" >}}

## Mais c'est grave ?
Ouai vraiment grave. Cette faille serait exploitable à pleins de niveaux. Les systèmes virtualisés sont également impactés. Même du javascript dans un navigateur pourrait faire des saloperies apparemment.

Du coup bha même une machine perso serait exploitable via une page web. Tous les hébergeurs de machines virtuelles sont probablement en train de flipper et patcher à droite à gauche.

Comme dit précédemment pour l'instant on a pas tous les détails mais comme à chaque fois, on ne sait pas si la faille est déjà utilisée dans la nature.

{{< figure src="/static/spectre.min.svg" title="Logo officiel de l'attaque meltdown" link="/static/spectre.min.svg" >}}

## Et du coup faut faire quoi ?
Bha dès que le patch arrive pour votre OS, vous l'installez sans réfléchir.

Et pour la prochaine fois, vous prenez du AMD histoire de renverser un peu le monopole d'Intel. Leur nouvelle gamme fait jeu sensiblement égal avec Intel voir se débrouille mieux en nombre de cœurs.

## Un peu de lecture supp :
Quelques liens pour approfondir le sujet. Pas de français pour le moment.

  - [L'article qui popularise ça (EN)](http://pythonsweetness.tumblr.com/post/169166980422/the-mysterious-case-of-the-linux-page-table)

  - [Lire la mémoire du kernel depuis l'usermode (EN)](https://cyber.wtf/2017/07/28/negative-result-reading-kernel-memory-from-user-mode/)

  - [Discussion reddit sur le sujet (EN](https://www.reddit.com/r/sysadmin/comments/7nl8r0/intel_bug_incoming/)

  - [Journal de Pinaraf sur linuxfr qui explique bien mieux que moi (FR)](https://linuxfr.org/users/pied/journaux/ca-sent-pas-bon-chez-intel)

## PS :
Ha bha visiblement il y a des **soupçons de délit d'initiés chez Intel** qui monte : le PDG d'Intel aurait revendu le maximum d'actions il y deux semaines alors que l'affaire n'était pas encore médiatisé. Il y a des risques qu'aujourd'hui Wall Street soit mis au courant de l'histoire et que l'action Intel baisse considérablement.

Pour info, **Windows est également touché et va être patché aussi**.

Pour l'instant ce ne sont que des suppositions de failles mais de nombreux indices étayent l'histoire. L'embargo sera levé ce jeudi midi.

## PS2 :
*4 Janvier 2018 :* Bon bha on a un nom et un site : L'attaque se nomme ***Meltdown*** et ***Spectre*** et [son site](https://spectreattack.com/) confirme à peu près tout ce qu'on savait sauf que c'est toujours vague concernant les processeurs affectés. Apparemment AMD **pourrait** être victime de la faille ansi qu'ARM. En fait la plus grande surprise vient du fait que c'est deux failles.
