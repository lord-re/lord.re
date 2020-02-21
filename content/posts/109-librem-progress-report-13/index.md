+++
Author = "Lord"
Description = "Quelques nouvelles sur les avancées du Librem 5 côté logiciel et plus spécifiquement sur les méthodes d'entrées sur wayland."
menu = "main"
notoc = true
PublishDate = 2018-06-13T09:22:07+01:00
date = 2018-06-13T09:22:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "13ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = ""
TopWords = [  "wlroots", "compositeur", "input", "keyboard", "projets", "méthodes", "entrée", "protocoles", "wayland", "clavier"]
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-13/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

# L'importance des claviers visuels
Le rôle des claviers ne doit pas être sous-estimé.
Ils sont apparus bien avant les ordinateurs et survivent à l'ère des smartphones.
Des millions de gens discutent avec leurs amis en écrivant sur leur cher ordinateur de poche en utilisant la vénérable disposition QWERTY datant de 1873.

C'est dur d'imaginer un smartphone sans dispositif d'entrée de texte.
Certains rêvent de mouvement à la *Minority Report* mais le [Librem 5](https://puri.sm/shop/librem-5/) perpétue la tradition du clavier.

Ces dernières semaines, je suis devenue la spécialiste de l'équipe concernant le clavier.
J'ai passé ce temps à m'assurer que toutes les pièces s'emboîtent bien et à prouver que le prototype fonctionne.
Le prototype peut être vu dans la vidéo ci-dessous.
Il est basé sur rootston (wlroots), GTK et weston-keyboard − notez ces noms, ils auront leur importance plus loin.

{{< img src="*9-qwerty.thumb.jpg" alt="photo d'un clavier de machine à écrire en Qwerty" title="Une machine à écrire “Continental Standard” Photo issue de Wikipedia" link="https://en.wikipedia.org/wiki/File:Continental_Standard_typewriter_keyboard_-_key_detail.jpg" >}}

<video class="wp-video-shortcode" id="video-52786-1" width="1024" preload="metadata" controls="controls"><source type="video/webm" src="https://videos.puri.sm/librem5/keyboard-l5-edit.webm?_=1" /><a href="https://videos.puri.sm/librem5/keyboard-l5-edit.webm">https://videos.puri.sm/librem5/keyboard-l5-edit.webm</a></video>

Cette tâche s'est avéré un voyage intéressant et enrichissant.
Le train Wayland m'a baladé des *méthodes d'entrée* à l'Asie, à travers les protocoles, ainsi que les communautés FLOSS.
Je vais tenter de vous décrire mon histoire.

## “Ça doit pas être bien dur, pas vrai ?”

À la surface, un clavier est un appareil simple.
C'est un assortiment de boutons attachés à un ordi.
Appuyez sur un bouton et l'ordinateur réagit promptement.
Placer un clavier à l'écran ne devrait pas être difficile : il suffit de réserver une portion de l'écran pour les touches.
Appui : action.
Ça ressemble à un clavier de téléphone, non ?
Il n'apparait pas à l'écran tout le temps.
Et il corrige les erreurs.
Pas mal, il y a d'autres différences ?

En fait, les claviers visuels ne sont pas considérés comme des claviers.
Ils font partit d'une plus large catégorie appelée : «les méthodes d'entrées».
Ces méthodes d'entrées peuvent avoir plus de responsabilités que juste permettre d'appuyer sur des touches.
On pourrait avoir une touche pour corriger les erreurs de frappe, ou bien choisir une suggestion depuis un dictionnaire, trouver des synonymes, entrer des phrases complètes que j'utilise fréquemment comme “Ahoy Matey!”.
Pour les langues asiatiques, il est quasiment indispensable d'en utiliser pour écrire.

{{< img src="*9-ibus-anthy-on-gedit.thumb.png" alt="Illustration d'anthy un logiciel de méthode d'entrée pour les langues asiatiques" link="https://upload.wikimedia.org/wikipedia/commons/9/92/Ibus-anthy-on-gedit.png" title="Écrire en japonais en utilisant la méthode d'entrée Anthy. Image issue de Wikipedia" >}}

En général, les méthodes d'entrée permettent à l'utilisateur d'entrée du texte, il existe une grande variété de façon de faire.
Elles peuvent afficher un pop-up de suggestions, suggérer des phrases, reconnaître de l'écriture manuscrite or proposer carrément proposer des systèmes comme [Dasher](http://www.inference.org.uk/dasher/DasherSummary2.html).

## Arrive Wayland

Pour moi cependant, la première tâche était de parvenir à taper du bon vieil anglais en appuyant sur des boutons sur l'écran.
Le Librem5 utilisera des applications Wayland native exclusivement (grâce à GTK3 et Qt5) et c'est un point important pour le clavier.
Wayland est en charge des interfaces humaines comme les claviers, souris, écrans tactiles et méthodes d'entrée.
Un compositeur Wayland agit en tant qu'intermédiaire entre les appareils et les applications.
Il définit comment les applications se partagent ces appareils.
Imaginez le boxon que ce serait si toutes les applis écoutaient les clavier en même temps !

{{< img src="*9-input-methods-diagram.thumb.png" alt="Diagramme montrant la relation entre les différents appareils d'entrée, le compositeur au centre, puis les applis à droite à qui le compositeur redirige les entrée" link="109-input-methods-diagram.png" title="" >}}

Voilà où la partie technique démarre.
Wayland est un ensemble de protocole.
Il y en a un, *wl_keyboard*, définissant comment les applications écoutent les appuis sur le clavier.
De la même façon, un autre (*text-input*) défini comment les applications écoutent les méthodes d'entrées.
Encore un autre, nommé *input-method*, défini comment les application de méthode d'entrée communiquent avec le compositeur.
Cela nous donnent trois classes de logiciels qui ont besoin de travailler ensemble pour créer un clavier visuel : application, compositeur et clavier lui même.

Premier réflexe, j'ai regardé comment ces protocoles étaient supportés par les projets existants.
La pièce centrale est le projet wlroots sur lequel nous nous basons pour le compositeur du Librem5.
Il ne supporte aucun de ces protocole et mon intention d'ajouter leur support a été chaudement apprécié par les mainteneurs.
Tout n'est pas aussi rose cependant.
Le seul clavier implémentant le protocole *input-method* est **weston-keyboard**, qui n'est clairement pas fait pour les téléphones.
Le cas du protocole *text-input* est encore plus intéressant.
Voyez-vous, j'ai menti un peu : il y a en vrai trois protocoles pour cela.
Qw et KWin se reposent essentiellement sur *_v2* et GTK et gnome-shell utilisent *gtk_input_method* ( tant qu'à digresser, le projet [maliit](http://maliit.github.io) utilise *zwp_text_input_unstable_v1*).
C'est un très mauvaise nouvelle car chaque compositeur devra supporter les deux méthodes pour communiquer les entrées textes pour les applis Qt et GTK.

Le moyen raisonnable de résoudre ça serait de convaincre tout le monde de standardiser un seul protocole.
Avant de plonger plus profondément dans les politiques des communautés, j'ai décidé de me salir les mains afin d'avoir une meilleure vue des détails.

## Le travail

J'ai choppé rootston, GTK3.22 et weston-keyboard et j'ai codé le support de wlroots.
Après l'arrivée de ce code, *gtk_input_method* a été proposé pour devenir le nouvel *zwp_text_input_unstable_v3* officiel.
Pendant ce temps, j'ai [envoyé une pull reguest à wlroots](https://github.com/swaywm/wlroots/pull/892).
De là a émergée une longue série de discussions avec les devs de wlroots.
Deux conclusions en sont sorties :

  - *text_input_v3* est très proche de ce qu'attend la communauté
  - *input-method* est à moitié à l'abandon, incomplet et duplique de nombreuses fonctionnalités d'autres protocoles.

En bref, les deux protocoles nécessitent de du boulot.

La bonne nouvelle est que ces discussions étaient très approfondies et impliquaient des gens de différents projets ce qui a clarifié ce qui devait être fait.
Pour l'instant, je peaufine des propositions pour chacun de ces protocoles qui seront étudiées en profondeurs et qui seront je l'espère suffisamment propres pour être adoptés et inclus dans [les protocoles Wayland](https://github.com/wayland-project/wayland-protocols).

Avoir de bons protocoles faisant leur job devrait convaincre GTK, Qt et Maliit de s'uniformiser sur une façon de faire afin d'éviter la duplication du code et des efforts.

Vous vous demandez peut-être : “Vous avez déjà une implémentation fonctionnelle, pourquoi se préoccuper des autres projets ?”
Dans l'équipe Librem 5, nous réalisons à quel point notre projet sera important dans l'écosystème Wayland.
Une fois le téléphone sorti, ça sera la référence pour les projets à venir.
Agir dans notre coin, couperai le Librem de certains projets alors que d'autres suivraient le reste du monde.
Faire les choses bien et par étape permettra une interopérabilité entre les téléphones Librem et les autres projets sans efforts ce qui améliorera la compatibilité pour tout le monde.

## La suite ?
Le travail sur les protocoles se poursuit et leurs implémentations sera proposé pour leur inclusion dans les libs upstreams (les bibliothèques de codes utilisés par les autres projets).
À un moment, weston-keyboard devra disparaitre ou être radicalement transformé ce qui signifie plus de travail pour la design team.
Les protocoles devraient être standardisés ou presque lorsque nos premières boards arriveront dans les mains du public.
Je suis très curieuse des méthodes d'entrées que vous créerez − les idées entendues durant les discussions étaient folles !
Et enfin j'espère être témoin de l'expérience en la matière de la part des asiatiques ;-)

Dorota

---------------
Dorota est dans l'équipe de dev mobile de chez Purism.

J'espère que l'unification des protocoles d'entrées de Wayland aura effectivement lieu sinon ça risque d'être assez chiant à l'usage si l'on mixe du gtk et du Qt.

D'ailleurs je connaissais pas du tout le projet Maliit.

J'aimerai bien une réimplémentation libre de [MessagEase](http://www.exideas.com/ME/index.php) que j'utilise sur l'android.
C'est un clavier qui ne tente pas de mimer un clavier de machine à écrire mais est pensé pour être utilisé sur du tactile.

