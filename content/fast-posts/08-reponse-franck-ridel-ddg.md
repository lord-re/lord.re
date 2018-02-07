+++
Author = "Lord"
Description = "Blog post pour répondre à l'article de Franck Ridel concernant DuckDuckGo"
Categories = ["actu", "réponse"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-02-04T21:16:39+01:00
date = 2018-02-04T21:16:39+01:00
title = "Réponse à Franck Ridel concernant DuckDuckGo"
+++
Je viens de lire [cet article de Franck Ridel](http://franck-ridel.fr/duckduckgo-le-canard-aux-pratiques-boiteuses/).
J'allais initialement commenter sur le JDH mais ma réponse commençait à être un poil long donc je le fais ici.

-----

## Quels sont les reproches envers Google ?

Google a un business plutôt efficace d'ammassage et de revente de données privées.
C'est un fait établi que je ne nierai pas.
Il est également reproché à Google de collaborer avec la NSA (mais pas forcément de bon cœur).

Le soucis de Google est sa position un peu trop omniprésente sur le mobile et l'Internet en général.
Éviter Google sur Internet est un sport de haut niveau.

## Que propose DuckDuckGo ?

Contrairement à Google leur business model est radicalement différent puisqu'ils ont juste deux moyens de gagner de l'argent.
*Quelques pubs dans les résultats* (uniquement basé sur la recherche en cours) et *des liens affiliés*.

DuckDuckGo base une bonne partie de sa communication sur le fait qu'ils respectent la vie privée. **Ils ne collectent pas  de données personnelles ni les revend.**

## Qu'à déclarer le patron de Qwant à propos de DDG ?

Il a annoncé que DDG hébergeait ses services sur Amazon et que par conséquent les gentils fonctionnaires de la NSA/CIA/FBI peuvent tout simplement aller piocher chez amazon pour récupérer des données.

Ça c'est **absolument vrai**.

Mais ce qu'il ne dit pas c'est que pour Qwant c'est pas vraiment mieux.
Les machines sont probablement hébergées en France.
Il doit donc se plier aux lois Françaises et Européennes.
*Est-ce vraiment mieux ?*

Il pousse à l'amalgame pour discréditer DDG. DDG ne s'est jamais vanter de ne pas collaborer avec la NSA (/…) mais juste de respecter la vie privée.

## Quelle menace ?

Éric Leandri pousse donc à l'amalgame des menaces concernant la vie privée.

Il faut bien distinguer deux choses :

  - Collecter/analyser/recouper des données et les revendre pour du pognon à n'importe qui.
  - Se faire voler des données issues de recherche web par une organisation étatique.

Ce sont deux concept diamétralement opposés qu'on ne peut pas faire passer pour la même chose.

Premièrement la portée des données n'est pas la même. DDG ne peut donner que quelques mots-clés de recherche, votre adresse IP, et les informations leakées par votre navigateur.
Google pour sa part peut y ajouter des informations concernant votre appareil (surtout si c'est un android ou un chromebook), la localisation ultra précise via les AP wifi, les mails que vous avez lu juste avant cette recherche et que vous enverrez ensuite, le trajet que vous avez parcouru ensuite,… bref à peu tout.

Ensuite la personne qui récupère les données… Google se fera un plaisir de revendre vos infos pour quelques menus dollars.
Ce qui est reproché à DDG c'est que les données seront récupérés par la CIA/NSA.
Je veux pas vous faire peur mais vous passerez pas outre la CIA/NSA dès que vos paquets IP toucheront le sol étasuniens (voir un peu ailleurs aussi).

Et je pose une vraie question :

## Est-ce plus grave que mes données soient interceptées par les US que par la France ?

Réellement je ne sais pas quoi penser.
Je suis pas spécialement sûr de préférer que mes données soient lus par des services français.
Je ne pense pas être particulièrement que les services Français soient moins regardant que ceux US.

Parceque oui, en France aussi on surveille les Internets des français.

## Bref Qwant ou DDG ?

Bha ça revient au même.

Le peu de données qu'ils possèderont sur moi iront chez les espions français et usiens mais bon… on peut malheureusement rien y faire.

## Et les autres solutions proposées ?

Voyons un peu les alternatives citées :


  - **Startpage** : Mouai c'est du résultat Google donc ça revient au même niveau interception que Qwant et DDG.
  - **Metager** : Idem.
  - **Searx** : À peu près pareil. Surtout si on utilise une instance personnelle et qu'on l'utilise seul ou presque : les données seront d'autant moins anonymes.

## DDG n'est pas qu'un méta-moteur

Ils ont démarrés effectivement comme étant *juste* une surcouche de Bing le côté respect de la vie privée en plus.
Ils ont depuis évolués et possèdent un bot crawler pour créer leur propre index désormais.
Ils ont donc des résultats bien de chez eux désormais.

−−−−−−−
## PS :
J'ai échangé brièvement par mail avec Kapush et après avoir eu son accord, voilà sa réponse :

Lecture intéressante mais qui fait la même omission que l'article initial.

  1. Qwant est hébergé chez Equinix en banlieue nord de paris
  2. Equinix est une entreprise californienne
  3. D'après la loi US, Le patriot act s'applique à toutes les entreprises étatsuniennes.

Conclusion *Qwant est soumis à exactement le même problème que duckduckgo au niveau de la capture de données par les agences gouvernementales US*.

La subtile différence est que *les USA n'ont pas de loi obligeant à la collecte et rétention des données de connexions, tandis que la France en a*.

Du coup si duckduckgo fait ce qu'ils disent et ne collecte pas les données sur leurs usagers alors il n'y a tout simplement rien à venir prendre.
C'est le modèle utilisé par certains fournisseurs de VPN basés aux USA.

Dans le cas de Qwant pour le moment ils jouent sur le fait que selon eux ils ne sont ni éditeur, ni hébergeur pour contourner l'obligation de collecter/conserver les données.
Comme expliqué dans cette interview: https://www.nextinpact.com/news/97572-dans-coulisses-qwant-interview-deric-leandri.htm

Aussi intéréssant à mentionner par rapport à la pique "duckduckgo c'est rien qu'un métamoteur pour bing", comme tu le fait remarquer ils ont leur propre crawler et ils utilisent aussi d'autres source mais surtout Qwant aussi utilise Bing https://www.nextinpact.com/news/103652-les-liens-moteur-qwant-avec-microsoft-bing.htm
