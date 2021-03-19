# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

> Warning: no minimalism can be found in this repo

## Introduction

A repo, on Github featuring dotfiles and an installation script bring an Arch system from first boot to totally useful to me and just the way I like it.

## Features

- Extensive
- Modular
- No Submodules
- Install script
  - Idemponent
  - Unattended Installation/Configuration
  - Customizable to Your System/Needs Using TUI Selection Menu
## How To

Brave soul I presume? Well lucky you, if you have nothing to do, try these relatively painless steps on a fresh install of Arch Linux and you are good to go.

```bash

git clone https://github.com/Thomashighbaugh/dotfiles
cd dotfiles
sh install.sh
```

Then the `install.sh` will: 
1. Install some necessary programs that are needed to install more programs, run the menu's dialog backend, etc
2. Prompt you to run a one-liner in another terminal that will install yay (AUR helper and pacman wrapper that I bet you heard of before now)
3. Use yay to install a few more programs from AUR you need for the aforementioned reasons 
4. Present you with a menu that you can use to select applications/categories of applications to install and provision individually 

### Selecting Applications on the Menu
Use the up and down arrows to select applications, then use spacebar to toggle them on or off. 

When you are satisfied with your selections, they will be gone through top-to-bottom and if the last item isn't toggled, you will be brought back to the menu

**In order to exit the script, you must select the last item, otherwise it will loop through the selections and bring you right back to the menu!**
---

## 'Why Even Use an Installation Script, Options Exist Doing This For You'
And those options don't work for my purposes. I hope to create a single script to use after rebooting into my system after freshly installing and downloading this repository without need for additional, awkward software to do so. These options are great for other purposes, but despite a lot of experimentation, I have found that a shell script is the best way to achieve my intended system, with Makefile coming in close second. 
---

## Inspiration

- [Holman Does Dotfiles](https://github.com/holman/dotfiles)

- [wafflepie/dotfiles](https://github.com/wafflepie/dotfiles)
