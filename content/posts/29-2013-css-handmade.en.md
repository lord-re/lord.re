+++
Author = "Lord"
menu = "main"
date = "2013-03-03T23:04:55+02:00"
title = "2013 - Handmade CSS."
Categories = ["meta","www"]
Tags = ["www","meta"]
Description = "Yet anothe blog post about the website design. What have i become ?!"

+++

It's time for another post about a new css redesign. **Bootstrap** is nice but what I prefer the most is creating the css design. So using something to do it isn't the best deal. Creating new content is hard but poking the css is easy and fun. So I totally redid it. I simplified the menu bar and removed some useless stuff. I nearly didn't changed the html. Some little edits there and there and here you have a brand new css.

One of the reason to change was that i have a 16/9 monitor and bootstrap only display on about a third of it. I hate when other webstites do this so it was time to change this. I tried two or three things on this subject. First, i try to rely more on html5 tags. So I now use *nav*, *article*, *footer* and so on. It's way more semantic (i'm gonna trust all the first results on Google…). It may help people using screen readers.

I made a vertical menu bar. It's more logic to use put content vertically with wide screens. We have plenty of unused space on the side but we keep on scrolling everytime. Now i have 85% of the horizontal space dedicated to the content. You add some margins and paddings to give some air.

The main concern now is that you text is layed of looooong lines. It's hard to change line without drifting. One of the rules to respect is trying to have lines of maximum 80 caracters. I'm not fully convincend about the number but it' reasonning is right. So i decided to use a new css property to lay content on columns. The results is really nice to read. If your window is large enough, the content will be spread on multiple columns. It has a newspaper feeling. The drawback here, is that you'll have to scroll up to read the second colmun. I'll have to find a way to get rid of this.

**PS 2017 :** this design stayed for 4 years. A record ! The new design is just a new evolution. I ditched the columns because i haven't found a solution to the "scroll-up" problem.
