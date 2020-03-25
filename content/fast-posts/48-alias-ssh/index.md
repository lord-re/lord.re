+++
Author = "Lord"
Description = "Tout petit article expliquant le fonctionnement du fichier ~/.ssh/config où on peut y définir des alias pour se connecter à différentes machines distantes via SSH. Ça permet de se simplifier la vie et potentiellement améliorer la sécurité au passage."
Categories = ["tips", "ssh"]
menu = "main"
notoc = true
WritingDate = 2020-03-25T09:31:36+01:00
date = 2020-03-25T09:31:36+01:00
title = "Les alias SSH"
editor = "kakoune"
TopWords = [  "ssh_config","openssh", "configuration", "connecter", "alias", "ssh"]
+++
Désolé désolé, j'ai oublié de vous écrire pendant ce confinement ces quelques jours.
Me revoilà \o/

Bon je vous avoue que j'ai pas grand-chose pour vous occuper.
J'ai fouillé fouillé (en vrai j'ai démarré l'ordi).
Et comme d'hab quand il est démarré, j'ai lancé ma connexion ssh vers mon client IRC, démarré mon ptit script pour la musique et lancé mon navigateur web.

Et là, PAF !
Je me suis dit que je pourrai vous écrire à propos des alias SSH.
J'en utilise pas mal, même presque tout le temps.

Dès que je dois me connecter plus de deux fois à une machine je me fais un alias.
Mais pas un alias au sens shell, mais direct dans la conf de mon client ssh.
Ça évite de retenir les détails et compagnie.

## Les fichiers de confs OpenSSH
Bon là on va pas parler du protocole lui-même mais vraiment d'OpenSSH.
Ça ne sera pas forcément valide avec les autres clients.
Et je n'aborderai que la partie client.

La conf globale se trouve dans */etc/ssh/ssh_config* .
Ce que vous modifiez là-dedans sera appliqué à chaque connexion.

Ce fichier est commenté pour vous expliquer ça d'ailleurs.
Vous pouvez vous amuser à mettre de la conf spécifique à un hôte là-dedans mais c'est pas trop le but.
Il vaut mieux réserver ça à son fichier de conf personnel.

Le fichier de conf perso se trouve dans *~/.ssh/config* .
Il a la même syntaxe que le global mais ne s'applique qu'à votre utilisateur.
Les options que vous définissez ici auront la priorité par rapport au fichier global.
Et d'ailleurs si vous définissez des options directement dans la commande, elles auront la priorité par rapport aux fichiers.

## La puissance des alias
En gros ce fichier va contenir plusieurs blocs de texte, chacun correspondant à un hôte vers lequel vous vous connecter.
La syntaxe est dans ce genre :

{{< highlight "ssh" >}}
Host le_nom_de_l'alias
	option valeur
	option valeur
	option valeur
{{< / highlight >}}

Un exemple ultra basique :

{{< highlight "ssh" >}}
Host n2
	hostname 10.0.0.253
	user root
{{< / highlight >}}

Voilà, au lieu de me faire un <samp>ssh root@10.0.0.253</samp> maintenant je fais <samp>ssh n2</samp> et le tour est joué.

Dans les options les plus intéressantes à mettre dedans il y a :

  - le **user** parcequ'on se rapelle jamais duquel c'est.
  - le **Port** quand c'est pas celui par défaut.
  - le **IdentityFile** car j'imagine que vous avez plusieurs clés SSH différentes.
  - le **hostname** en y mettant l'IP comme ça même si le DNS est HS vous pourrez vous connecter en direct (me suis déjà brûlé).
  - les **LocalForward** et **RemoteForward** quand vous utilisez des tunnels via SSH pour pas les réécrire à chaque fois.

Bon si vous êtes aussi ~~flem~~astucieux que moi, vous remarquerez vite qu'on peut jouer avec les <abbr title="RIP Uderzo">asterisques</abbr>.
Je m'explique : j'ai pas mal d'alias pour me connecter à différents containers et je leur donne un ptit nom explicite où je préfixe le nom de l'hyperviseur.

Par exemple j'ai un l'hôte des containers qui s'apelle *Z* et dedans j'ai mon client irc pour chatter.
Et bhé j'ai un alias *Zchat*, tout comme j'ai aussi *Zbackup* mais aussi *Zmail* …
Et bien, figurez-vous que c'est cool d'écrire <samp>ssh Zchat</samp> mais c'est encore trop long, du coup dans le fichier config j'ai fait un alias comme ça :

{{< highlight "ssh" >}}
Host zc*
	# Z-Chat
	option valeur
	option valeur
{{< / highlight >}}

Comme ça je peux écrire <samp>ssh zchat</samp> ou bien <samp>ssh zcatacombes_du_net</samp>, vous voyez le genre.
Je peux tout aussi bien me contenter de <samp>ssh zc</samp>.
Bon c'est une mini-ruse de flemmard j'en conviens, on peut se contenter de définir zc mais quand on a utilisé zchat pendant des années ça permet de faire une transition en douceur.

---------
Voilà n'hésitez pas à abuser de ces alias ssh ça libère la mémoire et ça accélère un poil les affaires et ça permet d'utiliser différentes clé sans se contraindre.

Bon, voilà, c'était léger aujourd'hui.
C'est le bon moment pour aller faire un tour dehors… ha bha non.
