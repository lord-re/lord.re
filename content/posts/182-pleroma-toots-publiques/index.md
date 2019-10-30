+++
Author = "Lord"
Description = "Ma pauvre instance Pleroma ne me permettait plus de poster des toots publics. Il m'a fallu réparer un poil la base de donnée pour remettre ça d'aplomb."
Categories = ["debug", "pleroma","adminsys","fediverse"]
menu = "main"
notoc = true
WritingDate = 2019-10-29T21:22:49+01:00
date = 2019-10-30T11:22:49+01:00
title = "Pleroma : problèmes de toots publiques"
editor = "kakoune"
+++
Je viens de passer une semaine avec mon instance Pleroma à moitié petée.
Enfin même pas la moitié juste un petit morceau : je pouvais plus envoyer de toots publics.

Les toots à destination des followers uniquement ou les messages privés arrivaient bien.

Étrange, n'est-il pas ?

Bon pas de bol, en utilisant les versions OTP de Pleroma, on a aucun log de base.
J'ai donc lancé pleroma de façon à voir les logs à l'écran :

**<samp>su - pleroma -s ./bin/pleroma start_iex</samp>**

Et là j'ai tenté d'envoyer un toot pernicieux pour avoir le droit à ce message d'erreur :

{{< highlight "elixir" >}}
ex(pleroma@127.0.0.1)1> 19:18:01.486 [error] Task #PID<0.6188.0> started from PleromaJobQueue.Worker terminating
** (UndefinedFunctionError) function nil.deactivated/0 is undefined (module nil is not available)
    nil.deactivated()
    (pleroma) lib/pleroma/web/activity_pub/activity_pub.ex:70: Pleroma.Web.ActivityPub.ActivityPub.check_actor_is_active/1
    (pleroma) lib/pleroma/web/activity_pub/activity_pub.ex:128: Pleroma.Web.ActivityPub.ActivityPub.insert/4
    (pleroma) lib/pleroma/web/activity_pub/activity_pub.ex:332: Pleroma.Web.ActivityPub.ActivityPub.announce/5
    (pleroma) lib/pleroma/web/activity_pub/publisher.ex:204: Pleroma.Web.ActivityPub.Publisher.publish/2
    (elixir) lib/enum.ex:783: Enum."-each/2-lists^foreach/1-0-"/2
    (elixir) lib/enum.ex:783: Enum.each/2
    (pleroma) lib/pleroma/web/federator/publisher.ex:60: Pleroma.Web.Federator.Publisher.publish/2
Function: #Function<3.57955314/0 in PleromaJobQueue.Worker.maybe_start_job/4>
    Args: []
{{< / highlight >}}

Et je sais pas vous mais moi ça me parle absolument pas et d'ailleurs Elixir est vraiment exotique à mes yeux (rien que la syntaxe de la conf est étrange je trouve).
Du coup je suis allé pleurnicher auprès du salon #pleroma sur Freenode.

Visiblement, ma base de donnée est un poil abîmée.

Donc on s'y connecte :

  - <samp>su - postgres</samp>
  - <samp>psql</samp>
  - <samp>\c pleroma_prod;</samp>
  - <samp>select * from users where info is null;</samp>
  - Si vous avez des résultats à la commande précédente et qu'il s'agit de comptes distants, vous pouvez (et il le faut)les dégager
  - <samp>delete from users where info is null;</samp>

Voilà, maintenant la base de donnée est dans un meilleur état.
Il ne reste plus qu'à relancer votre instance et c'est repartit, vous allez pouvoir shitposter like a boss.
