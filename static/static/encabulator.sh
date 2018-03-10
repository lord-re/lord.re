#! /bin/bash
# Script innofensif bien entendu.

# Il ne faut surtout jamais exécuté un script choppé sur les internets sans le regarder un minimum.
# D'un point de vue sécu c'est une horreur absolue.

# Les mainteneurs de votre distro font un important travail pour vous protégérer en vérifiant les sources et en vous proposant une façon sûre d'installer des logiciels propres sur votre linux.
# Ne ruinez pas votre linux en faisant du curl …| bash.
# Bon j'espère que cet article vous aura appris un peu de prudence et/ou vous aura fait rire.
# Si vous ne connaissiez pas le meme du Turbo Encabulator vous pouvez aller voir 
# https://en.wikipedia.org/wiki/Turboencabulator

# Cette vidéo ( https://www.youtube.com/watch?v=Ac7G7xOG2Ag ) est particulièrement drôle.

# C'est une variante du Bullshit Bingo commun dans le monde des startups de la tech.
# Une ptit blockchain encabulator ?
Hackerecho(){
	charseconds=${2:-"0.03"}
	for char in $(echo "$1" | fold -w1); do
		printf "%s" $char
		sleep "$charseconds"
	done
}
Hackerecho "Reticulating splines"
printf "\n"
Hackerecho "--------------------"
printf "\n"
Hackerecho "OK"
printf "\n"
Hackerecho "Détection du kernel :"
printf "[%s] \n" $(uname -r) 
Hackerecho "Détection de l'utilisateur :"
Hackerecho "[$(id)]"
printf "\n"
Hackerecho "Vérification GRUB :"
sleep 2
Hackerecho " O"
sleep 3
Hackerecho "K"
sleep 1
printf "\b"
sleep 0.5
printf "\b"
sleep 0.5
Hackerecho "  OK" "1"
printf "\n"
sleep 1
Hackerecho "recalcul de l'espace disponible"
Hackerecho "..." "2"
Hackerecho "OK"
printf "\n"
Hackerecho "Vérif DMA eBPF NUMA et MMU :" "0.05"
Hackerecho "$(lscpu)" "0.01"
clear
Hackerecho "Téléchargement puis désentrelacement des sources"
printf "\n"
Hackerecho "[------------------------------------------------]" "0.001"
printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
Hackerecho "||||||||||||||||||||||||||||||||||" "0.8"
Hackerecho "SSL FAILED - trying another mirror" "0.05"
printf "\n"
sleep 0.5
echo "Retrying in cleartext"
Hackerecho "[------------------------------------------------]" "0.001"
printf "\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b\b"
Hackerecho "||||||||||||||||||||||||||||||||||" "0.8"
Hackerecho "|||||||" "1.2"
Hackerecho "||||" "2.9"
Hackerecho "||" "6"
Hackerecho "]  [OK]" "0.01"
printf "\n"
Hackerecho "Calculating Checksum :"
Hackerecho "$(head -c 22 /dev/urandom | base64)" "0.5"
printf "\n"
Hackerecho "ERROR Checksum mismatch. Recalculating :" "0.01"
Hackerecho "$(head -c 22 /dev/urandom | base64)" "0.5"
Hackerecho " [OK]"
printf "\n\n"
Hackerecho "[PHASE D'INSTALLATION]"
printf "\n\n"
sleep 1
Hackerecho "Décompression du Binmft [1/8]"
printf "\n"
sleep 2
Hackerecho "Side Fumbling Prevention [2/8]"
printf "\n"
sleep 1
Hackerecho "DH Decyphering in UDMA-mode 4[3/8]"
printf "\n"
sleep 1.2
Hackerecho "Optimisation des IRQ [4/8]"
printf "\n"
sleep 0.4
Hackerecho "$(uname -r)[5/8]"
printf "\n"
sleep 1
Hackerecho "IFrame reinitialazition [6/8]"
printf "\n"
Hackerecho "Et voilà vous venez de faire une connerie."
printf "\n"
Hackerecho "Il ne faut surtout jamais executer un script chopper sur le net sans l'inspecter avant !"
printf "\n"
Hackerecho "Faire “curl x | bash” est potentiellement très dangeureux !"
printf "\n"
printf "\n"
Hackerecho "Les mainteneurs de votre distribution Linux ont la difficile tâche de vérifier que les paquets qu'ils mettent à disposition sont clean d'un point de vue sécurité."
printf "\n"
Hackerecho "Et les distributions linux fournissent ces paquets de manières sécurisées. En théorie vous ne risquez rien en installant un paquet via les dépots officiels de votre nunux."
printf "\n"
Hackerecho "Installer un paquet par un dépot externe ou bien carrément hors dépot via ce genre de manipulation peut comprommetre toute votre sécurité."
printf "\n"
Hackerecho "Le moins que vous puissiez faire c'est de télécharger le script, le lire pour vérifier qu'il ne fait rien de louche et si c'est le cas ne surtout pas l'executer."
printf "\n\n\n"
sleep 1
Hackerecho "Et concernant l'article, si vous ne connaissiez pas le meme “Turbo Encabulator”, vous pouvez vous rendre sur https://en.wikipedia.org/wiki/Turboencabulator"
printf "\n"
Hackerecho "Cette vidéo ( https://www.youtube.com/watch?v=Ac7G7xOG2Ag ) est particulièrement drôle."
printf "\n"
Hackerecho "C'est une variante du Bullshit Bingo commun dans le monde des startups de la tech."
printf "\n"
Hackerecho "Une ptit blockchain encabulator ?"

