+++
Author = "Lord"
Categories = ["software","adminsys","réseau","tips","mail","postfix"]
Description = "Allez hop hop hop, on modernise la stack mail. On vire spamassassin et opendkim. À la place on met ceux à la mode : rmilter et rspamd."
date = "2016-10-18T15:17:19+02:00"
title = "Dégageons opendkim et spamassassin pour Rspamd et Rmilter"
menu = "main"
jdh = "https://www.journalduhacker.net/s/vtv4an/d_gageons_opendkim_et_spammassassin_pour"
TopWords = [  "postscreen", "spam", "air", "dkim", "fout", "tiens", "postfix", "opendkim", "rspamd", "rmilter"]
+++
Après ce suspens insoutenable voilà la suite tant attendu.
Petit résumé pour les adeptes du tldr de l'article précédent : bon j'ai foutu du postscreen sur les deux mx tout va bien sauf qu'en fait je me suis rendu compte que mes mails ne sont plus signés par opendkim et spamassassin ne me satisfait plus trop trop.

## Plus d'Opendkim, donc on va rmilter
Ne sachant trop pourquoi OpenDkim ne faisait plus son taff.
Et là j'avais pas trop envie de le débugguer.
À vrai dire j'ai juste regardé si le process tournait et s'il était bien déclaré dans le main.cf de postfix.
Ouai à priori tout y est.
Bizarre j'ai pas souvenir d'y avoir touché.
Du coup par flemme et esprit d'aventure (c'est pas si incompatible) j'ai eu envie de voir les alternatives.
Depuis quelque temps j'entends parlé de Rmilter et Rspamd.
Du coup je me renseigne un peu plus et visiblement Rmilter a l'air pas mal du tout.
Opensource, moderne, à première vue plutôt bien branlé.
Et en plus il a l'air de gérer le DKIM.
Pfiou c'est inattendu.
Bref ni une ni deux j'émerge tout ça sur la fière Gentoo qui sert de serveur mail.
Bon pour mettre rmilter en service il suffit de le définir en tant que milter (c'est un portemanteau de mail filter, c'est t'y pas mignon comme mot ?).
En gros ça fonctionne comme les autres milters, du coup je n'ai qu'à modifier le port que j'avais défini pour Opendkim (qui est lui aussi un milter) et foutre celui de rmilter et pouf ça ira pour postfix.
Et maintenant on fonce dans le */etc/rmilter/rmilter.conf* et là WOW O__O ! Ha c'est plutôt bien fourni là-dedans.
Par chance c'est principalement commenté et du coup explicite.

Bon le truc de base, le port d'écoute.
Tiens, on peut brancher clamav.
M'en fout, mais je sais que ça fait plaisir à certains.
L'antispam, ok c'est fait pour être compatible avec différents antispam dont rspamd parfait je compte y passer par la même occase… pas mal d'options plus ou moins intéressantes d'ailleurs.
Redis.
Hein ?
Que vois-je ?
Mais qu'est-ce qu'il veut faire avec ça ?
hmmm c'est facultatif.
hmmm c'est pour fouttre en cache et apporter quelques raffinements.
Mouai allez pourquoi pas.
De mémoire de base ça coûte à peu près rien à faire tourner ça.
Voyons voir la suite.
… limits … ouai comme d'hab.
On va espérer que par défaut ce soit bien foutu.
Greylisting.
Ouai cool mais j'ai déjà postscreen qui fait son office comme vous l'avez lu précédemment (vous l'avez vraiment lu l'article précédent ?).
DKIM.
Ha bha enfin j'ai cru que ça n'arriverait jamais.
Hmmm tiens la conf a l'air diablement plus courte et explicite que celle d'opendkim.
C'est plutôt un bon point.
En gros on définit autant de bloc que de domaines différents.
Chaque bloc contient le domaine à signer, le chemin vers la clé privée, et le selector (champs dns du dkim).
Bref pas de superflus et super clair.
Allez passons à la suite.
Bon bha en fait on est en bas du fichier, il ne reste que des include pour d'autres bouts de conf, mais on s'en fout.

Bon bha yapuka lancer rmilter et reload postfix.

## Confons Rspamd
Allons dans le dossier de conf de rspamd.
Aoutch il y a du monde.
Tiens tous les fichiers de conf indiquent bien que les modifs doivent pas être fait ici car ça risque de se faire squancher à chaque update.
Donc il faut balancer les modifs perso dans un dossier override bref rien de bien méchant même si pas trop utile avec etc-update de gentoo et/ou fouttre tout ça dans un git.
Bon après avoir un peu tout regardé ça a l'air plutôt bien rangé et avoir des réglages par défaut plutôt honnête.
Je dirai même qu'il n'y a pas grand-chose à modifier.
Bon allez on se fout un ptit serveur redis en marche.
Et hop on lance rspamd.
Tiens il y a un rspamc pour faire mumuse.
On va lui faire ingurgiter quelques mails pour lui permettre de séparer le bon mail de l'ivraie.
Allez hop **<kbd>rspamc learn-spam /home/lord/maildir/.spam/</kbd>** et ça mouline.
Au bout de quelques minutes bha on a rspamd tout rassasié qui n'aura qu'à tremper ses lèvres dans le mail pour pouvoir le flagguer comme un grand.
Bon bha voilà.
Ça tourne.
Plus qu'à attendre de recevoir des spams.
Malheureusement j'en reçois quasiment plus depuis le passage de postscreen mais bon.

Testons les capacités de signatures dkim de rmilter.
On envoie un mail et on reluque les headers.
Ha bha ça marche.

Bon bha voilà.
Ça tourne comme ça depuis quelques mois maintenant sans soucis.
Avec quasiment tout par défaut.
C'est donc efficace, pas eu de faux positifs ni dans un sens ni dans l'autre.
Ça se pose en deux temps trois mouvements et la conf par défaut a des bons règlages.
Ça bouffe un poil plus de RAM qu'avant mais c'est franchement anecdotique.
Au final j'ai donc une stack composée de postfix, rmilter, rspamd, dovecot, un ptit nginx et son ptit couple roundcube/rainloop.
Et en dehors de Microsoft qui n'aime pas mes mails (il faut avoir bonne réputation mais quand tu leur envois jamais de mail bha tu n'as pas de réputation… le dilemme du club privé) mais je m'en fout.
Par contre s'ils pouvaient arrêter de tenter de m'envoyer du spam…

PS: Opendkim ne fonctionnait plus parce que j'avais fait une jolie faute de frappe dans le *main.cf* de postfix.
Du coup ça miltait plus beaucoup…

