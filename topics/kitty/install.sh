#!/bin/bash

################################################################################
## Kitty Installer #############################################################
################################################################################

sudo pacman -S --noconfirm kitty kitty-terminfo catimg

if [[ -r "$HOME/.config/kitty" ]]; then
	rm -rvf $HOME/.config/kitty
fi

mkdir -p $HOME/.config/kitty

sudo ln -sf $HOME/dotfiles/topics/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

sudo ln -sf $HOME/dotfiles/topics/kitty/theme.conf $HOME/.config/kitty/theme.conf

sudo ln -sf $HOME/dotfiles/topics/kitty/motd /etc/motd
