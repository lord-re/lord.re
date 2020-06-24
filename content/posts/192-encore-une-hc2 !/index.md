+++
Author = "Lord"
Description = ""
Categories = ["alpine", "sbc","linux"]
menu = "main"
notoc = true
WritingDate = 2020-03-09T15:48:05+01:00
date = 2020-03-09T15:48:05+01:00
title = "Encore une odroid HC2 !"
editor = "kakoune"
TopWords = [ "tunnel", "autossh", "disque", "samba", "ip", "ssh","hc2", "odroid", "ssh","backup"]

+++
## Encore une ?!
Je vais encore ajouter une ptite odroid dans mon harem.
Ce coup-ci elle ne sera pas à la maison mais un peu éloignée à la campagne.
Le but est de remplacer un disque dur externe mal en point.
Et tant qu'à remplacer un disque dur à l'agonie autant en mettre un vrai, plus robuste en réseau.

## Mais pourquoi toute une Odroid ?
Le disque dur externe ne servait à peu près jamais en mobilité mais à 95% pour du backup.
Du coup je me suis dit que ça ferait une pierre deux coups : un disque pour le backup maternelle et … un disque pour mon backup.
Et pour ça, une **Odroid HC2** c'est nickel : c'est tout petit, ça fait pas de bruit, ça consomme vraiment rien, le disque est bien au frais, c'est juste un peu moche (pas selon mes critères cela dit).

En plus ça me permettra de faire l'occasionnel SAV plus facilement qu'en passant par **TeamViewer**.
Même si j'en ai de moins en moins besoin, c'est toujours chiant.

## Objectif
Du coup le but, c'est de monter une ptite **Alpine Linux** dessus, y installer un skeudur, **Samba** et voilà pour le moment.
J'ai opté pour un skeudur de 4To qui sera tranquille pour au moins dix ans vu la volumétrie à stocker…
Une ptite carte SD de 64Go (vu le prix, prendre moins aurait été con).

Comme d'hab je choisis Alpine car c'est tout ptit, la surface d'attaque est minimale.
Le risque de bug est d'autant plus amenuisé, que je n'utiliserai quasiment aucun soft.
Je me contenterai vraiment du strict minimum.
Les updates seront rares et très rapides.

Je n'exposerai rien sur les Internets en plus.
Moins de risque de mauvaise surprise.

Une fois qu'elle aura mis le gros de ses données dessus, selon la volumétrie, j'en ferai un backup versionné chez moi.
Comme ça, même en cas de crypto locker vorace, je devrais être à même d'avoir une version clean des données.

## Retroussage de manches
Au début j'ai voulu faire le gros flemmard en faisant un gros <kbd>dd</kbd> du début de la carte SD de l'odroid existante.
Puis vu les débits pitoyables j'ai capitulé.

Je me suis donc rabattu sur une option à peine plus complexe : j'ai déjà une hc2 à la maison, je vous avais raconté [son installation à l'époque]({{< ref "posts/174-odroid-hc2" >}}).
Du coup, bha j'ai pas refait pareil mais en sautant les étapes du rootfs !

  - J'ai créé une partition sur la carte SD en ext4 (le moins d'emmerde à court terme).
  - Dessus, j'ai juste passé un coup de **rsync** depuis l'HC2 qui tourne actuellement.
  - J'ai ensuite remis les bouts du bootloader à base de <kbd>/boot/sd_fusing.sh /dev/sdi</kbd>.
  - Une fois fait j'ai corrigé customisé deux trois trucs (la conf réseau, le hostname, généré des clés ssh).
  - Le moment crucial de coller la SD dans la nouvelle Odroid.

## L'accès réseau à distance
Bon, ma mère, avoir une machine dispo en SSH, ça lui fait une belle jambe.
Et installer les mises à jour et tout ça va clairement pas lui plaire.
Du coup, non seulement je vais lui offrir la SBC, mais la lui installer et surtout lui maintenir (“I'm a generous god”).

Du coup, *il va me falloir un accès distant sécurisé*.
Bon, je mets ça en place aujourd'hui, je croise les doigts pour que ça tienne mais je vais tenter de faire un truc le plus simple possible pour que ça ait le moins de chance de casser possible.
Je dois tout préparer en amont pour n'avoir qu'à brancher chez elle.

### VPN
La première idée est de *partir sur un VPN*.
Si je le fais ça sera à base de **Wireguard**, sauf que bon, le kernel du truc est plutôt du genre pré-colombien… du coup on peut oublier.
Et je compte pas mettre autre chose niveau VPN.

### Accès SSH
La seconde idée c'est l'accès SSH direct.
L'idée me plait sauf que bon, je sais pas trop comment fonctionne sa connexion.
Est-ce qu'elle est en IP dynamique ? fixe ? NAT ? CGN ?
Bref, plein de risque que ça ne marche pas où qu'il faille tripotter son routeur et tout.
Et ça sans avoir la certitude qu'à la première update du routeur ça se fasse jarter.
Bref, ça ne m'enchante pas et j'ai pas super confiance.

### Tunnel SSH inversé
La troisième idée c'est l'accès SSH inverse.
Ouaip.
Ça ne veut rien dire.
En gros, c'est l'Odroid qui va initier la connexion et non l'inverse.
Mais du coup par quelle diablerie ça fonctionne ?

Et bien, ma ptite dame je vous le dit tout de go, ça sera facile et automatique.
Et comment ça fonctionne ?
Par la magie d'*un tunnel TCP et d'une connexion automatique de SSH*.
Et tout ça pour le prix d'un seul logiciel du doux nom de **AutoSSH**.

Et c'est cette solution qui est choisie !

## AutoSSH
Ce petit logiciel est super simple, il initie une connexion SSH.
Et dès qu'elle pète, il recommence.
Voilà, ça ne fait que ça.

Donc si jamais la connexion déconne, si le serveur déconne ou autre, dès que ça sera de nouveau opérationnel, la connexion sera rétablie.
C'est super pratique.
Le seul inconvénient, c'est qu'Alpine ne fournit pas le ptit fichier d'init nécessaire pour **OpenRC**.
Mais vous allez voir que c'est super simple.

<details><summary>/etc/init.d/autossh</summary>
{{< highlight "sh" >}}
#!/sbin/openrc-run

name="AutoSSH"
command="/usr/bin/autossh"
command_args="-M 0 -f -NR localhost:23:localhost:22 user@serveur"
command_user="root"

depend() {
        need net localmount
}
{{< / highlight >}}
</details>

Le premier tour de force c'est de lancer ça au boot et le fait qu'autossh s'acharne à ce que ce soit tout le temps up.

La seconde partie de la magie réside dans le tunnel qui est défini par <kbd>-R localhost:23:localhost:22</kbd>.
Cette option de SSH indique que le port *localhost:23 sur le serveur SSH, est relié au port localhost:22 du client*.

Dans ce cas, les deux occurences de *localhost* n'indiquent pas la même machine.
Le premier est le localhost du serveur, potentiellement, on peut ne pas le mettre, ce qui aurait pour conséquence que l'entrée du tunnel serait disponible sur toutes les interfaces réseau du serveur SSH.
Ça voudrait dire que n'importe qui tentant une connexion SSH sur le port 23 du serveur arriverait réellement sur le port 22 de l'odroid.
Perso, je préfère restreindre ça uniquement aux connexions provenant de localhost (donc le serveur).
Le second localhost est l'odroid du coup.

Bref, avec ce petit montage, je suis à peu près sûr de toujours parvenir à récupérer la main sur la machine.
Il me suffira de me connecter au serveur intermédiaire et sur celui-ci de me connecter avec <kbd>ssh -p 23 root@localhost</kbd> ce qui me connectera via le tunnel à l'odroid.

## Samba
Bon, un ptit partage **Samba** des plus basique.

Je crée un utilisateur nunux, un utilisateur samba avec le même nom avec <kbd>smbpasswd -a lutilisateur</kbd>.
Dans le montage, je file le dossier du skeudur à lutilisateur avec <kbd>chown lutilisateur:lutilisateur /mnt/sata/samba -R</kbd>.

Le fichier de conf Samba qui va avec :

<details><summary>/etc/samba/smb.conf</summary>
{{< highlight "ini" >}}
[global]
 workgroup            = WORKGROUP
 force user           = lutilisateur
 bind interfaces only = yes

[skeudur]
 browseable = yes
 writeable  = yes
 path       = /mnt/sata/samba
{{< / highlight >}}
</details>

Voilà, il ne devrait plus qu'à le rajouter dans le Window.

## Trouver l'IP
Bon et si SSH a un souci ?
Peu probable mais ça pourrait arriver.
Un problème de clé ou le serveur ssh qui déconne.

Ça serait pas mal si je pouvais avoir ne serait-ce que l'IP.
Du coup, j'ai pondu un ptit script d'une ligne à foutre dans le cron.

Le but est juste de faire une connexion http comme ça on récupère dans les logs du serveur web (une autre machine que le serveur SSH, comme ça c'est plus redondant).

Donc un ptit <kbd>wget http://ip.du.serveur -O /dev/null -q</kbd> .
C'est chouette, avec ça je pourrai trouver l'adresse IP publique que la machine va utiliser.

Pas mal, pas mal du tout mais…
Et si on chopait aussi les IP locales et tout ?

Allez j'arrête le teasing : <kbd>wget http://ip.du.serveur -O /dev/null -q -U odroid-$(ip a s eth0 | grep inet | awk '{print $2}' | tr '\n' '-')</kbd> et voilà.
On récolte toutes les IP directement assignées à eth0 (donc pas d'IPv4 publique, mais on l'a via le log.

Voilà c'était la ptite ruse de sioux.

-----------

Bon bha ça c'est fait.
Reste le plus difficile : configurer le windows.
Configurer le décodeur TV de la freebox, pour pouvoir y accéder.

Et expliquer un peu comment ça marche :-)
