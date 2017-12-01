+++
Author = "Lord"
Categories = ["tips","adminsys"]
Description = "Manage your dotfiles without a new soft. Easily with versionning and all."
Tags = ["www","meta"]
date = "2017-10-16T12:50:35+02:00"
PublishDate = "2017-10-16T12:50:35+02:00"
menu = "main"
notoc = true
title = "Easily manage your dotfiles with git"

+++
I tease you from time to time about this topic so here it is. I'll show you how i manage my dotfiles. It's a recurring subject in the linuxian world and everybody use a different solution.

Some use a soup of symbolic links in every directions to centralize everything in one easily copy/pastable directory. Others rely on personal scripts or even software like GNU Stow. Some nerdier use Makefile as a way to get themselves out of this burden (and in fact it's not so crazy). In my case I **wanted to avoid having to learn a new soft**. I wanted **not to install a dedicated soft/script**. It **can't be a PITA** with links**. I want **versionning** to recover from mistakes.

## Git to the rescue
A complete solution is to use ***Git***. With this you have versionning, easy synchronization and you can have branches between multiple computers. But how do you set it up ? Do you put everything from */home* in the repo but you'll have to cope with files in your home you don't want to add in your repo ? Moreover, you'll have all git's file in your home (description, HEAD, hooks, logs, refs, and so on).

## The git killing command !
**git --git-dir=/home/lord/.myconf --work-tree=/home/lord**

Here's the beast. It fits well in an alias (**config** for example). So every git's files will be stored in */home/lord/.myconf* so your */home* stays clean.

## Magnets how do they work ?
First you'll have to add files you want git to track with **config add .ssh/config** will add a precise file or **config add .ssh** will add all files in the folder. ***BEWARE ! Don't put sensitive files in your git repo if you're not absolutely confident with all machines which will sync/store you repo !*** (I don't put my ssh keys in my repo).

Next you check everything is good with **config status** :
	lord@hermes ~ %config status
	On branch master
	Your branch is ahead of 'origin/master' by 4 commits.
	  (use "git push" to publish your local commits)
	Changes to be committed:
	  (use "git reset HEAD <file>..." to unstage)
	        new file:   .config/mpv/scripts/fix-sub-timing.lua
	        new file:   .ssh/config
	        new file:   .ssh/known_hosts
	Untracked files not listed (use -u option to show untracked files)

We see that locally my repo have 4 commits that the "master server" haven't and that i added files that aren't commited yet. So let's commit them **config commit .ssh/config .ssh/known_hosts -m "[SSH] Adding .ssh/config and .ssh/known_hosts"** .

	lord@hermes ~ %config commit .ssh/config .ssh/known_hosts -m "[SSH] ajout de .ssh/config et .ssh/known_hosts"
	[master 35259ea] [SSH] ajout de .ssh/config et .ssh/known_hosts
	 2 files changed, 271 insertions(+)
	 create mode 100644 .ssh/config
	 create mode 100644 .ssh/known_hosts

Ok it's done. If later you want to remove some files from your repo (but not the real files) you'll have to **config rm --cached .ssh/id_rsa** . The important thing is ***--cached***.

Hey ! It's turning into a git tutorial ! Yes I know but there is just some more commands to learn. If you already know git you can skip this blog post now.

## How to change the past ?
You need use **config log** to see all the past commits with their dates, messages and ***hash id***. To see the content of a commit use **config diff xxxxxx** (you can limit to one file with **config diff xxxxxx your/file**) where xxxxx is the hash id of your commit.

Now you have found the faulty commit and want to cancel it ? The best is to **config revert xxxxxxxx**. You'll quickly learn to split your commits in multiples smaller commits. The smaller the commit the easier to get back.

If you only need to temporarily go back to a previous state you just need to **config checkout xxxxxxxx**. You'll be in the ***DETACHED HEAD*** state. You should keep you from editing anything in this mode, if not it's quite hard to merge all your changes and go back to the current state. By the way, to go back to the current state enter **config checkout master** and there you are.

You should know that there is a **reset** and **reset --hard** command but those can be very destructive. RTFM heavily before trying to use them.

## How do I sync elsewhere ?
I didn't synchronized for a long time but now I do it mainly for a backup purpose. I now have a personnal ***gogs*** installation (inside a ***Sandstorm*** instance) where I keep a copy of many repo. So the repo exist locally and in gogs but also on a third location as a backup. You just have to add a remote to the repo with **config remote add gogs https://xxxxxxx** and **config remote add backup ssh://xxxxxx** .

And now after commits i must push with **config push gogs** and **config push backup**.

And now you can **config fetch** or **config status** and **config pull**. There you are.

Now if you want to add this on a new machine all you have to do it going to */home/user* . You remove any file present (backup)and **config init .** then a nice **config remote add origin xxxxxxx**, followed by **config pull origin** (it can take some time for the first sync) and the final touch is **config checkout master**. And you're done with all your files.

## Not as simple as you said !
No. It looks hard but in fact you won't have to do complex things everyday. You'll mainly **config commit** and **config push**. If you already know git it's very easy, if not it's a very good reason to discover git.

The real magic is ***git --git-dir=/home/user/.myconf --work-tree=/home/user***
