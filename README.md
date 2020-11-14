# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

## What Is Going On Here
The wild world you have found yourself within is my dotfiles, which are Linux configuration files that generally begin with a period (or dot) hiding them from view.

This ever evolving example of what is possible with Linux (and a lot of time spent fighting with it) is entirely for the installation and configuration of my personal systems on Arch Linux based machines. You will probably need to modify it for your own use cases, whatever it is that they are. 


### Dotfiles are Meant to be Modular

Some dude named Holman wrote an article explaining his organizational pattern, which was the inspiration for this one even if I differed a bit in my approach to organizing this repository, read his logic [here](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/) since he can explain himself better.

Though his pattern has a flaw in my use case, I am looking to make each part of these dotfiles entirely modular. Such that I could break it apart and resemble the topics directory at whim and still it would function. This is why I use for loops instead of specifically calling each topic in a Makefile, despite the loss of precise control over order that it implies, because it means if I decide to nuke some piece of the configuration I won't need to fiddle with the scripts to make the thing install again.

To realize this, zsh completions related to git are not in `topics/git` but in `topics/zsh/git` (for example). That way zsh can be isolated entirely from git if that happens to suit my configuration. Now you can actually fork these dotfiles and add parts of them to your own without needing to roll in all the rest of them if you don't want them all.

The idea and indeed much of the programming logic of the repo comes from wafflepie's take on the _Holman Pattern_ which he included a script I have mopdified that replaces a portion of the Makefile for now

### Two Tools For One Problem?

Ansible has its use cases which it works awesomely for and Stow, well it works well for what its _actually_ for but really these tools are flatheads when what provisioning my systems really requires is a philips head, so to speak, for me to be truly satisfied with how stable and secure my system is. So instead of trying to bend Ansible to work with AUR helpers or even looking at anymore GNU word salad (called docs apparently to the GNU folks), I just wrote a bunch of files called `install.sh` which do the job of both tools, **NATIVELY** because that is what shell scripts exist for and reinventing that wheel doesn't seem to contribute much to anything but the frustrations of r/unixporn readers playing with the things years later.

Yes, I am a proponent of Makefiles for things like this, which are not exactly their intended purpose but close enough that they offer far better features than things like stow, but elected to write shell scripts to install all the necessary applications **by topic** and then symlink my configurations **by topic** because they are far easier to call and easily managed as modular components within a directory tree as I have done here. I left the Makefile around for updating the several repos that are part of these dotfiles but spread out for purposes of keeping my head on straight. Which is the same reason that I don't have a bunch of **hidden directories** in this repo like stow users...

### No Submodules Zone

**Detatched heads suck**, *especially from my repos*. So there is none of that in this repo. Sure there are other git repos being called in various topic's `install.sh` files, but they aren't downloaded in this repo only to haunt me later on, they are going into the places they are expected in the system. That way I can still set up a script to update them really fast (like after crashing my OS and remembering to update them all) but none of the tedious, hard to maintain tinkering with submodules that still detatch from their HEAD and cost you 12 hours of work on your awesomewm config (Lua is the worst, hands down). This is the power of shell scripts, no need to bend the tools to the point of detatching your repos from their HEAD which you won't realize until you realize that your work was lost.

Also I have included the external libraries, plugins, etc. within this repo as files, because the files included are the exact files I have built this configuration upon, no breaking changes can even be introduced unless I manually add them in. Maybe others desire some additional changes in the repos that they incorporate into their configurations, I tend to leave the thing out or make the changes myself over waiting and I don't judge, this is just what works for me.

### Idemponent (WIP)

All of this should be idempotent, which is the snobby way of saying you can run it on top of itself and it should still work. With the other cloned repos being the temporary exception as I have to hunt them all down and wrap them in conditionals.

According to RedHat's Glossary related to Ansible,

>     An operation is idempotent if the result of performing it once is exactly the same as the result of performing it repeatedly without any intervening actions.

What this means for my systems' configurations

- consistency in environment
- an known baseline systems can be returned to if my tinkering goes too far
- if not in the mood for debugging why soemthing isn't working right, I can just run the whole thing over (hoping its not an issue with the config files themselves)
- it sounds really nerdy
- its a key feature of Ansible I can reproduce without needing to try to fit ansible into an arch-based environment where the AUR helpers cannot be run as root.

---

## Directory Structure

### Within the System

Some people go to great lengths to hide as many of their dotfiles as possible out of the home directory, which I do somewhat as well, just not to the same extent. I have moved my bin directory to `.local/share/bin` but am also ok with having `.zshrc` in my home directory (for now...) and think having a `.etc` or `.local/etc` when already there is a `.config` is reinventing the wheel.

### Within the dotfiles Repository

Internal to this repository are a series of directories that are as follows
| Directory | Contents |
|-----------|----------|
| dependencies | things needed for rest of installation process, namely yay, are installed in the install.sh in here |
| devices | installation scripts for the devices I have to provision, these control what gets installed on each devices and in what order |
| topics | various programs that I either install, provision or both on fresh installations |

#### Doesn't that make it harder to work with the files cause there are like all these topics in there

When I want to modify values in my dotfiles, I generally navigate to where the system expects them and the soft link provided in the install process is sufficient that I never have an issue modifying the file found in that place that is really the one deep in my dotfiles/topics.

### Topics

Within the topics directory are a series of sub-directories that correspond to each program that is provisioned, installed or both. Inside of each of these is an `install.sh` script that will install and provision, according to need, that program. I have tried to minimize the number of package bundles where dozens of programs get lumped in together and installed, thus have maximized the number of sub-directories.

## Inspiration

- [Holman Does Dotfiles](https://github.com/holman/dotfiles)

- [wafflepie/dotfiles](https://github.com/wafflepie/dotfiles)
