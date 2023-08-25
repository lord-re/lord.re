+++
Author = "Lord"
Description = ""
Categories = ["", ""]
menu = "main"
notoc = true
WritingDate = 2021-06-23T17:07:37+01:00
date = 2021-06-23T17:07:37+01:00
title = "Le CSS Lab"
editor = "kakoune"
+++
Une ptite page avec quelques expérimentations CSS

<details><summary>
<span style="background-image: repeating-linear-gradient(to left, #64ff00, #00a3ff, #9500ff, red, #ffca00, #64ff00);background-size:100%; background-clip:text; -webkit-background-clip:text;color:transparent;animation:rainbow 3s infinite linear;">Un joli texte tout en arc-en-ciel</span>
</summary>
{{< highlight html >}}
<span style="background-image: repeating-linear-gradient(to left, #64ff00, #00a3ff, #9500ff, red, #ffca00, #64ff00);background-size:100%; background-clip:text; -webkit-background-clip:text;color:transparent;animation:rainbow 3s infinite linear;">Un joli texte tout en arc-en-ciel</span>
{{< / highlight >}}
</details>

<details><summary>Geeknode-Style
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);"><div style="background-color:hsla(0,0%,20%,0.93);margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;"><p>Le contenu</p></div></div>
</summary>

{{< highlight html >}}
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);">
  <div style="background-color:hsla(0,0%,20%,0.93);margin:1rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;">
    <p>Le contenu</p>
  </div>
</div>
{{< / highlight >}}
</details>

<details><summary>Clear-loth-Style
<div style="display:grid;justify-content:center;width:25rem;height:25rem;background-color:white;">
  <div style="background-color:white;box-shadow:0 0 2rem rgba(0,0,0,0.2);margin:1rem;padding:1rem;color:#222;">
    <p>Le contenu</p>
  </div>
</div>

</summary>

{{< highlight html >}}
<div style="display:grid;justify-content:center;width:25rem;height:25rem;background-color:white;">
  <div style="background-color:white;box-shadow:0 0 2rem rgba(0,0,0,0.2);margin:1rem;padding:1rem;color:#222;">
    <p>Le contenu</p>
  </div>
</div>
{{< / highlight >}}

</details>

<details><summary>Vignette
<div style="height:30rem;width:30rem;background:repeating-conic-gradient( at 50% 101%, #666, #655, #2F2, #655, #666);box-shadow:0 0 4rem 1rem black inset;border-radius:2rem;">
</summary>

{{< highlight html >}}
<div style="height:30rem;width:30rem;background:repeating-conic-gradient( at 50% 101%, #666, #655, #2F2, #655, #666);box-shadow:0 0 4rem 1rem black inset;border-radius:2rem;">
{{< / highlight >}}

</details>

<details><summary>DVD marquee
<marquee style="display:block;font-size:3rem;background:rgba(0,0,0,0.3)" behavior="alternate" height="320" width="480" direction="down"><marquee behavior="alternate">📼</marquee></marquee>
</summary>
{{< highlight html >}}
<marquee style="display:block;font-size:3rem;background:rgba(0,0,0,0.3)" behavior="alternate" height="320" width="480" direction="down">
  <marquee behavior="alternate">📼</marquee>
</marquee>
{{< / highlight >}}
</details>


<details><summary>Modal-blend
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);"><div style="mix-blend-mode:multiply;background-color:hsla(0,0%,20%,0.93);margin:2rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;"><p style="text-shadow:0 0 0.2rem black;color:white;">Le contenu <strong>intéressant</strong>. Voyez comme le texte adapte sa couleur ! Mais la lisibilité devient aléatoire, c'est pour cela que je rajoute une ombre noire au texte pour accentuer le contraste.</p></div></div>
</summary>

{{< highlight html >}}
<div style="display:grid;justify-content:center;width:25rem;height:25rem;border:1px solid red;background:repeating-conic-gradient(from -2.5deg at 50% 110%, rgba(255,255,255,.2) 0 5deg, rgba(255,255,255,0) 0 10deg),linear-gradient(#aca, #696);">
  <div style="mix-blend-mode:multiply;background-color:hsla(0,0%,20%,0.93);margin:2rem;box-shadow:0 0.5rem 1rem 0.25rem rgba(0,0,0,0.7);padding:1rem;border:1px solid #aca;">
    <p style="text-shadow:0 0 0.2rem black;color:white;">Le contenu <strong>intéressant</strong>. Voyez comme le texte adapte sa couleur ! Mais la lisibilité devient aléatoire, c'est pour cela que je rajoute une ombre noire au texte pour accentuer le contraste.</p>
  </div>
</div>
{{< / highlight >}}
</details>

<details><summary>Border conic gradient
<div style="display:grid;place-content:center;">
  <div style="padding:5rem;background:#222;border:3rem solid;border-image-slice:1;border-image-source:conic-gradient(#cac,#99c3d1,#ffa,#aff,#9cD256,#d25656,#cac);">Malheureusement pas de border-radius. Il est possible de l'animer en changeant l'angle !</div>
</div></summary>

{{< highlight html >}}
<div style="display:grid;place-content:center;">
  <div style="padding:5rem;background:#222;border:3rem solid;border-image-slice:1;border-image-source:conic-gradient(#cac,#99c3d1,#ffa,#aff,#9cD256,#d25656,#cac);">Malheureusement pas de border-radius. Il est possible de l'animer en changeant l'angle !</div>
{{< / highlight >}}
</details>
