+++
Author = "Lord"
Description = ""
Categories = ["linux", "mpd"]
menu = "main"
notoc = true
WritingDate = 2022-01-14T15:53:11+01:00
date = 2022-01-14T15:53:11+01:00
title = "Horreur, Mon MPD ne démarre pas après upgrade"
editor = "kakoune"
TopWords = [  "musique","linux","segfault", "libid3tag", "patch", "mpd"]
+++
(il y a un TL;DR en bas)

Vous vous rapellez le temps où j'écrivais des trucs sur Linux et son ptit monde ?
Non !
Ha merde c'est pire que ce que je pensais !

Bon bha je vais vous parler de ma ptite mésaventure du jour.

## Tout commence
Le commencement est toujours un moment délicat.
Hier, sans crier gare j'ai mis à jour ma ptite Gentoo comme je le fais très régulièrement.

Ho je me souviens encore de cette insouciance.
Je ne savais pas encore tout ce que j'allais endurer, j'étais un autre homme à l'époque.

✵Petite ellipse narrative✵

Je démarre mon fier engin, je me logue et là quelle ne fût point mon désappointement ?!
Pas de musique.
Mon ptit script de musique colore le terminal en violet pour me signaler que **mpd** n'a pas pointé ce matin.

Bon, je ne cède pas tout de suite à la panique, après tout ce n'est que la musique…
HANNNN PAS DE MUSIQUE !!!

VITE UNE SOLUTION !

## Message d'erreur confusant
Bon "sans paniquer" je tente de relancer **mpd** manuellement.
J'ouvre un terminal et je tape ces trois lettres <kbd>m</kbd>,<kbd>p</kbd>,<kbd>p</kbd> et enfin <kbd>Enter</kbd>.

J'espère voir le bout du tunnel.

<samp>Tag list mismatch Discarding database file</samp>

Bon bha le monde m'en veut terriblement.
J'essaye de ne pas céder plus à la panique.

Je vais voir si ce fichier existe vraiment.
C'est le cas.
Je le renomme et tente de relancer **mpd**.

<samp>Jan 14 16:05 : exception: Failed to open '/var/lib/mpd/database': No such file or directory</samp>

Ha, là déjà c'est mieux.
Mais **mpd** devrait recréer de lui-même ce fichier !
Pourquoi qu'il collabore pas ?
Je commence à perdre pédale, les mots ne me viennent plus dans l'ordre, le correcteur orthographique tourne à plein régime, une IA est obligée de retranscrire ce que le clavier parvient à tirer de mes doigts pour ce blog post.
C'est de plus en plus décousu (certains diront que je meuble).

Une terrible baisse de tension fait déraper mes mains sur le clavier.
Incrédule je regarde l'écran et je vois marqué <kbd>dmesg</kbd>, c'est surement un signe du destin !
J'envoie la commande persuadé que la providence n'était pas avec moi.

<samp>[ 1174.823896] update[8214]: segfault at 0 ip 00007fc9179ea010 sp 00007fc911039348 error 4 in libid3tag.so.0.16.1[7fc9179e4000+8000]
[ 1174.823913] Code: 0c 00 00 00 48 89 ef e8 5e a4 ff ff e9 62 fd ff ff 49 ff c4 e9 71 fa ff ff e8 7c a2 ff ff 66 2e 0f 1f 84 00 00 00 00 00 66 90 <8b> 0f 85 c9 74 2a 48 89 f8 0f 1f 80 00 00 00 00 8b 50 04 48 83 c0</samp>

Wow, un signe.

## C'est sa Segfault
Visiblement la **libid3tag** a un ptit bug et empêche les honnêtes programme de travailler.
Tout du moins c'est la conclusion logique sur laquelle tout le monde se serait rué.

Tout le monde sauf moi !
Après tout c'est **mpd** qui plante, du coup je me suis mis en tête d'aller décrouté ce papy pour le faire bosser comme je le souhaite.
Sauf que n'étant pas sûr de mes compétences, mon premier réflexe est d'aller tenter un bugreport chez **mpd** et donc d'aller voir un peu comment ça se passe là-bas.

Je suis immédiatement tombé sur [leur page expliquant comment leur faire un bon bugreport](https://mpd.readthedocs.io/en/stable/user.html#mpd-crashes).
Je pars donc bille en tête pour installer **gdb** histoire d'avoir un peu plus d'info sur la vraie cause de mon souci.

Une fois installé je lance l'immonde <kbd>gdb --args mpd --stderr --no-daemon --verbose</kbd> puis un ptit <kbd>run</kbd> .

Et là mon vieux, ça défile, on voit bien qu'il lit tous les mp3 les uns après les autres jusqu'au moment où il déraille complet.

<samp>Thread 4 "update" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7fffef221640 (LWP 2859)]
0x00007ffff5bbf960 in id3_ucs4_length () from /usr/lib64/libid3tag.so.0.16.1</samp>

Bon, bha j'ai pas spécialement plus d'info mais si on lui envoie un ptit <kbd>bt</kbd> j'obtiens une palanquée d'infos inutilisables pour un pauvre hère de mon espèce.

<samp>
#0  0x00007ffff5bbf960 in id3_ucs4_length () from /usr/lib64/libid3tag.so.0.16.1
#1  0x00007ffff5bb9df7 in id3_compat_fixup () from /usr/lib64/libid3tag.so.0.16.1
#2  0x00007ffff5bbedb2 in id3_tag_parse () from /usr/lib64/libid3tag.so.0.16.1
#3  0x000055555561c32a in ?? ()
#4  0x000055555561c5eb in ?? ()
#5  0x00005555555c481d in ?? ()
#6  0x00005555555c498a in ?? ()
#7  0x00005555555c1a8a in ?? ()
#8  0x00005555555c1c0b in ?? ()
#9  0x000055555562a924 in ?? ()
#10 0x000055555562ac9d in ?? ()
#11 0x0000555555629bdc in ?? ()
#12 0x000055555562952b in ?? ()
#13 0x0000555555629b6a in ?? ()
#14 0x000055555562952b in ?? ()
#15 0x0000555555629b6a in ?? ()
#16 0x000055555562952b in ?? ()
#17 0x000055555562a51a in ?? ()
#18 0x000055555562716d in ?? ()
#19 0x00005555555e1943 in ?? ()
#20 0x00007ffff555b007 in ?? () from /lib64/libc.so.6
#21 0x00007ffff55de480 in clone () from /lib64/libc.so.6
</samp>

Ça me fait une belle jambe.

## N'as-tu pas remarqué les symboles ?
Bon, il me faut les symboles de débug qui sont virés lors de la compilation.

Je vous avoue que j'aime beaucoup **Gentoo** mais c'est pas le genre de truc dont j'ai l'habitude.
Cela dit, je me doute que c'est très probablement un truc très simple à faire.

Après dix secondes de recherche je tente un <kbd>FEATURES="nostrip" emerge mpd</kbd> .
Je laisse mouliner tout ça et je retente de relancer **gdb** et **mpd** dedans.

<samp>
#0  0x00007ffff5bbf960 in id3_ucs4_length () from /usr/lib64/libid3tag.so.0.16.1
#1  0x00007ffff5bb9df7 in id3_compat_fixup () from /usr/lib64/libid3tag.so.0.16.1
#2  0x00007ffff5bbedb2 in id3_tag_parse () from /usr/lib64/libid3tag.so.0.16.1
#3  0x000055555561c32a in MadDecoder::DecodeNextFrame(bool, Tag*) ()
#4  0x000055555561c5eb in mad_decoder_scan_stream(InputStream&, TagHandler&) ()
#5  0x00005555555c481d in ScanFileTagsNoGeneric(Path, TagHandler&) ()
#6  0x00005555555c498a in ScanFileTagsWithGeneric(Path, TagBuilder&, AudioFormat*) ()
#7  0x00005555555c1a8a in Song::UpdateFile(Storage&) ()
#8  0x00005555555c1c0b in Song::LoadFile(Storage&, char const*, Directory&) ()
#9  0x000055555562a924 in UpdateWalk::UpdateSongFile2(Directory&, char const*, std::basic_string_view<char, std::char_traits<char> >, StorageFileInfo const&) ()
#10 0x000055555562ac9d in UpdateWalk::UpdateSongFile(Directory&, char const*, std::basic_string_view<char, std::char_traits<char> >, StorageFileInfo const&) ()
#11 0x0000555555629bdc in UpdateWalk::UpdateDirectoryChild(Directory&, ExcludeList const&, char const*, StorageFileInfo const&) ()
#12 0x000055555562952b in UpdateWalk::UpdateDirectory(Directory&, ExcludeList const&, StorageFileInfo const&) ()
#13 0x0000555555629b6a in UpdateWalk::UpdateDirectoryChild(Directory&, ExcludeList const&, char const*, StorageFileInfo const&) ()
#14 0x000055555562952b in UpdateWalk::UpdateDirectory(Directory&, ExcludeList const&, StorageFileInfo const&) ()
#15 0x0000555555629b6a in UpdateWalk::UpdateDirectoryChild(Directory&, ExcludeList const&, char const*, StorageFileInfo const&) ()
#16 0x000055555562952b in UpdateWalk::UpdateDirectory(Directory&, ExcludeList const&, StorageFileInfo const&) ()
#17 0x000055555562a51a in UpdateWalk::Walk(Directory&, char const*, bool) ()
#18 0x000055555562716d in BindMethodDetail::BindMethodWrapperGenerator2<UpdateService, true, void (UpdateService::*)() noexcept, &UpdateService::Task, void>::Invoke(void*) ()
#19 0x00005555555e1943 in Thread::ThreadProc(void*) ()
#20 0x00007ffff555b007 in ?? () from /lib64/libc.so.6
#21 0x00007ffff55de480 in clone () from /lib64/libc.so.6
</samp>

Ha ouai on a beaucoup plus d'infos qui pourront très probablement aider les devs de **mpd** pour un peu plus facilement trouver où ça merde.

## IANA
À côté de ça tout de même, je suis en gros manque de musique et décide de voir si je suis le seul linuxien à tomber sur cette coquille.

Bon bha pas beaucoup de résultat, je teste même sur le moteur de recherche avec le plus de part de marché vu qu'il est tellement mieux…
Et bien non.

Par contre, je regarde un peu du côté de Gentoo voir ce qu'il se raconte à propos de la libid3tag et vla-t-y pas que je tombe sur [ce bug](https://bugs.gentoo.org/show_bug.cgi?id=626698) qui a de l'activité hier !
C'est tout de même intrigant (de toilette) !

Et regardez bien mes ami·e·s dans les derniers commentaires ce qu'on peut trouver : un patch !

Un nouvel espoir me ragaillardit.
C'est cool un patch.
Surtout qu'il semble corriger ce qui m'ennuie.
Un patch vous dis-je !

## Qu'est-ce que je vais bien foutre d'un patch moi ?!
J'aurai été un triste utilisateur d'une distribution linux lambda, j'aurai été bien emmerdé.
Par chance, étant un heureux utilisateur de **Gentoo**, il m'est aisé d'appliquer tout type de patch à mes logiciels !

Il me suffit de déposer le-dit patch dans */etc/portage/patches/$CATEGORIE/$LOGICIEL/* et à réinstaller le logiciel en question !

Bon, alors en vrai, je n'ai pas un patch mais un commit sur **github** et c'est moins simple qu'il en a l'air pour lui faire cracher un patch à cette forge.
J'imagine que proposer un lien vers un patch serait vraiment du bloat dans cette interface web minimaliste (hummmm).

Bon en vrai, c'est pas compliqué, il suffit de rajouter ".patch" à la fin d'une url d'une PR pour avoir le précieux fichier.
Pas compliqué certe, mais faut le savoir.
Bref, me voilà en possesion [du patch](https://patch-diff.githubusercontent.com/raw/tenacityteam/libid3tag/pull/7.patch) que je colle dans */etc/portage/patches/media-libs/libid3tag/* , je réinstalle la lib avec <kbd>emerge --oneshot libid3tag mpd</kbd> et je patiente la bave au lettre en commençant à convulser par manque de musique.

## Tout est bien qui finit bien ?
Bha … j'attends que ça compile quoi.
C'est aussi ça **Gentoo**, des temps de pause.

Ha tiens !
Ça vient de finir de compiler.

Je lance **mpd**.
Hmmm il ne se passe rien.
o___O

Ha ?
Mais ?
Ha !
Mais non je suis con c'est normal, il y a juste pas d'erreur ni rien.
Je lance une ptite musique.

POUF !
J'ai de la musique !

Dis donc ça ressemble à blog post !
Ça parle pas de film !
Pfiouuu que m'arrive-t-il ?!

## TL;DR
Il y a un bug dans la **libid3tag** qui fait que **mpd** plante lors de l'indexation de certains fichiers mp3.
La solution consiste à installer [ce patch](https://patch-diff.githubusercontent.com/raw/tenacityteam/libid3tag/pull/7.patch) puis relancer **mpd**.
Voilà tout.
