+++
Author = "Lord"
Description = "Personnalisation de Weechat afin de le rendre plus agréable à utiliser. La majeure partie consiste à customiser l'interface."
Categories = ["irc", "cli"]
menu = "main"
notoc = true
PublishDate = 2018-07-16T12:53:23+02:00
date = 2018-07-25T11:53:23+02:00
title = "Configuration Weechat 2018"
editor = "kakoune"
+++

[Weechat](https://weechat.org/) 2.2 vient de sortir et c'est l'occasion de lui faire un ptit article.
Ça fait maintenant très longtemps que je l'utilise comme client IRC.
Je l'ai pas mal trifouillé de droite et de gauche depuis le temps du coup je voulais poser un peu toutes ces personnalisations quelque part pour les retrouver au cas où et pour vous les partager.

## Les scripts
Du haut de ses 15 ans, Weechat a sû se créer un petit écosystème complet de plugins/scripts (et bientôt des thêmes !).

J'ai toujours préferré éviter de trop en cumuler.
Du coup j'en utilise assez peu :

  - **colorize_nicks.py** : Permet de colorer les pseudos lorsqu'ils sont cités dans une phrase. Très pratique pour repérer quand ça parle de gens présent sur le salon.
  - **autoconnect.py** : Permet de se reconnecter automatiquement aux précédents serveurs et salon ouverts lors d'un redémarrage.
  - **chanmon.pl** : permet d'avoir un buffer aggrégeant tous les salons. Pratique pour voir d'un coup d'œil ce qu'il se raconte partout.
  - **colorize_lines.pl** : Permet de colorer les lignes de texte de la même couleur que le pseudo. Excellent pour améliorer la lisibilité.

Et voilà, j'ai réussi à ne pas être trop gourmand.

**Autoconnect** me sert peu car weechat tourne 24/7 sur un serveur mais au cas où, on sait jamais.

Les deux plugins de colorations sont purement esthétiques mais pourtant je pourrai pas m'en passer.
Ça simplifie grandement la lecture des conversations, surtout si on augmente le nombre de couleurs utilisées par weechat.

**Chanmon** est lui dispensable mais étant sur de très nombreux salons, j'ai très souvent la hotbar assez bien remplie avec de l'activité dans pleins de chans à la fois.
Ça me permet de ne pas aller dans un buffer où il y a de l'activité pour rien.

## Layout
{{< img src="*18-weechat-vanilla.thumb.png" link="118-weechat-vanilla.png" alt="capture d'écran de l'interface de Weechat" title="Par défaut c'est… meh" >}}

On va élaguer tout ça je vous préviens !

Bon alors la barre à gauche qui liste les *buffers* on peut virer : ça sert à rien.
**<samp>/bar del buflist</samp>**

La barre de droit avec la liste de pseudo, même combat : ça dégage.
**<samp>/bar del nicklist</samp>**
Les rares fois où vous aurez besoin de voir la nicklist vous ferez un ptit */names* et hop.

Vous voyez la barre avec le titre en haut ?
Vous voyez où je veux en venir :
**<samp>/bar del title</samp>**

Bon bha déjà c'est pas trop mal.

Bon cette barre bleue en bas c'est pas mal mais qu'est-ce que ça bouffe comme place !
It would be a shame if…
**<samp>/bar del status</samp>**

Ha merde il y avait des trucs pas mal dedans quand même !
Bon faisons une barre mieux foutue du coup !
**<samp>/bar add ubar root bottom 1 0 buffer_number+:+buffer_name,hotlist,input_text,time,[completion]</samp>**

Et voilà notre übar, plus qu'à virer celle par défaut :
**<samp>/bar del input</samp>**

Voilà, on a gratté à peu près tout l'espace disponible, on a fusionné la *status_bar* avec l'*input_bar* et viré toutes les autres.
C'est bien minimaliste tout en étant parfaitement fonctionnel.

Bon maintenant, il ne reste plus qu'à faire en sorte de voir le chanmon en haut.
On va donc découper la fenêtre horizontalement avec un ptit **<samp>/window splith 10</samp>** et on a donc 10% de l'espace vertical qui est dispo pour un autre buffer.
Pour passer à la fenêtre du haut on fait un ptit **<samp>/window up</samp>** on peut y changer de buffer (typiquement on se fout sur celui de *chanmon*) et on retourne à celui du bas et voilà.

Bon on a fait le plus gros du boulot je crois.
Il va rester à fignoler quelques ptits réglages pour rendre le truc encore un peu plus séyant.

## Ptites optimisations
On va virer tous les scripts inutiles (ou juste ne pas en installer).
**<samp>/script</samp>**
Et là on coupe avec **<samp>/script remove xxx.yy</samp>** .

Et surtout on va aussi virer tous les plugins inutiles.
**<samp>/plugin</samp>**
et maintenant **<samp>/plugin unload xxx</samp>** et surtout **<samp>set weechat.plugin.autoload "*,!buflist,!exec,!fset"</samp>** pour que ça persiste à un redémarrage de la bête.

En virant tout le superflux j'arrive à faire tourner mon instance weechat dans un container de 64Mo de ram avec pourtant près de 200 buffers ouverts simultannément tout en ayant le *relay*.
Et le tout avec un uptime de plusieurs mois.
Bref ça tourne comme sur des disquettes.

Mais mais !
À quoi ça ressemble maintenant qu'on a tout trifouillé ?!

{{< img src="*18-weechat-tweakd.thumb.png" link="118-weechat-tweakd.png" alt="Capture de Weechat une fois toutes les modifs effectuées" title="Beau comme un rognon !" >}}

## Vrac moins intéressant

  - *irc.network.send_unknown_commands on* # Pour envoyer les commandes d'admin du serveur
  - *plugins.var.perl.chanmon.alignment channel* # Histoire que ce soit joli à voir et pas le dawa
  - *plugins.var.perl.colorize_lines.highlight off* # Pour ne pas qu'un HL colore toute la ligne (c'est moche et trop agressif) 
  - *weechat.color.chat_time orange* # Un peu de orange pour l'heure
  - *weechat.completion.nick_completer ""* # Ouai j'aime pas quand ça rajoute ":" quand on tab un pseudo
  - *weechat.look.prefix_align_max 10* # Pas plus de 10 lettres pour les pseudos… largement suffisant
  - *weechat.look.prefix_same_nick ""* # J'aime bien le fait de pas avoir le même pseudo affiché en boucle lors de ligne successive
  - *weechat.look.prefix_suffix "│"* # Pour avoir des jolies barres complètes
  - *weechat.color.chat_nick_colors "028,029,030,031,032,033,034,035,036,037,038,039,040,041,042,043,044,045,046,047,048,049,050,051,058,059,060,061,062,063,064,065,066,067,068,069,070,071,072,073,074,075,076,077,078,079,080,081,082,083,084,085,086,087,088,089,090,091,092,093,094,095,096,097,098,099,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229"* C'est long mais ça rajoute tout pleins de nouvelles couleurs utilisables.
