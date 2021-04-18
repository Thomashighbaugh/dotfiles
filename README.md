# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

## Introduction

A repo, on Github featuring dotfiles and an installation script bring an Arch system from first boot to totally useful to me and just the way I like it. Your tastes will vary, inevitably, so you can use this as the basis for your own repo, steal ideas from it, fork it, whatever you want to do.

But **beware** minimalism and other trendiness are not to be found here. These files are about how **I** like my system and not how everyone else likes it.

## Features

- Extensive
- Modular
- Install script
  - Idemponent
  - Menu driven
  - Modular
  - Pulls in other repos
  - installs programs
  - provisions programs

## How To

Brave soul I presume? Well lucky you, if you have nothing to do, try these relatively painless steps on a fresh install of Arch Linux and you are good to go.

```bash

git clone https://github.com/Thomashighbaugh/dotfiles
cd dotfiles
sh install.sh
```

<p>Then the `./INSTALL` will show you a menu, use <kbd>Space</kbd> to select and <kbd></kbd> / <kbd></kbd> to select then <kbd>Enter</kbd> to get the showboat on the river!</p>

> Note: Just make sure you run the first item on the first menu before trying to install anything else as it installs `yay` and that's what everything else uses to install programs!

## But Why No Submodules

In this case, the avoidance of a useful, if badly documented, git feature known as submodules is due to the nature of a dotfiles repository. Were my awesomewm configuration (for example) pulled in as a submodule, I would still have to symlink it to `.config/awesome` which has the potential to break whereas having the installation script pull the repo into the `.config/awesome` directory directly mitigates that and I can eaisly then add it to eh `myrepos` configuration to insure when batch committing repositories related to my dotfiles, which generally I seek avoiding as I should just be committing to each as I change things directly in the repository at the time I am so changing them. `myrepos` serves as a backup for critical moments before a reinstall or bed time, to give some examples.

## Directory Structure

The two subdirectories at the repositories top level represent files that are contained within the user's home directory (aka `home/`) and those which are meant to be contained within the system's directories (or `root`). This division is merely to make it easier to appreciate the intended locations of these files on board the system without referencing the Installation Script. Inside of each, another subdirectory exists for topical divisions that often correspond to the names of the installation functions they relate to which in turn get their names from the programs that are being installed.

## Related Repositories Spun Out of This One

Once a configuration gets to a large enough size, it is spun out into its own repository and, as mentioned above, the installation script will clone this new repository in the position the system expects it instead of within this directory and symlinking, as the former is a more reliable method overall.

These additional repositories are listed in the table below for the purposes of providing the most exact account of the actual size of my dotfiles now that I have quite a few of these additional repositories.

| Name | Path | Notes |
|------x------x-------|
| [Awesome](https://github.com/Thomashighbaugh/awesomewm) | ~/.config/awesome | configuration of my window manager configured in lua |
| [bin](https://github.com/Thomashighbaugh/bin) | ~/.local/share/bin | scripts that I use locally, includes the scripts that display terminal colors in ASCii art |
| [firefox](https://github.com/Thomashighbaugh/firefox) | ~/.mozilla/firefox/[profile directory]/chrome | theme for webbrowser using CSS |
| [qtile](https://github.com/Thomashighbaugh/qtile) | ~/.config/qtile | Alternative window manager configured in python |
| [vim](https://github.com/Thomashighbaugh/vim) | ~/.vim | My editor configuration |
| [zsh](https://github.com/Thomashighbaugh/zsh) | ~/.zsh | My z shell configuration, similar set up to the vim configuration above |

## Inspiration

- [Holman Does Dotfiles](https://github.com/holman/dotfiles)

- [wafflepie/dotfiles](https://github.com/wafflepie/dotfiles)
