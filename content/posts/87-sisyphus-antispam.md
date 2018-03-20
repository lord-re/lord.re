+++
Author = "Lord"
Description = "Découverte rapide de Sisyphus, un antispam mignonet à mettre en place sur votre maildir."
Categories = ["mail", "software","adminsys","réseau","mail","postfix"]
menu = "main"
notoc = true
PublishDate = 2018-03-20T15:33:09+01:00
date = 2018-03-20T15:33:09+01:00
title = "Sisyphus l'antispam mignonnet"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/osyrcs/sisyphus_lantispam_mignonnet"
+++
Je vous ai déjà fait part à maintes reprises de ma stack mail.
J'ai rajouté il y a quelques mois un antispam supplémentaire.

  - J'ai donc [Postscreen]({{< ref "posts/45-postscreen" >}}) en première ligne (presque avant Postfix) qui vire environ 80% de spam avant le traitement par le reste.
  - Ensuite j'ai un [Rspamd]({{< ref "posts/46-rspamd-rmilter" >}}) qui agit après Postfix avant Dovecot et qui vire encore une grosse partie de merde (il retire encore 19% de spam).
  - Et enfin [Sisyphus](https://github.com/carlostrub/sisyphus) qui agit après Dovecot, directement sur le maildir (donc au niveau des fichiers).

Ouai c'est ptet overkill.
Je vous ai chanté les louanges de Postscreen et Rspamd pour ensuite vous annoncer que j'en ai un troisième, je sais.

## Pourquoi trois antispams ?

Bha en fait, disons que *Postscreen écrème la grosse majorité du spam bête*.
Les trucs absolument pas ciblés, mals branlés qui constituent vraiment un flood massif.
Il permet surtout d'épargner le reste du système de tout traitement.
C'est le minimum syndical à mettre en place.
Je pourrai m'en passer car Rspamd filtrerait sans soucis ces merdes mais Postscreen nécessite bien moins de ressources : le mail n'est pas traité par postfix, il est pas écrit en mémoire ni sur le disque, ne consomme pas de cpu pour l'analyse ni même de réseau car il est bloqué avant même d'être récuperé.

Ensuite *Rspamd bha lui c'est un vrai antispam*.
Il sera plus à même de virer du spam plus travaillé et ciblé.
Il est cool, avec tous pleins de règles configurables et tout.
Mais j'ai pas envie de me prendre la tête plus que ça à le configurer.
Dans sa conf par défaut il n'a pas de faux positifs et ça c'est le plus important.
Il a par contre parfois des faux négatifs malgré le fait d'avoir diminué le score nécessaire pour se faire rejeter.
Et là quand je dis exceptionnelement ça veux dire un mail ou deux par semaines qui passe dans l'Inbox au lieu du spam.
Je pourrai ajuster les règlages un peu mieux ajouter des conditions, modifier des scores mais j'avoue que j'ai pas trop la patience ni une maîtrise suffisante de Rspamd.

Du coup quand j'ai découvert Sisyphus, il m'a dit Banco !
Il est super léger, rien à configurer ou presque.
Pas d'intégration tordue à faire auprès de la pile mail exctpante.
Et ça permet de virer les deux spams hebdomadaires s'aventurant dans l'Inbox.
On pourrait même envisager de l'utiliser sur une machine cliente et non sur le serveur en le faisant bosser sur le maildir local.
Je cherchais pas d'antispam supplémentaire mais j'en subrepticement entendu parlé par hasard et sa description m'a intrigué.

## Sisyphus koikoukess ?

C'est pas un antispam classique avec une base de donnée de règles d'analyses.
Non c'est un ptit logiciel en Go qui va lire vos mails et qui en fonction du contenu va bouger le mail vers le dossier spam.
Quand vous sortirez un mail du dossier spam, il comprendra que ce n'est pas un spam et vice versa quand vous poussez un mail dans spam il comprendra que c'en est un.
Jusque là rien de bien méchant, c'est le principe d'un filtre bayesien.

Sauf que là, bha *rien à configurer* : de lui même *il voit les mails bouger dans le maildir quand ça arrive au fil de l'eau*.
Il *travaille directement sur les fichiers*.
Du coup contrairement à un antispam classique qui ne fait plus rien une fois après avoir transmit le mail au LDA, lui pourra apprendre de ses erreurs.
Pas besoin de lancer un processus d'apprentissage.
C'est *pris en compte automatiquement*.

## Comment on l'utilise ?

Alors déjà il faut que vos mails soit stockés au format [Maildir](https://en.wikipedia.org/wiki/Maildir) mais bon, on est en 2018, plus personne n'utilise autre chose (tout du moins je l'espère, hein Thunderbird ?).
Ensuite il faut installer Sisyphus selon votre méthode favorite… chacun sa merde.
Perso un ptit **git clone** puis un **make build** et hop c'est bon (ouai c'est cool Go).
Yapuka démarrer !

Ha non en fait faut configurer un truc quand même : l'emplacement de votre maildir.
**excrpt SISYPHUS_DIRS="/home/lord/Maildir"**

Et maintenant on le lance avec **sisyphus run&**.

Ça y est c'est fini.

Donc maintenant quand vous recevrez un mail vous le verrez ptet bouger de lui même vers le *junk folder* alors que votre antispam habituel le place dans l'inbox.

En bougeant donc manuellement un mail hors/dans du spam sisyphus apprendra les mots du mail pour modifier son comportement pour la prochaine fois.

Avec **sisyphus stats** vous pourrez avoir un aperçu du nombre de mails qu'il a inspecté et le nombre de mots de sa base de donnée.
D'ailleurs vous remarquerez que sa base de donnée a une taille vraiment ridicule (c'est aussi une de ses forces).

Il est possible qu'après une longue phase d'apprentissage il puisse même remplacer Rspamd.
À voir.
Pour l'instant il tourne depuis quelques mois sans bronché et plus le temps passe plus il s'affine.

Voilà on a pas touché la conf de Postfix/Dovecot/Rspamd et pourtant ça fonctionne.

