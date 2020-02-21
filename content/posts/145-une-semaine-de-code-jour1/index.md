+++
Author = "Lord"
Description = "Le début de mon périple où j'apprend à coder par moi même. Le premier jour je me fait un ptit client IRC pour éventuellement devenir un bot."
Categories = ["golang", "code"]
menu = "main"
notoc = true
PublishDate = 2018-12-18T00:39:37+01:00
date = 2018-12-18T00:39:37+01:00
title = "Une semaine pour coder par soi même : Jour 1"
editor = "kakoune"
TopWords = [  "pratique", "strings", "nil", "time", "writestring", "os", "go", "println", "bab", "conn"]
+++

*J'ai toujours été frustré de pas savoir coder.*
J'ai pourtant toujours un peu codé des bidouilles.

Déjà des pages webs donc en HTML avec son CSS mais jamais de Javascript.
Mais ces langages ne sont pas de la programmation à proprement parlé.

Puis en cours, j'ai eu le droit à un peu de théorie en algo mais pas grand-chose (suffisamment pour savoir si on accroche ou pas).
J'ai aussi eu le droit à du **Java**.
Ça m'a assez plu car c'était très pratique (faire un ptit truc de chat notamment).
Et puis du **C** et là … bha en fait ça m'a *gavé*.

Les pointeurs… pourquoi se faire chier encore avec ça ?
Et à l'époque j'étais pas spécialement à l'aise avec Linux du coup je galérais également avec l'OS.
Après cette expérience douloureuse avec le C, j'ai fait du **PHP**.

Lors d'un stage, j'ai créé un système de gestion de tickets chronométrés pour utiliser le wifi, couplé à un serveur Radius.
Bref un truc assez fun qui a fonctionné en prod deux semaines après avoir commencé.
C'était du gros bidouillage dégueu toussa mais … bha il a fonctionné sans aucun accroc !

Depuis j'ai jamais rien fait et ça remonte à pas mal d'années maintenant.

Étant un geek, qui plus est versé dans le Logiciel Libre, je dois avouer que *ça m'a toujours titillé mais les souvenirs des galères du C m'ont toujours hantés*.

Depuis j'ai toujours fait des ptits scripts et compagnie.
J'en suis même arrivé à faire des scripts shells plutôt poussé à un point où j'ai eu plusieurs fois des remarques comme quoi en Python ça serait beaucoup plus court et rapide et pratique et joli… blabla.

Bon du coup cette semaine je suis en congé et … bha je vais m'y mettre un peu dès aujourd'hui.

J'ai choisi de faire du **Go**.
Un truc que j'aime bien avec ce langage c'est que *ça génère des ptits binaires statiques*.
Tu les copies/colles et hop ça fonctionne ailleurs et ça c'est super pratique.

Et en plus tu peux avoir un fonctionnement un peu hybride dans le sens où *ça a beau être un langage compilé, tu peux faire du <samp>go run ta_source.go</samp> et hop ça tourne direct* (j'imagine qu'avec des programmes complexes ça tourne un peu moins instantanément, mais ça sera pas mon cas).

En plus ce langage est hype, donc autant voir pourquoi.
J'aurai été moins quicheux, j'aurai probablement choisi Rust mais je pense ne clairement pas avoir le background technique suffisant.

## J'ai fait quoi aujourd'hui ?
Bon bha pour mon tout premier programme en Go, j'ai choisi ce matin de faire un client IRC.

Ouai on se refait pas.

Bref *IRC c'est le protocole de chat probablement le plus simple du monde*, c'est du TCP avec juste une fine surcouche pour rendre ça plus utilisable et voilà.

Bon le but, à terme, est de remplacer [mon bot Nib]({{< ref "/posts/66-nib-irc-bot" >}}).
Pour l'instant c'est donc du Shell assez porcasse avec du bidouillage de partout.
Même si ça fonctionne, le truc tourne dans un container avec beaucoup de dépendances.
Donc le but va être d'intégrer le plus possible, directement dans le programme en Go, pour ne pas recourrir à des logiciels externes.

En pratique donc j'ai commencé doucement, mais pour moi c'est déjà énorme.
Je peux déjà me *connecter à un serveur irc* (hardcodé pour le moment), *répondre au Pings* envoyés par le serveur (histoire de pas être déconnecté), *recevoir/envoyer du texte brut* et j'ai même commencé le *serveur d'écoute*.

Je me suis aidé en suivant des morceaux de codes vus à droite à gauche.
Et je suis arrivé au résultat suivant pour le moment.

{{< highlight golang "linenos=table">}}
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
	conn, err := net.Dial("tcp","localhost:6667")
	go incoming(conn)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
	defer conn.Close()
	connbuf := bufio.NewReader(conn)
	go io.Copy(conn, os.Stdin)

	fmt.Println("NICK bab\n")
	io.WriteString(conn,"NICK bab\n")
	fmt.Println("USER bab 0.0.0.0 bab :Bab bot\n")
	io.WriteString(conn,"USER bab 0.0.0.0 bab :Bab bot\n")
	time.Sleep(1500 * time.Millisecond)
	fmt.Println("JOIN #bab\n")
	io.WriteString(conn,"JOIN #bab\n")
//	_, err = io.Copy(conn, os.Stdin)

	for {
		msg, err := connbuf.ReadString('\n')
		if err != nil {
			break
		}
		fmt.Println("<< "+msg)
		if strings.HasPrefix(msg,"PING") {
			fmt.Println(">> PONG "+strings.TrimPrefix(msg, "PING :"))
			io.WriteString(conn,"PONG "+strings.TrimPrefix(msg, "PING :"))
		}
	}
	
}

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
    		io.WriteString(out,"PRIVMSG #bab :"+inmsg)
    		time.Sleep(500 * time.Millisecond)


	}
//	go io.Copy(in,out)

}

{{< / highlight >}}

J'espère que le code ne vous fera pas trop mal aux yeux.
Je me doute qu'il est plein de conneries.

C'est pour l'instant la toute première étape, j'ai déjà pas mal de pistes d'améliorations mais ça va me demander du creusage de méninges et surtout prendre de nouvelles habitudes et m'habituer à la syntaxe.
Pour l'instant j'ai dû dédier environ 4 heures à ça.
Au final j'ai fait plus que ce que je comptais faire pour la première journée.

On verra demain pour la suite.
