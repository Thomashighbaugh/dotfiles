#!/bin/bash

## Related Repository Cloning and Setup

## This amounts to the bulk of the configuration nebula that is my dotfiles,
# these repositories are a little too much to manage in a monorepo and calling
# in submodules to symlink them makes little sense when I can instead write a
# quick script and place them where they are expected precisely.

###############################################################################
## Colors & Print Functions ###################################################
###############################################################################
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"

print() {
    case "$1" in
    t | title)
        shift
        printf "%s\n" "${sb}${cg}[###]$*${sn}"
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}"
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}"
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}"
        ;;
    *)
        printf '%s\n' "$*"
        ;;
    esac
}

function Repos() {
    print w "###############################################################################"
    print w Beginning Repository Cloning
    print w "###############################################################################"
    print s Awesome Window Manager
    git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome
    print s "###############################################################################"
    print s Cloning Grub2 Theme
    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme && sh "$HOME"/.local/share/Bhairava-Grub-Theme/install.sh
    print s "###############################################################################"
    print s Cloning bin Scripts
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
    print s "###############################################################################"
    print s Installing the Latest Neovim, with Packer and then Configuring It
    git clone https://github.com/neovim/neovim "$HOME"/neovim && cd "$HOME"/neovim && sudo make CMAKE_BUILD_TYPE=Release install && cd .. && rm "$HOME"/neovim
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://github.com/Thomashighbaugh/nvim "$HOME"/.config/nvim
    print s "###############################################################################"
    print s Cloning and Installing ZSH Configuration
    git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && cd "$HOME"/.zsh && sh install
    print s "###############################################################################"
    print s Cloning Icon Theme and GTK Theme, then Building the GTK Theme and Installing
    sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
    git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ~/.local/share/themes/Dhumavati-Theme && cd ~/.local/share/themes/Dhumavati-Theme && sudo make build && sudo make install
    print s "###############################################################################"
    print s Cloning QTile Configuration
    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
    print s "###############################################################################"
    print s Cloning and Patching Firefox
    git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox && cd /tmp/firefox && sh install.sh
    print s "###############################################################################"
    print s Cloning LightDM Theme
    git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme
}
