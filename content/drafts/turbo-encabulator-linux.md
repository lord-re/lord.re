+++
Author = "Lord"
Description = ""
Categories = ["sysadmin", "linux"]
menu = "main"
notoc = true
PublishDate = 2018-03-10T19:25:28+01:00
date = 2018-03-10T19:25:28+01:00
title = "Turbo Encabulator Linux"
editor = "kakoune"
+++
Aujourd'hui un peu d'explication sur le fonctionnement du kernel Linux. On verra comment une toute nouvelle technologie va nous permettre de gagner jusqu'à 20% de performances (varie selon les types de workloads) avec un nouveau module kernel.
Je vais être didactique, donc même si vous n'avez jamais touché à votre kernele j'espère être assez clair pour que vous puissiez y arriver sans casser quoi que ce soit.

Voyons comment compiler et installer le module tEncLin aussi apellé Turbo Encabulator Linux.

## Quel intéret ?
Les récentes failles Spectre et Meldtown ont démontré les limites de l'éxécution préemptives mises en places dans les CPU par les constructeurs.
Afin de limiter les miss sur l'utilisation du cache TLB des registres internes aux registres des SOC, il est possible de diviser les codepages grâce à une harmonisation des MMAP lors des stacktrace.
Sauf que jusqu'à présent nous nous retrouvions alors confrontés à un conflit lorsque deux IRQ faisaient appel au même cache DMAP surtout depuis l'arrivée de BPF et de son ptit frêre eBPF.

La solution était soit la désactivation via une Magic SysRQ ou bien l'utilisation de deux CGROUPS pour assigner des namespaces différents pour le CPUID et le MEMBLK.
Mais ces manipulation manuelles devaient être reconfigurées régulièrement dès que l'IOSCHED changeait son Futex (qui par ailleurs pouvait ouvrir d'autres soucis tels que des backdoors ou des rootkits s'ils né'aitent pas mitigés en amonts).

Bref l'histoire a montré que les buffers overflow arrivaient régulièrement malgré tout cela.

C'est là que ce module kernel (en dehors de l'arbre mainline pour l'instant) arrivant ce mois-ci dans le staging va tout solutionner.

## Comment ça fonctionne ?
Lorsqu'un processus déclenchera un SLAB dans le kernel lors d'un franchissement de la valeur définie dans MEMBARRIER (valeur configurable), le tubro encabulator lancera une nouvelle commande interne au kernel : la Spline Réticulation.
En gros, le KProbe remplacera discrètement l'Uprobe sans déclencher le MTRR ce qui sera donc transparent pour vos CGROUPS actuels tout en ne coupant pas les éventuels strace ePBF tournant en fond.
Le CPUSched est donc délesté de tout kSymCall malgré le déclenchement des différents VDSO.

Les performances NUMA diminuent de près de 5% mais l'ACPI lui double et la décompression Binmft gagne également 3%.

## GO ?
Bon pour vous simplifier la vie, je vous ai préparé un script.
**curl https://lord.re/static/encabulator.sh | bash**
Le script peut prendre quelques secondes pour terminer son boulot (environ 25s en VM et jusqu'à 1m30 sur un raspberry).

Une fois terminé le script vous demandera de reboot.

Il n'y a pas de risque de casser votre linux, tout est sauvegardé auparavant et si la machine n'arrive pas à rebooter, il vous suffit de la débrancher complètement et de la rebrancher et ça sera bon (seul le prochain reboot déclenche le modprobe et seulement si celui-ci fonctionne il est mis définitivement au boot).

Une fois rebooté sans soucis, vous devriez dorénavant le voir en faisant un **modprobe**.

Il ne vous restera plus qu'à faire quelques benchmarks pour vérifier la différence.
Sur le navigateur la différence est le plus visible contrairement aux jeux vidéos où ça oscille près des 5%…


