+++
Author = "Lord"
Description = "Purism post-mortem about their 2018 dns outage reminds us the infamous dependance with registry and registrars."
Categories = ["actu", "purism","dns","spof"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-02-21T14:02:59+01:00
date = 2018-02-21T14:02:59+01:00
title = "We all depend on registrars and registries"
editor = "kakoune"
+++
Purism just suffered from a [massive dns outage](https://puri.sm/posts/the-great-purism-dns-outage-of-2018/).
All their websites were down.

What caused this ?
It appears their domain name was unreachable.
After looking for a bug in their DNS servers, their was nothing to be found.

## The registrar

It came from their *registrar*.
The registrar is the entity from which you rent your domain name (no you don't buy a domain name).
They phoned to the hotline but apparently nothing were wrong on their side.
They tried to reach their *.sm* specialist which was unavailable until the morning.

So they waited.

On the morning, the specialist checked everything and found nothing.

We need to go Deeper !

## The registry

Deeper their is the *registry* which sells licences to registrar to rent domain name from their TLD (top level domain, the right part of a domain name).

Bad luck *.sm* comes from the [San Marino](https://en.wikipedia.org/wiki/San_Marino) in Europe.

So they waited, again, while everything was off.

Purism bypassed their registrar and directly contacted the *.sm registry*.

*The registrar didn't payed the registration fee.*

Hahahahaha, i'd love seeing the faces of Purism's technicians when they learned that their registrar was faulty.

So, everything get fixed, everything now works fine.

## Conclusion ?

** Choosing a registrar can have direct consequences on the availability of your infrastructure.**

You may have RAID, VM with high availability, a multi-homed network, in multiple datacenters, your domain name and your registrar will ever be your *SPOF* (single point of failure).

Purism choose to take another domain name in another registrar on another TLD but that's not a perfect solution : if your clients don't try to reach you by your backup domain name… you have no backup.

** Choosing a registry can have direct consequences on the availability of your infrastructure.**

Like you registrar, your registry (it means the TLD you choose) is crucial. Choosing a TLD for its œsthetics can be a future outage.

Even if you host your own DNS servers with fine management, you can still suffer from an outage of your underlying layers.	
