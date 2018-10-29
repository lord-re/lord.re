+++
Author = "Lord"
Description = "Comment configurer son ONT Alcatel tout seul comme un grand ?"
Categories = ["adminsys", "réseau"]
menu = "main"
notoc = true
PublishDate = 2018-10-29T12:33:50+01:00
date = 2018-10-29T12:33:50+01:00
title = "Confer un ONT alcatel"
editor = "kakoune"
+++
Une panne de connexion Internet à la maison est l'un des plus grand cataclysme des temps modernes.
Pour parer à toute éventualité (enfin à mon niveau), j'ai choppé un ONT de rabe.

Un [ONT](https://fr.wikipedia.org/wiki/Optical_Network_Termination) est un petit appareil qui fait la conversion entre le signal optique de la fibre… optique vers un signal électrique en RJ45.
Mais il ne fait pas uniquement cela (ça serait un media converter sinon).
Le FTTH en France est très majoritairement en [GPON](https://fr.wikipedia.org/wiki/GPON).
C'est-à-dire que sur une seule fibre on y mutualise plusieurs clients (jusqu'à 32 voire 64 ça dépend).

Du coup l'ONT doit parler avec l'[OLT](https://fr.wikipedia.org/wiki/Optical_Line_Termination) (qui est l'appareil chez l'opérateur) en faisant en sorte de pas marcher sur les platebandes de vos voisins avec qui vous partagez la fibre.
Et il doit également faire en sorte de chiffrer vos communications pour que vos voisins ne puissent pas chopper vos précieuses données.
Et cela se fait à base de SLID qui est un mot de passe.

Donc voilà, votre ONT n'est pas juste une bête boiboite noire à poser chez vous, il faut aussi y configurer le SLID.
Il s'agit en vrai d'un mini ordinateur sous Linux (comme d'hab) avec [ses failles](https://pierrekim.github.io/blog/2016-11-01-gpon-ftth-networks-insecurity.html).

## Configurons donc un Alcatel I-010G-U

  1. Raccordez votre PC directement au cul de l'ONT via un câble réseau
  2. Configurez votre PC en 192.168.1.1/24 (ex: **<samp>ip a a 192.168.1.1/24 dev eth0</samp>**)
  3. Démarrez l'ONT
  4. Maintenez 5s le bouton reset de l'ONT jusqu'à ce qu'un ptit flash ait lieu sur les LED
  5. Ouvrez votre navigateur sur la page **<samp>http://192.168.1.251</samp>**
{{< img src="ont-page1.png" alt="Page d'accueil de l'ONT" link="ont-page1.png" title="La page d'accueil de l'ONT" >}} 
  6. Rendez-vous dans *SLID configuration* 
{{< img src="ont-page2.png" alt="Page d'accueil de l'ONT" >}} 
  7. Entrez votre SLID
  8. Rebootez l'ONT
  9. Patientez 5 minutes qu'il se mette à jour et redémarre plusieurs fois
  10. Profitez des Internets \o/

Et voilà un ONT prêt à prendre le relai en cas de soucis avec le premier.

L'interface web de l'ONT n'est plus accessible désormais.
Si vous voulez y retourner, il faut refaire un reset de la bête.
