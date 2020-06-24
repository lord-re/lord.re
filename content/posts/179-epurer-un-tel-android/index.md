+++
Author = "Lord"
Description = "Les téléphones Android sont vendus remplis à ras-bord d'applications dispensables voire parasites. Je viens de changer récemment et il m'a fallu décanter le tout pour supprimer les gros morceaux. C'est parti pour du powerwashing !"
Categories = ["android", "tips", "cli"]
menu = "main"
notoc = true
WritingDate = 2019-08-27T13:13:57+02:00
date = 2019-09-10T19:13:57+02:00
lastEdit = 2020-04-21T22:06:03+02:00
title = "Épurer un téléphone Android"
editor = "kakoune"
TopWords = [  "applis", "bixby", "merdes", "sec", "app", "google", "samsung", "android"]
+++
**EDIT du 21/04/2020 :**
Hey je vois que cet article redevient populaire sans trop savoir pourquoi.
Mais, maintenant je sais pourquoi.
Pas mal de monde cherche ce à quoi correspond l'appli **IPSGeofence** .

Bon alors en fait *il s'agit d'une application de localisation qui ne se base pas sur le GPS mais sur des balises terrestres comme des tags ou des beacons bluetooth disséminés un peu partout*.
Et avec ces histoires de confinement suite à la pandémie Covid19 mais surtout de la sortie de confinement bha ça revient pas mal sur le carreau.

Bref, c'est une appli qui peut potentiellement participer au pistage.
Je sais pas vous, mais bon, avec cet article vous verrez comment la désactiver.

Voilà je vous laisse l'article rien que pour vous.

-----------------



J'ai récemment changé de téléphone pour le boulot.
Me voilà donc avec un Samsung Galaxy A50.

Et qui dit nouveau téléphone dit ?

**CRASSES**

Le téléphone est rempli de merdes.

  - Il y a les merdes made in Orange™.
  - Il y a les merdes made in Samsung™.
  - Il y a les merdes made in Google™.

On peut en enlever un peu depuis le téléphone mais la plupart sont bien attachées.
Et quand la crasse s'attache qu'est-ce qu'on fait ?
On utilise une console !

*Fût un temps où il fallait forcément rooter le téléphone pour s'en sortir.*
Installer une nouvelle rom et tout.
Et c'était vraiment le far west : installer d'obscurs logiciels pompés sur des sites tous plus louches les uns que les autres et croiser les doigts pour que tout se passe bien.
Toujours une partie d'emmerdes.

C'était vraiment chiant et je n'avais vraiment pas confiance envers tous ces sites et logiciels à bidouiller dans tous les sens.

Maintenant c'est bien moins indispensable je trouve.
Le root n'apporte plus grand avantage.

On peut désactiver tout un tas d'applis d'origine avec **ADB**.
Elles sont un peu présentes mais ne tournent pas (c'est le principal).

 


Bref, petite marche à suivre : 

  - *installer android-tools* via **<kbd>emerge android-tools</kbd>**.
  -  Sur votre téléphone il faut activer le mode dev : dans les *paramètres de votre téléphone*, dans *status*, il faut taper plein de fois sur *build number* jusqu'à ce qu'un message s'affiche en bas.
  - Un menu *dev* se trouve tout en bas des paramètres où il faut activer l'*USB debugging*.
  - sur votre ordi, un ptit coup de **<kbd>adb shell</kbd>** et vous vous retrouvez avec la main sur votre tel.

Maintenant **pour désactiver une application c'est <kbd>pm disable-user --user 0 LE_NOM_DE_L'APPLI</kbd>**

À chaque téléphone sa crasse.
Donc il vous faudra lister les applis d'abord : **<kbd>pm list packages</kbd>**

<details><summary>Liste de ce que j'ai désactivé</summary>
<pre>
package:com.google.android.youtube
package:com.samsung.android.themestore
package:com.google.android.googlequicksearchbox
package:com.samsung.android.aremoji
package:com.samsung.android.kidsinstaller
package:com.diotek.sec.lookup.dictionary
package:com.sec.android.app.samsungapps
package:com.samsung.android.app.settings.bixby
package:com.samsung.android.game.gamehome
package:com.google.ar.core
package:com.android.vending
package:com.samsung.systemui.bixby2
package:com.samsung.mlp
package:com.samsung.android.aircommandmanager
package:com.samsung.android.net.wifi.wifiguider
package:com.samsung.android.bixby.service
package:com.samsung.android.emojiupdater
package:com.samsung.android.smartfitting
package:com.google.android.gm
package:com.samsung.android.bixby.agent
package:com.google.android.setupwizard
package:com.facebook.services
package:com.samsung.android.mobileservice
package:com.android.printspooler
package:com.samsung.android.game.gametools
package:com.orange.update
package:com.android.chrome
package:com.samsung.android.ipsgeofence
package:com.google.android.tts
package:com.android.calllogbackup
package:com.google.android.partnersetup
package:com.samsung.android.app.routines
package:com.google.android.feedback
package:com.samsung.sec.android.teegris.tui_service
package:com.samsung.android.wellbeing
package:com.samsung.android.authfw
package:com.samsung.android.bixbyvision.framework
package:com.samsung.android.dqagent
package:com.samsung.android.game.gos
package:com.samsung.android.keyguardwallpaperupdator
package:com.android.wallpaper.livepicker
package:com.samsung.android.stickercenter
package:com.samsung.android.fmm
package:com.samsung.android.bixby.wakeup
package:com.samsung.android.samsungpass
package:com.samsung.android.scloud
package:com.samsung.android.app.spage
package:com.samsung.android.knox.analytics.uploader
package:com.sec.android.emergencylauncher
package:com.samsung.android.bbc.bbcagent
package:com.samsung.android.visionintelligence
package:com.samsung.android.app.watchmanagerstub
package:com.samsung.android.mateagent
package:com.samsung.android.networkdiagnostic
package:com.enhance.gameservice
package:com.android.wallpaperbackup
package:com.samsung.android.app.omcagent
package:com.samsung.android.samsungpassautofill
package:com.sec.android.app.fm
package:com.samsung.ipservice
package:com.samsung.android.tapack.authfw
package:com.samsung.android.bixby.agent.dummy
</pre>
</details>

Une fois viré toutes ces merdes le téléphone ne s'en porte que mieux.
Il fait moins de trucs dans votre dos, bouffe moins de batterie (j'arrive à faire des journées à 15% de batterie).

Il y a probablement pleins d'autres applis parasites mais faut avouer que les noms ne sont pas super explicites…

Dans un prochain article je vous listerai un peu les applis que j'utilise.
