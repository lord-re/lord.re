+++
Author = "Lord"
Description = "Une nouvelle instance Pleroma publique est ouverte ! Je participe à l'administration de craftopi.art qui s'adresse aux artisans/makers/crafters francophones."
Categories = ["fediverse", "pleroma"]
menu = "main"
notoc = true
WritingDate = 2023-08-15T09:47:01+02:00
date = 2023-08-26T09:47:01+02:00
title = "Bienvenue à Craftopi.art"
editor = "helix"
Audio = ""
Soustitre = "L'instance du fait-maison dans le Fediverse"
+++
Je vous l'avais un peu teasé mais voilà je vous le dévoile aujourd'hui :

Je participe à la création d'un nouveau nid douillet dans le <img src="https://lord.re/svg/fediverse.svg" class="spin svg3"><span class="rainbowverse">Fediverse</span> et bon vous avez vu le titre, ce recoin se nomme **<a href="https://craftopi.art">Craftopi.art</a>**.

## Koikoukess
Micro récap sur le Fediverse : c'est un *réseau social permettant à des gens de discuter, poster des photos ou vidéo, de commenter et recommander leurs lectures, de faire des sondages, de jouer aux échecs, …* 
Mais à la différence des autres, c'est qu'ici ça repose sur *un protocole normalisé ce qui a permis à de nombreux logiciels de s'y raccorder en étant compatibles*.
Des utilisateurs de Mastodon peuvent interagir avec d'autres sur Pleroma ou bien Lemmy ou Pixelfed ou Firefish ou …

Pour le moment c'est un réseau qui parvient à se tenir à l'écart d'entreprises et est donc pour le moment épargné de publicité, de tracking, de monétisation…
Pourvu que ça dure.

*Tout un chacun peut donc monter son serveur et le raccorder au reste du réseau.*
Il y a près de 25000 serveurs participants au réseau en ce moment.
Ces serveurs sont nommés instances et il y a de tout : *des ptites instance mono-utilisateur comme la mienne, des instances généralistes avec des centaines de milliers d'utilisateurs, des instances de niche avec des sujets très précis, …*

Oui mais **Crafopi.art** ?

## <span class="rainbowverse">Craftopi.art</span>
Le fédiverse est de plus en plus vaste mais il manquait une instance spécialisée pour les artisans.
**Une instance qui regroupe des souffleuses de verre, des tricoteurs, des peintres, des sculpteuses, des mailleurs, des …
Une instance avec une timeline qui sent le fait-main.**

Il y a déjà des artisans sur les réseaux sociaux.
C'est une communauté qui fuit petit à petit ~~Twitter~~ 𝕏 et qui s'éparpille sur des instances généralistes.
C'est difficile de les débusquer.

C'est une réflexion que je me faisais depuis un ptit moment et je n'étais visiblement pas le seul.
Puisqu'on en a discuté et paf l'idée a pris.

Une instance francophone utopique pour le craft et les artisans et pouf voilà que **[Craftopi.art](https://craftopi.art)** est née.

Nous vous proposons donc un ptit Pleroma interconnecté avec le reste du Fediverse.
C'est compatible avec quasiment toutes les applications faites pour Mastodon.
Nous vous proposons en plus l'interface **Mangane** un peu plus jolie qui est disponible à [cet endroit](https://mangane.craftopi.art/).
### Admins
La grande cheffe est donc la Loutre Habile mieux connue sous son nom latin de **Lutrinae Habilis** que l'on peut retrouver sur son site [From OtterSpace](https://fromotterspace.fr/) avec sa boutique et son blog ou tout logiquement sur [son compte Pleroma](https://craftopi.art/users/from_Otterspace).

Et moi-même. :-)

### Règles
Là c'est simple, suffit de **se comporter humainement**.

*Ne pas emmerder les autres, ne pas les humilier, ne pas propager de haine envers un groupe d'individu pour quelconque raison.*

C'est une instance de Gauche merci de ne pas venir chouiner à ce propos.

Concernant la modération nous *n'hésiterons pas à bloquer les instances propageant des contenus ne s'alignant pas avec nos règles*.
L'instance est actuellement toute petite et donc la modération est faite à deux sur notre temps libre donc nous ne sommes pas forcément tout le temps au taquet mais nous souhaitons faire au mieux.

Nous tolérons et même encourageons nos utilisateurs à faire la publicité de leurs créations et à poster des liens vers leurs boutiques !

Le contenu pour adulte est toleré tant que vous marquez le contenu comme NSFW.

### Inscriptions
Après quelques jours sur invitation uniquement, nous avons semi-ouvert les vannes.
~~Tout le monde peut s'inscrire mais nous devons manuellement approuver les nouveaux comptes.
D'ailleurs si vous le faites n'hésitez pas à nous contacter pour que l'on valide votre inscription plus rapidement ;-)~~

**Les inscriptions sont ouvertes \o/**

## Mes motivations
J'ai toujours été assez actif sur le net.
J'aime beaucoup participer à des ptites communautés.

Il y a fort longtemps j'étais dans une équipe de modération de forum.
Après j'ai plutôt enchaîné sur IRC puisque depuis un bon moment (10 ans ? non j'en sais rien) je participe au réseau Geeknode.

*Quand j'ai découvert le Fediverse, j'ai squatté une instance sélectionnée un peu au hasard.
Puis je me suis monté ma propre instance perso.
L'étape suivante c'est de monter une instance publique mais je dois avouer que je ne me sentais pas trop d'héberger des inconnus.*

Le point qui m'effraie le plus ce sont les relations inter-instances.
Si je fais le con sur ma ptite instance bon bha tant pis je me grille moi et c'est tout.
Sur une instance publique il y a une responsabilité envers "mes" utilisateurs.
Bref, faire ça à deux c'est déjà bien plus envisageable pour moi.

Je pense en plus que la communauté que je cherche à héberger sera compréhensive et bienveillante donc je pense que ça se passera bien.

*Le but n'est pas d'héberger trop de monde.*
Intérieurement j'aimerai beaucoup que l'instance monte à une centaine d'utilisateurs actifs, au-delà je pense que ça serait ptet un poil trop gros.

Je rêve que la timeline locale déborde de vie et de créations toute mimi !

## Sous le capot
Bon donc le serveur est une machine chez OVH assez costaude et pourtant pas chère.
J'aurai bien mis Alpine mais l'installeur OVH ne le propose pas et puis bon si je ne suis pas dispo il sera plus simple de trouver quelqu'un maîtrisant Debian.

### Pleroma OTP
La version OTP est plus simple (de peu) à installer.

Les mises-à-jour s'installent avec deux commandes et demi et on est pas obligé d'avoir tout un tas de dépendances pour le build.

### PostgresSQL
Sans trop de surprise il faut une base Postgres pour Pleroma.
Je suis parti sur la version stable à ce jour donc la 15.

### PgBackRest
Tiens pour une fois j'ai tenté de faire des backup un peu plus propre.
Je me suis donc tourné vers cet outil qui semble très bien foutu.

Il se démerde pour faire des backup bien propre de la base de donnée.
J'ai testé le restore c'est super simple.

Pas de bol la version de pgbackrest de Debian n'a pas le support de SFTP qui est dans la version juste après…

### MOTD
C'est tout con mais vu que ce serveur n'est pas MON serveur et héberge une ptite communauté et qu'à terme d'autres personnes l'administreront ptet.
J'ai foutu les quelques infos de base pour l'administration directement dans le Message Of The Day qui s'affiche lors de la connexion ssh.

Il y a notamment les infos pour passer root, pour lister les backup, pour créer un backup et restaurer un backup.
J'y ai mis également où se trouve Pleroma, où se trouve les backup et comment sont gérés les certifs.

En quelques lignes il y a le minimum vital.
C'est tout bête mais ça pourra probablement aider un futur admin (ou juste moi ^__^).

## Longue vie à Craftopi.art
Voilà, ce post me permet de faire un ptit peu de pub pour [l'instance](https://craftopi.art/about).
Et en plus c'est aussi l'occasion de fêter son premier moisiversaire puisqu'elle a ouverte le 26 Juillet 2023 !

Si vous pensez que ce nouveau lieu pourrait vous accueillir n'hésitez pas à nous rejoindre ;-)

Nous nous engageons à prévenir nos utilisateurs au moins trois mois en avance si jamais nous devions arrêter l'instance.
Ce délai permettra à chacune de transférer son compte vers un autre serveur.
