#!/bin/env bash

##############################################################################
## Awesome Wm ################################################################
##############################################################################

## Install Relevant Packages
yay -S --noconfirm --sudoloop awesome-git feh xcape

yay -S --noconfirm --sudoloop vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus

yay -S --noconfirm --sudoloop bemenu blueberry blueman bluez-hid2hci bluez-tools bluez-utils

yay -S --noconfirm --sudoloop awmtt thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman

yay -S --noconfirm --sudoloop maim firefox luarocks nitrogen

## Erase Current Configuration

 if [[ -d "$HOME/.config/awesome" ]]; then
 	mv $HOME/.config/awesome $HOME/.config/aweesome.old
 fi

## Install My Configuration
git clone https://github.com/Thomashighbaugh/awesomewm $HOME/.config/awesome
