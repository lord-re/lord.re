+++
Author = "Lord"
Categories = ["adminsys","network","tips"]
Tags = ["adminsys","network","tips"]
Description = "Tutorial to replace a Livebox with a true router. The goal is to keep the TV service."
date = "2012-12-09T22:45:36+02:00"
title = "Throw you livebox out but conserve your TV service"
menu = "main"

+++

***PS 2017 :*** *This tuto is completely deprecated since PPP will soon be removed in favor of DHCP (but still with exotic options)*

Here it is ! The holy grail is at home ! FTTH. Fiber. Holy molly this marvelous plastic thing which makes me dream has come. I got it. I subscribed to an almighty symetric 100M from Orange. Such a nice Internet connection. Symmetric bandwith is a wet dream for most geeks. It's a real game changer. No more static public IP, no more customizable reverse DNS… that's sad. I also have to forge the port 25. These are compromises I choose. The livebox. Wow ! Such a shitty peace of riggidy shit. At last, this detail can be fixed. But if you want to get rid of your livebox but still being able to use their tv decoder you'll have to roll up your sleeves !

## FTTH architecture for home users in 2012
My ISP choose an FTTH architecture using GPON. It means that one optical fiber will serve many clients. Such a strange idea ! After building a nice copper network they are building a fiber network ruled by economic pressure instead of future proofing it. On the copper network they had the same silly idea of multiplexing many clients on only one copper twisted pair. To use a phone it was usable but when the Internet became the main usage it clearly failed. Internet over POTS was terribly slow with usable bandwidth of 30Kbps (yes 30Kbits per second not bytes). And you can't have DSL on multiplexed copper lines. I'm still a bit traumatized… When deploying fiber they do the exact same mistake : multiplexing many clients on one fiber. For now this is not a concern but who knows how will it turns out in 10/20/30 years from now. One fiber per house would have been so much better.

So they bring the fiber in communal areas of your building. Next they have to come in each apartment to install the fiber. They won't put only one fiber but for (for other operators, they are such generous gods) so if you want more than one ISP or if you want to change your ISP they won't have to come back.

Now on the ISP side : the modem ! Orange use an ONT which will identify and convert light signals in electric signals. It's a transceiver with some authentication. Some ISP choose to include this in their box but not Orange. So if they change their equipment on the network, you won't have to change your box, only the ONT.

Now the Livebox get its signal from the ONT. It has to authenticate itself on the network with PPP (yes yes -___- ppp in 2012) and to route your network traffic and all the box-things. It lets you plug a TV decoder (h264 decoder provided by your isp) and also an analog telephone. So as a good geek you probably have you own router and you may want to ditch the box but keep you tv decoder.

## What does the livebox do ?
On its fourth ethernet port the box gets its precious wan connection from the ONT. It manages the PPP session. It serves as a gateway. It gets its TV stream and transfers to any of its three remaining ethernet port. It also gets it's phones servic in h323 (or SIP, I don't really know and don't care).

So it's PPP part acts as a good old DSL modem. So our router will have to manages PPP session with our login/password. The only fine detail comes from the fact that it's encapsulated inside a VLAN. For the joke they choose the VLAN number from the VPI/VCI from ATM. So how many layers to get our Internet ? … So you should have figured the next part… no ? Telephony service is also in another VLAN. And TV service ? Yes ! Another VLAN. Ready ?

## Let's make it better !
On the hardware side we will need 3 network interfaces :
```
eth0 - ONT
eth1 - LAN
eth2 - TV decoder
```
And many patch cables to bind them all.

On the software side we will need a Gentoo, brctl, iproute2, vconfig, ppp, rp-pppoe and a ppp-aware kernel.
Take a moment to look at you **ip l**, it won't be as simple anymore.

Our goal is to automate all this of course. And we are gonna play it gentoo-style. Most of the job will reside in */etc/conf.d/net/* . We will start slowly just enough to get an Internet connection to get back to IRC.
```
#eth0 à poil
config_eth0=noop

#config ppp
config_ppp0="ppp"
link_ppp0="eth0.835"
plugins_ppp0="pppoe"
username_ppp0="fti/1234567"
password_ppp0="1234567"
pppd_ppp0="
defaultroute
noauth
usepeerdns
holdoff 3
child-timeout 60
lcp-echo-interval 15
lcp-echo-failure 3
noaccomp noccp nobsdcomp nodeflate nopcomp novj"
rc_need_ppp0="net.eth0"
vlans_eth0="835"
config_eth1="10.0.0.1/16"
```
So now you have your ***eth0*** all naked. VLAN 835 will be set on top of it (you will have a new interface named ***eth0.835***) and on top of it (yes) ***ppp0***. So you should have lo, eth0, eth0.835, ppp0, eth1 and eth2. You are now quite close to being able to connect te the Great Internet on your lan. You gateway probably is already connected you just have to tell you kernel to route and forward packets.

```
iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
```
and it's done ! You lan is now full of tiny kawaii kittens and boobs and memes. Except that it's quite messy yet. Some things are borked. You have to tweak the MTU because of all these layers.
```
iptables -I FORWARD -p tcp --tcp-flags SYN,RST SYN -j TCPMSS --clamp-mss-to-pmtu
```
Breathe.

Breathe again.

## TVing
The TV part is named invasion of network interfaces.

TV is splitted and encapsulated like this :
```
835 : Internet
838 : Nego and HTTP for the TV decoder
840 : Channels streaming
841 : VoD but still, i don't care
```
Back to */etc/conf.d/net* :
```
vlans_eth0="835 838 839 840 841"
config_eth2="noop"
bridge_tv="eth2 eth0.838 eth0.839 eth0.840 eth0.841"
config_tv="192.168.1.1/24"
rc_need_tv="net.eth2"
```
Good ? You've completed your file like a boss ? Ready for the reboot of faith ? The only downside of this configuration is that each network interface will trigger a DHCP client which will have to timeout before it's ok. As you now have plenty of network interfaces it's gonna take some time. If you find any solution to solve this i'd be glad to hear it.

Let's grease everything up : in */etc/local.d/yourfavoritescript*
```
#réparation des bridges
echo "0" >/proc/sys/net/bridge/bridge-nf-call-arptables
echo "0" >/proc/sys/net/bridge/bridge-nf-call-ip6tables
echo "0" >/proc/sys/net/bridge/bridge-nf-call-iptables
echo "0" >/proc/sys/net/bridge/bridge-nf-filter-pppoe-tagged
echo "0" >/proc/sys/net/bridge/bridge-nf-filter-vlan-tagged
```
I won't address it here but you'll need a DHCP server for the tv decoder. And you should know that each time it's IP change you'll have to reboot it.

There. You did it ! You can ditch your crappy livebox and stop your 3€/month rent. Cya.

