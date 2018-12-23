+++
Author = "Lord"
Description = "Spoiler : samedi, j'ai pas touché au code. J'étais démotivé car coincé. Dans la nuite de samedi à dimanche, j'ai entrevue la solution. Je l'ai testé et Paf ça roule. J'aime beaucoup cette boucle de challenge/cogitation/coincé/dodo/solution. C'est la fin de la semaine mais je vais prolonger."
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-23T16:23:01+01:00
date = 2018-12-23T16:23:01+01:00
title = "Une semaine pour coder par soi même : Jour 6 et 7"
editor = "kakoune"
+++
Bon aujourd'hui je groupe le week-end dans un seul post.
Hier ?
J'ai … rien fait.

Voilà.
Aujourd'hui ?
J'ai … débloqué le tout petit truc qui me coinçait.

Bref je pense avoir surpassé tous les ptits trucs qui me faisaient chier et maintenant j'ai un code que je comprends de partout et qui marche comme je l'intuitais.
Je suis super content.

En fait, le truc qui m'a complètement paralysé dans ma fonction <samp>connection.Interact()</samp> était tout bête : j'arrivais à récupérer le texte et donc à l'afficher, mais étrangement je ne parvenais pas à réagir à ce texte reçu.
Du coup lorsque je recevais un *PING*, je le voyais, je créais le *PONG* qui va bien, mais il partait pas.
Et j'ai buté sur ça depuis vendredi soir.

Et encore une fois cette nuit, l'**illumination** !
Dans ma fonction <samp>connection.Interact()</samp>, lorsque je recevais le *PING*, j'étais dans le <samp>case reader</samp> en train d'éxecuter la commande <samp>parseIrc</samp>, mais du coup, je n'étais plus en mesure d'écouter le <samp>chan</samp> entrant.
Bon c'est dur à expliquer mais, le truc pour débloquer ça, a été tout simplement de foutre le <samp>parseIrc</samp> dans une routine en parallèle, comme ça, pendant que ça fait son boulot, la boucle se termine et elle est de nouveau disponible en écoute.

Voilà Samedi je n'y ai pas touché à cause de ça (bon j'ai été assez pris à côté faut dire, mais du coup je n'ai pas été très motivé).
Une fois ce verrou enlevé j'ai eu envie de me refaire chier à faire des trucs tordus.

J'ai donc commencé un *système antiflood*, pour ralentir le texte sortant afin de ne pas se faire jarter comme un pleutre lorsqu'on balance trop de texte d'un coup.
J'utilise donc une variable que j'incrémente à chaque fois que j'envoie du texte et qui se décrémente petit à petit chaque seconde.
Bon j'ai pas encore fait tourner le truc comme il faut mais c'est une première étape.

Avant de rajouter des commandes à proprement parlé au bot, j'ai envie de gérer le texte sortant comme une **FIFO** et donc gérer ça avec un fichier comme j'ai fait dans le bot en bash.
Je vais donc m'attarder à regarder un peu la doc de Go pour voir comment gérer les fichiers mais ça ne devrait pas être bien compliqué.

Bon et même si à la base je ne voulais que dédier une semaine à ce projet, il est suffisamment avancé pour que je le finisse maintenant.
Vais pouvoir foutre au rencard mon Frankenscript et remplacer par ce ptit programme.


## Le code

{{< highlight golang "linenos=table" >}}
package main

import (
	"bufio"
	"fmt"
	"io"
	"net"
	"os"
	"strings"
	"time"
)

var server string = "localhost"
var port string = "6667"
var channel string = "#lms"
var nick string = "bab"
var onchan bool
var rouge string = "\033[1;31m"
var vert string = "\033[1;32m"
var jaune string = "\033[1;33m"
var cyan string = "\033[1;36m"
var normal string = "\033[0m"
var me string
var debug bool = false

type Ircconnection struct {
	Server   string
	Port     string
	Nick     string
	Channel  string
	Bidule   bool
	Conn     net.Conn
	Receiver chan string
	Emitter  chan string
	RawEmitter	chan string
	counter	 int
}

func (connection *Ircconnection) Connect() {
	var err error
	connection.Conn, err = net.Dial("tcp", server+":"+port)
//	defer connection.Conn.Close()
	fmt.Println(rouge + "Connection to " + server + ":" + port + normal)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	connection.Receiver = make(chan string)
	connection.Emitter = make(chan string)
	connection.RawEmitter = make(chan string)
	fmt.Println(rouge + ">> NICK " + nick + normal)
	io.WriteString(connection.Conn, "NICK "+nick+"\n")
	fmt.Println(rouge + ">> USER " + nick + " 0.0.0.0 " + nick + " :" + nick + " bot" + normal)
	io.WriteString(connection.Conn, "USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot\n")
	go io.Copy(connection.Conn, os.Stdin)
	go connection.handleIncoming()
//	go connection.handleCounter()
	go connection.Join(channel)
	go connection.Interact()
}
func (connection *Ircconnection) Disconnect() {
	connection.Conn.Close()
}
func (connection Ircconnection) Join(channel string) {
	time.Sleep(1000 * time.Millisecond)
	fmt.Println(rouge + ">> JOIN " + channel + normal)
	io.WriteString(connection.Conn, "JOIN "+channel+"\n")
}
func (connection Ircconnection) SendMsg(msg string) {
	fmt.Println(rouge + ">> PRIVMSG " + connection.Channel + " :" + msg + normal)
	//io.WriteString(connection.Conn,"PRIVMSG "+connection.Channel+" :"+msg+"\n")
	connection.Emitter <- msg
}
func NewIrcconnection() Ircconnection {
	return Ircconnection{Server: server, Port: port, Nick: nick, Channel: channel}
}
func (connection *Ircconnection) SetNick(newnick string) {
	connection.Nick = newnick
	fmt.Println(rouge + "Changement de pseudo pour : " + vert + newnick + normal)
	io.WriteString(connection.Conn, "NICK :"+newnick+"\n")
}
func (connection *Ircconnection) handleIncoming() {
	scanner := bufio.NewScanner(connection.Conn)
	go func() {
		for scanner.Scan() {
			ln := scanner.Text()
			fmt.Println(jaune + "<< " + ln + normal)
			connection.Receiver <- ln
		}
	}()
}

func (connection *Ircconnection) Interact() {
	for {
		select {
			case writer := <-connection.Emitter:
    				connection.counter+= 200
    				if debug {
					fmt.Println(cyan + writer +" "+jaune+"[",connection.counter,"]"+ normal)
    				}
				go io.WriteString(connection.Conn,"PRIVMSG "+channel+" :"+writer+"\n")
			case writer := <-connection.RawEmitter:
				fmt.Println(cyan + writer + normal)
				go io.WriteString(connection.Conn,writer+"\n")
			case reader := <-connection.Receiver:
				//fmt.Println(cyan+reader+normal)
				go parseIrc(connection, reader)

		}
	}
}

// Futur système anti-flood. tout pourri pour le moment.
func (connection *Ircconnection) handleCounter(){
	for {
    		fmt.Println("On boucle : ",connection.counter)
		time.Sleep(time.Duration(connection.counter+500) * time.Millisecond)
		if (connection.counter > 0) {
			connection.counter -= 10
		} else {
    			
			connection.counter = 0
		}
	}
}

/////////////////// MAIN //////////////////////////////////////
func main() {
	if len(os.Args) > 1 {
		server = os.Args[1]
	}

	connection := NewIrcconnection()
	connection.Connect()

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

// ------------------
// Côté IRC
// ------------------

func parseIrc(connection *Ircconnection, msg string) {
	var elements []string = strings.Fields(msg)
	if debug {
		for i, element := range elements {
			fmt.Print(cyan+"[", i, "|"+normal+element+cyan+"] "+normal)
		}
	}
	if len(elements) < 2 {
    		fmt.Println("Syntax IRC ERROR !!!!")
		return
	}

	if elements[0] == "PING" {
		connection.RawEmitter <- "PONG :"+strings.TrimPrefix(msg, "PING :")
	}

	switch elements[1] {
	case "421":
		fmt.Println("!! Commande non reconnue par le serveur !!")
	case "433":
		fmt.Println("le pseudo déconne")
		nick = nick + "_"
		io.WriteString(connection.Conn, "NICK "+nick+"\n")
	case "JOIN":
		if ":"+nick == stringCut(elements[0], "!") {
			me = strings.TrimPrefix(elements[0], ":")
			fmt.Println(me + " a rejoin le salon " + strings.Trim(elements[2], ":"))
			onchan = true
			connection.Emitter<- "Salut "+channel+" !"
		}
	case "PART":
		fmt.Println("On est parti de " + strings.Trim(elements[2], ":"))
		onchan = false
	case "KICK":
		if elements[3] == nick {
			fmt.Println("Ptain on s'est fait kicker de " + elements[2] + " par " + elements[4] + " !")
			io.WriteString(connection.Conn, "JOIN "+channel+"\n")
		}
	case ":Closing":
    		fmt.Println("\n\n\nHa et merde on est déconnecté !\n\n\n")
		// Déconnecté
		time.Sleep(10000 * time.Millisecond)
		connection.Connect()
	}
	if len(elements) > 3 {
		switch elements[3] {
    			case ":cycle" :
				connection.Disconnect()
				connection.Connect()
			case ":heure" :
    				connection.Emitter<-"Paies-toi une montre vaut rien!"+msg
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
	fmt.Println(vert+"Incoming from ", in.RemoteAddr(), normal)
	inbuf := bufio.NewReader(in)
	for {
		inmsg, err := inbuf.ReadString('\n')
		if err != nil || !onchan || inmsg == "\n" {
			break
		}
		fmt.Print(vert + "<<]] " + inmsg + normal)
		connection.SendMsg(inmsg)
		time.Sleep(500 * time.Millisecond)
	}
}

// ------------
//  Génériques
// ------------

func stringCut(incoming string, pattern string) string {
	var results = strings.Split(incoming, pattern)
	if len(results) < 1 {
		return incoming
	} else {
		return results[0]
	}
}

{{< / highlight >}}

Bon bha voilà que s'achève cette semaine de blogposts chiants.
Je vous referai ptet un article une fois terminé mais c'est tout.
