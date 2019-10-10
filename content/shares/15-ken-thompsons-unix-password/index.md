+++
Author = "Lord"
Description = "Une petite histoire sur le crackage des mots de passes des pères de l'informatiques."
Categories = ["culture", "libre","geek"]
menu = "main"
notoc = true
WritingDate = 2019-10-10T10:47:05+02:00
date = 2019-10-10T10:47:05+02:00
title = "Le mot de passe Unix de Ken Thompson"
editor = "kakoune"
+++
Cette histoire est toute fraîche.
Elle est apparue ***[sur le blog de Leah Neukirchen](https://leahneukirchen.org/blog/archive/2019/10/ken-thompson-s-unix-password.html)*** le 09 Octobre 2019 ([version en cache local](original)).

Je vous en propose une traduction avec bien entendu l'accord de son auteur.

------
Aux alentours de 2014 je suis tombé sur un fichier [/etc/passwd](https://github.com/dspinellis/unix-history-repo/blob/BSD-3-Snapshot-Development/etc/passwd) dans les sources de BSD3 contenant les mots de passes des vieux de la vieille tels que Dennis Ritchie, Ken Thompson, Brian W. Kernighan, Steve Bourne et Bill Joy.

Comme l'algorithme [crypt(3)](https://minnie.tuhs.org/cgi-bin/utree.pl?file=V7/usr/man/man3/crypt.3) basé sur DES est bien connu pour être assez mauvais (et limité à maximum 8 caractères), j'ai pensué qu'il serait amusant de cracker ces mots de passe.

Les outils les plus connus pour ce genre d'exercices sont [John](https://www.openwall.com/john/) et [Hashcat](https://hashcat.net/wiki/).

Rapidement, je suis parvenu à cracké la majorité de ces mots de passe, qui pour la plupart étaient plutôt mauvais.
(Curieusement, Bwk utilisait /.,/., qui sont relativement simple à taper en Qwerty.

Malgré tout, le mote de passe de Ken résistait à mes assauts.
Même une recherche exhaustive de toutes les combinaisons de lettres minuscules et de chiffres prirent plusieurs jours (c'était en 2014) sans résultat probant.
Sachant que l'algorithme fût développé par Ken Thompos et Robert Morris, je me demandais ce qu'il se tramait.
J'ai d'ailleurs réalisé à ce moment que contrairement à d'autre méthode de hash (comme NTLM), crypt(3) s'avérait plus long à craquer (probablement dû à un manque d'optimisation).

Avait-il réellement utilisé des majuscules ou des caractères spéciaux ?
(Une recherche bruteforce exhaustive sur toutes les combinaisons sur 7bits prendrait plus de 2 ans sur un GPU moderne.)

L'histoire est [revenue sur le tapis](https://inbox.vuxu.org/tuhs/tqkjt9nn7p9zgkk9cm9d@localhost/T/#m160f0016894ea471ae02ee9de9a872f2c5f8ee93) plus tôt ce mois-ci sur la [mailing list The Unix Heritage Society](https://www.tuhs.org/) où [j'y ai partagé mes résultats](https://inbox.vuxu.org/tuhs/87bluxpqy0.fsf@vuxu.org/) ainsi que ma frustation à propos de ce dernier mot de passe résistant.

C'est alors qu'aujourd'hui le [mystère est levé](https://inbox.vuxu.org/tuhs/CACCFpdx_6oeyNkgH_5jgfxbxWbZ6VtOXQNKOsonHPF2=747ZOw@mail.gmail.com/) par Nigel Williams :

>From: Nigel Williams

>Subject: Re: [TUHS] Recovered /etc/passwd files
>
>ken is done:
>
>ZghOT0eRm4U9s:p/q2-q4!
>
>took 4+ days on an AMD Radeon Vega64 running hashcat at about 930MH/s
>during that time (those familiar know the hash-rate fluctuates and
>slows down towards the end)

Il s'agit d'un mouvement d'échec en [notation descriptive](https://fr.wikipedia.org/wiki/Notation_descriptive).
Il s'agit d'une [ouverture plutôt classique](https://en.wikibooks.org/wiki/Chess_Opening_Theory/1._d4).
Cela correspond bien au fait que Ken Thompson est un [grand amateur et même joueur d'échec sur ordinateur](https://www.chessprogramming.org/index.php?title=Ken_Thompson).

Je suis très content que ce mystère ait pu être percé et la réponse me satistfait.

------------

Voilà, cette histoire est vraiment cool.
Déjà, rien que trouver un fichier passwd avec tous ces utilisateurs dans un seul endroit ça parait fou.
Ces gens sont des légendes de l'informatique (et du Libre).

Certains de ces mots de passe sont plus complexes que la majorité des passes qui leakent actuellement alors qu'ils avaient des contraintes bien pourris (max 8 caractères sur de l'ascii simple).
