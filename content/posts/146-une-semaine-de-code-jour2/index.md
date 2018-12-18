+++
Author = "Lord"
Description = "J'ai passé un peu moins de temps sur ça aujourd'hui mais ça a tout de même pas mal progressé. J'ai lu un peu de doc et j'ai dé-hardcodé un peu le code avant que ça soit plus complexe."
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-18T10:36:12+01:00
date = 2018-12-18T10:36:12+01:00
title = "Une semaine pour coder par soi même : Jour 2"
editor = "kakoune"
+++
Contrairement à hier, j'écris l'article au fil de l'eau.

### Raccourcir la boucle

Bon pour ce second jour j'ai commencé par automatiser un poil la façon de tester le code.
Pour le moment je lançais un netcat en écoute sur un port dans un terminal, puis je lançais le <samp>go run ircc.go</samp>.
Sauf qu'à chaque fois que je le quittais, fallait retourner sur le term avec le netcat et le relancer… **chiant**.

Du coup premier truc de la journée : faire un micro-script shell pour lancer ça dans un tmux :

{{< highlight bash >}}
#! /bin/bash
Reload(){
        tmux send-keys -t .+ C-c
        tmux send-keys C-c
        tmux send-keys -t .+ nc Space -l Space -p Space 6667 Enter
        tmux send-keys go Space run Space ircc.go Enter
}

Loop(){
        while true
        do
                read -s -n 1 input
                Reload
        done
}

Loop
{{< / highlight >}}

Il permet d'envoyer un <samp>Ctrl-c</samp> aux deux panes, puis de relancer le serveur et le programme en Go.
La boucle permet de relancer ces actions en appuyant sur n'importe quelle touche comme ça c'est on ne peut plus simple.

### Foutre des variables et virer le hardcode
Ouai c'était pas terrible du coup j'ai commencé à mettre tout pleins de variables.
Déjà parceque c'est facile à faire, il suffit d'être méticuleux et de ne rien oublier.
Pour commencer la journée c'est soft.

J'en ai également profité pour tenter de récupérer les arguments donnés au programme.
Pour l'instant j'en ai pas spécialement besoin mais ça pourrait servir ensuite.
Du coup j'en profite pour récupérer <samp>os.Args</samp> (en testant au préalable sa longueur).
Je pourrai picorer cet exemple plus tard pour l'utiliser différemment.

### Parser un peu mieux IRC
Bon pour l'instant c'était très très basique.
Du coup je me suis attelé à faire ça un peu plus proprement.

Je suis donc parti dans l'idée de récupérer une chaîne de caractère et de l'éclater en plusieurs sous-chaîne (séparée par des espaces) pour ensuite comparer certains champs seulement.

En fonction de ça je déclenche des actions bidons pour le moment.

### Se documenter
J'ai dégainé [la RFC d'IRC](https://tools.ietf.org/html/rfc1459) car ça devenait indispensable sur certains points.

### Les emmerdes
J'entrevois déjà pas mal de limitations dans ma façon de coder.
Je me retrouve à balader certaines variables un peu partout (les <samp>conn</samp>, <samp>nick</samp> et compagnie).
J'imagine qu'il y a moyen de faire autrement mais ça va être vite compliqué sinon.

Il me faut donc trouver le moyen de pouvoir écrire une fonction "envoyer_sur_IRC" qui soit appelable d'à peu près partout sans lui donner le socket et compagnie…

## Le code maintenant

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

func main() {

	var server string = "localhost"
	var port string = "6667"
	var channel string = "#lms"
	var nick string = "bab"
	var commander string = ":Lord!Lord@geeknode.fuckyeah"

	if len(os.Args) > 1 {
		server = os.Args[1]
	}

	conn, err := net.Dial("tcp",server+":"+port)
	go incoming(conn)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer conn.Close()
	connbuf := bufio.NewReader(conn)
	go io.Copy(conn, os.Stdin)

	initIrc(conn, nick, channel)

	for {
		msg, err := connbuf.ReadString('\n')
		if err != nil {
			break
		}
		fmt.Println("<< "+msg)
		parseIrc(msg,conn,commander,channel)
	}
	
}

// ------------------
// Côté IRC
// ------------------

func initIrc(conn net.Conn, nick string, channel string){
	fmt.Println("NICK "+nick+"\n")
	io.WriteString(conn,"NICK "+nick+"\n")
	fmt.Println("USER "+nick+"0.0.0.0 "+nick+" :"+nick+" bot\n")
	io.WriteString(conn,"USER "+nick+" 0.0.0.0 "+nick+" :"+nick+" bot\n")
	fmt.Println("JOIN "+channel+"\n")
	io.WriteString(conn,"JOIN "+channel+"\n")

}

func parseIrc(msg string,conn net.Conn, commander string, channel string){
	var elements []string = strings.Fields(msg)
	for i, element := range elements {
		fmt.Println( i,": "+element )

		if elements[1] == "421" {
			fmt.Println("!! Commande non reconnue par le serveur !!")
			break
		}

		if elements[0] == "PING" {
			fmt.Println(">> PONG "+strings.TrimPrefix(msg, "PING :"))
			io.WriteString(conn,"PONG "+strings.TrimPrefix(msg, "PING :"))
			break
		}

		if elements[1] == "JOIN" {
			fmt.Println("On a rejoin le salon "+strings.Trim(elements[2],":"))
			break
		}

		if elements[1] == "PART" {
			fmt.Println("On est parti de "+strings.Trim(elements[2],":"))
			break
		}
	}
    

}


func sendIrc(conn net.Conn,channel string, msg string){
	fmt.Println(">> PRIVMSG "+channel+" :"+msg)
	io.WriteString(conn,">> PRIVMSG "+channel+" :"+msg)

}

// ------------------
// Serveur en écoute
// ------------------

func incoming(outconn net.Conn){
	ln, err :=net.Listen("tcp",":4321")
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	for {
		conn, err :=ln.Accept()
		if err != nil {
			fmt.Println(err)
			continue
		}
		go handleIncoming(conn, outconn)
	}
}

func handleIncoming(in net.Conn, out net.Conn){
	fmt.Println("Incoming from ",in.RemoteAddr())
	inbuf := bufio.NewReader(in)
	for {
    		inmsg, err := inbuf.ReadString('\n')
    		if err != nil {
			break
    		}
    		fmt.Println("<<]] "+inmsg)
    		io.WriteString(out,"PRIVMSG #lms :"+inmsg)
    		time.Sleep(500 * time.Millisecond)
	}
}

{{< / highlight >}}
