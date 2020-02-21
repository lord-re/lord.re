+++
Author = "Lord"
menu = "main"
Categories = ["software","adminsys","réseau","postfix","mail"]
Description = "Et si l'on soulageait votre stack mail en virant les spams au plus tôt avant même qu'ils ne rentrent chez vous ? Sounds Good !"
date = "2016-10-17T15:09:31+02:00"
lastEdit = "2019-07-28T00:10:12+02:00"
title = "Soulager son serveur mail du traitement du spam avec Postscreen"
jdh = "https://www.journalduhacker.net/s/xkorqz/soulager_son_serveur_mail_du_traitement"
TopWords = [  "dnsbl", "enforce", "perso", "backup", "protocole", "smtp", "mx", "postfix", "postscreen", "spam"]
+++

Quel titre sérieux !
Bref, jusqu'à il n'y a pas si longtemps que ça, j'avais une architecture assez basique pour le mail :

  - Un **postfix** pour l'*émission/réception*.
  - Un **Spamassassin** qui *reluque les mails et qui les taggue s'ils ressemblent à du spam*
  - Un **Dovecot** qui *stocke les mails et les présentent aux clients mails*.
  - **Dovecot** se chargeant par la même occasion de l'*auth* (via sasl) et du *classement des mails* (via sieve et managesieve).
  - À tout cela on rajoute quasiment la même chose en **MX backup** (c'est-à-dire un serveur qui sert uniquement si le premier serveur ne fonctionne pas).

Voilà c'est un truc assez classique pour les autohébergés.
Ça fait un peu peur au début mais au final tout est super bien documenté et très présent sur les Internets.

Mais voilà que le spam commençait à être vraiment insistant.
Une solution très commune à l'époque (un peu moins maintenant) est de rajouter du **greylisting** (voir le module postgrey pour Postfix).

Le principe est simple.

 > Un serveur extérieur contacte votre serveur pour lui délivrer un mail.

 > Votre serveur perso va lui dire "Coco reviens un peu plus tard c'est pas tout à fait prêt ici.".

 > Selon le protocole SMTP, le serveur d'origine doit retenter quelques minutes plus tard de vous délivrer le mail.
 
 > Ce coup-ci votre serveur, en voyant que ce serveur a déjà fait une tentative plus tôt, acceptera le mail.

La conséquence immédiate, c'est que tous les mails se prennent un délai dans les dents (on peut bien évidemment whitelister les serveurs avec lesquels vous conversez souvent) mais ce qu'il faut savoir c'est qu'envoyer des millions de mails pour spammer nécessite des logiciels particuliers.
*Les softs des spammeurs sont faits pour envoyer plein de mails vite, ils n'implémentent pas correctement le protocole SMTP à la lettre.*
Du coup il ne retentera pas votre serveur dans le délai imparti.
De ce fait vous serez blacklisté des spammeurs (ho joie).

Bref c'est pas mal du tout.
Perso l'idée me plaît pas mal mais le délai de réception des mails m'emmerde un poil.
Du coup je ne l'ai pas mis en place pendant des années.

## Revamping de la stack pour une architecture mieux redondée
Quel sous-titre sérieux !!
Lassé du flot de spam grandissant je me suis penché sur les trucs un peu plus à la mode.

Voyons voir.
Consultons le chan irc de chez #postfix (non ce n'est pas un hashtag).
Bon bon bon.
Le truc moderne efficace aujourd'hui c'est **Postscreen**.

En gros le greylisting c'est plus trop la mode, **Postgrey** tombe petit à petit en désuétude et finira par crever assez vite visiblement (enfin au rythme du mail quoi).
Le remplaçant c'est Postscreen qui fait du greylisting et une évaluation plus stricte du protocole SMTP.
En gros il va falloir que les serveurs qui voudront causer avec vous soient plus rigoureux sur leur respect du protocole.
Si ce n'est pas le cas vous pouvez soit ignorer ces tests (mais à quoi bon (en vrai ça sert lors de la mise en place quand on reluque consciencieusement les logs) ) soit carrément couper la connexion avec le serveur peu rigoureux.
Qui plus est ce module se targue de soulager votre infra mail, car il agit avant même la réception du mail.

De ce fait *une très grosse partie des mails seront jartés avant même d'être traités*.
Donc ils ne feront pas bosser votre mailqueue ni votre antispam ni votre petit Dovecot.
*Bref moins d'utilisation cpu/réseau/ram/skeudur et BEAUCOUP moins de spam.*
Énormément moins de spam !

## Convaincu ? Allez c'est partit, on s'installe ça !

Alors déjà vu qu'on est en 2016, j'espère quand même que votre Postfix est au moins en 2.8, si c'est pas le cas changez tout de suite de distro et passer sur un truc moins à la bourre.
Bon bha voilà vous avez tout installé, reste plus qu'à confer.
Gogo.

<details open>
<summary>Alors on va commencer par le *master.cf*</summary>
```
smtp     inet n - n n 1 postscreen
smtpd    pass - - n - - smtpd
dnsblog  unix - - n - 0 dnsblog
tlsproxy unix - - n - 0 tlsproxy
```
</details>

Bon alors là ça veut juste dire que tout ce qui rentre dans le process smtp est envoyé à la commande postscreen.
Donc tout ce qui rentre va être mouliné par postscreen.
Maintenant il faut dire à postscreen que faire.
Ça se conf avec le reste de Postfix dans le main.cf.
Le mieux est quand même d'aller matter la doc officielle mais bon voilà ce que j'ai mis chez moi :
<details open>
<summary>le *main.cf*</summary>
```
postscreen_access_list = permit_mynetworks, cidr:/etc/postfix/postscreen_access.cidr
postscreen_blacklist_action = drop
postscreen_dnsbl_sites =
zen.spamhaus.org*2
bl.spameatingmonkey.net*2
bl.spamcop.net
…
postscreen_dnsbl_threshold = 4
postscreen_dnsbl_action = drop
postscreen_greet_banner = On patiente 5 secondes, merci
postscreen_greet_action = enforce
postscreen_pipelining_enable = yes
postscreen_pipelining_action = enforce
postscreen_non_smtp_command_enable = yes
postscreen_non_smtp_command_action = enforce
postscreen_bare_newline_enable = yes
postscreen_bare_newline_action = enforce
```
</details>
et voilà.
Donc en très gros, j'ai le fichier */etc/postfix/postscreen_access.cidr* qui contient ma whitelist/blacklist faite à la mimine qui permet déjà de jarter les gros relous que je connais ou bien de leur éviter le délai.
Et la deuxième merdouille significative c'est que j'ai un petit paquet de dnsbl qui sont consultées ce qui permet de très grandement viré les spammeurs.
Perso j'en ai mis une dizaine et sachez que certaines dnsbl ne sont pas gratuites (sauf dans un usage perso/modéré ce qui est mon cas).
Pour celles et ceussent qui ne savent pas ce qu'est une dnsbl :

Une **DNSBL** : DNS BlackList est une liste noire de machines connues que l'on consulte via le protocole DNS qui fonctionne de la sorte : "Quel est l'ip de la machine truc.machin ?" et la réponse sera de la forme 127.0.0.X où X aura une valeur prédéfinie indiquant s'il est spammeur ou non.
C'est donc un mécanisme assez simple proche des api http.

Bon bha déjà avec ça normalement vous n'aurez quasiment plus de spam à traiter.
Ça va grandement aleger votre inbox.

<hr>
En mettant ça en place sur ma machine principale tout allait bien.
Sauf qu'au bout de quelques mois je suis allé voir un peu le MX backup (la machine secondaire qui traite les mails lorsque le primaire est hs) et là BAM.
Mauvaise surprise.
Elle est blindée de mails.
99% de spam bien entendu.
Bon du coup je lui mets un bon coup de Postscreen lui aussi.

Et puis en fait je me rends compte que des mails légitimes sont aussi arrivés ici.
Bha ouai, quand le Postscreen du MX primaire demande aux gens de revenir un poil plus tard… bha certains sont trop pressés et s'adressent au mx backup.
Finalement c'est plutôt logique.
Et comme en plus j'ai pas spécialement bien configuré le mx backup (celui stock les mails en local au lieu de les renvoyer au primaire, erreur classique) bha je me retrouve avec un ptit merdier de mail.

Bon c'est un peu hors sujet mais pour la ptite histoire, j'ai converti le fichier mbox contenant tous les mails au format maildir que j'ai ensuite rsync vers mon maildir principal pour les fusionner et là je me suis amusé à classer 12000 mails… FUN

Bon du coup je corrige la conf du mx backup.
Déjà plus trop de soucis de redondance.
Énorme bon point.
Plus trop de spam qui arrive à tire larigot.
Énorme bon point (encore un et j'ai une image !).
Bon et ce vieux spamassassin qui n'est pas si efficace que ça ? J'en profiterai pas pour le jarter ? Tiens d'ailleurs on vient de me signaler que je fais plus de signature DKIM sur mes mails sortants !
Grrr ça annonce un prochain article (et hop Cliffhanger des familles).

------
*PS Juillet 2019 :* J'ai corrigé et un petit modifié l'affichage de ce blogpost. Merci à Tetsumaki pour les remontées ;-)
