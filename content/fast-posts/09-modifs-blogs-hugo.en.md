+++
Author = "Lord"
Description = "What I did behind the scenes on the blog these last months"
Categories = ["meta", "hugo","blog","git"]
menu = "fast"
noread = true
draft = false
notoc = true
PublishDate = 2018-02-11T10:34:48+01:00
date = 2018-02-11T10:34:48+01:00
title = "Meta-news about the blog"
+++
Two months after introducing fast-posts here a small report.

## Rythm
I think i reached a nice regular rythm to publish new articles.
It's not a difficulty anymore.
It's now easier and more natural to write content.
It's a even a real pleasure to write.

Creating a distinction between traditionnal posts and fast-posts was a good decision which let me being more spontaneous.

## Layout
I tweaked a bit the site layout.

First, i added the *last edition date* (if there is one).
It's manual for now but i may change that later by using the file git metadata.

I then *corrected fast-posts colors in list pages*.
For those who haven't noticed yet (mainly the rss readers), fast-posts have a blueish tint.
This slight blue wasn't applied in lists.

Lists ?
It was half broken but I *repaired page lists*.
When you click in articles tags (like "meta", "hugo", "blog", "git" on the top), you go to a page which lists every articles from this category.
You may not know it but it was broken but it's better now.
I tweaked my hand-crafted hugo theme (it's probably not the best place to change it but you know…).
One day I'll publish the theme somewhere.

As I repaired categories, I *added a lot of tags to existing articles*.

## CSS
Let's talk about the *æsthetics changes in CSS*.

Stylized a little bit the last edition date in articles.

I also *changed the \<hr> style* which where awful to now reach the meh-level.

I *indented list items* which where a bit too much on the left.

I *centered images*.

And also *added some style to \<table>* which you'll see in a future article.

## How do i do it ?
I *always have one or two articles waiting* before releasing them.

I put them *off for some days before returning to it*.
This increase the quality of articles.

Before, i wrote article and released them without waiting.
Hours/days after being published, i often had to add/remove things from the articles.
By letting them sit on my cold computer for some days and then re-reading them before releasing, i can change them, see typos and all.
This way all articles have a second pass before being published.

Having always some articles close to be published i can maintain a good publishing rythm.
It's a small tip which increase quality without any downside.

## Which tools to publish ?
How it's done ?

  1. **cd ~/www** - That's where i keep the sources files
  2. **hugo new posts/xx-titre-du-post.md** - to create the file with metadata
  3. **amp** - to start [amp]({{< ref "posts/72-amp-text-editor" >}}) and write text
  4. **hugo server --navigateToChanged -F -D --disableFastRender** - to be able to browse edits in realtime.
  5. **git add content/posts/xx-titre-du-post.md** - to add the new file to the git repo
  6. **git commit !$ -m "[BLOG] ajout article xx titre du post"** - to commit files and add a comment to the repo
  7. **git push** - to save the repo and publish on the website.

## What if you built your blog ?
