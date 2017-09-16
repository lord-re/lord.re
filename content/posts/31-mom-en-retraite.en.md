+++
Tags = ["hardware","meta","software"]
Description = "Replacing mom with zoid. A server retire and another one replace it"
menu = "main"
date = "2013-04-14T23:14:01+02:00"
title = "Mom goes to retirement"
Categories = ["hardware","meta","software"]

+++
With a pinching with the heart i announce you Mom's retirement. **Mom** was my small dédibox (dedicated server from online.net) which did a lot of things. I know that i'm a fervent advocate of self-hosting but i still rent a dedicated server in a datacenter.This machine serves me well for 4 years. Here comes **Zoid**.

It's a bigger beast than mom so it will be easier for him. But now, in hindsight it will probably let me do more things. I have sixteen times more RAM et more or less the same increase in cpu horsepower. So, I'll install proxmox on it (by curiosity first then probably i'll keep it if it's stable and flexible enough). Each service will be isolated in it's own OpenVZ container.

To bind every webservices i'll set up a frontend nginx. It will reverse proxy to each service. I'll probably post on this later. I may also reverse proxy to **Bender** (my local self-hosted server) to reach it even if the DDNS update fails.

Another chapter of the Internet which closes itself. Mom was a legen. Farewell 20790.

