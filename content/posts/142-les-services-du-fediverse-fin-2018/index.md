+++
Author = "Lord"
Description = "Un petit tour des différents services gravitant dans le Fediverse ActivityPub en cette fin 2018."
Categories = ["alternatives", "fediverse"]
menu = "main"
notoc = true
PublishDate = 2018-11-26T17:23:55+02:00
date = 2018-11-26T17:23:55+02:00
title = "Les services du Fédiverse fin 2018"
+++
J'aime le Fédiverse.
Mais si vous savez, c'est le web 3.0.
Mais contrairement aux annonces précédentes, il existe déjà et vous pouvez l'utiliser dès maintenant !

Donc le Fédiverse c'est tout un ensemble de différents services qui savent parler entre eux.
Du coup, sur le même principe que les mails, un utilisateur sur le service X peut interagir avec un utilisateur du service Y.

Fini les silos de données qui vous enferment et vous retiennent prisonnier.
C'est également un outil pour combattre l'effet réseau : si votre service est dans le Fédiverse, même si vous êtes que deux utilisateurs de votre service, c'est pas grave, vous êtes dans le Fédiverse et avez accès à des millions d'autres utilisateurs !

Le fonctionnement de la fédération ressemble à un mélange des mails et du RSS : vous vous créez un compte sur un serveur dans le Fédiverse et ensuite vous vous abonnez à des émetteurs de contenu (une personne qui blog, une chaîne de vidéo, un hashtag d'une instance, une galerie photo…) et ensuite vous n'avez plus qu'à attendre que le contenu vous soit envoyé dès sa création.
Mais vous n'êtes pas seulement consommateur, vous pouvez également réagir, mettre en favoris, commenter, publier du contenu.

Le Web 2.0 c'est le web participatif où l'utilisateur est captif des plateformes, le Web 3.0 c'est l'utilisateur qui redevient maître de ses données et qui peut participer à toute une myriade de services interconnectés.

Allez c'est parti pour un petit tour du Fédiverse en cette fin 2018.
Si j'oublie un service m'insultez-pas mais parlez-m'en pour que le je rajoute à la liste.

## Mastodon
[Mastodon](https://joinmastodon.org)([RSS](https://blog.joinmastodon.org/index.xml)) est le poids lourd du Fediverse avec ses près de deux millions d'utilisateurs.
C'est donc un système de **microblog** avec des hashtags et une interface avec de multiples colonnes.
De part sa notoriété maintenant, il est le fer de lance du Fédiverse et être compatible avec lui est un objectif primordial pour tout nouveau service qui se crée.
Il est écrit en *Ruby* couplé à *PostgresQL*, *Redis*, *NodeJS*, bref pas le plus simple à héberger.

----------------

## Pleroma
[Pleroma](https://pleroma.social/) est le service que j'ai désormais adopté.

C'est également du **microblog** avec hashtags comme Mastodon mais reposant sur des technologies un poil différentes.
L'avantage est que c'est beaucoup plus simple à héberger que Mastodon et donc pour une instance mono-utilisateur c'est bien plus adapté.
{{< img src="pleromafe.thumb.jpg" link="pleromafe.png" alt="L'interface PleromaFE est sure une colonne, à la twitter" title="Il paraît que ça ressemble à Twitter" >}}

Il y a plusieures interfaces utilisateurs, soit PleromaFE qui ressemble à Twitter avec deux colonnes, une avec les mentions et de quoi écrire et une seconde avec la timeline.
{{< img src="mastofe.thumb.jpg" link="mastofe.png" alt="L'interface MastoFE est un copié collé de celle de Mastodon" title="Non, ce n'est pas Mastodon mais bien Pleroma mais avec MastoFE" >}}
La seconde interface est celle de Mastodon (inspirée de Twidere).

Le rythme de dev est assez élevé mais pour l'instant il n'y a pas de sorties officielles, du coup c'est via git uniquement.
En plus de se fédérer via ActivityPub, il parle le *OStatus* ce qui permet de se raccorder à pas mal d'autres services.
Il est compatible avec les applis Mastodon.
C'est codé en *Elixir* et nécessite une base *PostgresQL*.

Bref si vous voulez en savoir plus j'ai déjà écrit [un article rien qu'à lui]({{< ref "/posts/136-pleroma" >}}).

------------

## GnuSocial
[GnuSocial](https://gnu.io/social) est le papy des réseaux sociaux fédérés décentralisés et libres.
Parti d'Identi.ca pour finir en GnuSocial après moults forks et merges…

C'est encore du **microblog** à l'ancienne (comprendre Twitter) mais souvent les instances ont viré la limitation du nombre de caractères.
{{< img src="gnusocial.thumb.jpg" link="gnuscocial.png" alt="L'interface ressemble comme deux gouttes d'eau à Twitter" title="Le microblog approuvé par RMS" >}}
L'interface principale de Pleroma était à la base une interface pour GnuSocial.
La montée en puissance de Mastodon lui a redonné un sursaut d'activité.

Il est codé en *PHP* avec une base *MySQL* ce qui était classique à l'époque où il a commencé.

---------------

## MissKey
[Misskey](https://joinmisskey.github.io/en/)([RSS](https://joinmisskey.github.io/feed.rdf)) est un Mastodon qui a été doppé, programmé principalement par des Japonais.

C'est donc du **microblog** mais propose pas mal de petites améliorations dans l'interface mais également des fonctions supplémentaires comme, par-exemple, des jeux/des sondages/des réactions…
Ils se vantent d'être en perpétuelle évolution et force est de constater que le rythme de dev actuel est effectivement très élevé.
{{< img src="misskey.thumb.jpg" link="misskey.png" alt="La Home de Misskey est assez joli avec des widgets un peu partout." title="Au premier abord c'est assez fouilli mais au final pas tant que ça, il y a pas mal de thêmes différents (dont des sombres).">}}
Je l'ai un peu testé mais pas plus que ça.

Côté technique c'est du *NodeJS* avec *MongoDB* …

--------

## Microblog.pub
[Microblog.pub](https://microblog.pub/) est encore un service de **microblog**.

Il est orienté instance mono-utilisateur et se targue de ne pas nécessiter JS (tout le monde s'en fout ou presque mais moi non et visiblement l'auteur non plus).
{{< img src="microblog.thumb.jpg" link="microblog.png" alt="Du microblogging pur, sans aucune fioriture" title="Le minimalisme dans le Fédiverse" >}}
Je ne l'ai pas testé, mais il a l'air un peu plus simple que la concurrence.
J'ai l'impression qu'il s'oriente moins dans l'interaction et plus dans la publication.

Il est écrit en *Python*.

--------------------------

## Osada
[Osada](https://zotlabs.com/osada/) est tout récent et représente un peu moins d'une centaine d'utilisateurs à l'heure actuelle.

Il parle ActivityPub mais aussi Zot (que je ne connais pas).
Il n'est pas centré uniquement sur le **microblog** mais un **mix étrange de différentes apps**.
On peut biensûr microblogguer (et ça fédère) mais il propose même du *WebDAV* (transfert de fichier) ce qui est pour le moins surprenant mais ça fédère pas.

{{< img src="osada.thumb.jpg" link="osada.png" alt="aperçu de l'interface dépouillée d'Osada" title="le design est bien moins à la mode mais ça charge vite." >}}
Il propose une gestion (basique) de calendrier et d'évènement, mais ça ne fédère pas.

Sa population est bien plus diverse qu'à l'accoutumée : à première vue peu d'occidentaux, beaucoup de Sud-Américains et de Caribbéens.
Bon je l'ai testé une soirée, j'ai pas réussi à avoir de contacts avec d'autres personnes…

Le projet est surement bien trop jeune pour le moment mais à surveiller, il adopte une approche clairement différente et sa communauté pourrait s'avérer bien différente de ce à quoi on est habitué par chez nous.

Pour monter une instance ça sera encore du *PHP* et du *MySQL* ou *PostgreSQL*.

----------------------

## Friendica
[Friendica](https://friendi.ca/)([RSS](https://friendi.ca/feed/)) est une implémentation de *Diaspora* (ça tire du côté de Facebook) mais est en passe d'ajouter le support d'*ActivityPub* (en plus de Diaspora et *OStatus*) et donc se fédère déjà avec les services précédemment cités.

C'est lui aussi un ancien avec environ 2000 utilisateurs actifs et un grand nombre d'instances.
{{< img src="friendica.thumb.jpg" link="friendica.png" alt="" title="| merci Jared" >}}
C'est moins orienté **microblog** et plus **partage de photos/d'évènements et compagnie**.

J'ai pas testé, mais ça ne m'attire pas dans le concept, c'est pas ce que j'affectionne dans les réseaux sociaux.
Il propose le moyen de communiquer via *IMAP* ce qui est unique pour l'instant.
C'est propulsé par le classique *PHP*+*MySQL*.

------------------

## Hubzilla
[Hubzilla](https://project.hubzilla.org) ressemble un peu à Osada : il est compatible un peu avec tous les protocoles du Fediverse *Zot*, *ActivityPub*, *Diaspora* et *OStatus*.
Le fourre-tout.
{{< img src="hubzilla.thumb.jpg" link="hubzilla.png" alt="Encore une capture d'écran de réseau social, rien de bien différent" title="La home de Hubzilla | Lascapi" >}}
Je ne l'ai pas testé mais visiblement il tente de se fédérer le plus possible.
Merci [Lascapi](https://mastodon.zaclys.com/@lascapi) pour l'image.

Si vous voulez monter votre instance c'est le classique *PHP* et *MySQL*.

------------------

## Peertube
[Peertube](https://joinpeertube.org/) est un projet monté par Chocobozz et fortement soutenu par la communauté via un crowdfunding monté par Framasoft.
Il s'agit d'un service de **vidéos en ligne** à la Youtube mais encore une fois avec la fédération et tout.

Bien entendu vous pouvez regarder les vidéos des différentes instances sans vous y créer de compte.
{{< img src="peertube.thumb.jpg" link="peertube.png" alt="Interface de l'instance Skepticon" title="L'interface est classique pour un visiteur lambda tout en étant fédéré, comme quoi c'est faisable." >}}

Donc un vidéaste poste une vidéo et des gens depuis un autre service peuvent commenter/mettre en favoris…
Le projet bien que déjà fonctionnel n'en est qu'à ses débuts et donc de nombreuses fonctionnalités sont encore à attendre.

Il est propulsé par *NodeJS* avec *PostgreSQL* mais aussi *Redis* et nécessitera *FFmpeg* pour l'encodage vidéo.
Attention se monter une instance Peertube va nécessiter du CPU pour l'encodage des vidéos, de pas mal de stockage et aussi pas mal de bande passante, c'est clairement le plus cher à héberger de tout le Fédiverse.

------------------

## Funkwhale
[FunkWhale](https://funkwhale.audio/) est lui le Grooveshark du Fédiverse.
C'est une application pour **écouter de la musique** en fédérant les bibliothèques et à terme plus d'interactions avec le reste du Fédiverse.
{{< img src="funkwhale.thumb.jpg" link="funkwhale.png" alt="L'interface est scindée en deux, à gauche la partie lecture, à droite la partie bibliothèque." title="C'est effectivement assez ressemblant à Grooveshark comme à l'époque." >}}

Pour se monter une instance il faut un ptit *PostgreSQL*, un *Redis* et surtout *Python*.

------------------

## Plume
[Plume](https://plume-org.github.io/Plume/) est un service de **Blog**, pas microblog mais de vrai blog.
Exit les limitations de caractères et bonjour le MarkDown pour rédiger des articles.

Il est codé en *Rust* avec une base *PostgreSQL* ou *SQLite*.
Les articles sont donc suivables depuis les autres services.
{{< img src="plume.thumb.jpg" link="plume.png" alt="Exemple de blog de Valère" title="L'interface de Plume et à droite, le même article vu depuis Pleroma." >}}
Par exemple, depuis Pleroma, vous suivez un auteur, vous recevrez l'article complet qui apparaîtra dans votre Timeline un peu à la façon des RSS.

------------------

## Write.as
[Write.as](https://write.as/)([RSS](https://write.as/blog/feed/)) est un autre service de **Blog**, un peu comme Plume mais il s'agit d'une plateforme payante, mais le logiciel est libre et auto-hébergeable également.
Je ne l'ai pas testé mais visiblement ça marche bien, les articles de blog sont bien poussés vers les followers et dans le futur il sera même possible de commenter depuis le Fediverse en répondant.
{{< img src="writeas.thumb.jpg" link="writeas.png" alt="Cela ressemble à n'importe quel blog" title="À gauche l'article de blog et à droite comment ça apparait dans Pleroma." >}}

Le logiciel qui propulse le service est [WriteFreely](https://code.as/writeas/writefreely) et est écrit en *Go* et stock dans *MySQL*.
Il est intéressant de voir que les devs du projet monte une instance officielle payante pour pouvoir se rémunérer mais qu'il est possible de s'auto-héberger gratuitement.

------------------

## Read.as
[Read.as](https://read.as/) est fait par la même équipe que Write.as (sisi je vous jure !), c'est pour … heuu … **lire du contenu du Fédiverse**.
Pour le moment il n'y a pas grand-chose à se mettre sous la dent mais à voir dans quelque temps.
Potentiellement intéressant.
C'est aussi du *Go* et *MySQL*.

------------------

## Prismo
[Prismo](FIXME) est un simili HackerNews/Journal du Hacker/Reddit, bref, un **aggrégateur de liens**. 

Du *Ruby*, du *NodeJS* et du *PostgreSQL* ici.
{{< img src="prismo.thumb.jpg" link="prismo.png" alt="L'interface web de Prismo ressemble énormément aux alternatives" title="On reste sur une interface standard, la partie fédérée ne transparait pas." >}}
Il est possible donc de poster des liens, qui seront notés et commentés.

Le projet est tout jeune mais déjà fonctionnel.

------------------

## PixelFed
[PixelFed](https://pixelfed.org/) est l'instagram du Fediverse.
Bon je dis ça mais j'ai jamais vu Instagram non plus, je sais pas à quel point cette comparaison tient la route.
Bref c'est du **partage de photos** fédéré.
{{< img src="pixelfed.thumb.jpg" link="pixelfed.png" alt="Les images prennent le plus de place dans une interface très dépouillée." title="La Home | Jared">}}
Je ne l'ai pas testé mais quelques images en provenance de Dada : [timeline](pixelfed-timeline.jpg)-[profile](pixelfed-profile.jpg)-[settings](pixelfed-settings.png)-[discover](pixelfed-discover.jpg).
Merci à [Jared](https://crazynoisybizarre.town/@Jared) et [Dada](https://diaspodon.fr/@dada) pour les images.

Il n'est pas encore complètement fédéré (c'est d'ailleurs à deux doigts de devenir un meme du Fediverse), mais ça arrive bientôt.
Il tourne avec le classique *PHP*+*MySQL* avec supplément *Redis*.

------------------

## Pinafore
[Pinafore](https://pinafore.social/) est juste un frontend pour Mastodon, une interface utilisateur quoi.
Il vous faut un compte sur une instance Mastodon ailleurs et Pinafore vous fournira une interface différente.
{{< img src="pinafore.thumb.jpg" link="pinafore.png" alt="L'interface est très sobre sur une seule colonne et très réactive" title="C'est plus dépouillé que le Mastodon par défaut et très réactif.">}}
C'est écrit avec [svelte](https://svelte.technology/) que je ne connaissais pas.

------------------

## Aardwolf
[Aardwolf](https://aardwolf.social)([RSS](https://aardwolf.social/feed.xml)) va être un simili facebook.
Il est codé en *Rust* mais n'est pour l'instant pas du tout utilisable, c'est beaucoup trop tôt.
{{< img src="aardwolf.thumb.jpg" link="aardwolf.png" alt="C'est un prototype de la future interface" title="Juste une maquette pour le moment." >}}
On en reparlera dans quelques années quand il se féderera via ActivityPub.

------------------

## Anfora
[Anfora](https://github.com/anforaProject/anfora) se veut assez proche de PixelFed avec le partage de photo en ligne de mire.
Codé en *Python*, il utilise pour sa part *Redis*.
Il est lui aussi encore trop tôt pour l'utiliser, il ne se fédère pas encore au Fédiverse mais ça devrait arriver avant la première version 0.1.

-------------
## Plus d'infos concernant le Fediverse
Il existe quelques sites qui vous permettront d'avoir des infos diverses et variées :

  - [The-Federation.info](https://the-federation.info/) propose des stats sur le nombre d'utilisateurs et de nœuds des différents services.
  - [Fediverse.party](https://fediverse.party/) est plus joli et plus joyeux (bha ouai c'est une fête !) est plus didactique et propose un [flux RSS](https://fediverse.party/atom.xml) avec des news en provenance d'un peu tous les services du fediverse.
  - [Fediverse.network](https://fediverse.network/) est plus austère mais propose du monitoring des instances (et par la même occasion quelques stats).

-------------
Je remarque en passant que pas mal de ces projets héberge leur code ailleurs que sur Github (certains ont quand même un miroir sur github).
Il existe d'ailleurs un projet de forge logiciel avec support ActivityPub, on pourra bientôt recevoir les commits dans notre ptite Timeline !

