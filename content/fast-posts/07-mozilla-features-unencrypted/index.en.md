+++
Author = "Lord"
Description = "Mozilla starts restricting new Firefox features to HTTPS served pages"
Categories = ["news", "firefox", "security"]
menu = "fast"
noread = true
notoc = true
PublishDate = 2018-01-17T13:00:08+01:00
date = 2018-01-17T13:00:08+01:00
title = "Mozilla starts restricting new Firefox features to HTTPS-served pages"
+++
In its quest to a safer web, [Mozilla just announced](https://blog.mozilla.org/security/2018/01/15/secure-contexts-everywhere/) they are going to **restrict new firefox features to webpages served through HTTPS**.

Even if i'm completely convinced that HTTPS should be used everywhere i reckon that it can't be done in all cases.

Sometimes it's not possible to deploy HTTPS. Here is some examples which come to my mind :
  - If the webserver isn't connected to the Internet, it's getting complicated to get a valid cert (it's a completely legitimate use case to deploy a webserver without Internet access).
  - If the webclient can't keep the timedate while off it can be complicated to validate a cert too (many devices don't have a realtime clock like all the raspberries).
  - When you are using a machine with an outdated openssl not too old but old enough to not being compatible with modern crypto…

That's for all these reasons that contrary to many common guidelines, I don't redirect unencrypted trafic to HTTPS. It's a choice i let to my visitors. If they wan't secure content they can have it, if they don't I won't force them.

Well, I hope Mozilla won't extend this restriction to their older features.


