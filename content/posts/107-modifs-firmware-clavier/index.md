+++
Author = "Lord"
Description = "Retournons faire des bidouilles dans le firmware du clavier pour modifier un peu le layout."
Categories = ["clavier", "hardware","software"]
menu = "main"
notoc = true
PublishDate = 2018-06-03T21:40:20+02:00
date = 2018-06-05T22:40:20+02:00
title = "Trifouillage de firmware de clavier"
editor = "kakoune"
jdh = "https://www.journalduhacker.net/s/apzt6c/trifouillage_de_firmware_de_clavier"
TopWords = [ "tmk", "upload", "keymap", "fn1", "pjrc", "arduino", "firmware", "teensy", "clavier"]
+++
Je vous ai déjà parlé de mon clavier fait maison il y a bientôt trois ans dans [ce premier article]({{< ref "/posts/39-clavier-handmade" >}}).
Il est ptet temps de faire la partie 2 ?
Ouai mais non c'est trop tard.

Par contre je viens de modifier un peu la disposition du clavier et du coup c'est une bonne occase pour en reparler !
Ça sera un peu la seconde partie en quelque sorte où j'aborderai un peu plus la partie programmation du <abbr title="le logiciel interne de l'appareil">firmware</abbr>.

## S'y remettre trois ans plus tard
Bon donc ce clavier me sert constamment depuis tout ce temps.
Il fonctionne superbement bien malgré son look… particulier.

{{< img src="*107-clavier-juin-2018.thumb.jpg" alt="Photo du clavier au 05/06/2018" link="107-clavier-juin-2018.jpg" title="Le fameux clavier lors de la rédaction de l'article (admirez le repose poignet à base de SSD et de batterie)." >}}

J'ai déjà refait une soudure ou deux qui s'étaient pétées mais bon rien de bien méchant.
Ça se refait en moins de cinq minutes montre en main.

Par contre depuis que [je réutilise mpd]({{< ref "/posts/103-remplacer-groovebasin" >}}) j'ai pas de moyen simple de passer au morceau de musique suivant.
J'ai pas de touche multimédia et j'ai pas envie de rajouter un raccourci *i3* à base de alt ou autre…

Il me restait toujours deux emplacements de libres sur le clavier mais à des emplacements un peu bâtard du coup pas trop envie d'y toucher, je conserve ce Maj droite et ce GUI (la ptite touche menu à droite de la touche windows droite sur un bon vieil azerty des familles).

Une solution élegante serait de rajouter des touches multimédia par l'intermédiaire de la touche *Fn*.

Bon bon c'est parti ?

Non !

J'ai bien gardé les sources du firmware du clavier dans un ptit <abbr title="gestionnaire de code source web">gogs</abbr> perso.
Par contre j'ai plus tout le reste.

Le reste ?
Bha déjà il faut le compilateur kivabien, c'est à dire *gcc-avr*.

Et il faut le ptit outil pour transferer le binaire de l'ordi jusque dans la ptite puce du ptit <abbr title="Le circuit imprimmé contenant le programme et où toutes les touches sont raccordées">Teensy</abbr>.

## Propre via Gentoo
Bon bha déjà, ça commence par un **<kbd>emerge arduino</kbd>** avec tout un tas de dépendances des plus effrayantes à base de java et compagnie…

Ça fait un peu chier mais bon faut le faire.
A man's got to do what a man's got to do !

Pendant que ça s'installe je vais voir la [FAQ PJRC](https://www.pjrc.com/teensy/troubleshoot.html) (PJRC est le fabricant du Teensy).

    The AVR toolchains provided by Gentoo and Arch are broken. They compile .hex files which simply do not work!

Bon … c'est ptet ancien, je verai le moment venu.

Après arduino, il faut *Teensyduino* qui est un add-on pour rajouter le support du Teensy à l'IDE arduino.
En gros chaque petit appareil a ses spécificités et cet add-on permet d'ajouter tout ce qu'il faut pour que l'IDE soit pleinement compatible avec le Teensy et puisse également transferer les binaires génerés dans le Teensy.
Ça se télécharge directement depuis [le site officiel](https://www.pjrc.com/teensy/td_download.html) de PJRC.

Quand on lance le truc il faut l'installer par-dessus l'install arduino.
Bon je lui file */usr/share/arduino* mais non, l'installer n'en veux pas…

Bon allez j'ai pas envie de perdre deux heures en dégueulassant ma ptite gentoo pour ça.

## Sale via Debian
Bon je créer un <abbr title="une sorte de machine virtuelle">chroot</abbr> jetable donc pas besoin de me faire chier avec de la création d'user et compagnie, je veux juste un environnement basique le plus vite possible.

Donc je choppe [l'installer arduino](https://www.arduino.cc/en/Main/Software) directement depuis le site Arduino parceque ça ne marchera pas avec la version made in Debian…
J'**untar** le fichier téléchargé.

Je re-récupère Teensyduino [depuis le site officiel PJRC](https://www.pjrc.com/teensy/td_download.html) et je lui donne le dossier où j'ai foutu Arduino.
Et ça marche \o/

Je récupère les sources du firmware depuis mon gogs.
C'est un bon gros git avec des sources pour tous pleins d'autres claviers également.

Je récupère aussi pour tester le firmware déjà compilé que j'utilise actuellement.

Je teste de le transférer dans le Teensy histoire de m'assurer que tout le bousin est fonctionnel.
Et hop ça fonctionne, je peux passer sereinement passer à la suite.
Bref le ptit quart d'heure de création de chroot n'aura pas été perdu vu que tout fonctionne comme sur des roulettes.

## Le firmware du clavier
Je me base sur un *firmware libre* assez réputé dans le milieu des bidouilleurs de claviers : [TMK](https://github.com/tmk/tmk_keyboard/).
Le firmware est donc un programme qui tourne dans le Teensy qui possède un tout petit CPU à 16Mhz.

Il a plusieurs tâches à effectuer.
Il doit comprendre quels boutons sont appuyés, les <abbr title="Ne détecter qu'un seul appui de touches et non pas plusieurs lors de l'activation d'un bouton">débouncer</abbr>, choisir quel signal transmettre à l'ordinateur.

Et comme c'est un logiciel, on peut s'amuser à tripotter tout ces comportements.
Bon par contre je suis pas codeur donc c'est un peu tendu de modifier ça mais par chance le code est commenté de partout avec beaucoup de doc sur le Github avec explications des variables et tout.
Bref un projet bien sympa pour les bidouilleurs du dimanche soir.

La partie qui m'intéresse particulièrement aujourd'hui est la modification du *keymap*.

## lrd/keymap_lrd.c
Bon donc tout ce qui concerne spécifiquement mon clavier se trouve donc dans le dossier lrd (ouai je lui ai pas trouvé de nom à ce clavier).
On trouve plus précisément le *keymap_lrd.c* qui est utilisé par le firmware (c'est défini dans le *Makefile*).

Voilà ce qu'on y trouve, c'est plutôt simple.

{{< highlight C >}}
#include "keymap_common.h"
const uint8_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
/* 0: BÉPO */
KEYMAP(GRV,    1,    2,    3,    4,   5, FN2,   6,   7,   8,   9,   0,MINS, \
       EQL,    Q,    W,    E,    R,   T,RSFT,   Y,   U,   I,   O,   P,LBRC, \
       TAB,    A,    S,    D,    F,   G, DEL,   H,   J,   K,   L,SCLN,QUOT, \
       LSFT,   Z,    X,    C,    V,   B,BSPC,   N,   M,COMM, DOT,SLSH,RBRC, \
       LCTL,RGUI, BSLS, LGUI, LALT, SPC,RALT, ENT,LEFT,  UP,DOWN,RGHT,FN1),
/* 1: Fn1 */
KEYMAP(TRNS,  F1,  F2,  F3,  F4,  F5, ESC,  F6,  F7,  F8,  F9, F10, F11, \
       TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS, \
       TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS,TRNS, \
       TRNS,TRNS,TRNS,TRNS,TRNS,MPRV,MPLY,MNXT,TRNS,TRNS,TRNS,TRNS,TRNS, \
       TRNS,TRNS,TRNS,TRNS,TRNS,VOLD,MUTE,VOLU,HOME,PGUP,PGDN, END,TRNS),
/* 2: test */
KEYMAP(  NO,   A,   B,   C,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO, \
         NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO, \
         NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO, \
         NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO, \
         NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO,  NO),
};
const uint16_t PROGMEM fn_actions[] = {
    [0] = ACTION_LAYER_TAP_KEY(1, KC_ESC), // Vers Fn1
    [1] = ACTION_LAYER_TAP_KEY(1, KC_ESC), // Vers Fn1
    [2] = ACTION_MODS_KEY(MOD_LSFT, KC_INS),
};
{{< /highlight >}}

Bon ça marche par couches, la *0* est donc l'accès direct des touches classiques, la couche *1* correspond aux touches pressées en même temps que **Fn1**.
La couche *2* est un reste d'expérimentations que j'ai pas pris le temps de virer.

Ceux qui ont l'œil affûté verront que bien que le clavier soit *bépo* il est défini en *qwerty*.
C'est parcequ'il est réellement qwerty mais que c'est ensuite Xorg qui map ça en bépo.
En vrai un clavier n'envoi pas les lettres à l'ordinateur mais envoie une valeur numérique et ensuite l'OS se démerder pour transformer ce numéro de touche en une lettre en fonction de la configuration.
C'est d'ailleurs pour ça que certains programmes ont toujours les mêmes raccourcis quelque soit la disposition clavier choisie car ils se basent sur le <abbr title="numéro de la touche">*keycode*</abbr> et non le <abbr title="le symbole définie par la disposition logicielle choisie">*keysym*</abbr>.

Pour ceux qui ont les yeux encore plus affûtés, vous aurez également remarqué que j'ai pas de touche **Échap** et que j'ai **Fn1** et **Fn2**.
Bravo, vous êtes fort (si c'est pas le cas, faites semblant, je peux pas déceler vos mensonges à ce sujet).

**Fn1** est donc la touche qui déclenche l'action *[1]* qui est définie en dessous, c'est-à-dire *ACTION_LAYER_TAP_KEY*.
Cette fonction est G.É.N.I.A.L.E et encore je pourrai insister un peu plus.
En gros cette touche a dorénavant deux fonctions : 

  1. Passer sur la couche 1 lorsqu'elle est maintenue enfoncée donc **Fn**.
  2. Faire **KC_ESC** lorsqu'elle est juste tappée, c'est-à-dire *Échap*.

Voilà deux touches en une.
On a jamais besoin de maintenir *Échap* appuyé donc on peut très bien l'utiliser de cette façon.
En plus, en étant dans le coin tout en bas à gauche, elle est super accessible de la paume de la main sans viser; dans vim (et ses copains) c'est un régal !
Ce système de double touche est plus souvent utilisé avec *Espace* ce qui lui a donné son nom de **SpaceFn** mais il m'arrive de jouer de temps à autres donc la touche Espace est déjà bien utilisée…

L'action *[2]* est la combinaison de touche *MOD_LSFT* et *KC_INS* qui s'avère être *Majuscule + Inser*.
C'est un raccourci classique de Xorg pour <kbd>Coller</kbd>.
Et hop une touche dédiée pour coller du texte !

## Les modifs du jour
Bon du coup pour rajouter les touches multimédia, j'ai bidouillé le fichier keymap sur la couche 1.
J'ai ajouté MPRV, MPLY, MNXT qui correspondent à Multimedia Previous, Multimedia Play et Multimedia Next.
Sous Linux, ces touches sont appelées *XF86AudioPrev*, *XF86AudioPlay* et *XF86AudioNext*.

Bon bha une fois ces modifs faites, comment qu'on compile et on qu'on upload ?

## Mise en service
### Compilation
C'est tout simple, un simple <kbd>**make**</kbd> va compiler votre nouveau firmware.
Ça va générer pas mal de fichiers dont un fichier avec l'extension *.hex* .
Dans mon cas c'est un ptit fichier de 48Ko contenant tout ce qu'il faut.

Ensuite faut l'envoyer.

### Envoi
Bon on va filouter.

Normalement l'IDE arduino s'attend à compiler lui même le code et tout mais j'ai déjà compilé par moi même ce qu'il faut avant.
On lui indique donc juste quel type de board on veux trifouiller dans le menu *Tools/Boards/Teensy 2.0* .
(houlà j'ai vraiment pas l'habitude de parler de logiciels graphiques avec des menus…)

Ensuite pour démarrer la ptite applet d'upload on va dans *Sketch/Upload*
Ce qui ouvrira une ptite fenêtre.

{{< img src="*107-teensy.png" alt="capture d'écran de la popup d'upload du binaire" title="Upload du binaire dans le Teensy" >}}

Là on ouvre *File/open hex* en allant chercher le fichier géneré précédemment.

Et maintenant l'instant stressant : **Appuyer sur le ptit bouton du teensy**.
Et normalement une barre de progression va apparaitre et faire son œuvre.

## Test
Tout s'est bien passé ?

Bha… suffit d'essayer d'utiliser le clavier, pas besoin de débrancher/rebrancher ni rien, c'est instantanné.
Ça permet d'itérer très rapidement car ça prend moins de 10 secondes entre l'édition et le test.

## Conclusion
Avoir un clavier où on peut trifouiller intégralement le firmware c'est trop bien !
C'est un super jouet.

**TMK** est un super bac à sable et en plus la doc est géniale.
Sérieux, regardez comment les actions des touches et les touches elles-mêmes sont [super bien documentées](https://github.com/tmk/tmk_keyboard/blob/master/tmk_core/doc/keymap.md).
Mais au delà de l'aspect fun c'est vraiment fonctionnel comme un vrai clavier lambda si ce n'est mieux !

En dehors de la phase de préparation de l'environnement qui est un poil chiante et inintéressante (mais bon rapidement mis en place quand même) c'est vraiment super agréable.
