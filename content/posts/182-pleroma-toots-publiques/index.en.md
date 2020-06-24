+++
Author = "Lord"
Description = "My poor little Pleroma instance wasn't able to send nasty public toots. To fix it I had to do some black magic in the postgres database."
Categories = ["debug", "pleroma"]
menu = "main"
notoc = true
WritingDate = 2019-10-29T21:22:49+01:00
date = 2019-10-30T12:22:49+01:00
title = "Pleroma : unable to send public toots"
editor = "kakoune"
+++
It's been a week since my last public toot.
I didn't noticed it at first but all my public toots weren't send to other instances.
My *private* and *followers-only* toots worked perfectly but not the *public* ones.

That's a bit hard to notice but after one week of being ignored i felt quite alone. :-/

As I use OTP release of Pleroma, i don't have any logs anywhere.
I had to launch Pleroma with debug to get what i needed :

**<kbd>su - pleroma -s ./bin/pleroma start_iex</kbd>**

Then i sent a massive public toot and got this :

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

As a non Elixir-speaker I didn't know what to do of this.
So let's go to #pleroma in Freenode.

It appears that my database was borked.

So here are the steps to quickly fix it :

  - <kbd>su - postgres</kbd>
  - <kbd>psql</kbd>
  - <kbd>\c pleroma_prod;</kbd>
  - <kbd>select * from users where info is null;</kbd>
  - If you have results with non-local accounts, you can (and should) purge them with the following command.
  - <kbd>delete from users where info is null;</kbd>

Now that the database is in a better shape you just need to relaunch Pleroma and you're free to shitpost harder than ever.
