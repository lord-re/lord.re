+++
Author = "Lord"
Description = ""
Categories = ["sway", "wayland","ux"]
menu = "main"
notoc = true
draft = true
WritingDate = 2024-10-11T10:52:20+02:00
date = 2024-10-11T10:52:20+02:00
title = "Fuzzel toujours plus !"
editor = "helix"
Audio = ""
Soustitre = ""
+++
Ouai je vous en remet une couche sur [Fuzzel](https://codeberg.org/dnkl/fuzzel/).
Ce logiciel est vraiment bien mais en plus on peut en détourner l'usage pour faire autre chose qu'un simple launcher.

Et du coup je vous propose deux utilisation un peu plus originales.

## Un ptit menu pour yambar

**Yambar** est … une barre pour sway et autres compistors sous wayland.
Ça permet d'y foutre plein d'infos et également d'y mettre des actions lançables en cliquant sur différentes zones.
C'est basique mais c'est suffisant, léger et rapide.
C'est fait par le même dev et je vous en ai déjà parlé [ici]({{< ref "posts/242-amélioration-de-mon-environnement-nunux-vol3/#yambar" >}}).

Et autant j'adore la possibilité d'utiliser mon ordi intégralement au clavier, autant parfois c'est vrai que cliquer sur un bouton pour lancer un truc un peu complexe, c'est plus pratique.
C'est d'autant plus vrai pour les fonctions les moins utilisées qui sont du coup moins facilement accessibles de mémoire.

Du coup j'ai eu envie de me faire un ptit menu comme on trouve sur tous les OS mainstreams.
Et vous savez quel logiciel est très cool pour faire des menus ?
FUZZEL !

Et hop !

{{< img src="fuzzel-menu.png" title="Propre efficace, on y croirait !" alt="Yambar dans le coin en haut à gauche de l'écran avec une ptite icone de pager ouvrant un menu avec 7 options avec une ptite icone à chaque fois">}}

C'est ty pas mimi ?
Avec les emojis et la ptite barre de recherche en prime !
La classe.

En gros **yambar** affiche une icone qui ouvre un script lorsqu'on clique dessus.
Le script est tout simple (je vous le mets plus bas) avec fuzzel qui vient se coller en haut à droite de l'écran pour donner l'impression d'apparaitre sous l'icone.
Un peu de couleurs et hop.

On peut y foutre autant d'options qu'on veut et utiliser la souris pour choisir ou bien le clavier.
Vraiment pas mal.
Et on peut configurer pour qu'en cas de perte de focus, ça se ferme (par défaut).

<details><summary>/usr/local/bin/fuzzel-menu</summary>

{{< highlight shell "linenos=table">}}

#! /bin/sh

# Bordel pour l'audio
SINK=$(pw-dump | jq  -r '.[] | select(.info.props["media.class"] == "Audio/Sink") | (.id | tostring) + ":" + .info.props["node.description"]' | grep Family)
IFS=: read -r SINK_ID SINK_DESCRIPTION <<< "$SINK"



choice1=$(printf "🌅 Luminosité ++
🌇 Luminosité -- 
🔈 Enceintes 
🎧 Casque 
📷 Screenshot
📸 Region Screenshot 
📼 Twitch "\
| fuzzel --dmenu  --config=/dev/null --index --anchor=top-right --horizontal-pad=10 --lines 7 --width 25 --background=282136fa --text-color=cdcdcdfa --selection-text-color=222222ff --border-color=bbbbbbff)

case "$choice1" in

  "0")
    # Monter la luminosité de l'écran
    ddcutil setvcp 10 + 10 --display 2 --sleep-multiplier 0.2
    return
  ;;

  "1")
    # Baisser la luminosité de l'écran
    ddcutil setvcp 10 - 10 --display 2 --sleep-multiplier 0.2
    return
  ;;

  "2")
    # Changer la route du sink par défaut pour les enceintes
    wpctl set-route $SINK_ID 3
    return
  ;;

  "3")
    # Changer la route du sink par défaut pour le casque
    wpctl set-route $SINK_ID 4
    return
  ;;

  "4")
    # Prendre un screenshot de tout l'écran
    sleep 0.3
    grim /tmp/screenshot-$(date +%Y-%m-%d-%H:%M:%S).png
    return
  ;;

  "5")
    # Prendre un screenshot d'une région de l'écran
    slurp | grim -g - /tmp/screenshot-$(date +%Y-%m-%d-%H:%M:%S).png
    return
  ;;

  "6")
    # Démarrer le menu twitch
    fuzzel-twitch
    return
  ;;
esac

{{< / highlight >}}

Bon pour la partie audio j'avais des bouts en plus pour choper le numéro de route mais je me suis rendu compte que c'était fixe, donc pas besoin de complexifier plus que ça.

</details>

Le truc cool, c'est que vu que ce n'est qu'un simple script il est très facile à modifier.
Suffit de sauvegarder et de recliquer l'icone et hop ça s'ouvre.

Fuzzel supporte les icones mais je n'arrive pas à faire bien ce que je veux.
Les emojis c'est plus simple ^__^

Voilà c'est tout !

## Un menu (encore !) contextuel
Là j'ai piqué l'idée chez [Sxmo](https://sxmo.org/).
C'est une interface utilisateur pour linux mais à destination des téléphones portables.

Le but est de fournir un menu contextuel pour tout un tas d'appli et qui soit donc utilisable facilement avec les touches physiques du téléphone sans nécessiter de "colaboration" de la part des logiciels.
Ça permet d'accéder à des fonctionnalités via un unique moyen d'accès.

Et c'est vrai que ça semble contre-intuitif d'utiliser des logiciels principalement en console et optimisés pour le clavier avec un téléphone portable mais au final leurs ajustements rendent cette interface très plaisante.
Et du coup je leur ai piqué l'idée et une grande partie de l'implémentation pour refaire pareil mais sur mon gros dinateur.

Après tout, j'ai beau quasiment tout faire dans un terminal, c'est vrai que ça nécessite de connaitre et de se souvenir de nombreux raccourcis claviers.
Pour les logiciels du quotidien ça passe mais pour ceux qui servent moins souvent c'est plus compliqué.

Et du coup quel logiciel utiliser pour faire un menu ?
Et oui, c'est encore **Fuzzel** !

{{< img src="fuzzel-context-weechat.png" alt="Le menu propose de 8 choix possibles certains avec des emojis pour accompagner. On peut déclencher le bare mode, lancer une recherche, activer les filtres, mettre du gras, mettre une couleur, souligner, redessiner la fenêtre, afficher les touches" title="Déclenché depuis Weechat" >}}

Du coup dans **sway** je me fous un keybind pour déclencher mon script.
Le script détermine quelle est la fenêtre active puis en fonction de ça balance un fuzzel avec les choix prédeterminés.
Et en fonction de la sélection de l'utilisateur balance des touches depuis un clavier virtuel.

{{< img src="fuzzel-context-qutebrowser.png" alt="Ici on a l'option pour toggle le javascript, lancer les devtools, Supprimer un élément, Envoyer à mpv ou sur le téléviseur." title="Depuis QuteBrowser d'autres options …">}}

Maintenant il n'y a plus qu'à remplir ces menus !

C'est très pratique et ça peut même être utilisé comme un ptit aide-mémoire.

<details><summary>/usr/local/bin/fuzzel-context-menu</summary>

{{< highlight shell >}}


#! /bin/sh

FUZZEL_OPTS="--config=/dev/null --index --dmenu --background=282136fa --text-color=cdcdcdfa --selection-text-color=222222ff --border-color=bbbbbbff"

sway_focused_app() {
	swaymsg -t get_tree | jq -r '
			recurse(.nodes[]) |
			select(.focused == true) |
			{
				app_id: (if .app_id != null then
						.app_id
					else
						.window_properties.class
					end),
				name: .name,
			} |
			select(.app_id != null and .name != null) |
			.app_id
		'
}

sway_focused_title() {
	swaymsg -t get_tree | jq -r '
			recurse(.nodes[]) |
			select(.focused == true) |
			{
				app_id: (if .app_id != null then
						.app_id
					else
						.window_properties.class
					end),
				name: .name,
			} |
			select(.app_id != null and .name != null) |
			.name
		'
}


APP=$(sway_focused_app)
TITLE=$(sway_focused_title)
# CLI_APP=$(print "%s" "$TITLE" | cut -d' ' -f1)

# DEBUG
# fuzzel --dmenu --placeholder="APP [$APP] --- title [$TITLE]"


#############################
# Applis console uniquement #
#############################

if [ "$APP" = "foot" ]; then
	case "$TITLE" in

		hx*)
			PLACEHOLDER="📙 Helix"
		  TO_FUZZEL="
				Sélectionner paragraphe (mip) @ -k Escape mip
				Choisir sélecteur (s\|)       @ s\\\| -k Return
				Aligner (&)                   @ \&
				Supprimer les curseurs (,)    @ ,
			"
	  ;;

		rtorrent*)
		  PLACEHOLDER="🏴‍☠️rTorrent"
		  TO_FUZZEL="
				➕ Ajouter un torrent         @ -k backspace
				🚀 Démarrer un torrent        @ -M Ctrl s
				✋ Stopper un torrent         @ -M Ctrl d
				⛔ Quitter rTorrent           @ -M Ctrl q
			"
		;;

		top*)
      PLACEHOLDER="🧑‍💻Top"
			TO_FUZZEL="
				🪟 Changer de fenêtre (g)     @ g
				🔎 Chercher (L)               @ L
				🚩 Signal (k)                 @ k
				🆘 Aide (h)                   @ h
			"
		;;
		
		# Weechat
    "ssh zc")
		  PLACEHOLDER="💬 WeeChatX"
		  TO_FUZZEL="
				🫦 Bare Mode\0icon\x1fweechat @ -M Alt l
				🔎 Rechercher                 @ -M Ctrl r
				🔀 Toggle filters             @ -M Alt =
				🎨 Gras                       @ -M Ctrl b
				🎨 Color                      @ -M Ctrl v
				🎨 Underline                  @ -M Ctrl _
				🖌️ Redraw                     @ -M Ctrl l
				🔑 Show Key                   @ -M alt k
				
			"
		;;

    Yazi*)
			PLACEHOLDER="📂 Yazi"
			TO_FUZZEL="
				Copy (y)                      @ y
				✂️ Cut (x)                    @ x
				Paste (p)                     @ p
				Rename (r)                    @ r
				🔍 Find (/)                   @ / 
			"

		;;

		*)
		  PLACEHOLDER="🦶 Foot"
		  TO_FUZZEL="
				🔍 Zoom ++                    @ -M Ctrl +
				🔎 Zoom --                    @ -M Ctrl -
				🌐 URL Mode                   @ -M Ctrl -M Shift -k o
				🕶️ Search                     @ -M Ctrl -M Shift -k r
			"
		;;
	esac
fi

case "$APP" in

  "mpv")
	  PLACEHOLDER="📼 MPV"
	  TO_FUZZEL="
			⏯️ Pause                        @ -k Space
			🔇 Mute                         @ m
			ℹ️ Infos                        @ i
			🚀 Toggle hwdec                 @ -M Ctrl h
		"
	;;

  "org.qutebrowser.qutebrowser")
	  PLACEHOLDER="🌎 QuteBrowser"
    TO_FUZZEL="
			💲Toggle JS                     @ -k Escape tsh
			🛠️Devtools                      @ -k Escape :devtools -k Return
			🔪Delete                        @ -k Escape -M Shift F -m Shift -s 100 k
			📼To MPV                        @ -k Escape -M Shift F -m Shift -s 100 m
			📺To TV                         @ -k Escape -M Shift F -m Shift -s 100 t
		"
	;;

esac

if [ -z "$TO_FUZZEL" ]; then
  echo "Pas trouvé l'appli, désolé" | fuzzel --dmenu
	exit  
fi


CHOICES="$(printf "%s" "$TO_FUZZEL" | sed '/^[[:space:]]*$/d' | awk '{$1=$1};1')"
LINE_NUMBER=$(printf "%s\n" "$CHOICES" | wc --lines)
MAX_LINE_NUMBER=$(( $LINE_NUMBER < 10 ? $LINE_NUMBER : 10 ))
PICKED_LINE="$(echo -e "$CHOICES" |cut -d'@' -f1 | fuzzel --dmenu --index --placeholder="$PLACEHOLDER" --lines="$MAX_LINE_NUMBER")"
# Pas de choix fait par l'utilisateur.
if [ "$PICKED_LINE" == "" ]; then
 exit
fi
ACTION="$(printf "%s" "$CHOICES" | cut -d'@' -f2 | awk NR==$PICKED_LINE+1  )"

# DEBUG
# printf "PICKED Line : [%s]" "$PICKED_LINE"
# printf "ACTION : [%s]" "$ACTION"
# printf "Sending :[wtype %s]" "$ACTION" 


wtype $ACTION


{{< / highlight >}}

</details>

Voilà voilà, si ça peut vous inspirer ou vous aider, n'hésitez pas !
