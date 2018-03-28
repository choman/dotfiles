# How To - YADM up and running
by Chad Homan


YADM  (Yet Another Dotfile Manager) is a tool that I personally started using about a year ago.  I absolutely love YADM (yadm) and I hope to inspire you my fellow readers into not only trying it out.  But using it in you're daily routine.

Image a world where if you

YADM as describe by the main github repo:

yadm is like having a version of Git, that only operates on your dotfiles. If you know how to use Git, you already know how to use yadm.

- It doesn’t matter if your current directory is another Git-managed repository
- You don’t have to move your dotfiles, or have them symlinked from another location.
- yadm automatically inherits all of Git’s features, allowing you to branch, merge, rebase, use submodules, etc.

## Quick Note
The purpose of this article is not to teach you git.  The good news is using yadm will teach you git.  And more importantly, if you already know git, congratulations.  You already know yadm

## Installing yadm
First off we need to install yadm.  My recommendation is that you fork the main yadm repo which is located at: https://github.com/TheLocehiliosan/yadm.  Technically you don't have to, but I think there are a couple of good reasons to do so.  The choice is yours.  My main reason is that I feel choman is far easier to type then TheLocehiliosan.

After you clone the repo, you'll need to put the main executable 'yadm' somewhere in your path. On Ubuntu, /usr/local/bin works well.  If you don't have access to root.  Try creating a ~/bin directory and putting yadm there.  Don't forget to update your PATH.

If you wondering "why not use a PPA"?  Well there is.  But at the time of this writting, the PPA is out of date.  I believe there are features in the latest version of yadm that warrant cloning/forking the main yadm repo.  So if you wish to, feel free to use the ppa.  Here is the locations: ppa:flexiondotorg/yadm

## Creating your local yadm repo
It's much easier to get started with yadm by creating an empty repo on your Ubuntu rig.  Start by entering the following command

```
yadm init
```

Wow, that was almost too simple.  now what.  

## Your first commit
We all have it, our favorite .bashrc.  Or maybe it's all are favorite aliases in .bash_aliases.  More of a zsh fan, then it's your .zshrc.  either way let's focus on the .bashrc file for now.

Let's say we what to revision control the .bashrc.  Simply run the following commands

```
yadm add .bashrc
yadm commit -c 'initial commit'
```
There you have it, your first commit.  I cheated a bit with the '-c' switch.  Again, I'm not teaching git, sorry.  

## Your first push
First we need to setup a remote repository to store our dotfiles.  You should be able to use any git server.  We will focus on github.  Goto to github and login to your account.  If you do not have an account, set one up (it's free).  create a repository to house your dotfiles.  may I suggest 'dotfiles'.  Copy the repo url and enter the following commands
```
yadm remote add origin <url>
yadm push -u origin master
```
You have now pushed your .bashrc into github.  Neat.  So what.

## Quick tangent
So let's say you need to rebuild your rig or you have multiple rigs and VMs.  Let's start with rebuilding your rig.  

After you reinstall Ubuntu and login into your account.  All you need to do is
1. Clone yadm
1. Install yadm
1. yadm clone <dotfiles repo>

Now your environment with all your favorite functions and aliases are easily restored.

The other scenario, you have multiple rigs and/or VMs.  Well think about it.  If you goto the next system and run the same three commands.  Your environment just -followed- you to your next system. Now your standardizing your environment across systems... BAM!

And, just like git.  On machine where you have already cloned your dotfiles repository.   The following two commands can be used to keep you environment sync'd.

For example, if on Machine B you've made a change to the .bashrc file that you want to follow you. Enter the following commands

```
yadm add .bashrc
yadm commic -c '<neat new thing>'
yadm push
```

Then on machine A, enter the following command
```
yadm pull
```

The new .bashrc is loaded onto machine A.  

## yadm features
So now that the basics of yadm are out of the way.  Let's go over some of the features that really make yadm stand out.

### Alternate Files
When you start to use yadm, you may find that on a given system you may want a specific file that is not common across all your systems.  In all efforts, you should try to maintain a single file using the file's conventions to condition the file for the one off.  

For example, in the .bash_aliases on a host named "mydev".. It's possible you may have custom aliases that you just do not need anywhere else.  In yadmese, you should try to use an if statement to separate that host.  So something like:

```
if [ "$(hostanme)" = "mydev" ]; then
    alias build="make"
fi
```

But what if there are no conventions.  Well you're in luck, yadm supports alternate files.  These are called symlink alternates.  Here is a tables that shows the symlink support:

|  Link Naming Convention  |  Description                          |
|--------------------------|---------------------------------------|
| ##	                     | Default file linked                   |
| ##CLASS	                 | Matching Class                        |
| ##CLASS.OS	Matching     | Class & OS                            |
| ##CLASS.OS.HOSTNAME	     | Matching Class, OS & Hostname         |
| ##CLASS.OS.HOSTNAME.USER | Matching Class, OS, Hostname, & User  |
| ##OS	Matching           | OS                                    |
| ##OS.HOSTNAME	           | Matching OS & Hostname                |
| ##OS.HOSTNAME.USER	     | Matching OS, Hostname, & User         |

So any file maintained by yadm will automatically create a symlink to the best matched file. For example, consider the following files:

```
$HOME/path/example.txt##
$HOME/path/example.txt##Work
$HOME/path/example.txt##Darwin
$HOME/path/example.txt##Darwin.host1
$HOME/path/example.txt##Darwin.host2
$HOME/path/example.txt##Linux
$HOME/path/example.txt##Linux.host1
$HOME/path/example.txt##Linux.host2
```

if you're running on a host named host8. Then yadm will automatically create the link
```
$HOME/path/example.txt → $HOME/path/example.txt##Linux
```
if you're running on a host named host2. Then yadm will automatically create the link
```
$HOME/path/example.txt → $HOME/path/example.txt##Linux.host2
```
if you're running on an OS not defined, say Solaris. Then yadm will automatically create the link
```
$HOME/path/example.txt → $HOME/path/example.txt##
```
But what's that crazy thing called "Work".  Well, if running on a system, with CLASS set to “Work”,  then the link will be:
```
$HOME/path/example.txt → $HOME/path/example.txt##Work
```

The current look up order is CLASS/OS/HOSTNAME/USER
- CLASS must be manually set using yadm config local.class <class>.
- OS is determined by running uname -s.
- HOSTNAME by running hostname and removing any domain.
- USER by running id -u -n.

#### Advance Alternate File support
- Wildcards
- Class And Other Overrides
- Jinja2 Support

### Encryption
So what if you has a file containing license keys.  What about sync'ing your SSH keys. Typically these would be plain-text files put on a public repo, and that would not be good.  Well yadm supports encryption via gpg.  And to borrow from the yadm page, for these kind of files, _it's recommended to use a private repo instead of a public repo_.

So using this feature is pretty easy.  A list of patterns is written to $HOME/.yadm/encrypt.  For example:
```
.ssh/*key
```
Then by entering yadm encrypt, the entries are parsed and you'll be prompted for you gpg password.  The matching files will then be encrypted in a tar'file under the following: $HOME/.yadm/files.gpg

When completed, add the pattern file and the encrypted file to yadm.
```
yadm add .yadm/encrypt
yadm add .yadm/files.gpg
yadm push
```
The on the next system, if you run the following commands
```
yadm pull
yadm decrypt
```
When the password is confirmed, you will have synchronized your super private files.

#### Quick note
Your gpg keys will need to be on the next system.  How you get them there is a side step.  I would use an encrypted thumb drive or encrypt them to a thumb drive.  They are your gpg keys, protect them

### Bootstrap - The kitchen Sink
For the most part, your dotfiles are enough.  But consider these
- what if you are a git repo you like to have across systems
- what if you like the clock on your desktop a specific way
- perhaps you like to ensure certain browser extensions

For all the extras, there is yadm bootstrap.  The bootstrap is a convenient way to support things that your dotfiles (or yadm) quite frankly, do not support.

In it's simpliest form, yadm bootstrap is a script.  Specifically located at $HOME/.yadm/bootstrap.  Here is old Ubuntu unity example to set the size of the unity dock.
```
#!/bin/bash

dconf write /org/compiz/profiles/unity/plugins/unityshell/icon-size 32

```
