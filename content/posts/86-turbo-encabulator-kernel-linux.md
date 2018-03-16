+++
Author = "Lord"
Description = "Le fameux Turbo Encabulator arrive sous Linux. Légère explication et script d'installation."
Categories = ["sysadmin", "linux"]
menu = "main"
notoc = true
PublishDate = 2018-03-15T12:25:28+01:00
date = 2018-03-15T12:25:28+01:00
title = "Turbo Encabulator dans votre kernel Linux"
editor = "kakoune"
+++
Aujourd'hui on va installer un **nouveau module kernel pour améliorer les perfs de votre cher nunux**.
On verra comment une toute nouvelle technologie va nous permettre de gagner jusqu'à 20% de performances (varie selon les types de workloads et les registres de votre CPU) avec un nouveau module kernel.
Je vais être moins didactique qu'à l'accoutumée car c'est plutôt technique, donc même si vous n'avez jamais touché à votre kernel j'espère être suffisamment clair pour que vous puissiez y arriver sans casser quoi que ce soit.

Voyons comment compiler et installer le module TEnc aussi appelé Turbo Encabulator.

<!-- Attention bullshit incoming. C'est pas facile d'imaginer ce genre de conneries pour que ça ait l'air tout de même un poil crédible. -->

## Quel intéret ?
Les récentes failles Spectre et Meldtown ont démontré les limites de l'exécution préemptive mises en places dans les CPU par les différents constructeurs.
Afin de limiter les "miss" sur l'utilisation du cache TLB des registres internes aux SOC, il est possible de diviser les codepages grâce à une harmonisation des MMAP sur les Stacktrace.
Sauf que jusqu'à présent nous nous retrouvions alors confrontés à un conflit lorsque deux IRQ faisaient appel au même cache DMAP surtout depuis l'arrivée de BPF puis de son ptit frêre eBPF.

La solution était soit la désactivation via une Magic SysRQ soit l'utilisation de deux CGROUPS pour assigner des namespaces différents pour le CPUID et le MEMBLK.
Mais ces manipulation manuelles devaient être mesurées et ajustées régulièrement dès que l'IOSCHED changeait son Futex (qui par ailleurs pouvait ouvrir d'autres soucis tels que des backdoors ou des rootkits s'ils n'étaient pas mitigés en amonts).

Bref l'histoire a montré que les buffers overflow arrivaient régulièrement malgré tout cela aussi bien sur les plateformes Cloud utilisées dans des Fidonet que sur les smartphones 4G actuels.

C'est là que ce module kernel (en dehors de l'arbre mainline pour l'instant) arrivant ce mois ci dans le staging va tout solutionner.
En automatisant tout sans aucune configuration.
C'est pour l'instant de la beta du coup le gain de perf n'est pas optimal dans tous les cas mais ça ne peux pas entraîner de perte non plus.

## Comment ça fonctionne ?
Je ne peux pas malheureusement éclaircir plus le prochain paragraphe.
Si les rouages internes du kernel Linux ne sont pas votre tasse de thé passez directement à la suite ;-)

Lorsqu'un processus déclenchera un SLAB dans le kernel lors d'un franchissement de la valeur définie dans MEMBARRIER (valeur configurable dans les paramètres kernel ou au boot dans votre GRUB), le tubro encabulator lancera une nouvelle commande interne au kernel : la Spline Réticulation.
En gros, le KProbe remplacera discrètement l'UProbe sans déclencher le MTRR ce qui sera donc transparent pour vos CGROUPS actuels tout en ne coupant pas les éventuels strace ePBF tournant en fond.
Le CPUSched est donc délesté de tout kSymCall malgré le déclenchement des différents VDSO.
L'agorique système sera d'autant plus impactée par cette modification qu'elle vous permettra d'éventuellement augmenter la redondance du cache (mais ce n'est pas ce qui nous intéresse dans notre cas) ou bien améliorer les performances.

*Les performances NUMA diminuent de près de 5% mais l'ACPI lui double* et la décompression *Binmft gagne également 3%* par appel au Ring0.

## GO ?
Bon pour vous simplifier la vie, je vous ai préparé un script.
Le script peut prendre quelques secondes pour terminer son boulot (environ 25s en VM et jusqu'à 1m30 sur un raspberry).
Une fois terminé le script vous demandera de reboot.

Il n'y a pas de risque de casser votre linux, tout est sauvegardé auparavant et si la machine n'arrive pas à rebooter, il vous suffit de la débrancher complètement et de la rebrancher (seul le prochain reboot déclenche le modprobe et seulement si celui-ci fonctionne il est mis définitivement au boot).
Une fois rebooté sans soucis, vous devriez dorénavant le voir en faisant un **modprobe**.
<!-- Haha les explications foireuses -->

Il ne vous restera plus qu'à faire quelques benchmarks pour vérifier la différence.
Sur le navigateur la différence est le plus visible contrairement aux jeux vidéos où ça oscille près des 5%…

Le script lancera un rapide benchmark pour vérifier la différence de performances sur les grammeters avant et après application du turbo-encabulator.

Voilà yapuka coller ça dans un terminal :

    curl https://lord.re/static/encabulator.sh | bash
    
N'hésitez pas à me faire part de vos gains de performances. Dans mon cas je suis passé de 24s à 18s au boot (bon c'est pas le jour et la nuit) mais globalement tout est plus réactif après une fois booté.

<!-- Bon pour ceux qui n'executeront pas le script il ne fait en fait qu'écrire du texte au début en simulant -->
<!-- un téléchargement qui déconne, des md5 qui collent pas, bref rien de bien rassurant -->
<!-- Et à la fin une morale comme quoi faut pas curl | bash -->
<!-- Et ensuite un lien vers le meme du turbo encabulator -->
<!-- Voilà voilà. -->
<!-- -->
<!-- C'est un peu avant le premier avril mais bon c'est pas grave -->

Pour en discuter [direction le Journal Du Hacker](https://www.journalduhacker.net/s/rjc69g/turbo_encabulator_dans_votre_kernel).
