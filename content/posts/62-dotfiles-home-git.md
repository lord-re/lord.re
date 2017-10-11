+++
Categories = ["tips","adminsys"]
Description = "Gérer ses fameux dotfiles sans installer de nouveau logiciel. Simplement avec versionnement toussa toussa."
Tags = ["www","meta"]
date = "2017-10-16T12:50:35+02:00"
PublishDate = "2017-10-16T12:50:35+02:00"
menu = "main"
notoc = true
title = "Gérer ses dotfiles simplement avec git"

+++
Ça fait plusieurs fois que je vous tease sur ce sujet donc voilà je me lance. Je vais vous expliquer ma façon de gérer mes dotfiles. C'est un sujet assez récurrent chez les linuxiens et visiblement tout le monde à sa ptite façon de faire.

Certains font une soupe à base de lien symbolique dans tous les sens histoire de tout centraliser dans un seul dossier plus facilement copiable. D'autres utilisent des scripts ou softs exprès pour gérer ça comme par exemple GNU Stow. D'autres plus barbus adoptent un système basé sur du Makefile (et c'est finalement pas si crado que ça). Personnelement je ***ne voulais pas devoir apprendre à utiliser un autre soft***. Je veux ***pas devoir installer un soft exprès pour ça***. Je veux ***pas me faire chier*** avec des liens symboliques à faire moi même. Je veux ***un truc versionnable*** pour pouvoir revenir en arrière en cas de connerie.

## Git à la rescousse
Une solution complète est d'utiliser Git. Comme ça on versionne, on synchronise facilement et puis on peut même se faire des branches pour avoir des variations sur différentes machines. Mais du coup la question qui se pose est comment on le fout en place ? Est-ce qu'on fout tout son */home/* dedans mais du coup ça va contenir à la toque de fichiers qu'on a pas forcément envie de fouttre dedans ? Et puis surtout le plus problèmatique c'est qu'on va se retrouver avec tous les dossiers de git bien moches (description, HEAD, hooks, logs, refs,…) bref pas envie que ça trône là.

## La commande git qui tue
**git --git-dir=/home/lord/.myconf --work-tree=/home/lord**

Voilà la bête. À mettre dans un alias (par exemple **config**). Donc en gros toutes les saletés de git sont stockées dans */home/lord/.myconf* et du coup ça devrait être propre.

## Comment qu'on s'en sert ?
Bon première chose à faire c'est ajouter les fichiers que vous voulez gérer avec **config add .ssh/config** pour prendre un seul fichier ou bien **config add .ssh** pour prendre tout le dossier (attention si vous mettez vos clés privés dedans ça a des implications au niveau de la sécurité, je vous recommandes de ne pas inclure vos clés privées dedans (personnelement je ne le fais pas)).

Ensuite on vérifie l'état du bousin avec **config status** :
```
lord@hermes ~ %config status
On branch master
Your branch is ahead of 'origin/master' by 4 commits.
  (use "git push" to publish your local commits)
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)
        new file:   .config/mpv/scripts/fix-sub-timing.lua
        new file:   .ssh/config
        new file:   .ssh/known_hosts
Untracked files not listed (use -u option to show untracked files)
```

Ensuite il faut commit leur état actuel. Je vous recommande de faire des commits différents pour chaque fichier (tout du moins chaque fichiers logiquement groupés entre eux). Donc **config commit .ssh/config .ssh/known_hosts -m "[SSH] ajout de .ssh/config et .ssh/known_hosts"** .
```
lord@hermes ~ %config commit .ssh/config .ssh/known_hosts -m "[SSH] ajout de .ssh/config et .ssh/known_hosts"
[master 35259ea] [SSH] ajout de .ssh/config et .ssh/known_hosts
 2 files changed, 271 insertions(+)
 create mode 100644 .ssh/config
 create mode 100644 .ssh/known_hosts
```

Bon bha c'est fait. Si par mégarde vous avez mis des fichiers que vous ne voulez pas dans votre repo il va vous falloir **config rm --cached .ssh/id_rsa** . Le point important est le ***--cached*** qui ne supprimera pas le vrai fichier mais juste le fichier du repo. Méfiance.

Hey mais tu m'apprends à utiliser git ?! Ouai bha un tout petite peu. C'est surtout pour convaincre ceux qui ne sont pas dev, que de faire un chouilla de git c'est pas trop compliqué et que c'est super puissant comme outil.

## Bon et comment on altère le passé ?
Bon déjà comment trouver la modif qui foire ? Déjà pour voir les commits c'est avec **config log** vous y verrez la date, le numéro de commit et le message. Si vous voulez voir ce que contient un commit **config diff xxxxxxxxx**. Si c'est trop confus et que vous voulez voir les modifs d'un fichier précis dans le commit **config diff xxxxxxx votre/fichier**.

Vous avez trouvé le commit foireux et vous voulez annuler ? Le mieux c'est de faire un **config revert xxxxxxx**. Vous voyez l'intéret de fractionner vos modifs dans plusieurs commits ? Plus vous ferez des ptites modifs dans un seul commit plus ce sera simple de revenir en arrière.

Si vous voulez juste voir dans quel état vous étiez à un moment donné, **config checkout xxxxxxxxx** est votre ami. Vous serez dans le mode dit *DETACHED HEAD*. Par simplicité, évitez d'y faire des modifs. Pour revenir dans l'état courant lancez un **config checkout master** . Et voilà.

Sachez qu'il existe les commandes ***reset*** et aussi le ***reset --hard*** mais c'est assez dévastateur. Renseignez-vous bien avant de les utiliser.

## Mais du coup comment je sync ça ailleurs ?
Pendant longtemps j'ai pas synchronisé le cafoutch mais désormais je le fait dans un soucis de backup principalement. Mais ça peut servir pour utiliser sur de multiples machines. Désormais j'utilise un gogs (autohébergé via sandstorm) qui me permet d'avoir une ptite interface web mignonette. Du coup j'ai deux repos : un de backup et le gogs. Le but de l'article n'est pas de voir comment héberger ça donc sur ce point débrouillez-vous. Une fois l'hébergement solutionné il vous suffira donc dans votre repo local d'ajouter les repos distants.

Pour ajouter mon gogs j'ai donc **config remote add gogs https://xxxxxxxx** et pour ajouter mon backup **config remote add origin ssh://xxxxxxx**.

Pour y envoyer les commits il faut penser à **config push gogs** et **config push origin**. Voilà tout simplement.

Pour récupérer d'éventuelles modifs distantes on lance un **config fetch** suivi d'un **config status** encore une fois pour voir si on est retard par rapport à ***HEAD***. Si c'est le cas, on lance un **config pull**. Et voilà.

Donc pour résumer avant toute chose on *fetch* pour s'assurer qu'il n'y a pas de modif, s'il y en a on *pull* et sinon, si on fait des modifs on *pull*. Ça couvre à peu près tout.

Et donc le plus important comment ajouter le barda sur une nouvelle machine. On se place dans le */home/votre_user*. Là il va malheureusement falloir tout virer mais bon vous pourrez remettre les trucs après. Donc on commence par refouttre l'alias du début. Et puis on fait un **config init .**, suivi d'un **config remote add origin VOTREREPO**, ensuite un **config pull origin** (qui risquera de prendre un peu de temps et pour finir **config checkout master**. Pouf vous avez tout vos fichiers.

## Pas aussi simple que ça en l'air ton machin
Bof non franchement ça va assez bien. Au final c'est de l'utilisation assez basique de git. J'aborde pas les branches car j'en utilise pas mais c'est pas trop compliqué non plus. Et ça vous permettra d'avoir une branche spécifique par machine (si jamais vous voulez pas exactement la même chose de partout).
