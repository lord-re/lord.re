+++
Author = "Lord"
Description = "Le bloqueur de pub natif de Qutebrowser suffit pour la quasi-totalité des pubs du web. Cependant, les pubs Youtube sont épargnées sauf si l'on utilise JBlock."
Categories = ["qutebrowser", "web"]
menu = "main"
notoc = true
PublishDate = 2019-05-05T20:47:08+02:00
date = 2019-05-05T20:47:08+02:00
title = "Qutebrowser : config.py et Jblock"
editor = "kakoune"
+++
Hahaha vous avez vu ?
Firefox a cassé son système d'add-ons à cause d'un certificat expiré.
Prenons une petite minute pour se moquer mais pas plus parceque bon c'est un peu le dernier rempart dans la guerre des moteurs de rendu web.
On est à deux doigts de la monoculture ce qui est loin d'être une bonne nouvelle.

Autant j'aimerai qu'ils regagnent quelques parts de marché autant je n'arrive plus à utiliser Firefox depuis qu'ils ont changé l'API de leurs add-ons cassant **Vimperator**.
Mais bon, je ne peux plus me passer de l'*User Experience* qu'apporte [Qutebrowser]({{< ref "/posts/64-qutebrowser" >}}).
Cela dit, ce qui me manque le plus est tout de même l'add-on [uMatrix](https://geekfault.org/2016/05/11/umatrix-le-firewall-pour-navigateur/).

Qutebrowser propose bien un système de blocage de pub nativement, mais il s'avère être assez rudimentaire.
Il bloque à peu près toutes les pubs.
Toute ?
Non !
Les satanées pub Youtube persistent !

Aussi bien les ptites pubs moches en bas de la vidéo s'affichent parfois, parfois non.
Mais surtout sur certaines vidéos il y a parfois l'infâme pub vidéo et ça je supporte plus.
Je ne me tape pas de pubs à la tv (parceque je la regarde pas), à la radio (parceque j'écoute Fip), sur le web, ou autre, c'est pas pour m'en taper sur youtube.

Bref, j'ai cherché et j'ai trouvé **JBlock** qui s'échine à faire un bloqueur de pub plus poussé que le système natif.
Il sait utiliser les listes bien connues qu'utilisent uBlock Origins, AdBlock et compagnie.
Du coup on atteint à peu près le même niveau d'efficacité.
Et effectivement, je n'ai plus de pub sur Youtube \o/

## Config.py
Historiquement Qutebrowser utilisait *qutebrowser.conf* puis *autoconfig.yml* pour chopper sa config (avec également *keys.conf*).
Il est cependant possible d'utiliser un fichier de conf en Python pour faire à peu près la même chose avec quelques possibilités supplémentaires.
Je me suis donc amusé en ce joli dimanche pour convertir ma config dans ce format.

Dès que vous aurez créé le fichier, vos anciens fichiers de conf ne seront plus utilisés.

<details><summary>Voilà donc ce que j'ai mis dans *~/config/qutebrowser/config.py*</summary>
{{< highlight "python" >}}
from qutebrowser.config.configfiles import ConfigAPI
from qutebrowser.config.config import ConfigContainer

import sys, os

config = config
c = c

# Bindings
config.bind('o', 'set-cmd-text -s :open', mode='normal')
config.bind('O', 'set-cmd-text -s :open {url:pretty}', mode='normal')
config.bind('w', 'set-cmd-text -s :open -t', mode='normal')
config.bind('W', 'set-cmd-text -s :open -t {url:pretty}', mode='normal')
config.bind('Fy', 'hint links yank-primary', mode='normal')
config.bind('Fy', 'hint links yank-primary', mode='normal')
config.bind('yy', 'yank -s', mode='normal')
config.bind('m', 'spawn --detach mpv {url}', mode='normal')
config.bind('Fm', 'hint links spawn --detach mpv {hint-url}', mode='normal')
config.unbind('F')

#Config perso
c.editor.command = ["kakoune -e vim {}"]
c.zoom.default = 150
c.messages.timeout = 10000
c.downloads.remove_finished = 30000
c.content.headers.do_not_track = True
c.completion.height = "33%"
c.tabs.show = "multiple"
c.tabs.tabs_are_windows = True
c.content.javascript.enabled = False
c.hints.mode = "number"
c.url.searchengines = {'DEFAULT':'https://duckduckgo.com/?q={}','y':'https://youtube.com/results?search_query={}','w':'https://fr.wikipedia.org/w/index.php?search={}'}

#Fonts
c.fonts.statusbar = "17pt monospace"
c.fonts.downloads = "17pt monospace"
c.fonts.hints = "18pt monospace"
c.fonts.keyhint = "17pt monospace"
c.fonts.messages.error = "17pt monospace"
c.fonts.messages.info = "17pt monospace"
c.fonts.messages.warning = "17pt monospace"
c.fonts.completion.entry = "17pt monospace"
c.fonts.completion.category = "17pt monospace"
c.fonts.prompts = "17pt monospace"


try:
	from qutebrowser.api import message
	sys.path.append(os.path.join(sys.path[0], 'jblock'))
	config.source("jblock/jblock/integrations/qutebrowser.py")
except ImportError:
	pass
{{< / highlight >}}
</details>

Rien de bien exotique si ce n'est le *try* à la fin.

## JBlock
<<<<<<< HEAD
JBlock est codé par [Jay Kamat](https://jgkamat.gitlab.io).
=======
>>>>>>> 267ae572937b3a8c89dedbe696bfa31de9063b94
Cet add-on en Python doit être installé via un ptit coup de <samp>git clone https://gitlab.com/jgkamat/jblock</samp> directement depuis le dossier *~/.config/qutebrowser/* .

Une fois cloné, il vous faut ajouter le bout de *config.py* de la fin.
Ensuite il vous faut couper le blocage natif via un <samp>:set content.host_blocking.enabled false</samp>.

Ensuite il faut charger les listes que vous voulez utiliser.
Pour ça un coup de *<samp>:set content.host_blocking.lists '["https://easylist.to/easylist/easylist.txt", "https://easylist.to/easylist/easyprivacy.txt"]'</samp>* .

Bon bha, plus qu'à faire prendre en compte tout ça avec un petit <samp>*config-source*</samp> et on y est presque.

Un ptit coup de <samp>:jblock-update</samp> devrait vous créer le fichier *~/.local/share/qutebrowser/jblock-rules* .
On lance enfin <samp>:jblock-reload</samp> et c'est en route.

Yapuka tester!

Bon vous remarquerez que c'est plus primitif que les classiques.
Pas d'interface, pas de stats, pas d'auto-update…
Primitif mais fonctionnel.
