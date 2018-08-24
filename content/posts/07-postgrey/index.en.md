+++
Author = "Lord"
date = "2009-08-25T17:41:08+02:00"
title = "Adding PostGrey and …"
menu = "main"
Categories = ["adminsys","mail","postfix"]
Description = "My journey to enhance my selfhosted mailserver"
nodate = true

+++

Wow so classy ! My first title with an ellipsis ! Ok this time i was quite fed up of all this spam. My webstack isn't as clean as I intended. I rely on postfix, procmail, dovecot, roundcube. It's a gmail-like combo but self hosted. I want to connect to the stack with *thunderbird* and playing with it's *lightning* plugin to have a synchronised agenda, calendar, tasklist with my smartphone. I'll probably use *funambol* that i'm currently testing. It's starting to become bigger and bigger this stack. I feel a bit…drowning for now.

I'm gonna make it slow but i'll do it. For now I must fix dovecot to be able to connect with imap. While playing with all this I also added a greylisting plugin to postfix : **postgrey**. I hope it'll stop or at least reduce the amount of spam.

I also have some troubles with procmail. Some rules doesn't seem to work. Another mystery to solve !

Lots of work in 2010 ! I need to level up in email stack.

*PS : 2017 :* Wow. While translating this article i remember all those struggles. Email is still a PITA to operate. Lots of not so small software to setup correctly to make them work together. Today i still use postfix and dovecot but i dropped procmail to use sieve inside dovecot. The filtering rules of sieve is easier than procmail even if it's a bit less powerful.

I dropped roundcube to rainloop because of the slicker webui. I no longer use thunderbird and i don't need agenda/calendar/tasklist so i dumped funambol too (such a shitty mess this "thing"). And i also replaced postgrey with postscreen too but this one is more natural as postgrey was discontinued in favor of postscreen.

Ho god ! Post Scriptum starts to be longer than the original article !
