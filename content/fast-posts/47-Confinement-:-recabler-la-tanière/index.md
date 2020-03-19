+++
Author = "Lord"
Description = "Un petit bricolage aujourd'hui pour passer le temps. Mettre des connecteurs RJ45 femelles sur du câble de distribution."
Categories = ["cable", "bricolage"]
menu = "main"
notoc = true
WritingDate = 2020-03-19T15:00:04+01:00
date = 2020-03-19T15:00:04+01:00
title = "Confinement : Recâbler sa tanière"
editor = "kakoune"
TopWords = [ "rj45", "prise", "testeur", "connecteur", "fils", "câble","bricolage","confinement"]
+++
Bon en ces temps de confinement, faut parvenir à s'occuper (et si en plus ça peut aussi vous divertir un peu, tant mieux).
Du coup j'ai entrepris (au bout de deux ans) d'améliorer un peu mon câblage réseau à la maison.

J'ai deux gros câbles dans le salon qui font le tout le tour le long du mur.
Le but est de relier les deux datacenter du salon :

  - Le premier est un **meuble contenant la fibre**, le routeur, un switch (où sont raccordés les ordis).
  - Le second est la **tanière** où se trouvent les <abbr title="Single Board Computer">SBC</abbr>, disques durs, un switch.

Grosse infra vous dis-je !

Bref, j'avais tiré un double câble réseau et je l'avais serti direct comme un sagouin.
Le souci c'est que c'est pas du câble de brassage, il est très rigide et supporte assez peu les torsions.
Du coup une pauvre SBC, du haut de ses quelques grammes a tendance à se faire balader par ce câble.

Bref, fallait agir !

Allez on s'arme de *ciseaux* et de *connecteurs RJ45 femelles* mais surtout un *testeur de câble* (plus dur à trouver je vous l'accorde).

{{< img src="initial.jpg" link="initial.jpg" alt="Photo de la tanière avec les SBC et les gros câbles violet en question" title="Voilà donc la tanière, et le câble violet bien épais et rigide" >}}

(Il manque l'odroid N2 sur la photo car elle est actuellement en bidouillage intensif sur le bureau).

Donc la première étape consiste à dégager le connecteur mâle.
On va y mettre un connecteur femelle (le grand remplacement vous dis-je !).

Donc snip snip, on place la première partie du connecteur femelle.

{{< img src="coupure_et_insertion.jpg" link="coupure_et_insertion.jpg" alt="On voit les 8 fils de couleurs différentes passés à l'intérieur d'une sorte de bague" title="Pas trop long sinon ça rentre pas, pas trop court sinon… ça rentre pas" >}}

Bon maintenant il faut séparer les 8 fils qu'on va devoir mettre dans le bon ordre.
Faut faire gaffe à ne pas abîmer les fils qui sont assez petits et légèrement cassant une fois sorti de leur gaine et blindage.

{{< img src="eclatage.jpg" link="eclatage.jpg" alt="" title="">}}

Bon maintenant faut placer chacun des fils dans sa petite encoche.
C'est assez chiant quand on est peu manuel avec une légère tremblotte.

Faut pas hésiter à repousser un en arrière la gaine qui aura tendance à gêner.
Une fois tous les fils biens calés, fait bien faire en sorte qu'ils ne bougent pas et que l'excédent à été bien coupé.

{{< img src="juste_avant_fermeture.jpg" link="juste_avant_fermeture.jpg" alt="On a rassemblé le ptit réceptacle des fils dans le reste du connecteur" title="Faut couper le surplus en veillant bien à ce que ça ne bouge pas puis enfoncer les deux parties ensembles.">}}

Une fois les deux morceaux ensemble, on rabat les deux ptits bras l'un dans l'autre histoire que ça ne se rouvre pas.
{{< img src="fermeture.jpg" link="fermeture.jpg" alt="Le connecteur est refermé, presque prêt à l'emploi." title="Voilà le rendu final. C'est propre et ça peut se clipser dans une prise murale ou un bandeau de prise.">}}

Bien entendu j'ai pas de bandeau de prise ni de prise mural donc pour l'instant ça devrait rester à cet état.

Il faut bien entendu s'assurer que ça fonctionne avec un ptit testeur de câble.
Le but du jeu c'est que les 8 fils du connecteur soit dans le bon ordre.

{{< img src="test_nok.jpg" link="test_nok.jpg" alt="Un testeur de câble indique que l'ordre des fils ne correspond pas." title="Là c'est typiquement pas le cas. La paire 1 et 3 est inversée ainsi que la 2 et la 6.">}}

Dans ces cas-là, pas de miracle, on rouvre, on coupe on recommence.
On peut tenter de bidouiller et intervertir les erreurs mais faut être doué et malheureusement les fils seront fragilisés ce qui n'est pas cool du tout.

On s'y reprend pour cinq minutes et on arrive à ce résultat.

{{< img src="test_ok.jpg" link="test_ok.jpg" alt="Le testeur de câble indique que tout est OK" title="On voit que la longueur a légèrement diminuée et surtout que tout est bien raccord.">}}

Voilà pour le mini-bricolage du jour.

