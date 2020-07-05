+++
Author = "Lord"
Description = "Les sites statiques c'est super chouette. Cela dit, il y a un point qui est un peu moyen c'est pour les fonctions dynamiques. Pour les commentaires on passe par des systèmes externes. Et bha pour la recherche il existe des solutions tournant directement sur le navigateur permettant d'avoir un fonctionnement 100% statique. Voyons ça pour intégrer Tinysearch à Hugo."
Categories = ["meta", "hugo","recherche"]
menu = "main"
notoc = true
WritingDate = 2020-06-30T22:05:20+02:00
date = 2020-07-05T10:05:20+02:00
title = "Ajout d'un module de recherche pour Hugo"
editor = "kakoune"
+++
Régulièrement j'ai des gens qui ne retrouvent pas un article que j'ai écrit.
Et moi le premier, je cherche souvent pour savoir où j'ai bien pu parler d'un truc.
Et c'est vrai qu'étant donné qu'il y a de plus en plus de contenu sur mon blog, c'est forcément c'est de plus en plus complexe de se rappeler ou de retrouver une page précise.

Étant donné que j'ai déjà ouvert toutes les pages dans mon navigateur, je me base sur l'autocomplétion du navigateur mais c'est loin d'etre parfait.

Jusqu'à présent je recommandai du coup de se rendre sur la [monopage]({{< ref "mono" >}}).
Cette page contient absolument tout le contenu du site, il suffit donc d'attendre qu'elle charge puis utiliser la fonction recherche du navigateur (<kbd>Ctrl-f</kbd>) mais c'est un usage qui est au final marginal.
Ça fonctionne mais c'est peu plaisant et puis la page est de plus en plus longue à charger vu qu'elle pèse désormais près de 3Mo de HTML (bon une fois gzippé ça tombe à 800Ko).

L'autre technique est tout simplement de chercher via un moteur de recherche conventionnel comme le fameux **DuckDuckGo** ou autre moteur alternatif.
Mon site est pas mal crawlé et donc plutôt bien indexé donc ça fonctionne pas trop mal.
Mais c'est quand même dommage de dépendre de la bonne volonté des moteurs de recherche pour une fonctionnalité que j'aimerai offrir moi-même dans ma quête d'autonomie et d'indépendance.

## Cahier des charges
Donc je voulais un truc adapté à mes contraintes.

  - La première c'est d'être **statique**, c'est-à-dire que je n'ai rien à installer sur le serveur hébergeant le site.
Pas de PHP, pas de node, pas …

  - La seconde c'est que ce soit du **logiciel Libre** simple à utiliser.
Encore que la simplicité est très négociable si ça fait bien le taf.
Le but étant de ne pas avoir à installer cinquante trucs pour que ça fonctionne.

  - La troisième c'est que pour l'utilisateur ça soit **pratique** donc si c'est plus complexe ou moins performant que de fouiller manuellement la monopage ça sert à rien.

## Solution sélectionnée
Il y a trois semaines, lors de ma navigation habituelle sur Hacker News je tombe sur un ptit projet qui semble fait pour me titiller : **[Tinysearch](https://github.com/tinysearch/tinysearch)**

*C'est codé en rust, nécessite un bout de javascript + un bout de webassembly et c'est tout.*
Il est prévu pour être mis en place dans mon cas d'usage (les sites statiques) donc je n'aurai pas besoin de tordre un outil pour transformer une pince coupante en pince croco…

Après je n'ai pas cherché plus, je suis tombé par hasard sur ça et ça matchait vraiment bien.
Si ça se trouve il existe mieux ailleurs mais pour le moment je saurai m'en contenter.

## Donc la marche à suivre ?
Alors d'un point de vue utilisateur c'est simplement un petit bout de javascript, qui va lancer un bout de webassembly qui contient le moteur de recherche + son index.

Il faut donc au préalable (après la génération du site) créer (tout du moins le remettre à jour) cet index.

Il faut également intégrer dans les pages (ou dans une seule comme j'ai préféré) ajouter un peu de html+js pour charger ça et voilà.
C'est donc vraiment pas intrusif pour le site.

## Création de l'index
Alors ce cher **Tinysearch** a besoin d'un index mais ce n'est pas lui qui va le créer.
Enfin il va se créer son index à lui en touillant tout à sa sauce mais il faut lui fournir les données brutes.

Ici, les données brutes, c'est un fichier json contenant la liste de tous les articles.
Pour chaque article il veut un **titre**, une **url** et le **contenu**.

Il faut donc demander à notre cher **Hugo** de nous générer un fichier json avec la bonne syntaxe.
Bon alors sur le [github de Tinysearch](https://github.com/tinysearch/tinysearch) on trouve un peu de doc dont une toute fraîche détaillant la marche à suivre pour Hugo mais je l'ai quelque peu modifiée (~~je la proposerai ptet en retour si j'ai pas de mauvais retours~~ c'est fait).

On va donc devoir créer 1 fichier définissant la structure du fichier.

<details><summary>layout/_default/list.json.json (oui oui, deux fois .json)</summary>
{{< highlight "golang" >}}
[
{{ range $index , $e := .Site.RegularPages }}{{ if $index }}, {{end}}{{ dict "title" .Title "url" .Permalink "body" .Plain | jsonify }}{{end}}
]
{{< / highlight >}}
</details>

Il faut maintenant dire à Hugo de générer ce fichier pour la home uniquement, on a pas besoin de générer un json pour chacune des pages/liste.

Il faut donc éditer la config globale :

<details><summary>extrait du config.toml</summary>
{{< highlight "toml" >}}
[outputs]
  home = ["html","rss","json"]
{{< / highlight >}}
</details>

Donc là, pour la home, il générera le html habituel, le rss associé mais également le json.

Voilà maintenant à la racine de votre site ouaib vous trouverez votre fichier index.json

<details><summary>extrait du index.json généré</summary>
{{< highlight "json" >}}
[
    {
        "body": "blabla",
        "title": "Recherche",
        "url": "https://lord.re/recherche/"
    },
    {
        "body": "encore du blabla",
        "title": "Event Horizon",
        "url": "https://lord.re/visionnages/event-horizon/"
    }
]
{{< / highlight >}}
</details>

Voilà pour la partie création d'index.
Vous remarquerez que ce fichier json peut vite être assez gros.
Dans mon cas, il pèse 1.9Mo (710Ko gzippé) à comparer à la monopage qui fait 2.9Mo (835Ko gzippée).

## Utilisation de Tinysearch
Bon je zappe la partie installation : c'est un logiciel très jeune en rust qui n'est probablement dans aucune distribution linux pour le moment.
Je l'ai direct git cloné depuis github et j'ai même touillé une variable dans le code pour le faire fonctionner mais ça devrait être amélioré très bientôt cette partie-là.

Bref, la seule chose à faire est de lui donner à manger votre *index.json*.
Mettez-vous dans un dossier vierge créé pour l'occasion car il va pondre quelques fichiers.

<kbd>tinysearch /tmp/www/public/fr/index.json</kbd>.
Et là ça va voltiger dans tous les sens.
Pour le moment, à chaque fois que vous l'invoquerez il va récupérer des paquets rust, compiler quelques morceaux, lire votre index compiler un binaire en rust, le transpiler en webassembly et vous générer donc un fichier *js*, un *wasm* (contenant entre autre l'index dans son format à lui) quelques fichiers en plus qui ne seront pas utiles (sauf peut-être le demo.html pour tester vite fait).

Donc vous pouvez y récupérer le fichier js et wasm et le coller dans votre Hugo où bon vous semble, j'ai choisi de foutre ça dans *static/js/* alors que bon le fichier wasm en vrai n'est pas statique car il changera à chaque nouvelle génération d'index.

Ces deux fichiers peuvent être gzippés (et c'est très fortement recommandé).
Si votre site est assez conséquent le fichier wasm peut rapidement devenir un peu gros mais il se compresse vraiment très bien.
Pour info, mon fichier *tinysearch_engine_bg.wasm* pèose 2Mo (mais 330Ko gzippé).

## Création d'une page de recherche
J'aurai pu foutre la recherche direct dans la sidebar mais ça aurait alourdi toutes les pages du site alors que la recherche ne sera pas utilisée à tous les coups.

J'ai donc créé une page grâce à <kbd>hugo new recherche.md</kbd> et à l'intérieur les trois quarts sont du html.

<details><summary>extrait de content/recherche.md</summary>
{{< highlight "html">}}
<section class="ideas">
<article>
Vous êtes tout tristouille en train de chercher une page en particulier dans mon ptit bordel ?

Allez on va tenter de la trouver ensemble !

 <script type="module">
    import { search, default as init } from 'https://lord.re/js/tinysearch_engine.js';
    window.search = search;

    async function run() {
      await init('https://lord.re/js/tinysearch_engine_bg.wasm');
    }

    run();
  </script>

  <script>
    function doSearch() {
      let value = document.getElementById("recherche").value;
      const arr = search(value, 21);
      let ul = document.getElementById("results");
      ul.innerHTML = "";

      for (i = 0; i < arr.length; i++) {
        var li = document.createElement("li");

        let elem = arr[i];
        let elemlink = document.createElement('a');
        elemlink.innerHTML = elem[0];
        elemlink.setAttribute('href', elem[1]);
        li.appendChild(elemlink);

        ul.appendChild(li);
      }
    }
  </script>

  <input type="text" id="recherche" onkeyup="doSearch()" style="margin:1em;padding:1em;font-size:2rem;background-color:#222;color:#ddd;border-radius:0.3em;border:none;width:90%;box-shadow:inset 0 0 1em #111;" placeholder="recherche">
  <ul id="results">
  </ul>
{{< / highlight >}}
</details>

Donc on voit qu'il y a le js et le wasm qui sont chargés (faudra que vous adaptiez les url), j'ai un chouilla stylisé la boite d'input et voilà.

## Profit !
Normailement c'est tout bon.

Enfin normalement si vous avez pas joué les ptits malins avec des <abbr title="Content Security Policy">CSP</abbr>.
Visiblement le webassembly (wasm) nécessite d'avoir <kbd>script-src 'unsafe-eval'</kbd> pour accepter de tourner sinon vous aurez une erreur étrange dans la console.

## Comment ça marche du coup ?
En gros **Tinysearch** se base sur votre index exhaustif et utilise un *bloom filter* (j'y connais rien dans ce domaine) ce qui lui permet d'avoir une corresponsdance entre un mot et du contenu.
L'avantage c'est que potentiellement ce nouvel index peut-être vraiment petit par rapport à la taille de données indexées.
L'inconvénient c'est que c'est assez approximatif, certains termes peuvent donner des résultats faux-positifs et aussi quelques faux-négatifs (mais plus rare).

Vu que cet index est transféré au navigateur web et que c'est également le navigateur qui doit s'en dépatouiller lors d'une recherche, on ne peut pas se permettre d'avoir un fichier trop lourdingue.
Du coup c'est un compromis à trouver, pour l'instant c'est pas configurable (tout du moins il faut changer le code et recompiler **Tinysearch**) et c'est fourni avec une valeur ridiculement petite (tout du moins pour le contenu que j'ai).

J'ai passé le *<abbr title="une valeur qui se trouve dans bin/src/storage.rs à la ligne 68">magic number</abbr>* de 10 par défaut à 1024.
Le fichier wasm généré est désormais de 2Mo cependant il se gzip à environ 350Ko ce qui est de suite bien plus raisonnable.

Si vous voulez des explications plus en détails sur l'aspect technique de Tinysearch, un ptit tour sur [le blog du créateur du soft](https://endler.dev/2019/tinysearch/) où il explique un peu tout.
C'est intéressant mais très technique et en anglais.

## Pensées concernant Tinysearch
Le logiciel est *vraiment jeune pour le moment* et s'oriente d'ailleurs vers une première sortie en version 1.
Du coup ça implique que le code bouge pas mal et que les devs sont vraiment très à l'écoute et réactif.

Il est très probable que son fonctionnement change dans les semaines à venir.
Pour l'instant, on a dépassé le stade du prototype mais on est loin d'un logiciel fini et mature.
Ils sont conscients que le fonctionnement actuel n'est pas optimal.

Il faut pour l'instant modifier le code à la main et recompiler le soft afin de gérer le compromis d'efficacité/poids de l'index.

Ils savent que télécharger et compiler tout un tas de truc lors de son utilisation est pas user-friendly, pas optimisé du tout.
Bref, ce que je raconte aujourd'hui ne sera ptet plus du tout d'actualité d'ici quelque temps.

## Mettre à jour l'index
Bon maintenant ça veut dire qu'à chaque fois que je rajoute du nouveau contenu je dois désormais recréer l'index.
Ça mériterait d'être placé dans le hook git qui m'automatise la publication du blog, cela dit le logiciel bougeant encore pas mal, je ne vais pas l'optimiser tout de suite.

## À vous Cognacq Jay ! À vous les studios !
