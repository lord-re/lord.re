+++
Author = "Lord"
Description = "Photon est un lecteur de flux RSS en console utilisant sixel pour afficher des images directement dans votre terminal."
Categories = ["linux", "rss","tui"]
menu = "main"
notoc = true
WritingDate = 2022-02-07T17:08:56+01:00
date = 2022-02-07T17:08:56+01:00
title = "Photon : un client RSS en console mais graphique !"
editor = "kakoune"
+++
J'ai découvert il y a peu de temps un nouveau ptit logiciel.

## Photon pour lire vos ReuSseuSseu
Il s'agit de **Photon** un *lecteur de flux RSS*.

Il ne fait que ça, pas d'agrégation, pas de gestion de lu/non lu.
Il ne sert vraiment qu'en lecture.
De ce fait *il se paire plutôt bien avec un agrégateur* (**Tiny Tiny RSS** dans mon cas).

{{< img src="photon-cards.png" alt="Les cartes de photon pour chaque item du flux RSS avec une image de présentation, le titre et la date de publication" title="Pas mal le rendu dans le terminal, non ?" >}}

J'ai jamais été vraiment fan des lecteurs de RSS en console.
Beaucoup de mes flux ne sont pas que des articles de blogs ou de presse mais c'est souvent des flux de vidéo ou d'images.
Je regarde pas mal de chaînes Youtube via les RSS (donc aurevoir les algos et le pistage) et pas mal de webcomics.
Et bha… ce genre de contenu hors d'un navigateur web c'est assez compliqué habituellement.

Je me suis laissé tenté par ce nouveau logiciel et je tente de choper l'habitude de l'utiliser.
*Il a beau tourner dans un émulateur de terminal, il utilise **Sixel** pour afficher les images*.
Et je parle pas d'images converties en ASCII art (c'est marrant deux minutes mais bon…) mais d'un vrai rendu nickel.
Du coup pour une bonne partie des contenues ça passe plutôt bien.

{{< img src="photon-item.png" alt="Une grande image puis le contenu du RSS." title="Un article ouvert dans Photon.">}}

En plus le créateur de Photon est visiblement lui aussi un utilisateur de Youtube puisqu'il a prévu de base de pouvoir ouvrir les contenus dans **MPV** en une touche.
Du coup, on peut trouver les dernières vidéos via **Photon** et les afficher depuis **MPV**.
Le tout sans quitter le confort de votre bien joli terminal.

{{< img src="photon-item-bd.png" alt="Le webcomic s'affiche directement dans Photon" title="Le Perry Bible Fellowship s'affiche très bien :-)" >}}

Donc je suis sûr que vous êtes 100% convaincu, maintenant parlons technique !
C'est codé en Go (yabon !) et ça utilise des plugins en LUA.

## Installation

C'est un logiciel tout neuf vu qu'il a été débuté fin novembre 2021 et il y a quelques bugs d'affichage.
Après c'est rien de bien gênant et le dev est maintenant accessible sur le salon #photon sur libera.
Il n'y a pas de vrai site officiel mais il y a [la page sr.ht](https://git.sr.ht/~ghost08/photon) qui contient également l'accès au code source.

Vu la jeunesse, vous vous doutez que ça ne se trouvera pas dans votre distro favorite.
Mais comme c'est du Go, c'est facile à compiler et à cross-compiler.
Un ptit coup de git clone, puis un make et hop c'est fait.

Pour avoir un joli affichage, il faut avoir un terminal compatible **sixel**.
Ça ne court pas trop trop les rues.
Je vous conseille **[foot]({{< ref "/posts/218-foot-:-mon-nouveau-terminal">}})** qui fait tout bien comme il faut.

## Utilisation

Les touches pour interagir sont les fameuses hjkl héritées de vi mais si comme moi vous êtes en bépo, ça ne vous arrange pas trop.
Par chance il y a le plugin **arrow_keys.lua** (qui se trouve dans les sources) à placer dans *~/.config/photon/plugins/* pour pouvoir utiliser les flèches pour naviguer.

Après pour l'utiliser, la touche <kbd>o</kbd> pour ouvrir un item ou bien la touche <kbd>p</kbd> pour ouvrir l'item dans **mpv**.
Quand vous êtes sur un item, la touche <kbd>q</kbd> pour en sortir et retourner sur la liste.

Voilà, il y en a d'autres mais juste ça, ça suffit pour s'en débrouiller.

Pour le lancer il suffit de l'invoquer et de lui filer une url de flux rss.
Ou bien de lui piper des rss direct ou de coller des url dans un fichier texte bref le truc est pas chiant et vous pouvez l'utiliser à votre convenance.

## Conclusion
Bha, faites-en ce que vous voulez, hein.
Perso, j'aime les logiciels dans le terminal mais c'est vrai que pour du contenu vidéo et image c'est pas ouf.
**Photon** tente à son niveau de rendre ça accessible et utilisable et bha franchement le résultat est plus qu'encourageant.
