+++
Author = "Lord"
Description = "Suivons toujours les avancées de Purism pour créer le Librem 5. Ce coup-ci on parle juste du modèle d'applications qu'ils veulent mettre en place."
menu = "main"
notoc = true
PublishDate = 2018-03-11T10:12:07+01:00
date = 2018-03-11T10:12:07+01:00
Categories = ["traduction","software","librem","purism"]
title = "8ème article d'avancement du Librem 5"
editor = "kakoune"
+++
Ceci est une traduction libre de [cet article](https://puri.sm/posts/librem5-progress-report-5/) concernant les avancées de la société Purism concernant le smartphone **Librem 5**.
L'article original est sous licence [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/) tout comme ma traduction.


Ce smartphone a bénéficié d'un crowdfunding et a pour but d'apporter une alternative à Android en proposant un OS basé sur Linux et toutes les briques logiciels opensource qui vont avec.
Ils collaborent avec le projet [Gnome](https://www.gnome.org), le projet [KDE](https://www.kde.org) et le projet [Matrix](https://matrix.org).
Ils sont assez transparents sur leurs avancées et sont reconnus pour leur ligne de laptops.

Bref voilà l'article :

<hr>

# Design report #4: applications symbiotiques
Le but à long terme de Purism a toujours été de faire des ordinateurs aussi pratique que respectueux de leurs utilisateurs.
Les Librem sont une plateforme éthique et de ce fait ne devrait discriminer personne.
Au contraire, ils sont fait pour être inclusifs.
En d'autres termes, chacun peut trouver dans son Librem un outil pratique et sécurisé pour son utilisation du quotidien et donc l'accessibilité est une importante part de notre feuille de route concernant le design éthique.

Nous sommes conscient que le chemin sera long et que le Librem 5 représente de nombreux challenges donc nous devons établir de solides fondations qui favorise la praticité autant que possible.

## Les applications des plateformes existantes sont en compétition pour attirer votre attention
Avec les smartphones actuels, vous avez généralement un ensemble de fonctionnalités réduites que vous pouvez agrandir en ajoutant diverses applications selon vos besoins.
Habituellement ces applications sont propriétaires et sont designées autour d'un business model non éthique, d'où le fait quelles sont toutes en compétition permanente pour retenir votre attention et possèdent chacune leur fonctionnalités utilisable uniquement en leur sein.

Ceci amène son lot de redondance et de confusion en terme de fonctionnalité.
Un exemple évident sont les applications de communication, où chacune possède sa façon de gérer les contacts, leur propre protocole de communication verrouillé et isolé et où une tonne d'application vous implémenter les mêmes choses dans le même but (passer des appels et envoyer des messages) en tentant d'être la plus flashy pour attirer et retenir le plus d'utilisateurs.
Une image vaut mieux que mille mots :

{{< figure src="/static/83-diagram1.png" title="Écosystème d'applications en compétition" alt="Diagramme présentant la redondance des données et des fonctionnalité d'un écosystème d'application en compétition" link="/static/83-diagram1.png" >}}

## Envisager un écosystème harmonieux d'applications
Dans le monde réel, les écosystèmes durables sont fait d'entités biologiques interagissants ensembles en harmonie ou symbiose.
C'est ce qui rend la vie possible sur le long terme.

Le monde du logiciel Libre et Opensource, particulièrement les systèmes d'exploitation, sont similaires à un écosystème naturel.
Dans ce monde, pour faire partie du système, vous ne pouvez pas vous isoler et protéger votre technologie (dans le sens restreindre son utilisation).
Les business models et les intérêts sont complètement différents du monde du logiciel propriétaire.
Les bonnes pratiques favorise la réutilisation et l'intégration, l'amélioration de l'expérience utilisateur, la réduction de la dette technique, l'amélioration de la qualité logiciel et la diminution du coût de dev avec un système "collaboratif" où différentes applications de différents auteurs sont faites pour travailler ensemble.

## Le but est la fonctionnalité
L'idée derrière les recommandation de design de PureOS est de remplacer le concept d'application standalone, indépendante et en compétition avec les autres par le concept de petites applications, avec un seul but et favorisant l'intégration dans l'écosystème.
Cela permettra d'obtenir une expérience unifiée au travers des différents appareils (et au delà).
Ces petites applications peuvent être vue comme des «fonctionnalités» du système.
1 but = 1 fonctionnalité

{{< figure src="/static/83-diagram2.png" title="Écosystème d'applications en collaboration" alt="diagramme présentant la symbiose d'applications en collaboration" link="/static/83-diagram2.png" >}}

Pour cela, les grandes lignes des Human Interface Guidelines (recommandation pour les interfaces avec les humains) concernant les fonctionnalités seraient :

  - Ne pas voir chaque application comme indépendantes mais comme des «fonctionnalités» qui n'ont qu'un but et qui interagissent ensembles.
  - Une « fonctionnalité » est le garant de la sécurité de son flux de données . Ne faites partager les données de votre application qu'avec des fonctionnalités ou réseau «de confiance» et d'une manière sécurisée.
  - Faites que votre application ne fasse qu'une chose (un client mail n'est pas un agenda, ni un répertoire).
  - Faites que votre application dépende de fonctionnalités existantes (un client mail doit s'appuyer sur un répertoire existant et sur un agenda existant).
  - Éviter les redondances. N'essayez pas de réinventer les applications existantes. Améliorez-les à la place.
  - Préconfigurez vos applications par défaut. Faites en sorte que ça fonctionne dès l'installation.

## Avantages
Du point de vue de l'utilisateur, les fonctionnalités d'un appareil sont facilement identifiable car elles sont mises en avant par une application à but clairement identifié.
Par exemple, l'application "Appel" est faite pour téléphoner, qu'importe la technologie derrière (ex : Matrix, téléphonie classique, VoIP).
L'application "Messagerie" est utilisé pour envoyer des messages instantanés, qu'importe le protocole sous-jacent (ex : Matrix, SMS, XMPP).
L'application "Contacts" est utilisée pour manipuler et stocker les informations de vos contacts utilisable par l'application "Appel" et "Messagerie".

Du côté des dev, sont aussi simple que possible, les cas d'utilisations sont limités et toute logique non liée au but principal de votre application est déléguée à un autre programme ce qui rendra votre application plus simple à designer, implémenter et maintenir.

## Les données appartiennent à l'utilisateur, pas à l'application
Dans ce système d'application collaborant entre elles, où les applications interagissent les unes avec les autres en harmonie, les données ne sont plus limitées à la logique de l'application.
Les applications agissent comme des services, ou des « fournisseurs de données » pour les autres.
Les données naviguent d'une application à une autre, d'un appareil à une autre, d'un réseau à un autre.

Ce concept implique une séparation forte entre les données et les fonctionnalités où les données appartiennent uniquement à l'utilisateur.
Les applications qui les manipulent sont les garants de leur intégrité et de leur sécurité.

### Complément :
Ce sont des *recommandations*, représentant une vision globale.
Ces recommandations sont là comme un moyen pour guider le design des applications et pour suggérer l'application de bonnes pratiques en général.
Étant donné une qu'une distribution GNU/Linux comme PureOS est une plateforme ouvert où des milliers d'applications sont disponibles indépendamment (tant qu'elles respectent votre liberté !), vous n'êtes pas obligés de vous y conformer pour pouvoir distribuer votre application vers Debian et PureOS.
Qui plus est, ces plans sont un but à long terme qui n'est pas garanti d'être présent «immédiatement» dès la disponibilité de notre plateforme, …

---------------
Bon pas trop d'avancement dans cet article mais ils exposent leur vision de l'écosystème qu'ils veulent atteindre.
On doit donc s'attendre à des applications officielles assez simples (KISS) mais interopérantes.
J'ai un peu peur que les applications soient trop simplistes même si le principe est sympa.
Bon, par contre ils préviennent que ça sera pas forcément complet dès la sortie du système.
