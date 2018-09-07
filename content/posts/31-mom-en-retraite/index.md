+++
Author = "Lord"
Tags = ["hardware","meta","software"]
Description = "Remplacement de mom par zoid. Un serveur qui prend sa retraite et un nouveau vient le remplacer."
menu = "main"
date = "2013-04-14T23:14:01+02:00"
title = "Mom part en retraite"
Categories = ["hardware","meta","software"]

+++

C'est avec un pincement au cœur que je vous annonce le futur départ en retraite de Mom.
C'était la petite Dédibox qui me servait pour tout un tas de chose.
ouai je sais je prône l'auto-hébergement mais j'ai quand même une Dédibox).
(ouai normalement ça se fait pas de mettre des parenthèses en dehors d'une phrase mais s'il faut affronter l'académie française pour ça, je suis prêt à prendre le risque).
Cette petite bobox m'aura bien servi pendant près de quatre ans.
Heureusement je la remplace par Zoid.

Zoid est une belle bête qui aura la lourde tâche de reprendre toutes les activités de Mom.
Sauf que ce coup-ci j'ai un peu plus de recul et surtout la bestiole est bien plus véloce.
J'ai 16 fois plus de RAM et à vue d'œil à peu près le même augmentation de puissance CPU.
Donc, ça va être du Proxmox (par curiosité au début mais en fait c'est plutôt bien foutu et se laisse tripoter les entrailles sans trop sourciller).
Chaque service sera isolé dans son conteneur OpenVZ.

Pour “lier” tous les webservices qui seront hébergés, un vaillant Nginx sera de la partie.
À lui les joies du reverse proxying dans tous les sens.
À l'occasion je posterai surement la conf.
D'ailleurs je vais probablement faire du reverse proxy pour Bender afin de pouvoir le joindre même si l'update DNS que j'ai mis en place foire.

Et voilà, une page de l'Internet se tourne.
Le monde en parlera des siècles durant, faisant de Mom une légende.
Adieu 20790.

