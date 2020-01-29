
```
#####   ####  ##### ###### # #      ######  ####     #  #  #      #       #   #  
#    # #    #   #   #      # #      #      #             ##      #         # #   
#    # #    #   #   #####  # #      #####   ####                #        ####### 
#    # #    #   #   #      # #      #           #              #     ###   # #   
#    # #    #   #   #      # #      #      #    #             #      ###  #   #  
#####   ####    #   #      # ###### ######  ####             #       ###         
```

# Dotfiles 
![Screenshot 01](
## TL;DR 
Managed with Make; AWESOMEWM, ZSH, TMUX, VIM/NVIM, KITTY, ROFI; Custom & Consistent Theme; Basically my whole existence since I fell into the Linux rabbithole, all in one place. 

## Introduction
The repository before you is the culmination of a decision to learn Linux concurrently with web development, a fateful decision that a few months ago lead me to tiling window managers and using version control to back up my configurations between installs and to move my environment between systems while retaining the configurations that make it functional **for me**. 

Each of these files and the configurations it contains I have cobbled together through trial and error, which I reccomend you do as well instead of copying them wholesale. None the less, you are free to do with them whatever you wish as they are offered under the MIT license without any express or implied warranty.

In certain subdirectories, like the one for Awesome WM, ie `/awesome`, you will find another README with a little bit about the contents if I deemed it of interest. 

### Branches
The present goal is to have a different branch of this repo for each system type that these dotfiles are intended to provision. 

These branches are being made as needed but will eventually include all of the system types that were in the old version of this repository. These feature branches are for system types:
- Laptop
- MiniPC // Small Form Factor
- Raspberry Pi 3 
- Desktop
- Hypervisor 

### Quick Start // Personal Reference 
>>> Run `make` for all or `make {vim,zsh,..}` for individual components.

## Managed With Make
No I didn't use stow or dotbro, though I have in the past, I went straight to the source and used Makefile. I thought that this method would be the most troublesome way to configure my systems but its actually the easiest and most functional method of provisioning my systems that I have used so far because it features the functionality of a system link farmer like stow with the package installation power that I appreciated in Ansible. 

### Make = Ansible + Stow 
The formula is simple because Make essentially works, in this use case at least, like a modified shell script thus enabling me to system link to various configurations within this directory while also enabling me to install the over-the-top number of things I like to have ready on my system. 

Using this method also offers modularity, so if you want only to provision some portions of your system using my files that is easy enough to do (and each option is displayed in the help dialog from the Makefile). 

Essentially it removes the headache of maintaining an installation script especially in the process of debugging and provides an easy enough way to section that script and understand it when reading it. 

In contrast to symlink farmers like Stow, there is no need to wrap your head around the quirks, as essentially the Makefile methodology means that its running the exact command you input in it. No need to remember to remove the opening period or complexity involving linking an entire directory. Simply enter the command exactly as you want in the Makefile and it will run **exactly as entered**.

Since I provision systems generally that are under my direct control, using Ansible is a bit overkill even when targetting the localhost and I find its jargon to be an unnecessary distraction when simply trying to restore your system to working order. Its an awesome and powerful provisioning tool but I found I like the more direct control offered by my Makefiles even on remote systems per my specific use case. 

