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

### No Submodules Zone

No submodules are included within the application logic of the installation process, nor included in this repository. This is a strange choice, to be sure but this makes the installation and maintaining of this repository less of a nightmare for me and makes for a cleaner overall installation process for the end user, who is also just me. Submodules are of two overall types, those that are your own repositories and those that are other people's repositories. I will go over my reasoning for leaving them both out below. 

### Idemponent (WIP)

All of this should be idempotent, which is the snobby way of saying you can run it on top of itself and it should still work the same as if you had just run it the first time. The advantages of this approach are (for me):

- consistency in environment resulting from installation+provisioning
- if not in the mood for debugging why soemthing isn't working right that was working prior, I can just run the whole thing over or delete the `dotfiles` directory and `git clone` it again.
- its a key feature of Ansible I can reproduce without needing to try to fit ansible into an arch-based environment where the AUR helpers cannot be run as root nor need to remember the nuances of Ansible and the quirks its acquisition by RedHat will mean as time marches on (look at their videos sometime and you will get what I mean).

---

## Directory Structure

### Within the System

Some people go to great lengths to hide as many of their dotfiles as possible out of the home directory, which I do somewhat as well, just not to the same extent. I have moved my bin directory to `.local/share/bin` but am also ok with having `.zshrc` in my home directory (for now...) and think having a `.etc` or `.local/etc` when already there is a `.config` is reinventing the wheel.

### Directory Structure

Internal to this repository are a series of directories that are as follows
| Directory | Contents |
|-----------|----------|
| dependencies | things needed for rest of installation process, namely yay, are installed in the install.sh in here |
| devices | installation scripts for the devices I have to provision, these control what gets installed on each devices and in what order |
| topics | various programs that I either install, provision or both on fresh installations |


### Dependencies 
In order to have things work as expected in the individual programs installation phase, there are some necessary programs that need to be present on the system. These programs are needed by all devices and so the first step with each device's installation is first running the install script in the `dependencies` directory. The main program this script installs is yay, an AUR package manager that pulls in a large segment of programs I use because they are not in the Arch Official Repositories.  

### Topics

Within the topics directory are a series of sub-directories that correspond to each program that is provisioned, installed or both. Inside of each of these is an `install.sh` script that will install and provision, according to need, that program. I have tried to minimize the number of package bundles where dozens of programs get lumped in together and installed, thus have maximized the number of sub-directories. Many of these subdirectories only have the `install.sh` file in them because there is no necessary configuration files to symlink into the home directory, which may seem daunting to some, but navigating `vim` to the location it is symlinked to and editing the file has always worked fine for me so I doubt any potential users would have too much trouble with editing files doing it that way if they found the topics subdirectories a little daunting. 

## Inspiration

- [Holman Does Dotfiles](https://github.com/holman/dotfiles)

- [wafflepie/dotfiles](https://github.com/wafflepie/dotfiles)
