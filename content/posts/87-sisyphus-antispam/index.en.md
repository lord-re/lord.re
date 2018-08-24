+++
Author = "Lord"
Description = "Meet Sisyphus, a little antispam software which plays directly in your maildir."
Categories = ["mail", "software","adminsys","réseau","mail","postfix"]
menu = "main"
notoc = true
PublishDate = 2018-03-20T15:33:09+01:00
date = 2018-03-20T15:33:09+01:00
title = "Sisyphus the spam mover"
editor = "kakoune"
+++
I already talked about my mail stack.
Some months ago i added a new antispam to it.

  - Firstç there is Postscreen in frontline (almost in before Postfix) which rejects something like 80% of spam before using any resources.
  - Then I use Rspamd which works after Postfix and before Dovecot which also removes all the remaining spam.
  - Last there is [Sisyphus](https://github.com/carlostrub/sisyphus) which works after Dovecot, directly on the maildir. 

Yes, it's clearly overkill.
I know, i already chanted Postscreen and Rspamd (sorry, only in french) and now I announce a use a third one…

## Why three antispam ?

Well, *Postscreen removes the dumb spam*.
All non targeted mails from bad spammers using bad scripts but consisting of most of the flood.
With it, you lighten the load on your mail stack by sparring yourself cpu/ram/disk.
You'll drop spam before entering your stack.
It's the bare minimum to install.
Rspamd could replace it but it would require more resources.

Then *Rspamd is the real antispam*.
It's way smarter than Postscreen and Sisyphus and could be enough.
It uses lots of rules with mostly good defaults
But I don't want to spend time tweaking it.
I hate mails.
Even after lowering the required score to be rejected i keep getting spam in my inbox.
I have one or two spam reaching my inbox and 0 false positive.
I could add rules, or refine existing ones to crush those last two spams a week but it's too much work.

Then i discovered Sisyphus !
It's very lightweight, nothing to configure.
Nothing to change in Postfix/Rspamd/Dovecot/Rainloop.
And it succeeds to remove those last two fucking spams.
It can even be used on the client side directly in your local maildir.
I wasn't looking for a new antispam but it fits my new needs.

## Sisyphus watizit ?

It's not a full-featured antispam with a large ruleset and all.
It's just a small Go program which reads your spam and your ham and analyzes all the words to feed a bayesian filter.
When you throw a mail to the spam folder it will learn.
If you move a mail from it, it will learn too.

You *don't need to configure anything*.

## How to use it ?

First, your mails must be stored in a [Maildir](https://en.wikipedia.org/wiki/Maildir) but we are in 2018, nobody uses anything else (well, except Thunderbird).
Then you install Sisyphus as you install everything else.
In my case **git clone** then **make build** and it's ok (thanks Go).

Well you still need to tell Sisyphus where is your maildir.
**export SISYPHUS_DIRS="/home/lord/Maildir"**

And now launch it **sisyphu run&** .

It's done.

You'll now see your mail moving by themselves to your *junk folder*.

Sisyphus needs some time to learn your mails

You can run **sisyphus stats** to see if it is working right or not.
It will build its database alone like a grown-up (notice that the db is very small).

I may remove Rspamd in the future if it works well enough.
I'll see.
After more than 3 months running it's getting quite accurate.
