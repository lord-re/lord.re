+++
date = "2010-01-25T17:52:30+02:00"
title = "Un chtit coup de ViM pour changer"
Tags = ["tips","vim"]
Description = "Colorons le syslog lorsqu'on le lit avec vim. Après coup c'est pas forcément une bonne idée."
menu = "main"
Categories = ["tips","vim"]
nodate = true

+++
Ce coup-ci j'ai voulu faire un truc tout con : colorer le syslog dans vim. Donc je vais sur vim.org, je cherche un script de coloration de syslog. Je télécharge le fichier dans **~/.vim/after/syntax/syslog.vim** . Ensuite il ne reste plus qu'à éditer/créer le fichier **~/.vim/filetype.vim** avec dedans :
```
augroup filetypedetect
au! BufRead,BufNewFile /var/log/syslog set filetype=syslog
augroup END
```
Et voilà la prochaine fois que vous lirez vos logs vous aurez de zolies couleurs :-D
