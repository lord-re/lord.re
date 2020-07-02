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
You're too sad 'cause you can't find a specific page in my website ?

Come, we'll find it together !

 <script type="module">
    import { search, default as init } from 'https://lord.re/js/tinysearch_engine.js';
    window.search = search;

    async function run() {
      await init('https://lord.re/js/tinysearch_engine_bg.en.wasm');
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

It's brand new so it can be a bit rough.
It only looks for complete words and won't suggest anything.

Sometimes results can be a bit … strange but it's mostly ok.

It needs Javascript to run and will do everything on your side, nothing on the server.

</article>
</section>
