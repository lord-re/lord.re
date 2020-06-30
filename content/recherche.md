+++
Author = "Lord"
Description = ""
Categories = ["", ""]
menu = "main"
notoc = true
nofooter = true
WritingDate = 2020-06-30T20:15:50+02:00
date = 2020-06-30T20:15:50+02:00
title = "Recherche"
editor = "kakoune"
+++
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

-------------

C'est tout neuf donc c'est ptet pas parfaitement au point.
Ça ne cherche que les mots complets et ça ne suggère rien.

Des fois des résultats sont un peu étranges mais ça marche en gros.

Ça nécessite Javascript pour fonctionner et tout se fait sur votre ordi, rien sur le serveur.

</article>
</section>
