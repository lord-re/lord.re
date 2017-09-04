+++
date = "2010-01-25T17:52:30+02:00"
title = "An ounce of ViM to change your mind"
Tags = ["tips","vim"]
Description = "Coloring the syslog while using vim to read it. Finally it's not really a great idea."
menu = "main"
Categories = ["tips","vim"]
nodate = true

+++
This time i had a dumb idea : colors in syslog in vim ! So i'm browsing vim.org, looking for a script. I download the file to **~/.vim/after/syntax/syslog.vim** . Then a small edit in **~/.vim/filetype.vim** to add :
```
augroup filetypedetect
au! BufRead,BufNewFile /var/log/syslog set filetype=syslog
augroup END
```
And there you go ! Next time you'll open your logs you'll have a rainbow of despair :-D


*PS 2017 :* I don't use it anymore. It's quite pointless.
