+++
Author = "Lord"
Description = "Je ne vous le cache pas, aujourd'hui j'y ai passé bien moins de temps… Bon j'ai un peu discuté sur IRC à ce propos et on m'a soufflé de le faire un peu plus orienté objet."
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-20T23:42:31+01:00
date = 2018-12-20T23:42:31+01:00
title = "Une semaine pour coder par soi même : Jour 4"
editor = "kakoune"
TopWords = [  "case", "incoming", "writestring", "func", "strings", "ircconn", "channel", "conn", "elements"]
+++
Allez je vais être franc, j'y ai pas trop trop touché aujourd'hui, j'étais occupé par ailleurs.
J'ai presque pas lurker sur le Fédiverse et à peine sur les IRC.

J'ai quand même un peu discuté avec Cacatoès qui m'a soufflé que ça serait très probablement un peu mieux en utilisant de la programmation orientée objet.
Et après discussion et lecture à droite à gauche, ça pourrait être pas mal plus simple.

Ça m'a également fait remonter quelques vieux souvenirs de Java.
Je fais quelques tests sur une version copiée et effectivement ça a l'air jouable.

Du coup, allez hop, je reprends le code d'hier et je commence à y créer une structure pour la gestion de l'IRC.
Je commence à faire une première méthode, ça marche, une seconde ça marche.
Et là attention, je tente le tout pour le tout et BAM ça marche plus.
*Le* **scope** *des variables de mon objet me pose soucis.*

J'ai l'impression que si je modifie une variable de ma structure dans l'une des méthodes (typiquement le <kbd>net.Conn</kbd>) dans une autre méthode ça n'a pas été modifié :-(
J'ai naïvement pensé que les méthodes d'un *struct* pouvaient modifier les variables du *struct* globalement mais visiblement non.
Du coup je suis pas spécialement plus avancé.
Je voulais créer une méthode qui se connecte au lieu de le mettre dans le *New* mais du coup je ne peux pas…

J'imagine qu'il y a probablement une subtilité qui m'échappe.

Encore une fois je précise que je débute à 100% et que je compte pas en faire mon métier ni rien, c'est plus pour (re)découvrir et tenter de faire un ptit projet fonctionnel.

Bon et pour avoir l'impression d'avoir un truc un peu mieux qu'hier, j'ai mis le <kbd>switch</kbd>.

Voilà rien de transcendant aujourd'hui :-/

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
	go joinChan(conn,channel)
	return conn
}

func joinChan(conn net.Conn,channel string){
	time.Sleep(1000 * time.Millisecond)
	fmt.Println(rouge+">> JOIN "+channel+normal)
	io.WriteString(conn,"JOIN "+channel+"\n")
}

func parseIrc(msg string){
	var elements []string = strings.Fields(msg)
	for i, element := range elements {
		fmt.Print(cyan+"[",i,"|"+normal+element+cyan+"] "+normal )
	}
	fmt.Println("")

		if elements[0] == "PING" {
			fmt.Print(rouge+">> PONG "+strings.TrimPrefix(msg, "PING :")+normal)
			io.WriteString(ircconn,"PONG "+strings.TrimPrefix(msg, "PING :")+"\n")
		}

		switch elements[1] {
        		case "421" :
        			fmt.Println("!! Commande non reconnue par le serveur !!")
        		case "433" :
        			nick = nick+"_"
        			io.WriteString(ircconn,"NICK "+nick+"\n")
        		case "JOIN" :
            			if ":"+nick == stringCut(elements[0],"!"){
					me = strings.TrimPrefix(elements[0],":")
        				fmt.Println(me+" a rejoin le salon "+strings.Trim(elements[2],":"))
        				onchan = true
        				sendIrc("c'est moi que vla!")

            			}
        		case "PART" :
        			fmt.Println("On est parti de "+strings.Trim(elements[2],":"))
        			onchan = false
        		case "KICK" :
        		if elements[3] == nick {
        			fmt.Println("Ptain on s'est fait kicker de "+elements[2]+" par "+elements[4]+" !")
        			io.WriteString(ircconn,"JOIN "+channel+"\n")
        		}
        		case ":Closing" :
        		if elements[2] == "Link:" {
        			// Déconnecté
        			ircconn = initIrc(server, port, nick, channel)
        		}	
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

Le bilan positif de la journée : je n'ai pas plus de ligne de code qu'hier !
