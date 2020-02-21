+++
Author = "Lord"
title = "Gestionnaire de passwords : password-store"
menu = "main"
Categories = ["software","libre","tips"]
Tags = ["software","libre","tips"]
Description = "Petit tour de Password-store un des meilleurs gestionnaire de mots de passe."
date = "2014-04-25T00:47:41+02:00"
TopWords = [  "prefix", "agent", "dmenu", "init", "passmenu", "i3", "password_files", "gpg", "pass"]

+++

Comme vous le savez, il faut changer de mots de passe régulièrement.
Comme vous le savez il faut des mots de passe de pleins de caractères et si possible des caractères à la con.
Comme vous le savez il ne faut pas utiliser le même mot de passe pour plusieurs services différents.

Ouai c'est chiant mais au final des outils vont vous aider à gérer tout ça facilement et surtout ça sera très simple et utilisable avec tous les logiciels et pas uniquement votre navigateur web.
Donc quels sont les ingrédients ?

  * pass
  * dmenu
  * gnupg
  * pinentry
  * git

Commençons donc par installer tout ce petit monde.
Il nous reste plus qu'à configurer le tout.

## Configuration pour flemmarder
Donc générons une couple de clé qui servira à chiffrer tout le toutim histoire d'être à l'abri.
**gpg --gen-key**.
Répondez aux questions et tant qu'à faire, prévoyez une clé suffisamment grande pour être en sécurité.

On a un peu de crypto de faite maintenant rendons le truc distribué afin de l'utiliser sur plusieurs machines.

  1. **<samp>pass init</samp>** Là on crér le répertoire des mots de passe.
  2. **<samp>pass git init</samp>** là on prépare le terrain pour ce bon vieux git.
  3. **<samp>pass git remote add origin votreserveur:lenomdurepo</samp>** et là vous désignez le "serveur" qui sera le "point central" sur lequel vous pousserez les modifs et également sur lequel vous récupérerez les infos.

À partir de là vous n'aurez pas à vous soucier de la partie git (en dehors de la synchro).

Peaufinons un peu le bousin pour pas rentrer la passphrase gpg à chaque utilisation.
On va utiliser un agent-gpg.
Donc lorsque qingy va ouvrir une session i3 on va lui demander de sagement démarrer ça.
*/etc/qingy/xsessions/i3*
```
#! /bin/sh
eval $(gpg-agent --daemon)
exec /usr/bin/i3 >> /tmp/i3.log
```
On rajoute également un **use-agent** à la fin de gpg.conf et pour terminer on crée le fichier qui va bien :
*.gnupg/gpg-agent.conf*
```
pinentry-program /usr/bin/pinentry-qt4
no-grab
default-cache-ttl 1800
```
C'est assez explicite.

## Et maintenant flemmardons
Donc maintenant on va l'utiliser.
D'abord pour rajouter un pass existant : **<samp>pass insert nom_du_pass</samp>**.
Pour créer un mot de pass (et le mettre dans le buffer pour pouvoir le coller) : **<samp>pass generate -c nom_du_pass nombredecaractères</samp>**.
Vous remarque qu'il n'y a pas besoin d'entrer la passphrase GPG puisqu'ils sont chiffrés avec la clé publique PGP qui n'est pas sécurisée.

Maintenant pour lister les pass : **<samp>pass</samp>**.
Pour en récupérer un : **<samp>pass nom_du_pass</samp>**, (rajouter -c pour le fouttre dans le buffer de copié/collé).
Là ça vous demande votre passphrase gpg.

C'est bien mais c'est chiant d'ouvrir un terminal pour ça toussa toussa.
Donc on va utiliser *passmenu* qui utilise dmenu pour faire une petite interface graphique des plus ravissantes et surtout pratique car accessible à tout moment en un clin d'œil.
*/opt/bin/passmenu − [Merci cdown sur github](https://github.com/cdown/passmenu)*
```
#!/bin/bash
shopt -s nullglob globstar
export PASSWORD_STORE_X_SELECTION="primary"
prefix=${PASSWORD_STORE_DIR-~/.password-store}
password_files="( "$prefix"/**/*.gpg )
password_files=( "${password_files[@]#"$prefix"/}" )
password_files=( "${password_files[@]%.gpg}" )
password=$(printf '%s\n' "${password_files[@]}" | dmenu "$@")
pass -c "$password"
```
et on ajoute un ptit hotkey dans i3 *bindsym $m+o exec passmenu* comme ça un ptit coup de **<samp>Alt+o</samp>** et pouf j'ai le dmenu des pass ♥.

## Et sur une autre machine ?
On commence par installer gnpupg git pass.
Puis on fait un **<samp>pass init</samp>**, **<samp>pass git init</samp>** et enfin **<samp>pass git remote add origin votreserveur:lenomdurepo</samp>** et enfin un joli **<samp>pass git pull</samp>** et voilà vous avez tous vos pass ici aussi :-)

## Enjoy

