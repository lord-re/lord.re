+++
Author = "Lord"
Description = "Qt propose depuis peu un mode sombre applicable sur leurs applications. Qutebrowser peut donc en profiter et c'est clairement chouette. (chouette, nocture, sombre…)"
Categories = ["qutebrowser", "tips"]
menu = "main"
notoc = true
WritingDate = 2020-01-30T22:57:13+01:00
date = 2020-01-30T22:57:13+01:00
title = "Dark Mode pour Qutebrowser"
editor = "emacs"
+++

Je viens de découvrir qu'il est possible d'avoir un mode sombre pour **Qutebrowser**.
Ça fait des années que je rêve d'une telle fonctionnalité.
Alors que certains ce sont les portes rouges, moi ce sont les sites blancs que je veux repeindre en noir.

Cette astuce n'est pas propre à Qutebrowser lui-même mais pourrait s'appliquer à toutes les applis **Qt**.
Dans les versions récentes de Qt, toutes les applis peuvent avoir un mode sombre.

Bref pour l'activer dans votre Qutebrowser il faut éditer votre config.

<details open><summary><em>~/.config/qutebrowser/config.py</em></summary>
{{< highlight "python" >}}
c.qt.args = ["blink-settings=darkMode=1"]
{{< / highlight >}}
</details>

Vous relancez votre joli navigateur et hop.

C'est tout.

Ha et si les couleurs vous plaisent pas vous pouvez tenter d'autres valeur que *1* et mettre *2* ou plus (je ne sais pas jusqu'où ça va).

## Dernière déconvenue
On doit quand même subir l'horrible page super blanche quand on ouvre une nouvelle fenêtre ou un nouvel onglet avant que la vraie page ne s'affiche.
J'ai pas encore trouvé de solution à cette horreur.

Il est possible d'en changer la couleur.
Sauf qu'en fait ça veut dire changer également la couleur de toutes les pages webs n'ayant pas redéfinies leur couleur de fond par défaut.
Et mine de rien pas mal de site ouaib l'ont laissé par défaut.
Donc si comme moi vous tentez de faire le malin pour mettre une couleur foncée, vous allez vous confronter à des pages n'ayant pas non plus redéfinie leur couleur de texte par défaut.
Vous aurez donc la joie de tenter de lire du texte noir sur fond noir.

On peut aussi s'amuser à changer la couleur du texte par défaut mais bref on arrive à un point où il faut tout refaire et ça pète forcément à un endroit.
Bref c'est merdique.

Donc faisons-nous la promesse, lae premier d'entre nous qui trouve comment changer la couleur de la *blank page* et uniquement elle (pas les couleurs par défaut globales à toutes les pages), iel le dit à tout le monde et on sauve l'humanité !
OK ?
