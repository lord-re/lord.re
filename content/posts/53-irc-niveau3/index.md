+++
Author = "Lord"
Description = "On passe au niveau 3 de l'utilisation d'IRC. On aborde ce coup-ci l'utilisation un poil poussée."
menu = "main"
date = "2017-08-24T16:01:50+02:00"
title = "Guide d'utilisation d'IRC : niveau 3"
Categories = ["irc","tips","réseau"]
Tags = ["irc","tips","réseau"]
notoc = true
TopWords = [  "geeknode", "ircop", "set", "modes", "protéger", "irc", "pseudo"]
+++
C'est parti pour votre troisième niveau en IRC !

On aborde ici ce qu'un utilisateur lambda peut faire.

## Guide pour un utilisateur : Se protéger des relous

### Enregistrer son pseudo
Alors la toute première des choses à faire pour se protéger c'est d'**enregistrer son pseudo auprès des services**.
Ça évitera que quelqu'un d'autre le prenne et se fasse passer pour vous.
Pour cela il faut voir avec les services : <kbd>/msg C nick register unmotdepasse uneadressemail</kbd>.

### S'identifier
Désormais à chaque fois que vous vous connecterez au serveur, il faudra vous identifier auprès de C via <kbd>/msg C nick identify unmotdepasse</kbd>

### Ghoster son pseudo
Si quelqu'un est connecté avec votre pseudo, vous ne pourez pas le prendre.
Ghoster consiste donc à forcer la récupération de votre pseudo.

Ça se fait simplement avec <kbd>/msg C nick ghost votrepseudo votremotdepasse</kbd>.

L'usurpateur se retrouvera avec un pseudo aléatoire et vous serez de nouveau vous.

### Empêcher les autres d'utiliser votre pseudo
Et pour empêcher que ça ne se reproduise il va falloir activer votre **option protect** : <kbd>/msg C nick set protect on</kbd>.

Désormais, quelqu'un qui prend votre pseudo devra s'identifier au bout de 60 secondes (configurable) auprès de C sinon il se retrouvera avec un pseudo aléatoire.
Bon avec ça normalement plus de soucis d'usurpation d'identité.

### Planquer ses infos
Il est possible de planquer votre adresse mail ainsi que les autres informations (très recommandé).
<kbd>/msg C nick set hidemail on</kbd> et <kbd>/msg C nick set private on</kbd>.

À noter que les ircop auront tout de même accès à ces informations.

### Modifier ses modes
Pour connaître les modes utilisateurs qui nous sont affectés, il faut lancer un joli <kbd>/mode sonpseudo</kbd>.

On peut également voir ceux de quelqu'un d'autre.
Par défaut vous devriez avoir **iwz**.

  - Le **i** indique qu'un utilisateur extérieur d'un salon ne peut pas vous lister comme présent dans ce salon (ex : <kbd>/who #geeknode</kbd> ou <kbd>/names #geeknode</kbd>).
  - Le **w** indique que vous pouvez recevoir les messages en provenance des ircop (non utilisés sur Geeknode).
  - Enfin le **z** indique que vous êtes connecté de façon chiffrée avec le serveur (si vous l'êtes bien entendu).

Les modes utilisateurs intéressants pour se protéger sont **DRpTZ**.

  - **R** signifie que vous ne pouvez recevoir des queries ou pv ou msg (c'est la même chose) uniquement de la part des utilisateurs enregistrés auprès des services.
  - Un niveau au-dessus, le **D** lui permet de ne plus recevoir de tels messages en dehors de ceux envoyés par les services et les ircop.
  - **p** planque la liste des channels sur lesquels vous êtes connectés dans votre whois.
  - Les CTCP sont des commandes un peu exotiques dans IRC qui permettent à un client d'envoyer des commandes à un autre client (Client To Client Protocol).
Ça permet par exemple d'envoyer un ping, de demander la version du client irc, demander l'heure… Bref très généralement vous en voulez pas de ce genre de truc, du coup un ptit **T** et hop vous bloquez ça.
  - **Z** permet de limiter les queries/notice/ctcp uniquement aux personnes connectées de manière chiffrée.

Donc pour affecter ça : <kbd>/mode monpseudo +TZ</kbd> par exemple.
À noter que ça ne persiste pas en cas de déconnexion.
La liste complète des modes est ici dans [la doc unrealircd](https://www.unrealircd.org/docs/User_Modes).

Bon tout ça, c'est pour se protéger du côté du serveur, côté client vous pouvez faire deux trois trucs.
  - Le premier est de **garder son client irc à jour**. On a tendance à l'oublier mais le client irc est connecté au net et ce des heures durant avec pas mal de loulous qui traînent, les failles de sécurité arrivent régulièrement.
  - Ensuite vous pouvez **bloquer les DCC**. Le DCC c'est un moyen de connexion en p2p (ouai irc peut faire ça !) pour chatter ou s'échanger des fichiers (donc ça ne transite plus par le serveur). Si vous ne comptez pas utiliser cette fonctionnalité, désactivez-là, c'est un vecteur potentiel d'emmerdes et d'ailleurs si vous pouvez faire de même pour les CTCP, n'hésitez-pas.

----------

Du haut de votre niveau 3 vous savez désormais vous protéger de la très grande majorité des emmerdes potentielles sur IRC.

Il est toutefois possible de passer niveau 4 en apprenant un peu toutes les manips concernant la gestion d'un salon.
À vous les joies de la modération et du kick en étant un @op !

