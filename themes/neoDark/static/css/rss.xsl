<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">
  <xsl:output method="html" version="1.0" encoding="UTF-8" indent="yes"/>
  <xsl:template match="/">
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title><xsl:value-of select="/rss/channel/title"/></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1"/>
        <style type="text/css">
        * { box-sizing: border-box; }
        body { --gap: 5vw; margin: 0; font-family: system-ui; line-height: 1.7; background:#222;color:#ccc;}
        #main { max-width:50rem;margin:auto;}
        h1,h2,h3 { margin-block-start: 0; margin-block-end: 0; }
        h1 {text-align:center; font-height:2rem;}
        a:visited {color:#99b;}
        a {color:#ccf;}
        .item {background:#111;border-radius:1rem;padding:1rem;margin-bottom:1rem;}
        </style>
      </head>
      <body>
      <div id="main">
        <h1><xsl:value-of select="/rss/channel/title"/></h1>
        <img src="https://lord.re/svg/favicon.svg"/>
        <p><xsl:value-of select="/rss/channel/description"/></p>
        <p style="color:green;">Dernière mise à jour le <xsl:value-of select="/rss/channel/lastBuildDate"/></p>

        <div id="presentation">
        <p>Le chef vous propose son assortiment de flux RSS pour suivre ce site :</p>
        <ul>
          <li><a href="https://lord.re/index.xml">Gastonomique</a> : <strong>tout</strong></li>
          <li style="color:#cac;"><a href="https://lord.re/posts/index.xml">Les posts</a> : uniquement les articles un peu longs</li>
          <li style="color:#99c3d1;"><a href="https://lord.re/fast-posts/index.xml">Les fast-posts</a> : uniquement les ptits posts plus souvent sur l'actualité</li>
          <li style="color:#ffa;"><a href="https://lord.re/shares/index.xml">Les partages</a> : des trouvailles, des liens, des trucs qui me plaisent, de la culture</li>
          <li style="color:#aff;"><a href="https://lord.re/ideas/index.xml">Les idées de merde</a> : des idées qui ont trouvé le chemin du clavier</li>
          <li style="color:#9cd256;"><a href="https://lord.re/recap/index.xml">Les récaps mensuels</a> : le journal de bord de ce que j'ai foutu dans le mois</li>
          <li style="color:#d25656;"><a href="https://lord.re/visionnages/index.xml">Les visionnages</a> : si vous voulez mettre à l'épreuve mes goûts cinématographique c'est ici !</li>
        </ul>
      </div>

      <div><p>Rien ne sert de marteller mon pauvre petit serveur. Je poste pas dix fois par jour et je doute que mon contenu vous soit indispensable donc s'il vous plaît configurez votre lecteur de flux RSS pour qu'il ne vienne qu'une fois par jour. Vous ne manquerez rien et ça épargnera un peu ma machine et la planète (ahem).</p></div>
      <hr/>
  
      <section class="recent">
        <h2>Les 5 derniers posts</h2>
        <xsl:for-each select="/rss/channel/item">
          <div class="item">
            <h3><a target="_blank"><xsl:attribute name="href"><xsl:value-of select="link"/></xsl:attribute><xsl:value-of select="title"/></a></h3>
            <small class="meta">Publié le : <xsl:value-of select="pubDate"/></small>
            <div><xsl:value-of disable-output-escaping="yes" select="description"/></div>
          </div>
        </xsl:for-each>
      </section>

      </div> 
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
