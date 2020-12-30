# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

> Note: This is no minimalist's dotfiles, no attempt has been made here to minimize the size of the repository but has instead been written to minimize the hassle of the reinstallation process after first boot. Thus there is a lot going on, which follows a logical enough pattern but is not hipster enough to care about minimalism, instead the author pursued a sort of maximalism as you will see evaluating the source code. 

## What Is Going On Here

The wild world you have found yourself within is my dotfiles, which are Linux configuration files that generally begin with a period (or dot) hiding them from view.

This ever evolving example of what is possible with Linux (and a lot of time spent fighting with it) is entirely for the installation and configuration of my personal systems on Arch Linux based machines. You will probably need to modify it for your own use cases, whatever it is that they are.

### Dotfiles are Meant to be Modular

Some dude named Holman wrote an article explaining his organizational pattern in his dotfiles repo *a decade ago* (I wonder how Holman is doing a decade later...), which was the inspiration for this one even if I differed a bit in my approach to organizing this repository, read his logic [here](https://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/) since he can explain himself better than I ever could. 

Huge inspiration to those of us afflicted with concern for such matters, but his pattern has a flaw in my use case, I am looking to make each part of these dotfiles entirely modular. Such that I could break it apart and resemble the topics directory at whim and still it would function, as this would enable the forking of dotfiles as he exclaims they are meant to be as well as better lend them to a consistent provisioning process without reliance on the ugly carbunckle that programs like stow tend to be.

This modular approach also benefits you, patient reader, for you will be able to take portions of these dotfiles out of their general context and apply them locally as you see fit without the need to tease them out of some terse, messy monolithic script, a constant irritation of mine when evaluating other people's dotfiles if they had any provisioning going on they had rolled themselves (don't even get me started on dotfiles management applications, or Makefiles or any of the rest of that, I will go on for weeks). 

To realize this modular nature, zsh completions related to git are not in `topics/git` but in `topics/zsh/` (for example). That way zsh can be isolated entirely from git if that happens that I want to provision a system with my git configuration (currently an install and one git command to store my credentials) but not bring in the whole mess that is my zsh configuration.

The idea and indeed much of the programming logic of the repo comes from wafflepie's take on the _Holman Pattern_ which he included a script I have mopdified that replaces a portion of the Makefile for now

### No Submodules Zone

No submodules are included within the application logic of the installation process, nor included in this repository. This is a strange choice, to be sure but this makes the installation and maintaining of this repository less of a nightmare for me and makes for a cleaner overall installation process for the end user, who is also just me. Submodules are of two overall types, those that are your own repositories and those that are other people's repositories. I will go over my reasoning for leaving them both out below. 

### Idemponent 

All of this should be idempotent, which is the snobby way of saying you can run it on top of itself and it should still work the same as if you had just run it the first time. The advantages of this approach are (for me):

- consistency in environment resulting from installation+provisioning
- if not in the mood for debugging why soemthing isn't working right that was working prior, I can just run the whole thing over or delete the `dotfiles` directory and `git clone` it again.
- its a key feature of Ansible I can reproduce without needing to try to fit Ansible into an arch-based environment where the AUR helpers cannot be run as root nor need to remember the nuances of Ansible and the quirks its acquisition by RedHat will mean as time marches on (look at their videos sometime and you will get what I mean).
    - just like Ansible, these files are also completely adapted to being run remotely via ssh (you might want to trim a lot of graphical topics out of the installation file first)
    - also Ansible has some of the most annoying video docs I have ever seen. I know, company named after the founder's habit of wearing a *red fedora to college classes* what else can you reasonably expect.

### Unattended... well in theory
    Essentially, these scripts enable an unattended provisioning and configuration of Arch Linux (or Arch based OSes like Manjaro) after first boot and a few relatively simple requirements are met, namely the user is created and you are logged in as said user then clone this repository into their home directory. The end result is a completely provisioned according to my specific, strange tastes system that is ideal for my every want and whim after the reboot you should probably follow the installation process with. That's also known, in the unnecessary jargon of tech, as an unattended install in that it should require 0 input from the user. 

    The reality is I never walk away from an installation merely because there are bugs to catch and sometimes I forget to add the --noconfirm flag to a yay or pacman comand but I am working on ironing all of that out. Its just, I don't install the whole system everyday (anymore...) and so sometimes these bugs will linger. But you can submit pull requests I'd be happy to merge!

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
