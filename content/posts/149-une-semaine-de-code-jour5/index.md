+++
Author = "Lord"
Description = "Allez ce cinquième jour commence par un sentiment d'illumination et je finis en plus la journée avec une autre piste pour la suite."
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-21T10:27:36+01:00
date = 2018-12-21T10:27:36+01:00
title = "Une semaine pour coder par soi même : Jour 5"
editor = "kakoune"
+++
J'ai cogité toute la nuit à cette histoire.
Je pense que mon subconscient est allé puiser au fin fond de souvenirs anciens et il m'a resorti deux trucs : *les pointeurs*, les *getters/setters*.

Et du coup au réveil : Bon sang mais c'est bien sûr !

Allez hop ni une ni deux, j'enfourche mon fidèle kakoune et je crée une méthode bidon changeant juste une variable de ma <samp>Ircconnection struct</samp>, je parsème de <samp>fmt.Println</samp> et comme prévu, avant et après la dite méthode la modif n'est pas prise en compte.
J'appelle ce coup-ci le pointeur dans la méthode : **bingo daze !**

Bref j'ai à vue de nez la solution à tous mes problèmes, vais pouvoir me démerder.

Après avoir bidouillé deux heures je me rends vite compte qu'il me faut un moyen de "parler" aux go routines.
Et visiblement ce moyen ce sont les *channels*.

Ça complexifie pas mal le merdier mais d'un autre côté pour avoir des trucs asynchrones ça a l'air d'être LA façon de faire.
Du coup pour tester je me suis fait un ptit serveur netcat basique avec ce système.
Ça fonctionne mais ça commence à être un poil complexe pour moi, je n'ai pas encore le niveau requis.
Adapter mon client IRC avec ça représente pas mal de boulot.

Toujours est-il que ce serveur netcat fait maison pourra me servir un peu pendant les tests.
Et du coup je m'en inspire pour bidouiller petite à petit mon client IRC.
J'ai réussi à adapter suffisamment pour arriver plus ou moins au même niveau de fonctionnement donc la théorie marche.
J'ai pas encore tout adapté à ce modèle mais après une bonne nuit de réflexion les pièces du puzzle devraient s'emboiter plus facilement.
Au bout de ces quelques jours seulement j'ai le sentiment d'avoir bien progressé et lire des bouts de codes qui me paraissaient abscons m'est déjà beaucoup plus aisé.

## Le code

{{< highlight golang "linenos=table" >}}

package main

import (
	"bufio"
	"fmt"
	"net"
	"os"
	"io"
	"strings"
	"time"
    )

var server string = "localhost"
var port string = "6667"
var channel string = "#lms"
var nick string = "bab"
var commander string = ":Lord!Lord@geeknode.fuckyeah"
var onchan bool
var rouge string = "\033[1;31m"
var vert string = "\033[1;32m"
var jaune string = "\033[1;33m"
var cyan string = "\033[1;36m"
var normal string = "\033[0m"
var me string
var debug bool

type Ircconnection struct {
	Server		string
	Port		string
	Nick		string
	Channel		string
	Bidule		bool
	Conn		net.Conn
	Receiver	chan string
	Emitter		chan string
}

func (connection *Ircconnection) Connect(){
	var err error
	connection.Conn,err = net.Dial("tcp",server+":"+port)
	fmt.Println(rouge+"Connection to "+server+":"+port+normal)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	connection.Receiver = make(chan string)
	connection.Emitter  = make(chan string)
	fmt.Println(rouge+">> NICK "+nick+normal)
	io.WriteString(connection.Conn,"NICK "+nick+"\n")
	fmt.Println(rouge+">> USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot"+normal)
	io.WriteString(connection.Conn,"USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot\n")
	go io.Copy(connection.Conn, os.Stdin)
	go connection.handleIncoming()
}
func (connection *Ircconnection) Disconnect(){
	connection.Conn.Close()
}
func (connection Ircconnection) Join(channel string){
	time.Sleep(1000 * time.Millisecond)
	fmt.Println(rouge+">> JOIN "+channel+normal)
	io.WriteString(connection.Conn,"JOIN "+channel+"\n")
}
func (connection Ircconnection) SendMsg(msg string){
	fmt.Println(rouge+">> PRIVMSG "+connection.Channel+" :"+msg+normal)
	io.WriteString(connection.Conn,"PRIVMSG "+connection.Channel+" :"+msg+"\n")
}
func NewIrcconnection() Ircconnection{
	return Ircconnection{Server:server,Port:port,Nick:nick,Channel:channel}
}
func (connection *Ircconnection) SetNick(newnick string){
	connection.Nick = newnick
	fmt.Println(rouge+"Changement de pseudo pour : "+vert+newnick+normal)
	io.WriteString(connection.Conn,"NICK :"+newnick+"\n")
}
func (connection *Ircconnection) handleIncoming(){
	fmt.Println("Entrée dans handleIncoming()")
	scanner := bufio.NewScanner(connection.Conn)
	go func(){
		for scanner.Scan(){
			ln := scanner.Text()
			fmt.Println(jaune+"<< "+ln+normal)
			connection.Receiver <- ln
		}
	}()
	fmt.Println("Sortie de handleIncoming()")
}

func (connection *Ircconnection) Interact(){
	fmt.Println("Entrée dans Parse()")
	for {
		select {
			case reader := <- connection.Receiver :
//    				fmt.Println(cyan+reader+normal)
				parseIrc(*connection,reader)
			case writer := <- connection.Emitter :
    				fmt.Println(cyan+writer+normal)

		}
	}
	fmt.Println("Sortie de Parse()")
}

/////////////////// MAIN //////////////////////////////////////
func main() {
	if len(os.Args) > 1 {
		server = os.Args[1]
	}

	connection := NewIrcconnection()
	go incoming(connection)
	connection.Connect()
	go connection.Join(channel)
	connection.Interact()
	//time.Sleep(5000 * time.Millisecond)


}

// ------------------
// Côté IRC
// ------------------

func parseIrc(connection Ircconnection, msg string){
	var elements []string = strings.Fields(msg)
	if debug {
		for i, element := range elements {
			fmt.Print(cyan+"[",i,"|"+normal+element+cyan+"] "+normal )
		}
	}
	if len(elements)<2{
		return 
	}
	fmt.Println("")
	

	if elements[0] == "PING" {
//		connection.Emitter <- "Envoyer un PONG serait judicieux !"
		fmt.Println(rouge+">> PONG "+strings.TrimPrefix(msg, "PING :")+normal)
		io.WriteString(connection.Conn,"PONG "+strings.TrimPrefix(msg, "PING :")+"\n")
	}

	switch elements[1] {
        	case "421" :
        		fmt.Println("!! Commande non reconnue par le serveur !!")
        	case "433" :
        		nick = nick+"_"
        		io.WriteString(connection.Conn,"NICK "+nick+"\n")
        	case "JOIN" :
        		if ":"+nick == stringCut(elements[0],"!"){
				me = strings.TrimPrefix(elements[0],":")
        			fmt.Println(me+" a rejoin le salon "+strings.Trim(elements[2],":"))
        			onchan = true
        			connection.SendMsg("c'est moi que vla!")
        		}
        	case "PART" :
        		fmt.Println("On est parti de "+strings.Trim(elements[2],":"))
        		onchan = false
        	case "KICK" :
        		if elements[3] == nick {
        			fmt.Println("Ptain on s'est fait kicker de "+elements[2]+" par "+elements[4]+" !")
        			io.WriteString(connection.Conn,"JOIN "+channel+"\n")
        		}
        	case ":Closing" :
        		// Déconnecté
        		time.Sleep (5000 * time.Millisecond)
        		connection.Connect()
	}
	if len(elements) > 3 {
		if elements[3] == ":cycle" {
        		connection.Disconnect()
        		connection.Connect()
        	}
	}
}

// ------------------
// Serveur en écoute
// ------------------

func incoming(connection Ircconnection){
	in, err :=net.Listen("tcp",":4321")
	defer in.Close()
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for {
		inconn, err :=in.Accept()
		if err != nil {
			fmt.Println(err)
			continue
		}
		go handleIncoming(inconn,connection)
	}
}

func handleIncoming(in net.Conn,connection Ircconnection){
	fmt.Println(vert+"Incoming from ",in.RemoteAddr(),normal)
	inbuf := bufio.NewReader(in)
	for {
    		inmsg, err := inbuf.ReadString('\n')
    		if err != nil || !onchan || inmsg == "\n" {
			break
    		}
    		fmt.Print(vert+"<<]] "+inmsg+normal)
    		connection.SendMsg(inmsg)
		time.Sleep(500 * time.Millisecond)
	}
}

// ------------
//  Génériques
// ------------

func stringCut(incoming string, pattern string) string{
	var results = strings.Split(incoming, pattern)
	if len(results) < 1 {
		return incoming
	} else {
		return results[0]
	}
}
{{< / highlight >}}

Bon le *channel* <samp>Receiver</samp> fonctionne bien contrairement au <samp>Emitter</samp> qui ne se laisse pas dompter encore mais là je sature pour aujourd'hui ;-)

Le code a pas mal grossi aujourd'hui et il faudrait que j'en profite pour virer les morceaux obsolètes avant que ça ne s'accumule trop et que ça se disperse dans ma mémoire.
