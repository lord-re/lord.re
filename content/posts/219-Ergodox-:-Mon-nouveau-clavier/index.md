+++
Author = "Lord"
Description = ""
Categories = ["clavier", "hardware","software"]
menu = "main"
notoc = true
WritingDate = 2021-06-03T13:32:08+02:00
date = 2021-06-03T13:32:08+02:00
title = "Ergodox : Mon nouveau clavier"
editor = "kakoune"
+++
Et voilà un nouveau venu dans ma [collection de claviers]({{< ref "posts/166-keyboard-collection"  >}}) !
Un fameux Ergodox avec son design avec les mains séparées, ses touches presque ortholinéaires (on est proche de la patte d'ours) et son firmware facilement reprogrammable.

Par rapport à mon ancien j'ai donc la possibilité de ne plus me casser le poignet pour écrire du texte \o/.
Et franchement c'est très agréable à utiliser.
Je l'ai à peine depuis quelques jours que ça me plaît bien.

{{< img src="ergo.jpg" alt="photo de l'engin avec l'ancien clavier dans le fond." title="La passation de pouvoir" >}}

## Firmware libre
Contrairement à un clavier plus traditionnel, ici le firmware est libre et donc reprogrammable.
On peut donc modifier à loisir toute la partie logicielle qui tourne dans le clavier.
Et c'est un petit détail à la base mais au final c'est génial.
Ça permet pas mal de ptites folies.

Le truc élémentaire que ça permet c'est de déplacer logiciellement les touches du clavier.
Donc quand vous avez une touche qui vous gonfle vous pouvez la désactiver ou bien la déplacer.
Et là on commence à jouer à une partie de tetris endiablée.

Il y a six ans je m'étais fait un clavier à la main et j'avais utilisé un firmware libre du nom de **TMK** que l'on retrouvait un peu partout.
C'était le top à l'époque mais maintenant les claviers mécaniques sont bien plus populaires et maintenant toute une petite industrie s'est créée et organisée et maintenant on trouve bien plus de fabricants pour un peu tous les composants et également pour les firmwares.
Maintenant celui qui a le vent en poupe est **QMK** qui est un fork du premier.

Il a maintenant rallié une grande partie de la communauté et même les quelques rares fabricants de claviers artisanaux.
Du coup bha j'ai pas trop cherché à comprendre je suis allé vers là.
Surtout que maintenant il existe des sites ouaib vous permettant de faire la programmation de votre firmware tout dans le navigateur avec une interface toute intuitive avec peu de chance de se planter.
Et à la fin ça vous compile et vous donne le fichier qui va bien.

Alors attention !
Ce genre de truc c'est potentiellement très risqué.
Ça va vous compiler un bout de code qui va se planquer dans votre clavier.
C'est un énorme risque de rootkit !

Bon, alors il existe plusieurs sites pour le faire.
Perso je passe par le site de ZSA un constructeur assez connu dans le milieu.
Ils ont donc leur configurateur qui s'appelle [Oryx](https://configure.zsa.io/) qui est tout mignon.
Il ne permet pas de faire absolument tout ce que permet QMK mais pas loin.

## Ma disposition
Un ptit truc sympa c'est que ce que les configurations des utilisateurs du service peuvent être partagées.
Voilà [ma disposition actuelle](https://configure.zsa.io/ergodox-ez/layouts/B9NeA/latest/0#).
Elle n'est pas trop exotique.

### Bépo++
Bon je tape en bépo, mais le clavier se configure quand même en qwerty (encore que je n'avais pas vu mais, il y a une option qui permet de faire aussi en bépo mais c'était trop tard pour moi).
Par rapport à un bépo traditionnel je n'ai fait que quelques petites modifs : j'ai foutu le <kbd>ç</kbd> tout en bas tout seul (le pauvre).
J'ai également bougé le <kbd>w</kbd> en dessous du <kbd>m</kbd> ce qui est plus pratique et permet de gagner une colonne.
La dernière modif de bépo est le <kbd>%</kbd> qui est désormais à la place de la tabulation qui elle est descendue d'une case à là place du <kbd>Caps Lock</kbd> qui n'a aucun intêret.

Ensuite concernant les touches de modificateur j'ai placé <kbd>Hyper</kbd> et <kbd>Meh</kbd> mais en vrai je ne m'en sers pas.
Ce clavier a décidément bien trop de touches !

La touche <kbd>Paste</kbd> est une macro qui envoie <kbd>Shift+Insert</kbd> ce qui colle sous nunux.
Très pratique.

La touche <kbd>Esc/Fn</kbd> est une touche la touche <kbd>Écha</kbd> sauf que si je la maintiens enfoncée ça fait office de <kbd>Fn</kbd> ce qui me permet de passer sur la seconde couche du clavier.
La seconde couche ?!
Oui oui.
QMK a un système de couche où en fait on peut définir pour la même touche plusieurs fonctionnalités en fonction de la couche.

On peut passer d'une couche à l'autre en définissant des touches spécifiques à ça.
Dans mon cas les touches des chiffres, sur la seconde couche deviennent les touches <kbd>Fx</kbd> comme ça je peux quand même faire <kbd>F5</kbd> en appuyant sur <kbd>Esc/Fn</kbd> et <kbd>5</kbd>.
J'ai appliqué le même concept sur les flêches afin d'avoir les <kbd>Home</kbd>,<kbd>PageUp</kbd>,<kbd>PageDown</kbd> et <kbd>End</kbd>.
Cela dit, je trouve le système un peu moins agréable que sur TMK puisqu'ici ça se base sur une temporisation alors que sur TMK c'était le fait d'appuyer sur une autre touche sans relâcher la première qui changeait la donne.
Là il faut gérer le timing et pour le moment je l'ai pas le timing…

### Options du firmware
Dans les options du firmware j'ai pu baisser la durée de debounce.
Je ne sais pas trop pourquoi ils utilisent une valeur de 30ms par défaut alors qu'à l'usage j'ai jamais eu de soucis avec 5ms.
Le debounce c'est le temps minimum que la touche doit être appuyée pour qu'elle soit prise en compte.
Ça évite de la compter en double ou triple au moment de son activation/désactivation.

### Download et Upload
Voilà, une fois tout paramétré, on clique le gros bouton **Compile this layout**.
Ça mouline quelques secondes puis il vous fournit soit le binaire soit les sources.
Vous téléchargez le fichier donc au format .hex ça fait moins de 100Ko c'est tout petit.

Il ne vous reste plus qu'à l'envoyer dans votre clavier !
Alors là, je suis passé par **teensy_cli_loader** qui est un tout ptit logiciel (qui nécessite *libusb-compat* sous gentoo) à qui vous dites le type de micro-controlleur et vous lui donnez le programme.
Vous le lancez en root et vous appuyez sur le ptit bouton planqué du clavier.

<details><summary><kbd>teensy_loader_cli --mcu=atmega32u4 -v -w /tmp/keyboard/ergodox_ez_glow_bepo_B9NeA_05DQP.hex</kbd></summary>
<pre>Teensy Loader, Command Line, Version 2.2
Read "/tmp/keyboard/ergodox_ez_glow_bepo_B9NeA_05DQP.hex": 23036 bytes, 71.4% usage
Waiting for Teensy device...
 (hint: press the reset button)
Found HalfKay Bootloader
Read "/tmp/keyboard/ergodox_ez_glow_bepo_B9NeA_05DQP.hex": 23036 bytes, 71.4% usage
Programming....................................................................................................................................................................................
Booting</pre>
</details>

Et là votre clavier a pris en compte le nouveau firmware et vous pouvez de suite tester les modifs.
Ça ne prend que quelques secondes.

## L'ergodox physiquement
Bon si vous ne connaissez pas l'ergodox, à sa vue vous devez vous dire que c'est un étrange appareil.
Et c'est pas si faux.

En fait les claviers sont d'étranges appareils de base.
L'informatique a connu quelques révolutions mais les claviers sont restés des trucs archaïques optimisés pour un fonctionnement de machine à écrire avec les contraintes mécaniques de l'époque.
L'Ergodox est un design libre qui a fait quelques choix intéressants.
Déjà les mains sont séparées.
On peut donc écarter et incliner les deux moitiés indépendamment et ça c'est génial.
On a plus la contrainte d'avoir un seul bloc avec toutes les touches et donc une position d'écriture assez désagréable.
Les touches sont organisées en patte d'ours et non plus avec un décalage qui n'a plus lieu d'être.
Chaque colonne suit donc à peu près la longueur de vos doigts, ça permet de bien se placer un peu plus facilement (je suis quand même un saguoin sur ce point).

{{< img src="pimped.jpg" alt="Le lavier avec tous ses nouveaux keycaps" title="Le voilà tout maquillé !" >}}

Les pouces ont leur ptit bloc de touches rien que pour eux.
Mais francehement à l'usage je trouve que les deux grandes touches sont facilement utilisables alors que les autres sont assez compliquées à atteindre.
Bon je n'y ai foutu que des touches multimédia donc peu utiles dans le rush de l'écriture ou du jeu.
J'ai quand même foutu <kbd>AltGr</kbd> là-bas et c'est clairement pas agréable pour le moment.
Il va me faloir un peu plus de mémoire musculaire.

D'ailleurs en parlant de mémoire musculaire je m'attendais à galérer bien plus.
Changer de disposition matérielle est généralement très compliqué.
On perd vachement en vitesse de frappe.
On cherche les touches du coup on perd le fil de ce que l'on cherche à écrire.
Mais dans mon cas ça ne me le fait pas du tout.

J'ai biensûr perdu un peu en vitesse frappe mais tellement peu.
Le confort apporté par le design séparé est tellement agréable que ça en vaut la chandelle.
Et une fois la mémoire musculaire parfaitement reconstruite ça sera du bonheur complet.

Bon comme à mon habitude je l'ai revêtu de ses habits de lumières afin d'être le plus beau de tous les claviers.

------------

Bon à voir dans le temps si j'en suis toujours satisfait mais je n'ai pas trop d'inquiétudes.
