+++
Author = "Lord"
Description = ""
Categories = ["golang", "code","irc"]
menu = "main"
notoc = true
WritingDate = 2021-07-15T13:03:38+02:00
date = 2021-07-15T19:03:38+02:00
title = "Reprise de GoNib mon bot IRC en Golang"
editor = "kakoune"
+++
Ouai ça fait longtemps que je vous ai pas écrit.
Une part de flemme mais aussi de pas trop savoir quoi écrire mais j'ai une autre excuse !
En ce moment je me suis beaucoup replongé dans **Gonib** mon bot IRC écrit en Golang.

Je l'ai commencé il y a deux ans avec une ptite série de poste à son propos. 
Et je n'y ai plus touché.
Il a tourné parfaitement tout ce temps.

Il y a qu'un ptit truc qui me gonflait : *les commandes sont case-sensitive et mon clavier android envoie une majuscule en début de phrase ce qui fait chier*.
Je voulais donc juste virer ça, histoire de plus me faire chier.
Et puis au final, une fois ouvert le code : aoutch.
Je ne me souvenais pas que c'était aussi long ce code source.

Et *j'ai pris plaisir à lire les sources et recomprendre ce que j'avais fait*.
Et direct j'ai eu d'autres idées d'amélioration et voilà j'étais lancé.

## debugPrint
Bon premier truc faire en sorte de pouvoir afficher différentes informations en fonction du niveau de débug.
C'est tout con mais ultra pratique et plutôt que d'avoir à manuellement enlever/foutre des **fmt.Println** de partout pourquoi ne pas se faire une ptite commande perso pour ça ?

La commande est ultra simple, elle prend une string et un int en entrée pour juste le message à afficher ainsi que le niveau de débug nécessaire pour l'afficher.
Bon au début j'ai fait le truc à l'envers puis je me suis ressaisi et maintenant plus le niveau est élevé plus j'affiche des trucs basiques.

Maintenant je suis pas sûr que le nom de la fonction soit très judicieux mais bon… c'est fait.

J'ai donc viré la quasi-totalité des **fmt.Println** qui ont été donc remplacé par des **debugPrint**.

## Des variables globales de status
J'ai ajouté quelques variables globales afin de savoir si je suis connecté ou non, est-ce que je suis sur le salon, la connexion TCP éest-elle établie ?
Quel est mon pseudo ?
Quel est mon nom complet ?
Tout ce genre de ptit truc.

Et en fonction de ce qui est reçu du serveur adapter leurs valeurs.
J'en suis cependant au stade où j'ai des souvenirs de l'école où l'on m'a répété qu'il fallait éviter les variables globales, c'est pas beau, c'est dangeureux.
Sauf que j'ai pas le souvenir du "pourquoi ?" et surtout "c'est pas bien, mais forcément pour telle utilisation c'est normale".

*Du coup je sais pas si j'en ai une utilisation légitime ou non.*

Et je me fais encore plus peur depuis que j'ai découvert que le compilo pouvait détecter comme un grand les **race-conditions** en ajoutant simplement **-race** dans la ligne d'éxécution.
Et là … bha … j'en ai.

En gros il détecte que je lis et écris une même variable depuis plusieurs fonctions/routines différentes.
Et bha oui et c'est chouette, non ?
Comment faire autrement ?
*J'ai pas trop la solution actuellement*.

Visiblement il faut passer par des channels et du coup les passer à toutes les fonctions qui en ont besoin.
Et surtout j'ai l'impression que c'est bien pour envoyer les infos dans un sens mais dans l'autre sens… j'ai l'impression que c'est moins simple.
*C'est le gros point que j'aimerai améliorer prochainement mais j'ai pas encore trouvé la doc bien à ce sujet*.

## Parser
Bon la syntaxe du protocole IRC est simple.
Donc faire un parser ça va être du gâteau, non ?

Et bhé en fait mouai.
Je m'y suis repris à trois fois afin de faire un parser à peu près solide.
Et tant qu'à faire j'ai séparé la partie parser de la partie action à réaliser.

Après avoir un peu mieux observé un peu tout ce qui provient du serveur je suis arrivé à ça :

**[@tag] :source TYPE [destination] [option] [:contenu]**

### [@tag]
En gros le **tag** est la grande nouveauté d'IRCv3 et c'est donc parfaitement optionnel.
Ça peut contenir des infos assez variées que je détaille plus loin.
Ça commence par un "@" et ça contient en vérité plusieurs tags.
Exemple : *@msgid=UXY5o0fonahKTQI3EiEL3I;time=2021-07-15T14:35:45.173Z*

### :source
La source indique qui est à l'origine d'un message.
Elle y est toujours et commence par ":" .
Ça peut être le nom du serveur s'il s'agit d'un message serveur ou bien être un utilisateur.
Exemple : *Lord!Lord@geeknode.fuckyeah*

### TYPE
Le type de message reçu.
Il y a plein de types de message, les PRIVMSG (les messages classiques), les NOTICE, les KICK, les TOPIC, bref il y a de quoi faire.
D'ailleurs à ce propos, sur IRC il n'y a pas de différence entre un message pour un salon et un message personnel, juste la destination va changer.
Dans les TYPE on retrouve également tous les numerics, qui sont des informations renvoyées par le serveur.
On trouve une liste pas mal du tout [sur cette page](https://www.alien.net.au/irc/irc2numerics.html).
Exemple : *PRIVMSG*

### [destination]
Il s'agit bha … ouai du destinataire d'un message.
C'est donc souvent un nom de salon, le nom de quelqu'un ou parfois directement le nom du serveur.
Ce champ est presque tout le temps rempli mais il existe de rares messages (biensûr quand j'écris je ne me souviens plus desquels) qui n'en ont pas.
Il faut donc prévoir le cas où c'est vide.
Exemple : *#testage*

### [option]
J'ai appelé ce champ option car bha au début je pensais que c'était le seul optionnel…
En gros ce champ complémente parfois le champ TYPE.
C'est notamment le cas pour les CAP qui ont des sous-commandes qui sont alors présentes dans ce champs.
Exemple : *LS*

### [:contenu]
Le dernier champ est le contenu.
Il commence par un ":" et contrairement à ce que je pensais n'est même pas obligatoire (source d'emmerde).
Certains NUMERICS n'ont pas de contenu (ce qui est illogique ma foi).
C'est la partie qui contient les messages à proprement écrit.
Pour les messages de TYPE "fonctionnels" ça contient souvent la raison, ou du facultatif.
Exemple : *:asv ?*

### Et du coup ?
Bha je me suis fait une ptite fonction à qui *j'envoie une string, un séparateur et qui me renvoie deux string : la partie de la string avant séparateur et la partie de la string après le séparateur*.
Si le séparateur n'est pas trouvé, ça me renvoie dans la première string toute la string d'entrée.
Étrangement je n'ai pas trouvé de fonction dans la libs **strings** qui fasse ça.

Il ne me reste plus qu'à appeler cette fonction plusieurs fois afin d'extraire chaque morceau de ma ligne.
Au final le parser ne fait plus que dix lignes et semble s'accomoder de tout ce que lui envoie le serveur.

Le parser créer ensuite une **struct ParsedMessage** qui contient toutes les strings des différents morceaux.
Cette struct est envoyée à la fonction **processMessage** qui s'occupera de traiter tout ça :-)

J'en suis plutôt content parcequ'au bout de quatre versions j'ai le sentiment d'être parvenu au résultat nickel.

<details><summary>Je ne résiste pas au plaisir de vous montrer cette partie</summary>
{{< highlight "golang" >}}
if msg[:1] == "@" { msg , message_tag = extractUntil(msg," ") }
if msg[:1] == ":" {
    msg , message_source = extractUntil(msg," ")
    message_source = message_source[1:]
}
msg , message_type = extractUntil(msg," ")
if msg[:1] != ":" { msg , message_destination = extractUntil(msg," ") }
if msg[:1] != ":" { msg , message_option = extractUntil(msg," :") }
if msg[:1] == ":" { message_content = strings.TrimSuffix(msg[1:]," ") }

return ParsedMessage{msg_tag: message_tag, msg_source: message_source, msg_type: message_type, msg_destination: message_destination, msg_content: message_content, msg_option: message_option}
{{< / highlight>}}
</details>

## Go fmt
Ouai je l'avais pas fait avant.
Mais maintenant c'est bon, j'essaye d'y penser régulièrement.

Cette commande permet de s'occuper du formattage des fichiers sources.
Ça met les bons espace, ça indente tout comme il faut… bref c'est cool.

Je me retrouvais avec des fichiers avec des tabs et des espaces vu que les éditeurs de texte s'évertuent à ajouter l'un ou l'autre par défaut ou à ne pas afficher l'indentation présente mais la leur.
Bref, en faisant un **cat** sur le fichier c'était le gros bordel.

Hop *maintenant c'est propre et cohérent*.

## Module Détection de SHUN
Sur IRC, les ircop (ceux qui gèrent le serveur) ont une commande géniale qui permet de faire en sorte d'ignorer tout ce qu'envoie un client sauf les PING/PONG.
*Ça a pour effet d'isoler un relou qui emmerde tout le monde*.
Il ne se rend pas compte que ce qu'il envoie ne parvient pas aux autres personnes.

J'ai donc ajouté un ptit moyen de détecter ça sur mon bot au cas où…
Bon en vrai c'était juste pour voir la faisabilité.
Moralité : c'est ultra simple.

*Il suffit de s'envoyer régulièrement un message à soi-même et de vérifier qu'on le reçoit.*
Voilà j'ai mis ça en place à côté de la détection de ping timeout.

## Module quizz
L'été est là et ce sont des vacances pour pas mal de monde.
Qui n'aime pas un ptit quizz entre amis ?

*À une époque IRC débordait de ces bots de jeux et je suis triste de ne plus en avoir.*
Donc j'ai fait le mien \o/

Le principe est super simple :
Un fichier CSV avec sur chaque ligne la réponse, la question, un indice, un second indice.

Lorsque quelqu'un demande un quizz, on choppe une ligne aléatoire du fichier et on pose la question, on démarre un timer.
Tous les messages qui arrivent pendant le timer sont testées pour voir si ça correspond à la réponse.
Au bout d'un premier timer on balance un indice, puis au second timer, un deuxième indice puis au troisième c'est perdu.
Bien entendu une bonne réponse met fin à tout.

En cas de bonne réponse, on lit le fichier de score, on cherche si une ligne commence par le pseudo si c'est le cas incrémente l'int des points, si c'est pas le cas on rajoute une ligne.
Voilà c'est tout bête.

J'ai pas envie de me faire chier avec l'affichage des points pour le moment et encore moins pour le tri.
Pas envie de faire d'algo, si vraiment je m'y attèle ça sera hors du bot via une filouterie à base de commandes shell :-°

## Module TODO
Bon, mon module TODO avait un ptit bug foireux.
Il m'ajoutait parfois des lignes vides (et donc des todo vides).

J'ai donc jeté et refait de 0 la gestion de fichier.
Et c'est bon ça marche.

*En gros je lis la todo en entier et je la fous en mémoire.
Je fais les modifs dans la mémoire et je réécris intégralement le fichier.*

C'est pas optimisé mais franchement vu la taille de la todo, ça ira largement.
Ce bug traînait depuis deux ans et je ne comprenais pas comment il pouvait se produire et en bossant sur le module de quizz j'ai eu le même truc et j'ai compris ma connerie.
Comme quoi *si vous avez un souci sur bug, faites deux ans de pause et pouf vous aurez l'illumination directe*.

## Support IRCv3

*Quitte à faire un bot IRC en 2021, autant qu'il soit compatible avec une partie des specs de IRCv3.*
Ces specs ajoutent pas mal de trucs plus ou moins utiles.

Un gros morceau sont donc les **message-tags**.

Faut bien voir qu'*IRCv3 reste pleinement compatible* avec le protocole d'antan.
Il faut donc que les deux versions du protocole puissent coexister.
Ce qui a été décidé est assez simple c'est lors de la connexion, un client en IRCv3 peut négocier des **CAPS** qui vont activer ou non certaines extensions du protocole.

Comme ça un client non compatible reste comme d'hab alors qu'un nouveau aura droit à quelques variations dans le protocole.

### message-tags
Une grande partie de ces extensions utilisent donc les **tags** qui sont un morceau de texte que l'on retrouve en début de ligne avec donc différentes infos supplémentaires.
Ça peut être juste l'**horodatage** des messages (ouai initialement, les messages ne le sont pas, c'est au client de le faire de son côté ce qui fait que selon l'horloge des clients un même message peut être affiché comme étant arrivé à une heure complètement différente).
On a également des **id** permettant d'avoir un identifiant unique sur un message (pratique si on le combine à d'autres extensions comme par exemple des réactions).
Il est possible d'y ajouter des tags custom par les clients ce qui peut amener à plein de ptites joyeusetés complémentaires (certains clients envisagent d'envoyer une url vers une image pour servir d'avatar).
Dans les tags on retrouve également de la notification de personne en train d'écrire.
Bref tout un tas de trucs divers et variés.

*Dans mon cas pour l'instant j'ai juste fait en sorte que le parser puisse recevoir ces tags sans planter ce qui est déjà pas mal à mon niveau.**

### Négociation des CAPS
Pour activer ces nouveautés, il faut les demander au serveur lors de la phase de connexion.
J'en demande un paquet et je stock le résultat dans une map de booléen.
Ça me permet d'avoir un tableau avec tout ça.

*J'ai découvert la joie des mutex afin de pouvoir remplir ce tableau en écriture et le consulter en lecture sans causer de souci.*
Bon j'ai rien fait de bien poussé, juste suffisamment pour que ça m'explose plus à la gueule.

Au début ça fonctionnait sans rien faire avec le niveau de débug max, mais lorsque je l'ai baissé, le programme tournant un chouilla plus vite, j'ai eu de la lecture en même temps que de l'écriture ce qui m'a planté le truc.

Par chance le message d'erreur est plutôt explicite avec le numéro de ligne et tout qui va bien.
Un coup de moteur de recherche plus tard et hop j'avais une solution à appliquer.

### extended-join
Une CAP en particulier est l'**extended-join** qui permet d'avoir quelques infos en plus quand quelqu'un rejoint un salon.
Le souci c'est que du coup la syntaxe de la commande JOIN est quelque peu chamboulée (trois fois rien, hein) du coup j'ai rajouté une condition en fonction du tableau précédent afin de savoir si la CAP est activée ou non et en fonction de ça processer différemment le JOIN.

C'est mon premier cas où il a fallu que j'adapte mon process en fonction des CAPS.
Je suis content que ça fonctionne comme sur des roulettes.
Je suis cependant juste un peu déçu quant à la syntaxe : je n'ai pas réussi à récupérer la valeur pour l'utiliser directement dans le if, j'ai été obligé de récupérer la valeur dans une variable qui est ensuite utilisé dans le if…

Un peu dommage.

----------
Bon bha voilà, j'ai encore pas mal de trucs à faire dessus.
Le bot culmine à 750 lignes de codes (bon avec des commentaires et des lignes vides, hein).

*J'aimerai vraiment m'atteler au souci de race-conditions et mieux comprendre la bonne façon de gérer des variables globales* (qui ne devraient probablement pas être globales).
Voilà voilà.

<details><summary>gonib.go</summary>
{{< highlight go "linenos=inline" >}}
package main

import (
	"bufio"
	"flag"
	"fmt"
	"io"
	"io/ioutil"
	"math/rand"
	"net"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

var bleu string = "\033[1;34m"
var rouge string = "\033[1;31m"
var vert string = "\033[1;32m"
var jaune string = "\033[1;33m"
var violet string = "\033[1;35m"
var cyan string = "\033[1;36m"
var normal string = "\033[0m"
var dim string = "\033[2m"
var me string
var server string
var port string
var nick string
var wanted_nick string
var channel string
var lport string
var debug int = 0
var todofile string = "/home/nib/todo"
var datelayout string = "02/01/06"
var tdatelayout string = "02/01/06 - 15:03:05"
var onchan bool = false
var connected bool = false
var cap_messagetags int = 0 //sert comme booléen mais permet de shifter le parsing
var quizz_on bool = false
var quizz_reponse chan ParsedMessage
var enabled_caps = make(map[string]bool)
var enabled_caps_mutex = sync.RWMutex{}

var sender chan Message
var rawsender chan string
var AliveLoop chan bool
var pong chan bool

type Ircconnection struct {
	Server   string
	Port     string
	Timeouts int
	Conn     net.Conn
	Receiver chan string
	//	Pong              chan bool
	counter           int
	Struct            chan Message
	StopHandleCounter chan bool
	StopInteract      chan bool
}

type ParsedMessage struct {
	msg_tag         string
	msg_source      string
	msg_type        string
	msg_destination string
	msg_content     string
	msg_option      string
}
type Message struct {
	msg   string
	dest  string
	level int // le Level correspond à l'importance du message. 10 ce sont les messages normaux. En dessous ça sera plus du debug (par exemple les Pings), en fonction de la couleur on peut décider de ne pas afficher, ou d'afficher avec une certaine couleur
}

func (connection *Ircconnection) Connect() {
	var TcpConnected bool = false
	for !TcpConnected {
		var err error
		connection.Conn, err = net.Dial("tcp", server+":"+port)
		fmt.Println(rouge + "Connection to " + server + ":" + port + normal)
		if err != nil {
			fmt.Println(err)
			time.Sleep(time.Duration(connection.Timeouts) * time.Second)
		} else {
			TcpConnected = true
		}
	}
	connection.Receiver = make(chan string)
	connection.Struct = make(chan Message)
	connection.StopHandleCounter = make(chan bool)
	connection.StopInteract = make(chan bool)
	connection.Timeouts = 0
	counter_updater := make(chan bool)
	go io.Copy(connection.Conn, os.Stdin)
	go connection.handleIncoming()
	go connection.handleCounter(counter_updater)
	go connection.Interact(counter_updater)
	rawsender <- "CAP LS 302"
	rawsender <- "NICK " + wanted_nick
	rawsender <- "USER " + wanted_nick + " 0.0.0.0 " + wanted_nick + " :" + wanted_nick + " bot"
	rawsender <- "CAP REQ :message-tags"
	rawsender <- "CAP REQ :batch"
	rawsender <- "CAP REQ :extended-join"
	rawsender <- "CAP REQ :chghost"
	rawsender <- "CAP REQ :cap-notify"
	rawsender <- "CAP REQ :userhost-in-names"
	rawsender <- "CAP REQ :multi-prefix"
	rawsender <- "CAP REQ :away-notify"
	rawsender <- "CAP REQ :account-notify"
	rawsender <- "CAP REQ :server-time"
	rawsender <- "CAP REQ :echo-message"
	rawsender <- "CAP REQ :labeled-response"
	rawsender <- "CAP END"

	for !connected {
		time.Sleep(200 * time.Millisecond)
	}
	rawsender <- "JOIN :" + channel
	go connection.StatusCheck()
}
func (connection *Ircconnection) Disconnect() {
	onchan = false
	connected = false
	cap_messagetags = 0
	defer debugPrint("Fermeture Disconnect()", 0)
	fmt.Println(vert + "On coupe" + rouge + " la connexion !" + normal)
	connection.StopHandleCounter <- true
	connection.StopInteract <- true
	connection.Conn.Close()
	go connection.Connect()
}
func NewIrcconnection() Ircconnection {
	return Ircconnection{Server: server, Port: port, Timeouts: 5}
}
func (connection *Ircconnection) handleIncoming() {
	defer debugPrint("Fermeture connection.handleIncoming()", 0)
	scanner := bufio.NewScanner(connection.Conn)
	for scanner.Scan() {
		ln := scanner.Text()
		connection.Receiver <- ln
	}
}

func (connection *Ircconnection) Interact(counter_updater chan bool) {
	defer debugPrint("Fermeture connection.Interact()", 0)
	for {
		select {
		case writer := <-sender:
			if connection.counter < 5000 {
				counter_updater <- true
			}
			fmt.Println("\t"+jaune+">>> PRIVMSG "+normal+writer.dest+" :"+writer.msg+" //"+jaune+"[", connection.counter, "]"+normal)
			io.WriteString(connection.Conn, "PRIVMSG "+writer.dest+" :"+writer.msg+"\n")
			time.Sleep(time.Duration(connection.counter) * time.Millisecond)
		case rawwriter := <-rawsender:
			if connection.counter < 5000 {
				//counter_updater <- true
			}
			if debug > 0 {
				fmt.Println("\t"+rouge+">>> "+normal+rawwriter+" //"+jaune+"[", connection.counter, "]"+normal)
			}
			io.WriteString(connection.Conn, rawwriter+"\n")
			time.Sleep(time.Duration(connection.counter) * time.Millisecond)
		case reader := <-connection.Receiver:
			parsedMessage := parseIrc(connection, reader)
			go processMessage(parsedMessage)
		case <-connection.StopInteract:
			return

		}
	}
}

func (connection *Ircconnection) StatusCheck() {
	defer connection.Disconnect()
	defer debugPrint("Fermeture connection.StatusCheck()", 0)
	var ShunTimeouts int = 0
	for {
		time.Sleep(60 * time.Second)
		// Vérif de la disponibilité du pseudo
		if nick != wanted_nick {
			debugPrint("Pseudo "+nick+" différent de "+wanted_nick, 2)
			rawsender <- "NICK " + wanted_nick
		}
		// Vérif de la connexion au salon désiré
		if !onchan {
			rawsender <- "JOIN " + channel
		}
		// Vérif du PING du serveur
		debugPrint("\t"+jaune+"CHECK: "+bleu+"PING "+normal+me, 2)
		rawsender <- "PING " + me
		select {
		case <-pong:
			connection.Timeouts = 0
			//time.Sleep(10 * time.Second)
		case <-time.After(2 * time.Second):
			connection.Timeouts++
			fmt.Println(rouge+"Timeout ", connection.Timeouts)
			if connection.Timeouts > 5 {
				fmt.Println(rouge + "Ping Timeout du serveur !" + normal)
				return
				connection.Disconnect()
			}
		}
		// Vérif shun
		debugPrint("\t"+jaune+"CHECK: "+bleu+"PRIVMSG "+normal+nick+":AUTOCHECK", 2)
		sender <- Message{msg: "AUTOCHECK", dest: nick, level: 12}
		select {
		case <-AliveLoop:
			ShunTimeouts = 0
		case <-time.After(2 * time.Second):
			ShunTimeouts++
			fmt.Println(rouge+"ShunTimeout ", ShunTimeouts)
			if ShunTimeouts > 2 {
				fmt.Println(rouge + "Shun Timeout du serveur !" + normal)
				connection.Disconnect()
				return
			}
		}
	}
}

// Futur système anti-flood. tout pourri pour le moment.
func (connection *Ircconnection) handleCounter(counter_updater <-chan bool) {
	defer debugPrint("Fermeture de connection.handleCounter()", 0)
	for {
		select {
		case <-connection.StopHandleCounter:
			return
		case <-counter_updater:
			connection.counter = connection.counter + 100
		default:
			time.Sleep(time.Duration(connection.counter+500) * time.Millisecond)
			if connection.counter > 0 {
				connection.counter -= 50
			} else {
				connection.counter = 0
			}
		}
	}
}

/////////////////// MAIN //////////////////////////////////////
func main() {
	sender = make(chan Message, 3)
	rawsender = make(chan string)
	AliveLoop = make(chan bool)
	pong = make(chan bool)
	quizz_reponse = make(chan ParsedMessage)

	flag.StringVar(&server, "server", "localhost", "Server hostname to connect to")
	flag.StringVar(&port, "port", "6667", "Which port to connect to")
	flag.StringVar(&wanted_nick, "nick", "bab", "Which nickname you want to use")
	flag.StringVar(&channel, "channel", "#lms", "Which channel to join")
	flag.StringVar(&lport, "lport", "4321", "Which port to listen incoming connections")
	flag.IntVar(&debug, "debug", 0, "Enable debug messages")
	flag.Parse()

	connection := NewIrcconnection()
	connection.Connect()

	in, err := net.Listen("tcp", ":"+lport)
	check(err)
	defer in.Close()

	for {
		inconn, err := in.Accept()
		if err != nil {
			fmt.Println(err)
			continue
		}
		go handleIncoming(inconn, connection)
	}

}

// ------------------
// Côté IRC
// ------------------

func parseIrc(connection *Ircconnection, msg string) ParsedMessage {
	debugPrint("\t\t"+cyan+"<< "+normal+msg, 3)

	var message_tag string = ""
	var message_source string = ""
	var message_type string = ""
	var message_destination string = ""
	var message_option string = ""
	var message_content string = ""
	// PARSER 3
	if msg[:1] == "@" {
		msg, message_tag = extractUntil(msg, " ")
	}
	if msg[:1] == ":" {
		msg, message_source = extractUntil(msg, " ")
		message_source = message_source[1:]
	}
	msg, message_type = extractUntil(msg, " ")
	if msg[:1] != ":" {
		msg, message_destination = extractUntil(msg, " ")
	}
	if msg[:1] != ":" {
		msg, message_option = extractUntil(msg, " :")
	}
	if msg[:1] == ":" {
		message_content = strings.TrimSuffix(msg[1:], " ")
	}

	//fmt.Println("tag ["+bleu+message_tag+normal+"] src ["+bleu+ message_source+normal+"] type ["+bleu+ message_type+normal+"] dst ["+bleu+ message_destination+normal+"] option ["+bleu+ message_option+normal+"] content ["+bleu+ message_content+normal+"]")
	return ParsedMessage{msg_tag: message_tag, msg_source: message_source, msg_type: message_type, msg_destination: message_destination, msg_content: message_content, msg_option: message_option}

}

func processMessage(parsedMessage ParsedMessage) {
	debugPrint(violet+"Message_tag ["+normal+parsedMessage.msg_tag+violet+"] source ["+normal+parsedMessage.msg_source+violet+"] type ["+normal+parsedMessage.msg_type+violet+"] destination ["+normal+parsedMessage.msg_destination+violet+"] option ["+normal+parsedMessage.msg_option+violet+"] content ["+normal+parsedMessage.msg_content+violet+"]"+normal, 5)

	if parsedMessage.msg_type == "PING" {
		rawsender <- "PONG :" + parsedMessage.msg_content
		return
	}
	switch parsedMessage.msg_type {
	case "CAP":
		if parsedMessage.msg_option == "ACK" {
			enabled_caps_mutex.Lock()
			enabled_caps[parsedMessage.msg_content] = true
			enabled_caps_mutex.Unlock()
		}
		return

	case "001":
		connected = true
		nick = parsedMessage.msg_destination
		me = parsedMessage.msg_content[strings.LastIndex(parsedMessage.msg_content, " ")+1:]
		return
	case "NOTICE":
		// Auto Invite on Knock
		if parsedMessage.msg_content == ":[Knock]" {
			//io.WriteString(connection.Conn, "invite "+elements[5][0:strings.IndexAny(elements[5], "!")]+" "+channel+"\n")
		}
		return
	case "JOIN":
		// @msgid=sBqscFhVMaV9uQMOxJsAcb-uxRnr6kSWCSBVDMvd22ufA;time=2021-07-13T23:07:17.218Z :gonib!gonib@2a01:cb1d:8c37:7f00:7285:c2ff:fe62:b714 JOIN #testage * :gonib bot
		// @msgid=B7Bk1vWoztQeTBWRQZeyAU-uxRnr6kSWCSBVDMvd22ufA;time=2021-07-13T23:09:06.420Z :gonib!gonib@2a01:cb1d:8c37:7f00:7285:c2ff:fe62:b714 JOIN :#testage
		var new_chan string
		enabled_caps_mutex.RLock()
		extended_join := enabled_caps["extended-join"]
		enabled_caps_mutex.RUnlock()
		if extended_join {
			new_chan = parsedMessage.msg_destination
		} else {
			new_chan = parsedMessage.msg_content
		}
		if Nick(parsedMessage.msg_source) == nick {
			debugPrint("On join "+new_chan, 0)
			sender <- Message{msg: "Bonjour " + new_chan + " :-)", dest: new_chan, level: 10}
		} else {
			sender <- Message{msg: "Bienvenue " + Nick(parsedMessage.msg_source), dest: new_chan, level: 10}
		}
		return
	case "PONG":
		pong <- true
		//FIXME !! connection.Pong <- true
	case "PART":
		if Nick(parsedMessage.msg_source) == nick && parsedMessage.msg_content == channel {
			onchan = false
			debugPrint(rouge+"On vient de quitter "+channel+normal, 0)
		}
		return
	case "MODE":
		return
	case "TOPIC":
		return
	case "NICK":
		if parsedMessage.msg_source == nick {
			nick = parsedMessage.msg_content
		}
		return
	case "KICK":
		if parsedMessage.msg_content == nick {
			debugPrint(rouge+"On s'est fait kicker de "+parsedMessage.msg_destination+" par "+parsedMessage.msg_source+normal, 0)
			onchan = false
		}
		return
	case "QUIT":
		if Nick(parsedMessage.msg_source) == nick {
			debugPrint(rouge+"On vient de se déconnecter"+normal, 0)
			onchan = false
			connected = false
		}
		return
	case "ERROR":
		debugPrint(rouge+parsedMessage.msg_content+normal, 0)
		connected = false
		onchan = false
		return
	case "319":
		if !strings.Contains(parsedMessage.msg_content, channel) {
			onchan = false
			debugPrint(rouge+"On n'est pas connecté au salon"+normal, 0)
		} else {
			onchan = true
		}
		return
	case "433":
		if !connected { //pseudo déjà utilisé au moment de la connexion
			debugPrint(rouge+"PSEUDO OCCUPÉ LORS DE LA CONNEXION"+normal+" on passe à "+wanted_nick+"_", 0)
			rawsender <- "NICK " + wanted_nick + "_"
			//io.WriteString(connection.Conn, "NICK "+wanted_nick+"_ \n")
		} else {
			fmt.Println(vert + "le pseudo " + parsedMessage.msg_content + " est déjà utilisé, on reste sur " + nick + normal)
		}
		return
	case "PRIVMSG":
		if parsedMessage.msg_source == me && parsedMessage.msg_destination == nick && parsedMessage.msg_content == "AUTOCHECK" {
			AliveLoop <- true
			return
		}
		fmt.Println("\t\t" + bleu + "<< " + normal + parsedMessage.msg_destination + " " + Nick(parsedMessage.msg_source) + " |" + parsedMessage.msg_content)

		if quizz_on {
			quizz_reponse <- ParsedMessage{msg_source: parsedMessage.msg_source, msg_content: parsedMessage.msg_content, msg_type: parsedMessage.msg_type, msg_tag: ""}
		}

		if parsedMessage.msg_content == "quizz" {
			if quizz_on {
				return
			}
			quizz_on = true
			go quizz()
		}
		if len(parsedMessage.msg_content) > 1 {
			var elements []string = strings.Fields(parsedMessage.msg_content)
			switch elements[0] {
			case "dig":
				if len(elements) > 1 {
					ip, err := net.LookupIP(elements[1])
					if err != nil {
						sender <- Message{msg: "Erreur de résolution DNS.", dest: parsedMessage.msg_destination, level: 11}
						return
					}
					for i := 0; i < len(ip); i++ {
						sender <- Message{msg: ip[i].String(), dest: parsedMessage.msg_destination, level: 10}
					}
				} else {
					sender <- Message{msg: "Il faut un argument supplémentaire", dest: parsedMessage.msg_destination, level: 10}
				}
				return
			case "up":
				if len(elements) > 2 {
					_, err := net.Dial("tcp", elements[1]+":"+elements[2])
					if err != nil {
						sender <- Message{msg: elements[1] + ":" + elements[2] + " est non joignable", dest: parsedMessage.msg_destination, level: 10}
					} else {
						sender <- Message{msg: elements[1] + ":" + elements[2] + " : OK", dest: parsedMessage.msg_destination, level: 10}
					}
				} else {
					sender <- Message{msg: "Syntaxe : up nom port", dest: parsedMessage.msg_destination, level: 10}
				}
				return
			}
		}
		return
	default:
		//debugPrint(rouge+"PAS COMPRIS : "+parsedMessage.msg_content+normal)
		return
	}
}

func aReimplementer(connection *Ircconnection, msg string, elements []string) {
	if len(elements) > 3 {
		switch elements[3] {
		case ":heure":
			sender <- Message{msg: "Paies-toi une montre vaut rien!", dest: channel, level: 5}
		case ":todo":
			if len(elements) <= 4 {
				todoList()
			} else {
				switch elements[4] {
				case "add":
					item := ""
					for i := 5; i < len(elements); i++ {
						item = item + elements[i] + " "
					}
					todoAdd(item)
					sender <- Message{msg: "Ajout à la todo", dest: channel, level: 10}
				case "del":
					item, err := strconv.ParseInt(elements[5], 10, 32)
					if err != nil {
						sender <- Message{msg: err.Error(), dest: channel, level: 11}
					}
					todoDel(int(item) - 1)
					sender <- Message{msg: "Suppression de l'item", dest: channel, level: 10}
				}
			}
		case ":plot", ":Plot":
			if len(elements) == 8 {
				plotArgs := elements[4] + " " + elements[5] + " " + elements[6] + " " + elements[7]
				plotAdd(plotArgs)
			} else {
				sender <- Message{msg: "conso gaz elec eau", dest: channel, level: 10}
				sender <- Message{msg: "poids peupeu bab lord", dest: channel, level: 10}
			}
		}
	}
}

// -----------------
// Commandes du bot
// -----------------

func todoList() {
	file, err := os.Open(todofile)
	if err != nil {
		file, e := os.Create(todofile)
		if e != nil {
			sender <- Message{msg: e.Error(), dest: channel, level: 11}
		}
		defer file.Close()
	}
	defer file.Close()
	scanner := bufio.NewScanner(file)
	var index int = 0
	for scanner.Scan() {
		index++
		sender <- Message{msg: strconv.Itoa(index) + ": " + scanner.Text(), dest: channel, level: 10}
	}

}

func todoAdd(item string) {
	file, err := os.OpenFile(todofile, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		sender <- Message{msg: err.Error(), dest: channel, level: 12}
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	defer writer.Flush()
	sender <- Message{msg: "Ajout : " + item, dest: channel, level: 10}
	now := time.Now().Format(datelayout)
	fmt.Fprint(file, now, " ", item, "\n")
}

func todoDel(item int) {
	input, err := ioutil.ReadFile(todofile)
	if err != nil {
		sender <- Message{msg: err.Error(), dest: channel, level: 11}
	}
	lines := strings.Split(string(input), "\n")
	linesout := make([]string, 0)
	for i, todo := range lines {
		if i != item && string(todo) != "" {
			linesout = append(linesout, todo)
		}
	}
	output := strings.Join(linesout, "\n")
	err = ioutil.WriteFile(todofile, []byte(output), 0644)
	if err != nil {
		sender <- Message{msg: err.Error(), dest: channel, level: 11}
	}
}

func plotAdd(incoming string) {
	var args []string = strings.Fields(incoming)
	if args[0] != "conso" && args[0] != "poids" {
		sender <- Message{msg: "Seul 'poids' ou 'conso' sont acceptés", dest: channel, level: 12}
		return
	}
	var filePath string = "/var/www/lord.re/graph/" + args[0] + ".csv"
	fmt.Println("le fichier est " + filePath)
	file, err := os.OpenFile(filePath, os.O_APPEND|os.O_CREATE|os.O_WRONLY, 0644)
	if err != nil {
		sender <- Message{msg: err.Error(), dest: channel, level: 12}
	}
	defer file.Close()
	writer := bufio.NewWriter(file)
	defer writer.Flush()
	now := time.Now().Format(datelayout)
	fmt.Fprint(file, now, ",", args[1], ",", args[2], ",", args[3], "\n")
	sender <- Message{msg: "C'est plotté ! https://lord.re/graph", dest: channel, level: 10}
}

func quizz() {
	defer func() {
		sender <- Message{msg: "C'est fini pour cette passionnante partie de quizz. À une prochaine ;-)", dest: channel, level: 10}
		quizz_on = false
	}()
	sender <- Message{msg: "C'est parti !", dest: channel, level: 10}
	var max_indice int = 3
	var nbr_indice int = 0

	bonne_reponse, question, indice1, indice2 := randomQuizz()
	sender <- Message{msg: question, dest: channel, level: 10}
	for {
		select {
		case reponse := <-quizz_reponse:
			debugPrint("Quizz réponse : "+reponse.msg_content+" | emetteur :"+reponse.msg_source, 5)
			if reponse.msg_content == bonne_reponse {
				sender <- Message{msg: "C'est gagné " + Nick(reponse.msg_source), dest: channel, level: 10}
				quizzUpScore(Nick(reponse.msg_source))
				return
			}
		case <-time.After(30 * time.Second):
			nbr_indice++
			debugPrint("Nbr_indice : "+strconv.Itoa(nbr_indice), 5)
			if nbr_indice == 1 {
				sender <- Message{msg: "Indice 1 : " + indice1, dest: channel, level: 10}
			}
			if nbr_indice == 2 {
				sender <- Message{msg: "Indice 2 : " + indice2, dest: channel, level: 10}
			}
			if nbr_indice > max_indice {
				debugPrint("C'est perdu", 4)
				sender <- Message{msg: "Et c'est perdu :-( Nous ne saurons jamais la réponse !", dest: channel, level: 10}
				return
			}
		}
	}
}

// ------------------
// Serveur en écoute
// ------------------

func incoming(connection Ircconnection) {
	in, err := net.Listen("tcp", ":4321")
	defer in.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for {
		inconn, err := in.Accept()
		if err != nil {
			fmt.Println(err)
			continue
		}
		go handleIncoming(inconn, connection)
	}
}

func handleIncoming(in net.Conn, connection Ircconnection) {
	defer func() {
		fmt.Println(bleu+"Déconnexion de ", in.RemoteAddr(), normal)
		in.Close()
		recover()
	}()
	fmt.Println(bleu+"Incoming from ", in.RemoteAddr(), normal)
	inbuf := bufio.NewReader(in)
	for {
		inmsg, err := inbuf.ReadString('\n')
		if err != nil || inmsg == "\n" {
			break
		}
		fmt.Print(vert + "<<]] " + inmsg + normal)
		//   		connection.SendMsg(inmsg,3)
		sender <- Message{msg: inmsg, dest: channel, level: 10}
		time.Sleep(500 * time.Millisecond)
	}
}

// ------------
//  Génériques
// ------------

func debugPrint(msg string, level int) {
	if debug >= level {
		fmt.Println(cyan + msg + normal)
	}
}
func quizzUpScore(gagnant string) {
	debugPrint("Entrée dans quizzUpScore pour "+gagnant, 4)

	scoreData, err := ioutil.ReadFile("quizz_score.txt")
	check(err)
	scorelines := strings.Split(string(scoreData), "\n")
	var nouveau_gagnant bool = true
	for i, line := range scorelines {
		if strings.Contains(line, gagnant+",") {
			nouveau_gagnant = false
			linedata := strings.Split(line, ",")
			new_score, _ := strconv.Atoi(linedata[1])
			new_score++
			scorelines[i] = linedata[0] + "," + strconv.Itoa(new_score)
			debugPrint("joueur :"+linedata[0]+" ancien score :"+linedata[1]+" nouveau score : "+strconv.Itoa(new_score), 4)
		}
	}
	if nouveau_gagnant {
		//au lieu d'append on édite la dernière ligne qui par défaut ne contient qu'un retour à la ligne. Ça évite les lignes vides qui se rajoutent.
		scorelines[len(scorelines)-1] = gagnant + ",1\n"
	}
	newScoreData := strings.Join(scorelines, "\n")
	err = ioutil.WriteFile("quizz_score.txt", []byte(newScoreData), 0644)
	check(err)
}
func randomQuizz() (string, string, string, string) {
	debugPrint("Entrée dans randomQuizz()", 4)
	file, err := os.Open("quizz.txt")
	check(err)
	defer file.Close()
	var quizzAssets []string
	var nbr_line int = 0
	scanner := bufio.NewScanner(file)
	for scanner.Scan() {
		quizzAssets = append(quizzAssets, scanner.Text())
		nbr_line++
	}
	random_seed := rand.NewSource(time.Now().UnixNano())
	random_source := rand.New(random_seed)
	var retourQuizz []string = strings.Split(quizzAssets[random_source.Intn(nbr_line)], ",")
	debugPrint(retourQuizz[0]+retourQuizz[1]+retourQuizz[2]+retourQuizz[3], 4)
	return retourQuizz[0], retourQuizz[1], retourQuizz[2], retourQuizz[3]

}

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func Nick(utilisateur_complet string) string {
	var nick_extrait string = utilisateur_complet[0:strings.IndexAny(utilisateur_complet, "!")]
	return nick_extrait
}

func extractUntil(input string, pattern string) (string, string) {
	var output1 string
	var output2 string
	if strings.Contains(input, pattern) {
		output2 = strings.TrimPrefix(input[:strings.Index(input, pattern)], " ")
		output1 = strings.TrimPrefix(strings.TrimPrefix(input, output2), " ")
		//		fmt.Println(violet+"[input:"+normal+input+violet+"] [output1:"+normal+output1+violet+"] [output2:"+normal+output2+violet+"]"+normal)
		return output1, output2
	} else {
		//		fmt.Println(violet+"[input:"+normal+input+violet+"] [output1:"+normal+input+violet+"] [output2:"+normal+""+violet+"]"+normal)
		return input, ""

	}
}

{{< / highlight>}}
</detail> 

