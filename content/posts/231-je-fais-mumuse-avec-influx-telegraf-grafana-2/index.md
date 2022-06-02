+++
Author = "Lord"
Description = "Deuxième partie de mes aventures de monitoring. J'aborde ici les différentes métriques avec les quelques scripts que j'ai mis en place."
Categories = ["monitoring", "graph"]
menu = "main"
notoc = true
WritingDate = 2022-05-31T17:29:30+02:00
date = 2022-06-02T23:39:30+02:00
title = "Je fais mumuse avec InfluxDB Telegraf Grafana : vol.2"
editor = "kakoune"
TopWords = ["line_protocol", "métriques", "cron", "csv", "go", "up", "woob", "host", "script", "telegraf","influx","influxdb","grafana"]
+++
Dans [la première partie]({{< ref "posts/230-je-fais-mumuse-avec-influx-telegraf-grafana" >}}) j'expliquais à peu près comment j'avais installé la stack.
Le tout avec un peu d'*auth*, du *TLS* et un *reverse proxy* pour que ce soit propre.

## Les bienfaits de Go
Un point que je n'ai pas abordé c'est *mon amour pour Go*.
Habituellement on s'en fout un peu du langage d'un logiciel mais là quand on doit installer un agent sur chacune des machines et qu'elles ne sont pas du tout uniformes ça peut vite être les emmerdes.

En théorie les langages avec interprêteur genre python ça devrait être pas mal mais à l'usage c'est un nid à emmerdes.
Avoir le bon interprêteur dans la bonne version, avec les bonnes libs et tout c'est un enfer.
J'ai horreur de python pour cela.
Et non, utiliser virtualenv ou venv ou pip ou $truc_du_jour ça n'aide pas.

Avec les logiciels compilés c'est en théorie un peu mieux mais dès qu'on a un soft un peu complexe qui a pas mal de dépendances dont des libs dynamiques on est reparti dans l'enfer encore une fois.
Et c'est sans commencer à évoquer la cross-compilation qui est généralement assez chiant à mettre en place.

Et c'est là que Go arrive en sauveur.
Ce pépère *génère un binaire statique*.
Alors certes ce binaire est très gros (enfin ça reste très tolérable niveau taille de données, hein)  mais il contient tout et est autonome.
Vous pouvez donc copier ce binaire sur la machine de destination et pouf il tournera.
Quel panard !

Le deuxième très gros point positif est l'*extrème simplicité à cross-compiler en Go*.
C'est intégré nativement.
Rien besoin d'installer de plus que le compilo d'origine.
Deux variables d'environnements à définir et pouf le binaire pondu sera cross-compilé vers la cible.
On ne peut plus simple.

On combine ces deux points et il est très simple de compiler puis déployer un programme en Go.
En gros un ptit <kbd>GOARCH=arm GOARM=7 make</kbd> et pouf vous n'avez plus qu'à envoyer le binaire produit sur votre machine de destination.

J'ai appliqué cette méthode pour **Telegraf**, il ne restait plus qu'à pousser un fichier de conf et un fichier d'init pour le lancer au boot.
En moins de dix minutes je suis à même de foutre ça sur une nouvelle machine même si l'OS ne permet pas de l'installer nativement.

J'arrête de vous embêter avec Go (pour l'instant ; niark niark).
## Trifouillage de Telegraf
Bon **Telegraf** de base est plein de plugins qui permettent de monitorer tout un tas de logiciels assez connus.
Il sait aussi monitorer les métriques usuelles des ordis : l'utilisation CPU, l'utilisation RAM, le réseau, les disques… toussa quoi.

Il suffit généralement de décommenter les morceaux en question dans la conf pour l'activer.
C'est bien, c'est fourni de base.

Il possède cela-dit quelques plugins plus "diy".
Il y a notamment **http** qui permet de choper des métriques via … bha http.
Il y a également **file** qui permet de choper des métriques via … des fichiers.
Avec à chaque fois suffisamment d'options pour pouvoir gérer des données sous différentes formes (CSV/JSON…).

Du coup j'ai commencé à faire mumuse avec ça.

### Grapher ma conso élec/gaz/eau
Ça fait quelques années maintenant que je m'astreins chaque semaine à relever mes différents compteurs.
Je balance tout cela dans un fichier CSV.
J'ai donc la date, le relevé de gaz, le relevé d'élec, le relevé d'eau, le delta de gaz depuis la semaine précédente, pareil pour l'élec, pareil pour l'eau.
Le tout dans un (maintenant long) fichier CSV.

J'ai donc commencé à ajouter un plugin **http** qui récupère ce CSV, le parse et ingère ça dans InfluxDB.
Ça marche super bien.
J'ai pu avoir toutes mes mesures dans un joli ✨ graph ✨.

{{< img src="conso.png" alt="des graphs de type compteur à aiguille" title="C'est pas mal non comme rendu ? (Tiens j'avais oublié de mettre l'unité pour le gaz :-/ )" >}}

Wow.
Tant d'années que je relève ça et j'ai enfin un vrai graph tout joli !
Par contre j'avoue que ça m'écorche un peu quand même de parser un fichier complet constamment alors que bon je ne fais qu'ajouter qu'une ligne par semaine.

Je peux déjà commencer par limiter la fréquence de test de ce plugin pour ne passer qu'une fois par jour.
Mais ça reste du bricolage qui ne me plait guère.

Je commence à voir pour me faire un ptit script shell qui ne va faire que générer un nouveau fichier CSV avec seulement deux lignes.
C'est beaucoup plus léger.
C'est au final un script ultra simple.
(spoiler : ça va pas durer longtemps)

## Se passer de Telegraf
Bon il est ptet temps de savoir se passer de **Telegraf** quand il n'est pas spécialement nécessaire.
Bien entendu je le conserve pour toutes ses métriques mais pour celles que je veux rajouter je me passerai de ses services.

### Grapher la température et l'humidité relative de mon salon
J'ai une ptite sonde USB raccordée à l'une de mes machines.
C'est un appareil en hardware libre avec un logiciel libre lui aussi.

{{< img src="sonde.jpg" alt="C'est un PCB qui mesure 1cm par 3cm environ avec un port micro USB" title="Malheureusement ça ne se vend plus."  >}}

On lance le logiciel et il sort la température et l'humidité et l'état des LED.
Et c'est tout.
Je relève ça depuis quelques années maintenant mais pareil je ne l'avais jamais graphé.

Bon le truc c'est que là, je me suis dit que je vais pouvoir relever ces infos un peu plus fréquemment vu que c'est 100% automatisé.
Pourquoi pas toutes les 10s après tout ?

Par contre la méthode CSV va vite montrer ses limites.
Je regarde un peu la doc de telegraf et influx et je tombe sur une page concernant le **[line protocol](https://docs.influxdata.com/influxdb/v1.8/write_protocols/line_protocol_tutorial/)** d'InfluxDB.
Et là en fait ils montrent comment parler directement à la DB pour lui ajouter une mesure.
Et c'est super simple !
Mais vraiment très simple !

Je dégaine un **curl** et j'envoie une mesure bidon, je vais dans le grafana, je crée un nouveau graphique je tente de créer une query pour ça et là sous mes yeux ébahis ça fonctionne.
Bon bha je vais pas me faire chier à parser et compagnie avec telegraf mais parler directement à Influx.

Bon bon bon…
Je vais ptet refaire les autres graphs avec cette méthode et au lieu d'alimenter un CSV, je vais directement alimenter ma base InfluxDB.
Bon ça me simplifie pas mal la vie.

Donc je me refais un ptit script de zéro.

<details><summary>/usr/local/bin/hyg2influx</summary>
{{< highlight "shell" >}}
#! /bin/sh

host="n2"
influx_url="https://hostname.de.influxdb/write?db=telemetrie"

hygoutput=$(/usr/local/bin/hyg-usb -c)
sonde=$( echo "$hygoutput" | awk -F, '{print $1}')
temperature=$(echo "$hygoutput" | awk -F, '{print $2}')
humidite=$(echo "$hygoutput" | awk -F, '{print $3}')

line_protocol=$( printf "sondes,sonde=%s temperature=%s,hygrometrie=%s" "$sonde" "$temperature" "$humidite")

curl -XPOST -u user:password "$influx_url" --data-binary "$line_protocol"

{{< / highlight >}}
</details>

Et on demande à notre cher **cron** de lancer ce script à chaque minute et c'est bon.
Beaucoup moins de parseage, ça bouffe moins de CPU, c'est plus léger et plus facile à débugguer.
**Telegraf** était vraiment un composant qui n'avait pas vraiment de plus-value.

{{< img src="sondes.png" alt="Deux graphs 'compteurs' et une courbe avec ses statistiques pour la température et l'humidité" title="On peu rajouter dans la légende les valeurs min/max/moyenne/le delta/la dernière relevée (et d'autres) ce qui est chouette comme tout." >}}

Bon, je vous le détaille pas, mais j'ai modifié mon script pour l'élec/gaz/eau pour qu'il ait sensiblement la même gueule afin de zapper **telegraf**.

### Grapher les mises à jour AlpineLinux
Mon ptit cheptel de machines comprend maintenant 4 bestioles sous Alpine.
Et je les tiens pas parfaitement à jour tout le temps.

Je pourrai mettre un **cron** qui upgrade régulièrement mais je préfère le faire manuellement.
Non, je me suis juste contenté d'un **cron** qui *update régulièrement les dépots*.
À moi ensuite de me connecter et de lancer la mise-à-jour.
J'ai donc rajouté un ptit morceau qui m'indique le nombre de paquet "upgradable".

<details><summary>/etc/periodic/daily/alpine_update</summary>
{{< highlight "shell" >}}
#! /bin/sh
apk update

host="MonAlpineFavorite"
installed=$(apk list --installed | wc -l)
upgradable=$(apk list -u | wc -l )
orphaned=$(apk list --orphaned | wc -l )

line_protocol=$( printf "apk_stats,host=%s installed=%si,upgradable=%si,orphaned=%si" "$host" "$installed" "$upgradable" "$orphaned")
curl -XPOST -u user:motdepasse "https://adresse.du.serveurinflux.db/write?db=telemetrie" --data-binary "$line_protocol"
{{< / highlight >}}
</details>

C'est basique mais ça fait le boulot.

{{< img src="upgrades.png" alt="Des barres qui augmentent avec le nombre de paquets à mettre à jour." title="J'ai arbitrairement défini que 10 paquets non à jour c'est trop." >}}

### Le nerf de la guerre : le peugnon !
Bon j'ai un compte en banque que j'aimerai grapher.
Et quel est l'outil que l'on utilise pour consulter son compte en banque ?
**Woob**.

En gros vous y rentrez vos identifiants de banque et le truc se débrouille pour s'y connecter en bravant les captchas et compagnie.
Il saura vous resortir votre balance actuelle.
C'est pile ce que je veux !

Bon alors là par contre j'ai eu un vrai dilemme.
**Woob** c'est chouette mais c'est du python (beurk) et j'ai pas spécialement envie d'installer ça sur ma machine qui graphe.
Du coup, je vais le foutre sur ma machine perso qui tourne par intermittence.
D'ailleurs j'ai déjà **woob** depuis fort longtemps sur cette machine.
Par contre je n'ai pas de **cron** ici.

J'ai pas spécialement envie d'installer **cron** et de le faire tourner juste pour ça.
Du coup je me fais un truc un peu hybride.
Je vais passer par **telegraf** (qui est déjà installé pour les autres métriques) et qui va lancer une commande régulièrement.

Donc je rajoute un plugin dans la conf de **telegraf** :

<details><summary>extrait de /etc/telegraf/telegraf.conf</summary>
{{< highlight "toml" >}}
[[inputs.exec]]
  commands = [ "/usr/local/bin/woob2telegraf" ]
  timeout = "10s"
  interval = "4h"
  json_name_key = "label"
  data_format =  "json"
  name_override = "banque"
  tag_keys = ["label"]
{{< / highlight >}}
</details>

<details><summary>le /usr/local/bin/woob2telegraf</summary>
{{< highlight "shell" >}}
#! /bin/sh

# Le script est lent et fait potentiellement un appel à la banque constamment donc on le fout en cache.
# Il écrit dans /tmp/woob2telegraf
# Quand on invoque le script on regarde s'il existe déjà ce fichier et s'il est moins vieux qu'un certain délai.

update_data() {
  # On demande à woob de nous sortir un json mais il est un peu trop fourni, donc on utilise jq pour ne conserver que le label et la balance
  woob bank ls --formatter json | jq '[.[] | {label: .label , balance: .balance| tonumber }]' > /tmp/woob2telegraf
}

if [ ! -e /tmp/woob2telegraf ]
then
  update_data
else
  lastupdate=$(stat --format=%Z /tmp/woob2telegraf)
  date=$(date +%s)
  diff=$(expr $date - $lastupdate  )
  # En gros 4h 
  if [ "$diff" -gt 15000 ]
  then
    update_data
  fi
fi

# On envoie à telegraf
cat /tmp/woob2telegraf
{{< / highlight >}}
</details>

Et hop, tout ça pour s'éviter d'avoir **cron**…
Ça y est je peux avoir une ptite visu sur mes finances.

### DEBOUT !
Bon, j'ai quelques machines et j'aimerai bien savoir lesquelles sont up ou non.
Au début je pensais ptet partir sur un graph qui se base sur des pings via **Telegraf** mais je me suis dit qu'il y avait moyen de faire bien plus léger.

#### Collectons
Je suis donc parti sur du fait maison encore qui va être executé chaque minute (clairement pas besoin de relever ça plus souvent).
Chacun des hosts va juste envoyer un booléen à *true* et c'est tout.

<details><summary>/usr/local/bin/up2influx</summary>
{{< highlight "shell" >}}
#! /bin/sh

host=$(hostname)
influx_url="https://url.de.votre.influx.db/write?db=telemetrie"

line_protocol=$( printf "up,host=%s up=true" "$host" )

curl -XPOST -u user:password "$influx_url" --data-binary "$line_protocol"
{{< / highlight >}}
</details>

C'est ultra simple et j'imagine que niveau stockage dans Influx ça sera très léger (ouai faut commencer à penser à la volumétrie de données généré par tout cela.
Je déploie ce script sur chacune des machines et je le fous dans un *cron* chaque minute.

Jusqu'à présent c'est vrai que j'ai pas trop parlé de la mise en place côté **grafana** donc je ne vous épargne pas ce coup-ci.
Si vous avez jamais touché ça peut faire un peu peur au début mais retroussons nos manches !

#### Grafanons !
Créons un nouveau panel.
Dedans il faut créer une requête de la base de donnée pour extraire les données que l'on veut.
Donc là, on va picorer dans la base *télémétrie* et plus spécifiquement dans le bucket *up*.
On va *select* le champ *up* et lui appliquer la fonction *last()* qui permet de sélectionner la dernière valeur.
Ensuite on *group by* et le critère qui va nous intéresser sera *tag(host)* ce qui nous permettra de ne pas mélanger les métriques des différentes machines.
Et surtout on rajoute un *fill(0)* qui indiquera que si l'on a pas de métrique il faut remplacer par un "0".
Pour que ce soit plus joli, on met un *alias* à la valeur *$tag_host*.
Le tout dernier point à gérer sur ce panneau est le *query options* où l'on définit notre *interval* à la valeur *1m* (vu qu'on ne le relève qu'une fois par minute).

{{< img src="query.png" alt="l'éditeur de query de grafana avec tous ces réglages." title="C'est ptet plus parlant avec une image." >}}

Bon là c'est la moitié du boulot, maintenant il faut la représentation.
Je suis parti sur un *State timeline* qui me semble très adapté pour ce genre d'info.
En gros c'est une frise temporelle avec du vert quand c'est bon et du rouge quand c'est pas bon.
Pour la forme on peut s'amuser à faire un *value mapping* où l'on indique que le "false" > "Down" et "true" > "Up" ce qui est un peu plus parlant et surtout pour ces deux valeurs attribuer des couleurs chatoyantes.

On personnalise le titre et c'est tout bon.

{{< img src="up.png" alt="Affichage des différentes barres montrant le statut des différentes machines." title="Ça fait pro, hein ?" >}}

Voilà un peu le genre de truc qu'on peut faire avec cet outil.

## Toujours plus !
Bon c'est cool je suis super content de tout ça.

J'ai beaucoup aimé me replonger dans ces outils.
J'ai pas mal appris dans cette ptite aventure et j'aimerai ajouter encore d'autres trucs à grapher.

Je vous en parlerai ptet au compte goutte quand je le ferai.

Dans la première partie, on m'a suggeré **Victoria Metrics** en remplacement d'**InfluxDB**.
Et c'est vrai que j'ai un peu regardé et ça semble mieux sur un peu tous les aspects : moins de ram, moins de stockage, de meilleures perfs, compatibles avec influx et avec quelques fonctionnalités supplémentaires et en plus c'est aussi en Go.
It would be a shame if …
