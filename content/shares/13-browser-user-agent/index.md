+++
Author = "Lord"
Description = "Les navigateurs web affichent leur nom et leur versions aux serveurs. Cet identifiant est le User-agent. Savez-vous à quoi ressemble un User-agent ? C'est une information des plus fouillies, voyons ça vite fait !"
Categories = ["culture", "web"]
menu = "main"
notoc = true
PublishDate = 2019-01-29T20:27:01+01:00
date = 2019-01-29T20:27:01+01:00
title = "L'histoire des User Agent des browsers"
editor = "kakoune"
+++
Quand vous consultez une page web, votre navigateur web envoie son nom au serveur.
Cela permet entre autre de faire des *statistiques* à propos des visiteurs d'un site ouaib (tiens X% de mes lecteurs utilisent Chrome 67, Y% utilisent Firefox 58,… ce genre de truc).
À la base ça permettait surtout aux serveurs web d'*envoyer des pages webs adaptées au navigateur* du visiteur.

Aux balbutiements du web, les navigateurs avaient des capacités pas mal différentes les uns des autres et du coup les pages web devaient être adaptées.
Bon c'est toujours un peu le cas mais dans une bien moins moindre mesure.

Bref, je m'égare.
Le *user-agent* des navigateurs ne donne pas simplement le nom du navigateur et sa version, il envoie des infos assez… étrange au premier regard.
Un petit exemple ?

**Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) QtWebEngine/5.12.0 Chrome/69.0.3497.128 Safari/537.36**

Ouaip.
Tout ça pour dire **Qutebrowser**.

Décorticons !

  1. Mozilla/5.0 (X11; Linux x86_64)
  2. AppleWebKit/537.36 (KHTML, like Gecko)
  3. QtWebEngine/5.12.0
  4. Chrome/69.0.3497.128
  5. Safari/537.36

On retrouve presque tous les moteurs de rendu web existant (sauf ceux de chez Microsoft).

  - Donc du *Mozilla* (pour **Netscape** (qui est devenu **Firefox**)) 
  - Un peu de *Webkit* (qui est issu de *KHTML* de **Konqueror** qui a des fonctionnalités proche de *Gecko* (le moteur de **Firefox**))
  - *QtWebEngine* est le vrai moteur de rendu que j'utilise. C'est un dérivé du moteur de **Chromium** fait par les gens de chez Qt.
  - **Chrome** qui utilise le moteur de rendu *Blink* qui est dérivé de *Webkit* qui est dérivé de *KHTML*.
  - **Safari** : alors là pas vraiment, mais bon **Safari** est l'instigateur de *Webkit* …

Sacré bordel, hein ?

Et c'est pas un cas unique!
Voilà une ptite brochette trouvée dans mes logs :

  - Mozilla/5.0 (iPhone; U; CPU iPhone OS 3_0 like Mac OS X; en-us) AppleWebKit/528.18 (KHTML, like Gecko) Version/4.0 Mobile/7A341 Safari/528.16
  - Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/71.0.3578.98 Safari/537.36
  - Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36(KHTML, like Gecko) Chrome/50.0.2661.75 Safari/537.36
  - Mozilla/5.0 (X11; Linux x86_64; rv:63.0) Gecko/20100101 Firefox/63.0

## Comment est-on arrivé à un tel merdier dans le nommage des navigateurs ?

[Cette page de chez WebAIM](https://webaim.org/blog/user-agent-string-history/) [[cache]](original) vous détaillera un peu tout ça mais tention ! C'est en anglais.

Pour les plus flemmards vla un ptit résumé.
En gros tout a commencé au tout début du web, l'un des premiers navigateurs graphiques (**Mosaic**) ne supportait pas les *frames* et **Netscape** (Mosaic Killer → Mozilla) les supportait du coup jusque là tout va bien.
Les serveurs web envoient donc des pages avec des frames aux navigateurs s'annonçant en tant que Mozilla.

À ce moment Microsoft a sorti son **Internet Explorer** , qui lui aussi suportait les frames.
Du coup pour recevoir les pages avec frames, **Internet Explorer** s'est identifié en tant que Mozilla tout en ajoutant ensuite des subtilités.
Et c'est à partir de là que tout a commencé.

De fil en aiguille on en arrive aux immondices actuelles où chaque nouveau navigateur s'est retrouvé obligé de se faire passer pour un autre pour recevoir les pages webs les mieux foutues.
Bref cet article est court mais passionnant, je vous le recommande chaudement.

## Pourrait-on aujourd'hui arrêter ces conneries et faire en sorte que les navigateurs se présentent plus directement ?
Je sais pas trop.
J'imagine que oui et non.

Ça marcherait pour les pages simples, mais un peu moins pour les sites fait par des sagouins qui utilisent du code dépendant de chaque navigateur.
Les moteurs de rendu modernes sont bien plus respectueux des normes qu'auparavant.

Malheureusement, la monoculture des moteurs de rendu poussent à des abus de la part des devs de navigateurs mais aussi de pages webs.
La disparition récente du moteur de **Edge** ne va pas aider (et en plus [ils se permettent de remettre en doute la pertinence la persévérance de Mozilla envers son moteur](https://www.zdnet.com/article/microsoft-guy-mozilla-should-give-up-on-firefox-and-go-with-chromium-too/)).

