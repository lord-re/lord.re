+++
Author = "Lord"
Description = ""
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-19T13:57:25+01:00
date = 2018-12-19T13:57:25+01:00
title = "Une semaine pour coder par soi même : Jour 3"
editor = "kakoune"
TopWords = [  "print", "incoming", "func", "rouge", "writestring", "channel", "conn", "ircconn", "strings", "elements"]
+++
Je piétine.
J'ai un peu lu à droite à gauche, je sais toujours pas trop comment m'en sortir de ces histoires de "variables globales".

Du coup j'ai continué un peu à raffiner le support d'IRC :

  - *Je détecte désormais si le pseudo est déjà occupé* pour en prendre un autre.
  - *Je détecte également s'il y a une déconnexion propre* de la part du serveur. Mais je sais pas me débrouiller pour faire en sorte de repartir sur la fonction initIrc sans que ça foute la merde avec la variable <samp>conn</samp>….
  - *Je détecte lorsque je me fais kicker* et je rejoin automatiquement.

**J'utilise maintenant des variables globales.**
C'est pas bien il paraît mais j'ai pas trop réussi à savoir si dans mon cas c'était justifié ou non, mais comme ça marche pour le moment ça me va bien.

J'ai été étonné de voir que dans la lib *strings* il n'y avait pas moyen de récupérer une sous-chaîne en coupant une chaîne en entrée jusqu'à un caractère particulier du coup me la suis rajoutée.
Rien de bien méchant mais ça permet de se simplifier la tâche plus tard.

J'ai remarqué une petite erreur dans la logique de la fonction <samp>parseIrc</samp> où je bouclais sur plus qu'il ne fallait.
Je pense qu'il serait malin de remplacer l'empilement de *if* par un *switch*, mais là j'ai un poil la flemme pour le moment.

Bon ça peut sembler assez peu mais … au final je suis assez satisfait des maigres avancées, j'ai l'impression (mais c'est peut-être complètement faux) que mon code est un peu plus robuste grâce aux variables globales.

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
var ircconn net.Conn
var debug bool


func main() {

	if len(os.Args) > 1 {
		server = os.Args[1]
	}
	ircconn = initIrc(server, port, nick, channel)

	go incoming()
	ircconnbuf := bufio.NewReader(ircconn)
	go io.Copy(ircconn, os.Stdin)

	for {
		msg, err := ircconnbuf.ReadString('\n')
		if err != nil {
    			fmt.Println(err)
			break
		}
		fmt.Print(jaune+"<< "+msg+normal)
		parseIrc(msg)
	}
	
	defer ircconn.Close()
}

// ------------------
// Côté IRC
// ------------------

func initIrc(server string, port string, nick string, channel string) net.Conn{
	conn, err := net.Dial("tcp",server+":"+port)
	fmt.Println(rouge+server+":"+port+normal)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	fmt.Println(rouge+">> NICK "+nick+normal)
	io.WriteString(conn,"NICK "+nick+"\n")
	fmt.Println(rouge+">> USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot"+normal)
	io.WriteString(conn,"USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot\n")
	fmt.Println(rouge+">> JOIN "+channel+normal)
	io.WriteString(conn,"JOIN "+channel+"\n")
	return conn
}

func parseIrc(msg string){
	var elements []string = strings.Fields(msg)
	for i, element := range elements {
		fmt.Print(cyan+"[",i,"|"+normal+element+cyan+"] "+normal )
	}
	fmt.Println("")

		if elements[1] == "421" {
			fmt.Println("!! Commande non reconnue par le serveur !!")
		}

		if elements[1] == "433" {
			nick = nick+"_"
			io.WriteString(ircconn,"NICK "+nick+"\n")
		}
		
		if elements[0] == "PING" {
			fmt.Print(rouge+">> PONG "+strings.TrimPrefix(msg, "PING :")+normal)
			io.WriteString(ircconn,"PONG "+strings.TrimPrefix(msg, "PING :")+"\n")
		}

		if elements[1] == "JOIN" {
    			if ":"+nick == stringCut(elements[0],"!"){
        			me = strings.TrimPrefix(elements[0],":")
				fmt.Println(me+" a rejoin le salon "+strings.Trim(elements[2],":"))
				onchan = true
				sendIrc("c'est moi que vla!")

    			}
		}

		if elements[1] == "PART" {
			fmt.Println("On est parti de "+strings.Trim(elements[2],":"))
			onchan = false
		}

		if elements[1] == "KICK" && elements[3] == nick {
			fmt.Println("Ptain on s'est fait kicker de "+elements[2]+" par "+elements[4]+" !")
			io.WriteString(ircconn,"JOIN "+channel+"\n")
		}

		if elements[1] == ":Closing" && elements[2] == "Link:" {
			// Déconnecté
			ircconn = initIrc(server, port, nick, channel)
		}
}

func sendIrc(msg string){
	msg = strings.TrimSpace(msg)
	fmt.Print(rouge+">> PRIVMSG "+channel+" :"+msg+"\n"+normal)
	io.WriteString(ircconn,"PRIVMSG "+channel+" :"+msg+"\n")

}

// ------------------
// Serveur en écoute
// ------------------

func incoming(){
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
		go handleIncoming(inconn)
	}
}

func handleIncoming(in net.Conn){
	fmt.Println(vert+"Incoming from ",in.RemoteAddr(),normal)
	inbuf := bufio.NewReader(in)
	for {
    		inmsg, err := inbuf.ReadString('\n')
    		if err != nil || !onchan || inmsg == "\n" {
			break
    		}
    		fmt.Print(vert+"<<]] "+inmsg+normal)
    		sendIrc(inmsg)
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

Ha au fait j'ai installé un vrai serveur IRC pour tester en condition un peu plus réelle sans pour autant pourrir un vrai réseau IRC…
Du coup mon ptit script bash d'hier n'a pas servi.
