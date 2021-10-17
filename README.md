# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

## What Is This?

This is the landing point for the overall set of my Linux configuration files stored on Github (and Gitlab via its pipelines). What is stored in this repository is the installation script that installs the entire suite of these files, using a selection driven menu on BASH, as well as files that don't themselves justify a separate repository.

Below is a directory of the other repositories that are associated with this configuration, which are themselves sets of interrelated files that keeping in this repository would be excessive and make administration of this and other repositories hard and awkward to deal with. Some of these are now part of the Electric Tantra effort, an operating system based on my overall system that is almost ready pending completion of my AwesomeWM configuration, thus the link will lead to a repository that is under the organization set up as a means of abstracting my repositories into relatively coherent portions, even if the organization is just me (as intended but pull requests welcome and open to new contributors always).

## Introduction to My Dotfiles

As hopefully implied by them being my configurations, this is the files which make my installations of Linux perform according to my taste and desires. This repository has grown into a relatively unique and home rolled solution, I have eschewed the use of helper programs instead preferring to completely control the process using my own installation script, even over writing my own dotfiles manager program which would offer no additional advantage to me in my use case and add additional complexity of supporting use cases outside the scope of my own.

Nonetheless, I host these publicly for the benefit of others in being able for them to serve them as examples of some of the options of how they may arrange their own dotfiles and/or as the basis for their own. **CAUTION**: if you do use these as the basis for your own configuration set, please take care to go over everything and adjust them to your needs as my preferences are idiosyncratic in the extreme at times compared to others.

## Features

**- Extensive**

- Includes specific configurations for a lot of programs
- designed a base16 scheme specifically for the purpose
- Modular
  **- Install script**
  - Idempotent
  - Menu driven
  - Modular
  - Pulls in other repos (via installation script, not as subrepos easing the maintenance process)
    - offers an example of how this may be done
  - installs programs
    - but only the ones associated with selected menu items, allowing the adaption of the files to various systems without needing to create obtuse profiles or `playbooks` in the case of Ansible or even more obtuse git branches for different use cases.
  - provisions programs with the dotfiles placed via symlink into the appropriate location on the system.

## How To

Brave soul I presume? Well lucky you, if you have nothing to do, try these relatively painless steps on a fresh install of Arch Linux and you are good to go.

```bash

git clone https://github.com/Thomashighbaugh/dotfiles
cd dotfiles
sh INSTALL

```

It is also possible that you want to just install all of the packages contained within the menu, to which end selecting them each individually may be rather tedious. Luckily, I have a script prepared for this as well! I use it to test for broken packages in a docker container but feel free to adapt it to your use cases.

```bash
git clone https://github.com/Thomashighbaugh/dotfiles
cd dotfiles
sh docker/install.sh
```

<p>Then the `./INSTALL` will show you a menu, use <kbd>Space</kbd> to select and <kbd>Up</kbd> / <kbd>Down</kbd> to select then <kbd>Enter</kbd> to get the showboat on the river!</p>

> Note: Just make sure you run the first item ("Core Dependencies") on the first menu before trying to install anything else as it installs `yay` and that's what everything else uses to install programs!

## "But Why No Submodules?!"

In this case, the avoidance of a useful, if badly documented, git feature known as submodules is due to **the nature of a dotfiles repository**. Were my awesomewm configuration (for example) pulled in as a submodule, I would **still have to symlink it to** `.config/awesome` which has the potential to break and/or find some other means of frustrating me, whereas having the installation script pull the repo into the `.config/awesome` directory directly mitigates that and I can easily then add it to my `myrepos` configuration to insure when batch committing repositories related to my dotfiles, which generally I seek avoiding as I should just be committing to each as I change things directly in the repository at the time I am so changing them. `myrepos` serves as a backup for critical moments before a reinstall or bed time, to give some examples.

## "But Why Not Maintain Separate Dotfiles Repos For Various WM Configurations"

My AwesomeWM configuration does feature the relevant files it needs to start and perform effectively, namely Rofi and Picom files that it starts with those programs or as needed, but creating an entire separate repository is just going to lead to changes in my primary WM (awesome) not being reflected in the others, whereas this way if I use another, the same platform exists under it such that if I were to change a file related to my GTK settings and go back to Awesome (as always happens whatever I tell myself) that change will still be present. This makes the most sense for me, trust me.

## Directory Structure

The two subdirectories at the repositories top level represent files that are contained within the user's home directory (aka `home/`) and those which are meant to be contained within the system's directories (or `root`). This division is merely to make it easier to appreciate the intended locations of these files on board the system without referencing the Installation Script. Inside of each, another subdirectory exists for topical divisions that often correspond to the names of the installation functions they relate to which in turn get their names from the programs that are being installed.

There is now also a docker subdirectory that is where a variant of the installation script (without interaction) is stored and dockerfile that builds an arch linux docker container than attempts to install the programs, insuring my logic and packages are functional if I have need to test them, due to a mangled install or other issue I cannot foresee arising. In theory, you could use this as a docker container for other purposes, but I do not know why you would want to as it installs mostly GUI packages but `whatever is clever`.
