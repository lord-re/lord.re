+++
Author = "Lord"
Description = "Quelques nouvelles sur les avancées du Librem 5 côté logiciel."
menu = "main"
notoc = true
PublishDate = 2018-06-13T09:22:07+01:00
date = 2018-06-15T23:22:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "14ème article d'avancement du Librem 5"
editor = "kakoune"
jdh = ""
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-14/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org), [UBPorts](https://ubports.com/) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

Beaucoup de travail a été abattu sur le projet Librem 5 et même s'il en reste énormément, nous voulions faire un point des avancées réalisées par l'équipe ces deux dernières semaines.
Profitez donc de cette brève mise à jour concernant nos effort récents et nos accomplissements.

## Le travail logiciel
Cela représente une importante masse de travail pour le Librem 5.
Il y a toute l'infrastructure comme l'apparence de l'interface utilisateur et les nouvelles bibliothèques et protocoles.
Mais il y a aussi les applications familières qui sont nécessaires.

Sous le capot, notre [interface téléphone (phosh)](https://source.puri.sm/Librem5/phosh) a subit d'importantes améliorations ergonomiques principalement concernant l'écran de verrouillage.
Un important changement vient du fait que dorénavant le déverrouillage est délégué à **PAM** pour mieux gérer le verrouillage de l'appareil via un code PIN.
Des ajouts de code ont également ont été fait pour mieux gérer de multiples sorties (écrans).
Également, [libhandy](https://source.puri.sm/Librem5/libhandy) est notre lib pour l'UI *handy* (pratique) pour développer des applications GTK+.
Il y a eu l'ajout récent d'un widget de flèches (*HdyArrows*) pour indiquer la direction de balayage de l'écran qui sera très utile pour de nombreuses applications, particulièrement pour l'écran de déverrouillage.
Qui plus est, libhandy a eu quelques corrections de bugs et une refonte de la gestion du clavier.
Puisque les graphismes sont importants, nous avons ajouté le [support d'Etnaviv](https://lists.freedesktop.org/archives/wayland-devel/2018-March/037532.html) à weston-simple-dmabuf (un client Wayland pour tester l'implémentation du protocole Linux DMA-BUF).
Nous avons aussi completé son [support du format NV12](https://lists.freedesktop.org/archives/wayland-devel/2018-March/037536.html).
C'est utilisé pour tester l'[implémentation](https://github.com/swaywm/wlroots/pull/724) de [linux-dmabuf](https://github.com/swaywm/wlroots/pull/698) de **wlroots**.
Nous aimerions tout particulièrement remercier le projet **wlroots** et **Weston** pour leurs revues de code, recommandations et supports.

Puisqu'on peut pas avoir un téléphone qui ne puisse faire d'appels téléphoniques, de grands efforts ont été fait sur [Calls](https://source.puri.sm/Librem5/calls) qui peut désormais émettre des appels !
(Et si vous l'aviez manqué, nous vous encourageons à lire [l'article correspondant](https://puri.sm/posts/librem5-progress-report-12/)[FR]({{< ref "/posts/102-librem-progress-report-11-5" >}}))
En plus de tout le code écrit, les interfaces ont été documentées dans de code.
L'empaquetage pour Debian est en préparation et nous taffons pour inclure un paquet Flatpak créé par un membre de la communauté.

Chaque smartphone nécessite un clavier visuel (OSK pour On-Screen-Keyboard), donc des efforts de devs ont été fait en ce sens pour les protocoles nécessaires et les upstreamer (les faire accepter par les mainteneurs des projets amonts).
Pour l'instant, le protocole *virtual-keyboard* [a été accepté](https://github.com/swaywm/wlroots/pull/999) pour être inclus dans wlroots.
Le protocole *text-input* a été [soumis upstream](https://lists.freedesktop.org/archives/wayland-devel/2018-May/038071.html) à l'approbation.
Pour tester le protocole. *virtual-keyboard*, nous avons créé un prototype basé sur **weston-keyboard**.
Vous pouvez lire ça plus en détail à propos du dev du clavier visuel dans [l'article de Dorota](https://puri.sm/posts/dorota-on-the-importance-of-on-screen-keyboards/)[FR]({{< ref "/posts/109-librem-progress-report-13" >}}).

## Le travail matériel
Identifier et tester chaque composant matériel qui seront présent dans le dev kit et éventuellement le téléphone est une tâche non trivial.
Après le choix d'un composant potentiel et la réception de quelques échantillons pour tests, il faut souvent modifier ou carrément écrire un module kernel avant même de pouvoir tester.
Cela a été le cas pour évaluer et tester des module basse consommation Wifi, ce qui est encore en cours.
Les moteurs de vibrations sont aussi en cours d'approvisionnements pour évaluations et les chargeurs de batterie sont testés.
Nous sommes aussi en train d'investiguer différentes options pour les caméras.

## Construire une communauté
La communauté continue d'occuper nos pensées.
Nous avons donc monté un [wiki PureOS](https://wiki.puri.sm/) qui n'est pas encore très étoffé mais qui pourrait devenir un endroit pour trouver de la documentation générale et des informations techniques sur PureOs et les produits Purism.
Nous avons corrigé un soucis sur la mailing-list de la communauté pour être de nouveau fonctionnelle et avons ouvert nos salons de discussion Matrix pour que vous puissiez nous rejoindre avec vos Matrix ID existants.
Pour plus d'infos à ce propos, jetez un œil à notre [page “volunteer”](https://developer.puri.sm/Volunteering/HowTo.html).

Nous sommes heureux de recevoir des propositions de volontariat qui font un travail formidable pour aider à rendre le Librem5 génial.
Si vous avez suivi ou contribué à nos dépôts de code, sachez que nous venons de migrer de Gogs à GitLab − la nouvelle adresse est [source.puri.sm](https://source.puri.sm/).

C'est tout les amis.
Restez branchés pour de futures nouveautés à venir !

---------------
Beaucoup d'avancées logicielles.
C'est assez encourageant et on dirait qu'un bon rythme s'est mis en place avec de la collaboration effective avec d'autres projets.

Par contre c'est toujours un peu flippant concernant la partie matos.
Les dev kits devraient pas tarder à être finalisés pour être livrés… j'ai du mal à imaginer que la deadline initiale puisse être respectées.
On croise les doigts
