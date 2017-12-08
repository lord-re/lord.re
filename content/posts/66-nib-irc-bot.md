+++
Author = "Lord"
Description = "Présentation de mon bot irc écrit en shell. Il a pour vocation de me simplifier la vie en scannant les flux rss, monitorans quelques machines, surveillant le cours des crypto monnaies, gérant ma todo list et quelques autres fonctions."
Categories = ["shell", "linux","irc"]
Tags = ["shell", "linux","irc"]
menu = "main"
notoc = true
PublishDate = 2017-12-08T16:21:40+01:00
date = 2017-12-08T16:21:40+01:00
title = "NIB : Mon assistant personnel IRC"
+++

Je vous présente ***NIB*** mon assistant personnel. Il me simplifie la vie depuis quelques années maintenant. J'y gère des todo, j'y fais un peu de supervision, un peu de self monitoring manuel également et il possède même quelques commandes réseaux. 

J'ai une forte addiction à l'irc. J'y suis connecté 24h/24 depuis près de vingt ans ans maintenant. Je consulte jamais mes mails mais irc plusieurs fois par heure. Dès que je démarre mon ordi, je me reconnecte sur ma session ssh où tourne mon fidèle tmux/weechat. C'est ma cyber-forme de communication première (désolé blog mais ouais tu passes après). Bref si je dois avoir un assistant personnel faut qu'il soit accessible sur irc. J'y ait accès sur mon ordi, sur n'importe quel ordi via le web ou directement depuis mon téléphone via client weechat-android tournant constamment aussi.

## Choix techniques

Je ne sais pas coder, tout juste lire quelques lignes de codes pour m'en dépatouiller pour tenter de débugguer un peu à droite à gauche mais guère plus. J'ai donc bidouillé du **script shell** pour fabriquer mon bot irc.

Il existe pas mal de bots irc déjà dans pas mal de langages différents mais bon j'ai pas envie d'avoir du vieux code pas forcément à jour ou bien des softs avec quinze milles dépendances et surtout j'ai envie de m'amuser à faire ça. Un truc léger et pas forcément rempli de fonctionnalités. Du coup bha du script shell c'est à peu près universel, un client irc facilement hackable et les commandes inotify pour aider. On tartine ça de commandes sorties de **coreutils** et pouf.  Voilà tout ce qui est nécessaire. En bonus on peut rajouter tmux c'est quand même plus pratique.

Au final c'est très économe en ram (la vm consomme 14Mo là tout de suite) en CPU 4 Minutes de CPU par jour environ soit bien moins de 1% de CPU en moyenne et ça rentre dans moins de 100Mo de skeudur. C'est donc virtuellement hébergeable partout. Perso je le fais tourner dans un container sur mon routeur.

Le client IRC choisi est **ii**. C'est un client irc assez minimaliste fait par les braves gens de [Suckless](https://suckless.org/). Il se connecte au réseau irc voulu ainsi qu'au salon de discussion voulu et vous ouvre des *FIFO* dans lesquels vous enverrez le texte. Pour lire le salon vous ouvrirez le fichier texte qu'ii crée. C'est assez primitif au premier abord mais ça permet d'utiliser les logiciels de son choix pour lire/écrire c'est pas mal. C'est du coup ultra simple à scripter. Un simple ``echo coucou >> irc.geeknode.org/#lesalon/in`` et hop.

Une partie du boulot du bot est fait par le bot lui même mais pas uniquement. Le bot est également en écoute sur un port et envoi sur IRC tout ce qui arrive sur ce port. Ça permet de recevoir du texte depuis l'extérieur (Ça fait même un cheap honey pot).

## Fonctionnalités

### Lecture de RSS

En plus d'être addict à IRC je suis un gros utilisateur des flux RSS. Ça permet de suivre de très nombreux sites sans les consulter un par un. J'héberge une instance [Tiny Tiny RSS](https://tt-rss.org/) qui est est un excellent aggrégateur de flux en web. Il est particulièrement adapté pour gérer énormément de flux et les catégoriser. J' ai une catégorie particuliere où je suis les sorties de nouvelles versions de logiciel et également les failles de sécurité. Ce flux est donc assez important. Du coup chaque nouvel item de ce flux est rebalancé sur IRC via le bot histoire de vite faire les mises à jour (ou pas). Pour cela j'utilise **rsstail** qui pioche le flux géneré par ttrss. *On dépend donc de rsstail.*

### Monitoring ping

Je gère quelques machines persos mais également des machines associatives dont certaines nécessitent un uptime plutôt correct.  Je fait donc chaque minute un test de connexion TCP et/ou UDP sur les services critiques. En cas d'échec, le bot affiche le service qui est injoignable. Je fait ça chaque minute ce qui me permet de voir les downtimes assez rapidement et ainsi voir combien de temps ça dure. Pour faire ce teste j'utilise une fonction assez peu connue du shell : ``echo >/dev/tcp/la_machine/le_port) &>/dev/null`` . Et bien entendu je récupère (ou non) un code d'erreur en retour. Si ça échoue, j'attend quelques secondes et je lance une seconde tentative, ça évite d'avoir des erreurs pour des micro-interruptions. *0 dépendance pour ce module.*

### Vérif des backup

Le boulot n'est pas fait par le bot lui même mais directement sur le serveur de backup qui ne fait que transmettre le texte.

Un simple cron lançant régulièrement un tout petit script qui vérifie si le dossier du dernier backup journalier existe. Et ensuite qui vérifie que ce dossier n'est pas plus vieux qu'un jour. Basique mais suffisant. Et biensûr si c'est pas le cas, une alerte vers le bot. Une dernière petite fonctionnalité est l'affichage de la taille du dernier backup. Ça me permet de voir vite fait si la valeur est cohérente ou pas. Ça ne me demande moins de dix secondes d'attention par jour. *Pas de dépendance introduite par ce module.*

### Gestion de todo

Un petit script qui ajoute/supprime des lignes dans un fichier texte. Une ligne par truc à faire. Un cron qui affiche la todo tous les jours deux fois par jours. Avec ça je me sens "oppressé" du coup je la vide aussi vite que possible. Un simple ***todo add truc à faire*** et hop c'est ajouté. C'est tout à base de **echo** et **while read**. *Pas de dépendance en dehors des coreutils classiques.*

### VoD perso

Mon NAS est connecté au net. Du coup parfois quand je suis pas dans mon LAN et que j'ai envie de matter une vidéo dispo sur mon NAS je dois chercher la vidéo. Ouais ouais le NAS est pas super bien rangé, il y a des trucs à droite à gauche (séparé sur plusieurs disques). Du coup je me suis fait une ptite commande qui va simplement **find|grepper** dans tous les dossiers de stockage pour trouver la vidéo désirée et qui me sort le lien. *Ce coup-ci on a besoin de ssh (ainsi que la configuration d'un utilisateur et de ses clés) comme unique dépendance.*

### Monitoring perso

Je fais du monitoring manuel. La consommation de gaz/élec/eau que je relève manuellement une fois par semaine et je graph ça. Pour le relevé je balance ça dans le bot et c'est lui qui met en forme et balance ça dans un fichier csv. Ensuite j'ai une ptite page web avec du JS qui lit le fichier CSV et qui génère un très joli graph. Je graph aussi la conso essence de la bagnole (et le prix au passage) ainsi que le poids des habitants de la maison (chat compris). Donc là c'est principalement du **sed** et un ajout dans un fichier csv via **ssh**. *La seule dépendance externe est encore une fois ssh*.

### Téléchargement

Ouai des fois j'ai un besoin urgent de télécharger un fichier. Je lui donne l'url et il s'en débrouille. Rien de bien méchant, un **wget** et hop. *Toujours pas de dépendance*.

### Monitoring de sessions

Gérant plusieurs machines ouvertes sur le net, j'ai des serveurs SSH à droite à gauche bien évidemment. Même si tant que possible j'essaye de faire en sorte que la conf des SSHD soit bonne, on n'est à l'abri de rien. Du coup dès qu'une session est ouverte je reçois l'information de la provenance de la connexion ainsi que l'utilisateur. Ça permet de voir en live qui se connecte où. C'est génial ( "Tiens qui sait ce *Lord* qui vient de se connecter sur mon routeur ?" ). Ça permet de réagir assez vite en cas de compromission ou tout simplement après coup de voir qui s'est connecté il y a six mois sur telle machine ? On voit également en live les backup se faire via ssh. On peut facilement détecter un backup qui se passe mal (une connexion qui ne dure que 5 secondes au lieu des 40 minutes habituelles par exemple).

Cette partie n'est en fait pas gerée par le bot lui même. C'est juste sur les machines surveillées, un script qui s'execute à la connexion pour envoyer la notif au bot. Soit on fout la commande dans le *sshrc* qui est executé à l'établissement de la connexion réussie. Soit (et je préfère) carrément dans PAM ce qui permet d'avoir la connexion ET la déconnexion. On envoi ça via un simple netcat même si je pourrai le faire via un **echo >/dev/tcp/** . *Pas de dépendance sur le bot par contre un script à mettre en place sur chacune des machines surveillées et donc installation de nc*.

## Crypto-monnaies

J'ai un peu de crypto monnaies et je tente de grapher un peu combien ça vaut. Et surtout je mine à mon rythme du Monero l'hiver pour chauffer l'appart. Du coup je récupère la balance de mon wallet, le cours du monero, le hashrate actuel et avec un chouilla de calcul je sors la valeur en €uro de mon ptit portefeuille. C'est principalement du **curl | jq** et les calculs avec **awk** (ouais c'est pas l'outil le plus intuitif mais ça fonctionne et ça évite de rajouter un paquet supplémentaire au container. Donc toutes les trentes minutes le bot relève les infos, annonce les résultats et envoie ça dans un csv via **ssh** pour être graphé. *Là on introduit pas mal de dépendances : curl, jq, awk et ssh*.

## Quelques détails d'implémentation

Le code est en bash et non en sh pure. Je sais plus exactement pour quelle raison. J'ai tenté d'utiliser le plus possible de variable en début de fichier.

J'ai découpé en multiples fonctions qui s'exécutent parallèlement. Le bot utilise de nombreuses boucles qui tournent constamment.

  - La première boucle vérifie que **ii** tourne. Si ce n'est pas le cas elle va le relancer et se reconnecter au salon. Ça permet en cas de relancement du bot ou de plantage de ii de se relancer mais en vrai ça n'arrive jamais. Par contre lorsque le bot se fait kill (parfois ça flood un peu trop), ii s'arrête. Du coup la boucle relance le truc.
  - La seconde boucle vérifie que **nc** tourne et écoute les connexions entrantes. Nc envoie tout ce qu'il reçoit dans un fichier que j'ai appelé buffer. Ce buffer permet de conserver tous les messages si jamais le reste du bot est en carafe (sait-on jamais).
	- La troisième boucle est celle qui lit le buffer et envoie les lignes vers l'irc avec un ptit délai entre chaque ligne pour éviter le flood. Elle vide également le buffer. C'est un fifo fait main.
  - Il y a ensuite une quatrième boucle qui s'amuse à lire ce qu'il se passe sur irc et dans certaines conditions va parser ce qui se raconte (en gros si c'est pas le bot lui même qui parle.
	- Une autre boucle encore qui lit ce qu'il se passe dans le shell ayant lancé le bot. Histoire de pouvoir lancer des commandes interactivement. Ça sert rarement mais parfois c'est utile. J'ai aussi bidouillé des scripts qui envoie des commandes à tmux pour "écrire interactivement" avec le bot. Bidouillage quand tu nous tiens.
	- J'ai la boucle de monitoring réseau qui tente d'établir les connexions réseau chaque minute.

Donc voilà au moins six boucles en bash qui tournent. Si ça c'est pas du multiprocess qui tue…

J'ai ensuite chacune des commandes qui est une fonction appart. Une fonction d'initialisation qui lance tout ça. Une fonction pour killer tout mais en vrai certaines fois ça kill pas tout du coup je relance le container chaque nuit pour éviter de trop accumuler. C'est crade mais pas critique dans mon cas. 

Et voilà ça fait un script bash un petit peu tordu de 400 lignes mais au final il tourne sans aucun soucis depuis des mois. Ptet qu'un jour je le réécrirai en rust ou en go (wink wink).

## Voilà le monstre

```


#! /bin/bash

ircnetwork=""
ircport=""
ircchan=""
ircdir="/home/lord/irc"
chanout="$ircdir/$ircnetwork/$ircchan/out"
chanin="$ircdir/$ircnetwork/$ircchan/in"
buffer="$chanin"buf
realnick="nib"
selfnick="<$realnick>"
launcheddate="$(date)"
rss_url=""

bold="\e[1m"
normal="\e[m"
bleu="\e[0;34m"
violet="\e[0;35m"
rouge="\e[0;33m"

trap "Send 'Je vais me pieuter!';printf 'Extinction suite à signal\n'; KillAllJobs; exit 0 " 2 3 15

KillAllJobs(){ 
	jobs -p
	jobs -p | xargs kill -9;
}

Send(){
  printf "\x033[BOT-%s]\x0f %b\n" "$(date +%H:%M:%S)" "$1" | fold -b -w 500 >> "$buffer"
}
SendNoFormat(){
  printf "%s\n" "$1" | fold -b -w 500 >> "$buffer" &
}
Log(){
  printf "%s - %b\n" "$(date '+%d/%m %H:%M:%S')" "$1"
}

Init(){
	Log "==============="
  Log "\e[0;32m   Lancement\e[0m"
	Log "==============="

  Iiloop
  iiloop_pid=$!
  Log "$violet Démarrage du bot$bold [1/5]$bleu iiloop_pid: $iiloop_pid $normal"
  Ncloop
  ncloop_pid=$!
  Log "$violet Démarrage du bot$bold [2/5]$bleu ncloop_pid: $ncloop_pid $normal"
  Rssloop
  rssloop_pid=$!
  Log "$violet Démarrage du bot$bold [3/5]$bleu rssloop_pid: $rssloop_pid $normal"
  Pingloop
  pingloop_pid=$!
  Log "$violet Démarrage du bot$bold [4/5]$bleu pingloop_pid: $pingloop_pid $normal"
  Debufloop
  debufloop_pid=$!
  Log "$violet Démarrage du bot$bold [5/5]$bleu debufloop_pid: $debufloop_pid $normal"
  Chaninputloop
  chaninputloop_pid=$!
  Log "$violet Démarrage du bot$bold [6/5]$bleu chaninputloop_pid: $chaninputloop_pid $normal"
}

Debufloop(){
# Utilisation d'un fichier tampon pour les fois où on est pas connecté et qu'on arrive pas à balancer dans la fifo d'ii.
  [ ! -f "$buffer" ] && touch "$buffer"
  while true;
	do
	  inotifywait "$buffer" -e close_write,modify > /dev/null 2>&1
	  while read buffered_line;
		do
		  printf "%s\n" "$buffered_line" >> "$chanin"
			sleep 0.5
		done < "$buffer"
		> "$buffer"
	done &
}
Rssloop(){
  while true;
	do
		Log "\e[0;36mRelancement de rsstail\e[0;m"
		Send "\x037[RSS]\x0f Relancement de Rsstail."
    rsstail -u $rss_url -n 0 -z -P -l |while read -r x;do printf '\x037[RSS] %s\n' "$x" >> "$buffer";done
	done &
}
Pingloop(){
  while true;
	do
	  TcpPortTest "xxxx" "22"
	  TcpPortTest "xxxx" "80"
	  TcpPortTest "xxxx" "443"
	  UdpPortTest "xxxx" "1194"
	  TcpPortTest "xxxx" "80"
	  TcpPortTest "xxxx" "80"
	  TcpPortTest "xxxx" "443"
		sleep 60
	done &
}
Ncloop(){
	while true;
	do
    if pgrep ncat >/dev/null 2>&1
		  then sleep 5
		else
      Log "Relancement de ncat"
			Send "Relancement de ncat"
      ncat -l -p 4321 -k >> "$buffer" &
	  fi
	done &
}
Iiloop(){
	while true;
	do
	  if pgrep ii >/dev/null 2>&1
		then sleep 2
		else
	    Log "Relancement d'ii"
	    ii -s $ircnetwork -p $ircport -n $realnick -f $realnick &
		  sleep 1
		  printf "/j %s\n" "$ircchan" > $ircdir/$ircnetwork/in
		fi
          sleep 1
	done &
}
Parsemsg(){
case $1 in
      #### HELP ####
      "help"|"aide"|"commandes"|"commands") Send "Bonjour, Je suis ne suis qu'un humble bot. Voici mes quelques commandes dispos : \x032dl, dig\x0f, \x032ip, iloth, up, film, rss\x0f, \x038debug, reboot, exit\x0f et voilà ! C'est tout !";;

      #### BOT ####
      "restart"|"rehash"|"reboot") Send "Reboot du bot" && break ;;
    	"exit"|"quit"|"ctrlc"|"ta gueule") Send "Désolé de vous décevoir patwon. La seule solution est le seppuku." return 1;;

      #### COMMANDS ####
	"rss") Send "SendRss" && SendRss &;;
	dig*) Dig "$1" &;;
	up*) Up "$1" &;;
	film*) Film "$1" & ;;
	todo*) Todo "$1" & ;;
	dl*) [ "$nick" == "<Lord>" ] &&	Dl "$1" & ;;
	plot*) Plot "$1" & ;;
	coin*) Coin "$1" &;;

      # INFOS #
      #### IP ####
      "ip") Send "IP : Choix possibles: \x2lord\x0f, \x2iloth\x0f, \x2lan";;
    	"ip iloth") Send "XXXXX";;
      "ip lord") Send "XXXXX";;
    	"ip lan") Send "XXXXX";;

      #### DEBUG ####
      "debug") Send "date: $date | time: $time | nick: $nick | msg: $msg" && Send "commandes disponibles:\x02 color, pid\x0f. Lancé depuis $launcheddate.";;
			"color") CouleurIndex ;;
			"pid") Send "iiloop_pid: $iiloop_pid" && Send "ncloop_pid: $ncloop_pid" && Send "rssloop_pid: $rssloop_pid" && Send "pingloop_pid: $pingloop_pid" && Send "debufloop_pid: $debufloop_pid" && Send "Chaninputloop_pid: $chaninputloop_pid" ;;
    esac
}

Chaninputloop(){
  tailf -n1 $chanout | while read -r date time nick msg; do
  if [ "$nick" = "$selfnick" ]  #On ignore ce que raconte le bot lui même
    then continue 
  else
	  Parsemsg "$msg"
  fi
  done &
}

Interactiveloop(){
	while read userinput
	do
		if [[ "$userinput" == /* ]]
		then
			Parsemsg "${userinput:1}"
		else
		  Send ": $userinput"
	  fi
	done
}

Kill(){
	if [ -e /proc/"$1" ]
	then
    Log "$rouge Kill $2: $1 $normal"
		disown $1
	  kill $1
	  wait $1
	  Log "$rouge $2 killed $normal"
	fi
}
CouleurIndex(){
	for ((color_index=30;color_index<=39;color_index++)) do
	  Send "\x0$color_index Couleur $color_index"
	done
}
SendRss(){
  rsstail -u $rss_url -1 -n 5 -z -P -l | for ((rss_index=0;rss_index<=7;rss_index++)) do 
    read -r x;
		printf "\x037[RSS] %b\n" "$x" >> "$buffer"
		sleep 1;
  done 
}
Dig(){
	digargs="$(printf "%s" "$1" | cut -c 5-)"
	[ ! -z "$digargs" ] && Send "$(dig +short $(printf "%s" "$1" | cut -c 5-))" || Send "Syntaxe: C'est la même que dig, tout simplement"
}
Up(){
	upargs="$(printf "%s" "$1" | cut -c 4-)"
	if [ -z "$upargs" ];
	then Send "syntaxe: up domaine port . ex: up lord.re 80"
  elif TcpPortTest $upargs;
	then
	  Send "\x039[PING]\x0f$upargs est UP !"
  fi
}
TcpPortTest(){
  if (! echo >/dev/tcp/$1/$2) &>/dev/null
	then
	  sleep 5
		(echo >/dev/tcp/$1/$2) &>/dev/null || Send "\x039[PING]\x0f Ping KO vers \x02$1:$2\x0f"
		return 1
	fi
}
UdpPortTest(){
  if (! echo >/dev/udp/$1/$2) &>/dev/null
	then
	  sleep 5
		(echo >/dev/tcp/$1/$2) &>/dev/null || Send "\x039[PING]\x0f Ping KO vers \x02$1\x0f"
	  return 1
	fi
}
Film(){
	filmargs="$(printf "%s" "$1" | cut -c 6-)"
	Send "Film: $filmargs"
	Filmresults="$(ssh nib@10.0.0.1 "find /stockage/*/films | grep $filmargs -i")"
        if [ $( echo $Filmresults | wc -l ) -gt 10 ]
	then
	  Send "Trop de résultats pour : $filmargs"
		return 0
	else
          Send "ok"
          while IFS= read -r resultat
          do
            echo $resultat | sed 's/ /%20/g' | sed 'XXXXX' | sed 's/\/films//'
          done <<< $Filmresults
        fi
}
Todo(){
	set $1
  [ ! -f "ircdir/todo" ] && touch "$ircdir/todo"
  if [ -z $2 ]
	then
	  index=1
		while read -r todoitem;
		do
		  Send "$index - $todoitem"
			let "index++"
		done < "$ircdir/todo"
		[ $index -eq 1 ] && Send "Rien à faire \o/"
		return 0
	fi
	if [ "$2" == "add" ]
	then
	  shift 2
	  Send "Ajout todo : $*"
		printf "%s - %s\n" "$(date '+%d/%m %H:%M:%S')" "$*" >> "$ircdir/todo"
	elif [ $2 == "del" ]
	then
	  Send "Suppression de l'item : $3"
		sed -i "$3d" "$ircdir/todo"
	elif [ $2 == "flush" ]
	then
	  Send "Vidage de la todo"
		> "$ircdir/todo"
  else
	  Send "Mauvaise syntaxe : todo add, todo del, todo flush ou bien todo."
	fi
	return 0
}

Plot(){
	set $1
	[ ! -f "ircdir/plot" ] && touch "$ircdir/plot"
	if [ -z $2 ]
	then
		index=1
		while read -r plotitem;
		do
			Send "$index - $plotitem"
			let "index++"
		done < "$ircdir/plot"
		Send "Syntaxe : [action] (données)"
		Send "Syntaxe : action : add / send / del / flush / info"
		Send "Syntaxe : catégories : conso / poids / voiture"
		Send "Syntaxe : ex : plot add [données]"
		Send "Syntaxe : ex : plot info (catégorie)" 
		Send "Syntaxe : ex : plot send [catégorie]"
		Send "Syntaxe : ex : plot del numéro"
		Send "Syntaxe : ex : plot flush"
		
		[ $index -eq 1 ] && Send "Rien à valider"
		return 0
	fi
	if [ "$2" == "add" ]
  then
		shift 2
		Send "$#"
		if [ $# -gt 0 ]
		then
			Send "Envoi de : $*"
			printf "%s" "$(date '+%d/%m/%y')" >> "$ircdir/plot"
			while [ $# -gt 0 ]; do
				printf ",%s" "$1" >> "$ircdir/plot"
				shift
			done
			printf "\n" >> "$ircdir/plot"
			Send "Pensez à [plot send si c'est bon]"
		else
			Send "Pas assez d'arguments :-("
		fi
	elif [ "$2" == "send" ]
	then
		if [ "$3" == "conso" -o "$3" == "poids" -o "$3" == "voiture" ]
		then
			cat "$ircdir/plot" | ssh nib@10.0.0.1 "cat >> /var/graph/$3.csv" && Send "Données ajoutées dans $3. Merci ;-)"
			> "$ircdir/plot"
		else
			Send "Mauvaise catégorie."
		fi
	elif [ "$2" == "del" ]
	then
		Send "Supression de l'item : $3"
		sed -i "$3d" "$ircdir/plot"
	elif [ "$2" == "flush" ]
	then
   		Send "Suppression des plots en cours"
		> "$ircdir/plot"
	elif [ "$2" == "info" ]
	then
		Send "Pour la conso : Gaz Élec Eau"
		Send "Pour le poids : Peluche Bab Lrd"
		Send "Pour la voiture : Km Litre Prix"
	else
		Send "Mauvaise syntaxe : plot add, plot del, plot send, plot flush ou bien plot info."
	fi
	return 0
}

Dl(){
	set $1
	[ -z "$2" ] && Send "Syntaxe: dl URL" && return 0
	Send "Bon bha je vais télécharger $2"
	wget --quiet -c -P XXXX "$2"
	Send "Dl de $2 fini. Enjoy."
return
}

Coin(){
	set $1
	balance="$(curl --silent --insecure 'XXXX' | jq -r '.stats.balance')"
	hashrate="$(curl --silent --insecure 'XXXX' | jq -r '.stats.hashrate')"
	balance=$(awk "BEGIN {print $balance / 1000000000000}")

	hashrate=${hashrate%?}
	unit=$(echo $hashrate | cut -c $((${#hashrate})))
	if [ "$unit" = "K" ] ;
	then
		echo "*1000"
		hashrate=$(awk "BEGIN {print $hashrate * 1000}")
		hashrate=$(awk "BEGIN {print $hashrate * 1000}")
	fi

	xmreur="$(curl --silent --insecure 'https://api.cryptonator.com/api/ticker/XMR-EUR' | jq -r '.ticker.price')"
	btceur="$(curl --silent --insecure 'https://api.cryptonator.com/api/ticker/BTC-EUR' | jq -r '.ticker.price')"
	pognon=$(awk "BEGIN {print $balance * $xmreur}")
	#output irc
	Send "\x038[COIN]\x0f - $(date '+%d/%m/%y %H:%M:%S') - $balance XMR @ $hashrate KH/s - XMR-EUR : $xmreur ce qui fait $pognon €     - BTC-EUR: $btceur \n"
	if [ "$2" == "send" ]
	then
		printf "%s,%s,%s,%s,%s,%s\n" "$(date '+%d/%m/%y %H:%M')" $balance $hashrate $xmreur $pognon $btceur | ssh nib@10.0.0.1 "cat >> /var/graph/coin.csv"
	fi
	
	return 0
}

main(){
  ### Pré-init #################################################################
  # Si le bot est lancé avec des arguments, ceux-ci sont envoyés sur le chan, si pas d'argument on lance le bot.
  if [[ ! -t 0 ]];
  then
    if [[ ! -z "$1" ]];
  	then
      while read -r pipedtext; do SendNoFormat "| $* $pipedtext"; done
    else
      while read -r pipedtext; do SendNoFormat "| $pipedtext"; done
  	fi
  exit
  fi
  if [[ ! -z "$1" ]] && [[ -t 0 ]];
    then
  		if [[ "$1" == /* ]]
  		then
  			#on utilise une variable intermédiaire pour virer le premier /, ça ne fonctionne pas sur $* ou $@
  		  lavar=$@
  			Parsemsg "${lavar:1}"
  		else
  		  Send "> $*"
  	  fi
  	  exit
  fi
  [ "$EUID" = "0" ] && printf "Merci de ne pas lancer le bot en root. Ciao.\n" &&	exit 
  ###############################################################################

  Init
  Interactiveloop
  Log "Redémarrage du bot"

  Kill "$iiloop_pid" "iiloop"
  Kill "$ncloop_pid" "ncloop"
  Kill "$rssloop_pid" "rssloop"
  Kill "$pingloop_pid" "pingloop"
  Kill "$debufloop_pid" "debufloop"

  exec "$0"
}

main $*
```
*Partout où vous voyez XXXX j'ai planqué des infos sensibles.*


PS : Merci Gof pour la correction ;-)
