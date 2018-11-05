+++
Author = "Lord"
Description = "Petite astuce pour lancer une application de façon à ce qu'elle n'ait pas accès au net. Rien besoin d'installer, on s'appuie sur les namespace réseau pour cela."
Categories = ["linux", "tips","réseau"]
menu = "main"
notoc = true
PublishDate = 2018-11-05T22:06:32+01:00
date = 2018-11-05T22:06:32+01:00
title = "Bloquer l'accès au net à un soft sous Nunux"
editor = "kakoune"
+++
Suite à une ptite question sur le Fédivers voilà une petite astuce pour votre nunux favoris.

Lorsque vous lancez une application par défaut, celle-ci a accès au net sans restriction.
Voyons comment couper complètement l'accès au net à une application.

Pour cela vous aurez besoin de la commande **ip** faisant partie de *iproute2* et … c'est tout.
Il y a fort à parier qu'elles soit déjà installées vu que c'est la base pour configurer le réseau (non non, *ifconfig est obsolète sous Linux depuis près de 17ans*, faut se mettre à la page sans souffler et traîner les pieds, merci).

Il faut tout d'abord créer un *namespace réseau* qui n'aura pas accès au net.
C'est impressionnant dit comme ça mais en vrai c'est juste **<samp>ip netns add nonet</samp>** .
Là, on a donc créée *nonet*.

Et maintenant il ne reste plus qu'à lancer une application dans ce namespace particulier avec **<samp>ip netns exec nonet votre_appli</samp>** .
Et voilà.

Bon bien entendu si vous ne voulez pas exécuter l'application en root il faut ajouter du *su* .
Ce qui donne quelque chose comme **<samp>ip netns exec nonet su lord -c "votre appli</samp>** .

Voilà voilà :-)

En vrai les namespaces réseau peuvent faire des trucs bien plus puissant comme avec l'utilisation d'un VPN forcer des applis à l'extérieur d'un VPN et d'autre les forcer à l'intérieur mais c'est pas le but de notre article ;-)

