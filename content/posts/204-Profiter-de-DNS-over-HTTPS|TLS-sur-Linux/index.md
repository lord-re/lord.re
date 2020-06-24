+++
Author = "Lord"
Description = "Blocky est un proxy DNS vous permettant de profiter de la sécurité supplémentaire permise par DoT et DoH pour vos requêtes DNS. Avec ça, vos requêtes DNS ne seront connues que de votre résolveur DNS et de vous."
Categories = ["dns", "linux","software"]
menu = "main"
notoc = true
WritingDate = 2020-06-03T13:24:55+02:00
date = 2020-06-04T13:24:55+02:00
title = "Blocky : un proxy DNS pour votre nunux"
editor = "kakoune"
TopWords = ["dns","résolveur","lan","turris","lxc","dnssec","doh","dot"]
+++
C'est un sujet pas mal à la mode ces derniers temps le DNS.
C'est la pierre angulaire d'Internet.
Sans le DNS à peu près tout le net s'effondre.

Celui qui contrôle le DNS contrôle le monde comme dirait l'autre.
C'est d'ailleurs par ce biais que l'État fait taire les sites embarassants.
Bref, c'est un outil sensible et qui mérite qu'on s'y intéresse.

À la base c'est un protocole assez simple où tout se balade en clair.
Et donc qui dit en clair dit 0 sécurité.
Dont tout chacun peut facilement épier les requêtes et réponses DNS de son réseau.
Et il est également aisé pour n'importe quelle machine sur le trajet d'interecpter et de modifier ce qu'il circule.

Imaginez, vous demandez l'adresse de <kbd>petit.partie.politique.minoritaire.fr</kbd> et en réponse vous obtenez finalement l'adresse ip correspondant à <kbd>censure.politique.fr</kbd> .
Ouai c'est un exemple super caricatural mais … c'est un peu ce qui se fait déjà.
Lorsque vous demandez l'adresse IP de certains services, vous obtenez parfois rien en réponse suite à une décision de justice.
C'est souvent des sites de diffusion culturelle qui sont impactés.

## DNSSEC, DoT, DoH
Au fil du temps, on s'est rendu compte que le DNS c'est super mais que question sécurité il y avait du boulot.

Est donc arrivé DNSSEC qui permet de garantir qu'une réponse reçue n'a pas été modifiée.
C'est donc tout un ptit paquet de cryptographie qui a été ajouté au protocole d'origine.
C'est optionnel et d'ailleurs assez peu répandu (faites-le si vous possédez un domaine) et assez peu compris mais c'est quelque chose de capital.

Ça garantie l'intégrité de la réponse mais absolument pas la confidentialité des échanges.
Si vous faites une requête pour <kbd>le.terrorisme.pour.les.nuls</kbd>, votre FAI le saura, votre routeur également et tous les membres de votre réseau local également mais rassurez-vous, vous pourrez être sûr que la réponse obtenue est légitime.

Bon, maintenant qu'on a l'assurance de l'authenticité de nos réponses, est-ce qu'il serait pas temps d'avoir droit à un peu plus d'intimité numérique ?
Et c'est là qu'entre en scène deux nouveaux protocoles : DNS over TLS et DNS over HTTPS.
En gros, on fait passer les requêtes DNS dans du TLS ou bien de l'HTTPS.

TLS c'est la couche de sécurisation assez standard qu'on retrouve dans de très nombreux protocoles.
C'est ce qui est utilisé pour les mails par exemple, ou IRC mais son emploi le plus répandu est dans … HTTPS.
Ouaip.

Et du coup quelle est la différence entre DoT et DoH ?
Bha franchement pour l'utilisateur c'est sensiblement identique même si DoH a un petit avantage : il passe par HTTPS.
Je m'explique : de très nombreux points d'accès libres sont très restreints et permettent d'utiliser le protocole DNS, HTTP et HTTPS et rien d'autre.
Dans ce genre de cas, DoT ne fonctionnera pas car il sera bloqué contrairement à DoH.

Bref, en utilisant l'un de ces deux protocoles vous pouvez garantir que vos requêtes DNS ne seront lisibles que par votre résolveur DNS (le serveur) et votre ordinateur.

Le gros frein à l'adoption est que les systèmes d'exploitation actuels ne savent pas s'en débrouiller actuellement même s'il se murmure que pour Windows ça devrait arriver rapidement.

## Here comes Blocky
Heureusement si le système d'exploitation ne sait pas le faire nativement, il est possible (tout du moins sous Linux, le reste m'en fout grave) de passer par un logiciel pour pallier ce manque.
Je ne cherchais pas vraiment à le faire mais je suis tombé parfaitement par hasard sur un ptit logiciel en Go (j'adore) qui sert donc de proxy.

[Blocky](https://github.com/0xERR0R/blocky/) !
Il se fait passer pour un **résolveur DNS classique**, mais de son côté il parle soit **DNS**, soit **DoT**, soit **DoH**.
Du coup vous allez pouvoir profiter de tous les avantages précédemment cités.

Il est super *simple à mettre en place, léger et tourne sans faire d'histoire*.
Il a l'énorme avantage de pouvoir utiliser bien plus de serveur DNS que votre système d'exploitation : ici vous pouvez en mettre autant que vous voulez.
Pour chaque requête qu'il reçoit, il enverra 2 requêtes vers 2 serveurs de sa liste : il transmettra la première réponse qu'il recevra.
Et d'ailleurs les serveurs qui lui renverront des erreurs auront moins de chance d'être séléctionné les prochains coups.
C'est tout con mais ça permet d'*utiliser des résolveurs publiques à la fiabilité moindre sans pour autant en pâtir* lorsqu'ils déconneront.

Un autre de ses atouts est la possibilité de ne plus être neutre.
Quoi ?!
Comment ?!
Bha ouai mais c'est la mode désormais.
Le but n'est pas de censurer mais de zapper du contenu non désiré.
On peut s'en servir pour *bloquer la pub*.
Voilà, vous allez pouvoir vous faire un truc à la pi-hole.

Ha, il fait *cache* aussi mais bon c'est plus classique pour un simili-résolveur DNS.

Voilà, il a toutes les bonnes features et pour l'instant rien a lui reprocher.

Dans les fonctionnalités que je n'ai pas testé également :

  - des stats à donner à bouffer à Prometheus
  - peut être consulté en DoH directement pour ceux utilisant Firefox par exemple

Gardez en tête que c'est un projet super récent (moins de six mois) et qu'il peut donc pas mal évoluer.

## Installation
Je fais tourner ça sur mon routeur dans un ptit container Alpine.
Je créé le container, lui affecte une IP.

Le template Alpine que j'utilise a quelques services assez inutiles que je vire, au boot je ne garde que … bha rien en fait.
Ensuite, Blocky doit bosser en root.
Donc bha pas d'user à créer.
Vu que le container ne sert qu'à ça … bha je tolère sinon il aurait été pas mal de le faire tourner en tant qu'utilisateur normal et de lui rediriger les connexions entrantes vers un port >1024 à coup d'iptables.

Blocky n'est pas dans les dépots, mais c'est pas grave.
Je le compile sur mon ordi mais à destination du routeur.
Comme c'est du Go c'est super simple et rapide.
<kbd>GOARCH=arm GOARM=7 go build main.go</kbd>

Au bout de quelques secondes on a un binaire d'une trentaine de Mo.
Ouai là pour certains ça va paraître minuscule mais pour d'autre énormes.

En vrai c'est assez énorme pour un binaire mais comme c'est du statique ça intègre tout ce qu'il faut dedans.
Il est possible de le réduire avec quelques options mais pour l'instant franchement pas trop besoin (<kbd>-ldflags="-s -w"</kbd> lors de la compilation).

Il ne reste plus qu'à déposer le binaire dans */usr/sbin/blocky* par exemple.

### Fichier init
Ouai je sais c'est horrible mais je n'utilise toujours pas systemd.
J'ai donc dû me démener pendant des heures afin de pondre ce fichier d'init.
Il n'y a pas à dire, systemd a vraiment simplifié la vie ⁿᵒⁿ.

<details open><summary>/etc/init.d/blocky</summary>
{{< highlight "shell" >}}
#!/sbin/openrc-run

name="Blocky : DNS proxy"
command="/usr/sbin/blocky"
command_args="-c /etc/blocky.yml"
pidfile="/var/run/blocky.pid"
start_stop_daemon_args="-b -m"
{{< / highlight>}}
</details>

Voilà, après ce paroxysme de la complexité, il faut quand même rendre le script éxécutable avec <kbd>chmod +x /etc/init.d/blocky</kbd> et on termine en apothéose avec l'activation au boot avec <kbd>rc-update add blocky</kbd>.

### Fichier de conf
<details><summary>/etc/blocky.yml</summary>
{{< highlight "yaml" >}}
upstream:
    # these external DNS resolvers will be used. Blocky picks 2 random resolvers from the list for each query
    # format for resolver: net:host:[port][/path]. net could be tcp, udp, tcp-tls or https (DoH). If port is empty, default port will be used (53 for udp and tcp, 853 for tcp-tls, 443 for https (Doh))
    externalResolvers:
# Les méchants
#      - udp:1.1.1.1
#      - udp:8.8.8.8
# FDN
#       - udp:80.67.169.12
#       - udp:[2001:910:800::40]
# LDN
#       - tcp-tls:2001:913::8:853 HS
#       - tcp-tls:80.67.188.188:853 HS
#       - tcp-tls:ns0.ldn-fai.net:853 HS
       - https://ldn-fai.net/dns-query
# Les Gentils
       - https://dns.hostux.net/dns-query

# Les Méchants bis
#       - tcp-tls:1.1.1.1:853
#       - https://cloudflare-dns.com/dns-query
#       - https://dns.nextdns.io/
#       - https://dns9.quad9.net/dns-query

# optional: custom IP address for domain name (with all sub-domains)
# example: query "printer.lan" or "my.printer.lan" will return 192.168.178.3
#customDNS:
#    mapping:
#      printer.lan: 192.168.178.3

# optional: definition, which DNS resolver should be used for queries to the domain (with all sub-domains).
# Example: Query client.fritz.box will ask DNS server 192.168.178.1. This is necessary for local network, to resolve clients by host name
#conditional:
#    mapping:
#      fritz.box: udp:192.168.178.1

# optional: use black and white lists to block queries (for example ads, trackers, adult pages etc.)
blocking:
    # definition of blacklist groups. Can be external link (http/https) or local file
    blackLists:
      ads:
        - https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt
        - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
        - https://mirror1.malwaredomains.com/files/justdomains
        - http://sysctl.org/cameleon/hosts
        - https://zeustracker.abuse.ch/blocklist.php?download=domainblocklist
        - https://s3.amazonaws.com/lists.disconnect.me/simple_tracking.txt
      special:
        - https://hosts-file.net/ad_servers.txt
    # definition of whitelist groups. Attention: if the same group has black and whitelists, whitelists will be used to disable particular blacklist entries. If a group has only whitelist entries -> this means only domains from this list are allowed, all other domains will be blocked
    whiteLists:
      ads:
        - whitelist.txt
    # definition: which groups should be applied for which client
    clientGroupsBlock:
      # default will be used, if no special definition for a client name exists
      default:
        - ads
        - special
      # use client name or ip address
      #laptop.fritz.box:
      #  - ads
    # which response will be sent, if query is blocked:
    # zeroIp: 0.0.0.0 will be returned (default)
    # nxDomain: return NXDOMAIN as return code
    # comma separated list of destination IP adresses (for example: 192.100.100.15, 2001:0db8:85a3:08d3:1319:8a2e:0370:7344). Should contain ipv4 and ipv6 to cover all query types. Useful with running web server on this address to display the "blocked" page.
    blockType: zeroIp
    # optional: automatically list refresh period in minutes. Default: 4h.
    # Negative value -> deactivate automatically refresh.
    # 0 value -> use default
    refreshPeriod: 0

# optional: configuration for caching of DNS responses
caching:
  # amount in minutes, how long a response must be cached (min value).
  # If <=0, use response's TTL, if >0 use this value, if TTL is smaller
  # Default: 0
  minTime: 40
  # amount in minutes, how long a response must be cached (max value).
  # If <0, do not cache responses
  # If 0, use TTL
  # If > 0, use this value, if TTL is greater
  # Default: 0
  maxTime: 0

# optional: configuration of client name resolution
clientLookup:
  # optional: this DNS resolver will be used to perform reverse DNS lookup (typically local router)
  # upstream: udp:10.0.254
  # optional: some routers return multiple names for client (host name and user defined name). Define which single name should be used.
  # Example: take second name if present, if not take first name
  singleNameOrder:
      - 2
      - 1
  # optional: custom mapping of client name to IP addresses. Useful if reverse DNS does not work properly or just to have custom client names.
  clients:
    hermes:
      - 10.0.0.3
    huawei:
      - 10.1.0.10
# optional: configuration for prometheus metrics endpoint
prometheus:
  # enabled if true
  enable: false
  # url path, optional (default '/metrics')
  path: /metrics

# optional: write query information (question, answer, client, duration etc) to daily csv file
queryLog:
    # directory (should be mounted as volume in docker)
    dir: /var/log/blocky
    # if true, write one file per client. Writes all queries to single file otherwise
    perClient: true
    # if > 0, deletes log files which are older than ... days
    logRetentionDays: 7

# optional: DNS listener port, default 53 (UDP and TCP)
port: 53
# optional: HTTP listener port, default 0 = no http listener. If > 0, will be used for prometheus metrics, pprof, REST API, DoH ...
httpPort: 4000
# optional: HTTPS listener port, default 0 = no http listener. If > 0, will be used for prometheus metrics, pprof, REST API, DoH...
#httpsPort: 443
# mandatory, if https port > 0: path to cert and key file for SSL encryption
httpsCertFile: server.crt
httpsKeyFile: server.key
# optional: use this DNS server to resolve blacklist urls and upstream DNS servers (DOH). Useful if no DNS resolver is configured and blocky needs to resolve a host name. Format net:IP:port, net must be udp or tcp
bootstrapDns: tcp:10.0.0.254
# optional: Log level (one from debug, info, warn, error). Default: info
logLevel: info
{{< / highlight >}}
</details>

Voilà c'est le fichier de conf de base avec au final très peu de modification.
Il est bien commenté donc vous devriez pouvoir vous en dépatouiller sans encombres.

Il ne restera plus qu'à configurer vos machines pour utiliser ce résolveur DNS en éditant leur */etc/resolv.conf* respectifs ou bien en éditant la configuration du serveur DHCP (plus efficace).


PS : l'article est parti plus tôt que prévu avant d'être parfaitement fini, désolé.
