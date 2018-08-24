+++
Author = "Lord"
Description = "On passe au niveau 3 de l'utilisation d'IRC. On aborde ce coup-ci l'utilisation un poil poussée."
menu = "main"
date = "2017-08-24T16:01:50+02:00"
title = "Guide d'utilisation d'IRC : niveau 3"
Categories = ["irc","tips","réseau"]
Tags = ["irc","tips","réseau"]
notoc = true

+++
## Guide perso : Se protéger des relous
Alors la toute première des choses à faire pour se protéger c'est d'**enregistrer son pseudo auprès des services**. Ça évitera que quelqu'un le prenne et se fasse passer pour vous. Pour cela il faut voir avec les services : ***/msg C nick register unmotdepasse uneadressemail***. Désormais à chaque fois que vous vous connecterez au serveur, il faudra vous identifier auprès de C via ***/msg C nick identify unmotdepasse***

**Ghoster son nick**. Si quelqu'un est connecté avec votre pseudo, vous ne pouvez pas utiliser ce pseudo. Ghoster consiste donc à forcer la récupération de votre pseudo. Ça se fait simplement avec ***/msg C nick ghost votrepseudo votremotdepasse*** . L'usurpateur se retrouvera avec un pseudo aléatoire et vous serez de nouveau vous. Et pour empêcher que ça ne se reproduise il va falloir activer votre **option protect** : ***/msg C nick set protect on***. Désormais, quelqu'un qui prend votre pseudo devra s'identifier au bout de 60 secondes (configurable) auprès de C sinon il se retrouvera avec un pseudo aléatoire. Bon avec ça normalement plus de soucis d'usurpation d'identité.

**Planquer ses infos**. Il est possible de planquer votre adresse mail ainsi que les autres informations (très recommandé). ***/msg C nick set hidemail on*** et ***/msg C nick set private on***. À noter que les ircop auront tout de même accès à ces informations.

**Modifier ses modes**. Pour connaître les modes utilisateurs qui nous sont affectés, il faut lancer un joli ***/mode sonpseudo***. On peut également voir ceux de quelqu'un d'autre. Par défaut vous devriez avoir **iwz**. Le **i** indique qu'un utilisateur extérieur d'un salon ne peut pas vous lister comme présent dans ce salon (ex : ***/who #geeknode*** ou ***/names #geeknode***). Le **w** indique que vous pouvez recevoir les messages en provenance des ircop (non utilisés sur Geeknode). Enfin le **z** indique que vous êtes connecté de façon chiffrée avec le serveur (si vous l'êtes bien entendu).

Les modes utilisateurs intéressants pour se protéger sont **DRpTZ**.

Le **R** signifie que vous ne pouvez recevoir des queries ou pv ou msg (c'est la même chose) uniquement de la part des utilisateurs enregistrés auprès des services. Un niveau au dessus, le **D** lui permet de ne plus recevoir de tels messages en dehors de ceux envoyés par les services et les ircop.

Le **p** planque la liste des channels sur lesquels vous êtes connectés dans votre whois.

Les CTCP sont des commandes un peu exotiques dans IRC qui permettent à un client d'envoyer des commandes à un autre client (Client To Client Protocol). Ça permet par exemple d'envoyer un ping, de demander la version du client irc, demander l'heure… Bref très généralement vous en voulez pas de ce genre de truc, du coup un ptit **T** et hop vous bloquez ça.

Et enfin **Z** permet de limiter les queries/notice/ctcp uniquement aux personnes connectés de manière chiffrée.

Donc pour affecter ça : **/mode monpseudo +TZ** par exemple. À noter que ça ne persiste pas en cas de déconnexion. La liste complète des modes est ici dans [la doc unrealircd](https://www.unrealircd.org/docs/User_Modes).

- Bon tout ça, c'est pour se protéger du côté du serveur, côté client vous pouvez faire deux trois trucs. Le premier est de **garder son client irc à jour**. On a tendance à l'oublier mais le client irc est connecté au net et ce des heures durant avec pas mal de loulous qui traînent, les failles de sécurité arrivent régulièrement. Ensuite vous pouvez **bloquer les DCC**. Le DCC c'est un moyen de connexion en p2p (ouai irc peut faire ça !) pour chatter ou s'échanger des fichiers (donc ça ne transite plus par le serveur). Si vous ne comptez pas utiliser cette fonctionnalités, désactivez-là, c'est un vecteur potentiel d'emmerdes et d'ailleurs si vous pouvez faire de même pour les CTCP, n'hésitez-pas.

