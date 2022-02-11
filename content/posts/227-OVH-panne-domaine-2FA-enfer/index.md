+++
Author = "Lord"
Description = "J'ai pété mon nom de domaine et OVH m'a poignardé. Mes galères à base de 2FA, hotline et DNSSEC."
Categories = ["dnssec", "sécurité"]
menu = "main"
notoc = true
WritingDate = 2022-02-07T20:23:04+01:00
date = 2022-02-11T20:23:04+01:00
title = "OVH m'a mis à terre"
subtitle = "Une histoire de DNSSEC, 2FA et de hotline"
editor = "kakoune"
+++
Haaa (\*soulagement\*) !

Cela fait trois semaines que mes mails sont cassés.
Enfin pas tout à fait mes mails mais c'est le plus gros impact de ce qui vient de m'arriver.
Je vous raconte un peu mes déboires de ces dernières semaines.
(je vais finir vlogger putaclic !)

## Trop de sécurité tue la sécurité
J'ai pris un nom de domaine chez OVH il y a maintenant fort longtemps.
C'est un domaine qui me sert assez peu mais quand même un ptit peu.

J'héberge le serveur DNS et tous les autres services moi-même.
OVH n'est réduit qu'au simple rôle de registrar, c'est-à-dire un loueur de nom de domaine.

Je vous ai déjà parlé plusieurs fois de **DNSSEC**, c'est une extension du protocole **DNS** qui permet d'ajouter de la crypto à sa zone DNS et donc c'est une couche de sécurité supplémentaire.
Ça permet de prouver que les réponses obtenues pour un nom de domaine n'ont pas été alteré en chemin.

Donc lorsqu'un utilisateur fait une requête DNS pour mon nom de domaine, s'il a bien configuré sa pile réseau, il peut être certain d'obtenir une réponse véridique.
Mais pour cela, il faut que je signe ma zone avec des clés.
Et pour que ça fonctionne bien, il faut toute une chaîne de confiance, ce qui implique qu'en tant que propriétaire du domaine, je dois envoyer ce qu'on apelle un **enregistrement DS** dans la zone parente.
C'est une tâche qui m'incombe que je dois faire via mon registrar (OVH).

Si cet enregistrement DS n'est pas bon ou absent, la validité DNSSEC n'est pas bonne.
Et si la zone est signée mais que la chaîne de confiance n'est pas bonne de bout en bout, les requêtes DNSSEC ne sont plus bonnes et donc un ordinateur bien configuré doit émettre une erreur.

Il faut toutefois garder à l'esprit que DNSSEC est purement facultatif.
Seuls les utilisateurs ayant choisi d'utiliser un résolveur validant DNSSEC seront impactés en cas de panne de ce genre.
Si votre résolveur ne fait pas de validation DNSSEC, les requêtes DNS fonctionneront.
Ce mécanisme a pour but de ne justement pas fonctionner lorsque la chaîne de confiance n'est pas complète.

## Vraiment trop de sécurité tue la sécurité
Pour vous la faire court, j'ai changé la crypto de ma zone ce qui a donc pété la chaîne de confiance.
Il me fallait renvoyer un enregistrement DS tout neuf et donc je devais me connecter à l'interface d'administration d'OVH.

Facile !

Je vais sur la page web, je dégaine mon gestionnaire de mot de passe.
Je me loggue et là pan un message qui me dit qu'ils ont activé l'authentification à 2 facteurs.
Comme ça.
Sans me demander mon avis.
Et ils l'ont fait sur quoi ?

Sur une adresse mail du domaine qui est justement en panne.

Je me retrouve à devoir récupérer un mail sur le domaine cassé pour pouvoir réparer le domaine cassé.

Voilà voilà.

Alors je sais, il ne faut pas avoir comme adresse de contact une adresse qui dépend du truc que vous voulez administrer mais bon, au bout d'un moment il n'y a pas trop le choix.
Ne comptez pas sur moi pour créer un compte bidon chez un fournisseur de mail générique extérieur juste pour ça en sachant que je renouvelle mon domaine tous les dix ans maintenant…
Mais d'un autre côté ils ont activé sans rien me dire et sans me demander comment configurer l'auth 2FA.

Merci la sécurité.

## Allo vais hache ?
Bon, je tente de regarder un peu leur doc pour savoir comment débloquer le truc mais je trouve rien de probant.
Je me dis que pour une fois je vais aller emmerder un peu le support téléphonique.

On ne sait jamais.
Sur un malentendu, une boîte qui fait de l'hébergement et tout, si ça se trouve la hotline pourrait être vraiment démerdante.

Bon, ça répond super vite, je tombe sur un humain et je décris le truc et …
Ha bha merde, il comprend !
Même les quelques termes techniques que j'ai timidement placés.

Bref, il ne peut pas virer l'auth 2FA (heureusement parceque bon s'il suffisait d'un simple appel de hotline pour le péter…).
Je demande s'il a moyen de virer l'enregistrement DS lui-même.
Bon il ne peut pas non plus (bon… heureusement aussi mais c'est quand même bien dommage).
Il me redirige vers le formulaire pour changer l'adresse mail de contact.
Merci aurevoir.

Bon ça m'a pas tant aidé mais bon, je reçois un mail dans la foulée avec un numéro de ticket.

## Formulaire PDF
Bon, c'est une pauvre page A4 qui demande mon nom/prénom, quelle adresse mail utiliser, une signature.
Il n'y a qu'à mailer ça avec pour preuve de mon identité ma carte d'identité.

Allez, je dégaine **Adobe Reader** sur le pc de ma femme (ouai j'ai rien pour éditer les pdf sur mon ordi).
Je choppe le jpg de ma CNI.
Je renvoie ça par mail à l'adresse indiquée.

## Relation épistolaire naissante
Là je reçois un mail d'accusé de réception du formulaire.
Je reçois le lendemain un mail m'indiquant l'adresse mail de secours de mon compte et qu'ils ne sont pas capables de supprimer l'authentification 2FA.

Ok, bon l'adresse mail en question n'existe plus depuis belle lurette, tant pis.
Et pour le 2FA… bha ouai je sais, c'est bizarre de m'en reparler mais pourquoi pas.

Et là, j'ai été couillon.
J'ai cru qu'ils avaient mis à jour l'adresse mail de contact.
Je tente de me connecter à mon compte et je vois que … manifestement ils tentent toujours d'envoyer à l'ancienne adresse mail.
Du coup je réponds au mail : je leur explique que l'adresse du 2FA n'a pas été mis à jour comme convenu (ce qui au final était normal vu qu'ils n'avaient rien modifié encore).

J'ai une réponse me demandant de remplir le même formulaire que rempli précédemment.

...

Ha.

Je leur indique que j'ai déjà rempli ce formulaire.
Je reçois une réponse me demandant le numéro de ticket et le numéro de case (ce numéro est sur le formulaire).

Et là encore le lendemain une réponse de leur part qui m'indique que sans réponse de ma part dans les 7 jours, le ticket sera fermé.


## Capitulation
Bon, les mails c'est bien gentil mais avec plus de 24h entre chaque interaction, ça ne va pas bien vite.

J'ai lancé une bouteille à la mer sur le Fédiverse.
Un peu désespéré j'ai demandé si quelqu'un avait une éventuelle solution à mon souci.

J'ai eu un coup de main de la part d'une très gentille personne qui bosse à l'**Eurid**.
Il s'agit de l'organisme qui gère les domaines en .eu (ce qui était mon cas !).

Bon, elle en parle autour d'elle et au final, elle ne peut rien faire.
Ça pourrait les foutre un peu dans la merde vis-à-vis d'OVH.

Bon pas de bol, ça ne m'a pas décoincé mais c'était quand même super sympa (merci à toi si tu me lis ;-) ).

Je tente ensuite via IRC, voir si personne ne pourrait m'y démerdouiller.
Pas de bol, le seul contact potentiel que j'avais n'est plus chez OVH du coup pas trop moyen de passer par là.

Je dégaine finalement mon ultime Joker : l'appel à un ami !
J'ai un pote qui bosse chez OVH, mais j'aurai préferé éviter de le faire chier pour ça.
Mais bon, là ça fait déjà plus de trois semaines que ça déconne et j'ai vraiment un besoin très urgent de débloquer la situation.
(Parceque ouai, c'est ma première panne depuis des années mais c'est aussi la première fois depuis des années que j'ai vraiment besoin de mes mails… salopard de Murphy.)

## A new hope
Bon mon pote fourre son nez là où il faut et parvient à contacter une personne susceptible de me décoincer.
*Il s'avère que le formulaire que j'avais rempli trois semaines auparavant n'avait pas été pris en compte.*
J'ai un retour dans les dix minutes par mail : *le formulaire a besoin d'avoir une signature manuscrite*.

“manuscrite”

2022, hébergeur web d'envergure mondiale, le cloud toussa toussa : manuscrite.

Oui oui.
Ils ont ignoré ma requête parceque j'ai rempli le pdf en utilisant un ordinateur mais non il fallait imprimer le pdf, le remplir le scanner et l'envoyer par mail.
Une chance qu'il ne faille pas le faxer ni même le poster !

Bien entendu, je n'ai pas d'imprimante ni de scanner.

Du coup je screenshot le pdf, j'écris sur un bout de papier qui traine les infos demandées.
Je photographie le papier.
J'insère dans **paint.net** mon écriture, je fous un ptit coup de bruit, un coup de flou gaussien, un coup de vignettage, je fais une ptite rotation de quelques degrés, je crop, j'enregistre en jpg avec une compression un peu moche.
Et hop j'ai un document “manuscrit” que je rebalance par mail dans les dix minutes qui suivent. 

Une heure après j'ai un retour par mail comme quoi c'est bon.

## Tout ça pour ça
Je tente de me connecter à l'interface d'admin OVH.
Je reçois le mail du 2FA sur mon adresse fonctionnelle.

Hop, je suis loggué \o/

Je vais dans la partie domaine, je dégage l'enregistrement DS (j'ai au préalable désactivé la signature DNSSEC que je refoutrais dans quelques jours).
Et voilà.
3 minutes de boulot.

Je me suis fait chier pendant trois semaines pour cliquer un bouton.

Bon j'ai une part de responsabilité hein.
Mais quand même, OVH est pas ouf côté support et leur activation du 2FA d'eux-même sans me consulter m'a pas spécialement plu.
Bon, c'est un domaine à 10balles l'année donc je me doute que je vais pas avoir l'attention de quelqu'un pendant des heures mais me faire poireauter trois semaines sans prendre le temps de regarder le formulaire…
Là c'est dur.

Et chouiner que c'est pas manuscrit ça m'a achevé -___-

C'est un peu triste de devoir passer par des moyens détournés pour résoudre un souci comme ça tout de même.

## PS (enfin pas vraiment)
Cette panne m'a permis de voir un peu qui est un peu plus regardant sur la sécurité que les autres.
Les gens que parvenaient encore à me contacter par mail … bha ce sont typiquement ceux qui négligent un peu leur sécurité (et donc la mienne au passage).

Sans trop de surprise, ma banque n'était pas impactée… vous savez ces organismes qui gèrent votre pognon toussa toussa.

--------
Ma ptite histoire me rapelle notre dépendance envers les registrars.
Il n'y a malheureusement pas de ptit registrar à taille humaine car l'ICANN exige de solides garanties.
C'est dommage j'aurai bien aimé participer à un registrar associatif.
