+++
Author = "Lord"
Description = "La fin Septembre 2018. Le festival Frames, la hausse de prix online, migration vers kif, ajout d'un SSD dans le routeur."
Categories = ["meta", "actu","perso"]
menu = "main"
notoc = true
PublishDate = 2018-10-01T22:20:11+02:00
date = 2018-10-01T22:20:11+02:00
title = "La fin Septembre 2018"
editor = "kakoune"
+++
Ouai le titre est nul (en vrai je l'ai pas encore écrit mais je sais pas quoi mettre donc ça sera probablement nul quand je publierai).

Bref ne perdons pas de temps en palabres, je poste un peu moins en ce moment, mais je suis pas mal occupé de trucs offline et/ou de truc pas suffisamment intéressant pour en écrire des articles.
Du coup je vais faire un seul ptit article avec un peu tout ça.

## Frames
Ce week-end s'est tenu le [Frames Festival](http://framesfestival.fr/) à Avignon.
C'est une convention sur deux jours (pour le grand public) avec des vidéastes venant présenter leurs dernières créations mais aussi pour discuter en rapport avec leur domaine respectif ou carrément de création de contenu audio-visuel.

J'y allais moyennement chaud mais au final *j'ai été conquis*.
Les intervenants sont tous supers sympas et surtout **accessibles**.
Ils sont à portée de bras et il y a toujours moyen de trouver un ptit créneau soit pour faire sa groupie et grapiller un autographe soit carrément de discuter quelques minutes.
La team de l'orga s'est vraiment décarcassée pour rendre les attentes moins longues, les lieux sont sympatoches (erf j'ai appris que le cinoche Pandora était en galère administrative, j'espère qu'ils pourront rouvrir même si je peux pas trop y aller, le concept est franchement génial).
J'ai d'ailleurs appris qu'*ils sont en train de monter une asso/syndicat/société de protection pour aider les vidéastes*, ça a été discuté lors des journées PRO précédents le week-end.
J'ai pu rencontrer dans le désordre : 

  - **François Descraques** qui a dédicassé son livre en avant première et a pu balancer pas mal d'anecdotes croustillantes. Et ptet même qu'il va y avoir une suite à *3ème droite* et ptet même que ça se lira pas…
  - Le **Fossoyeur de films** qui est co-organisateur de l'initiative a tenu quelques conférences toutes centrées sur la saison 3 de Twin Peaks si j'me souviens bien.
  - Son pote Patrick Baud le fameux **Axolot** qui a diffusé sa prochaine escale à Paris.
  - **Cyrus North** avec son acolyte (désolé j'ai pas retenu le nom) qui a enregistré en live un podcast avec donc Axolot et Léo Grasset de **Dirty Biology** sur comment survivre à une invasion zombie.
  - **Flober** qui a donné une bonne liste de conseil à propos de l'écriture de scénar et la diffusion de sa dernière vidéo.
  - **Alt236** que je ne connaissais pas. J'ai découvert une semaine avant le festival et me suis tout tapé et suis devenu fan : il parle de cinéma, fait de la musique, relie ça à de la peinture, bref de l'art avec toujours des thêmatiques tourné vers l'étrange, le sombre, le glauque. Il est super sympa et passionné et a tenu donc une conférence sur "l'inquiétante étrangeté". Bref allez-voir [ce qu'il fait](https://www.youtube.com/channel/UC1KxoDAzbWOWOhw5GbsE-Bw/videos). J'ai eu son tout premier autographe !
  - **Realmyop**, **Florence Porcel**, **French Food Porn** et **Aude GG** qui ont discuté des troubles mentaux des youtubeurs. Rien de bien nouveau sous le soleil et d'ailleurs je pense que je ferai un article dédié à cela mais ça va demander un peu plus de réflexions.
  - **Adrien Ménielle** et **Jérôme Niel** nous ont présenté un court métrage qui ne sera diffusé sur Youtube que dans un an. Un hommage aux séries des années 90. Franchement bien fait et hilarant.
  - La team **Nexus VI** qui fait l'une des meilleures chaîne francophone à mon goût. Techniquement ça claque, ça sort de la masse et en plus c'est drôle et ça parle science-fiction et visiblement j'ai des goûts cinématographiques raccords avec le Capitaine. Mais ce qui était bien c'est que c'était une apparté avec les techos du Nexus VI qui ont abordé leur façon de bosser et tout. Ils vont faire un crowdfunding en Octobre ;-) Tiens d'ailleurs, la 3D est faite sous Blender : des gens biens !
  - Une aparté avec Bruce d'**E-penser** on a parlé un peu avenir de sa chaîne, d'Arel3 et on a pas réussi à avoir le moindre spoiler :-(
  - J'ai découvert **Romain Houles** qui a récemment monté une [chaîne youtube : Derrière le masque](https://www.youtube.com/channel/UCow2gT3meZphlG8D2sa9nig/videos) qui parle des effets spéciaux (non numériques). On a un peu discuté et du coup je ne connaissais pas encore son travail, mais j'ai maintenant vu deux de ses vidéos et c'est pour l'instant vraiment bien avec pas mal de boulot de recherche et tout.

Bon bha va falloir y aller l'an prochain !
J'ai pas pu tout voir mais bon.

## Serveur
*Online a récemment décidé de monter ses prix*.
Mais quand ils le font ils font pas semblant.
Du coup je vais résilier *zapp* que je louais chez eux depuis quelques années.
Il était clairement surdimensionné, mais il avait pas mal de stockage ce qu'ils ne proposent plus (tout du moins pas du tout dans cette gamme de prix).

Du coup *je me suis trouvé un autre VPS et je vais me débrouiller autrement pour le stockage*.
Je suis donc progressivement en train de migrer ce qu'hébergeait zapp.

J'ai fait le DNS ce soir à base de copié/collé des fichiers inhérents à Knot de l'ancien vers le nouveau.
Ensuite direction le registrar (recoucou online), où je modifie les serveurs DNS ayant autorité sur la zone pour donner le nouveau VPS.
Je modifie le SOA en accord avec ça.
Et d'ailleurs je remarque qu'enfin, Online permet de signer sa zone DNSSEC (enfin permet de lui passer le DS record pour fermer le dernier maillon manquant de DNSSEC).
Du coup très bientôt vous pourrez chopper la zone lord.re en DNSSEC.

Il va me rester à migrer **TinyTinyRSS**, les **mails** (que je meure d'envie de dégager, je HAIS les mails) et le ptit **Sandstorm**.

Pour les backup je vais me débrouiller autrement.

## Routeur
Vous avez probablement constaté quelques interruptions de services il y a quelques jours.
*Orange a décidé de modifier la façon dont ils attribuent les adresses IP*.
Pour les clients utilisant une box pas de soucis elle a eu une mise à jour va bien mais pour les autres… bha faut se démerder.

En gros, le DHCP répondait plus.
Certains ont donc remis la livebox et ont sniffé le trafic réseau entre l'ONT et la box.
Ils se sont rendu compte que l'auth DHCP avait quelques peu changé (trois fois rien mais suffisamment pour que ça soit plus compatible).
Une fois rajouté une chaîne de caractère dans l'auth DHCP, pouf tout remarche comme avant.

## IPv6
J'en ai d'ailleurs profité pour enfin faire marcher l'IPv6.
Et pour une fois, je me suis laissé guidé par OpenWRT.
D'habitude je déteste toute leur façon de faire.
Ne connaissant pas trop trop IPv6 et n'ayant pas d'expérience à ce propos, bha j'ai fait à leur sauce et tout a marché en deux deux.

Du coup me voilà enfin sur l'Internet de 1998 !

## Backup
Bon pour l'instant mon backup était assez simple : 

  - Les données originales sont dans Bender (un serveur/nas)
  - J'ai un premier backup en tant que disque dur interne branché sur un dock USB sur Bender
  - J'ai un second backup extérieur sur la dédibox

La dédibox va dégager, il me faut donc retrouver un endroit pour le backup.

J'ai pas loin de 600Go de données dans le backup pour la très grande majorité des photos d'appareils numérique et de téléphone.
La première étape a été de *recompresser les photos*, il faut dire que les téléphones pondent des jpeg plutôt bien compressés mais mon appareil photo pas vraiment.
En recompressant les jpeg en gardant toujours une excellente qualité (comparaison côte-à-côte) j'ai pu réduire la quantité de données de moitié et suis donc à environ 280Go.
Je devrais pouvoir gagner 50 Go en compressant les vidéos ce que je ferai probablement un peu plus tard en AV1.
Bref la volumétrie est plus facilement bougeable.

J'ai acheté un SSD au format mSata pour 90 balles que j'ai foutu dans le Turris Omnia où il hébergera les containers LXC dont un dédié au backup.
Comme ça à la maison j'aurai *les données sur du ext4 mécanique, du xfs mécanique et du btrfs ssd*.

Il me manque plus qu'un backup distant ce qui va se finir probablement en NAS chez ma moman.


