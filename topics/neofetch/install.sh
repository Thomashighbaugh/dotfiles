#!/bin/env bash

################################################################################
## Neofetch Installer ##########################################################
################################################################################

sudo pacman -S --noconfirm neofetch

ln -svf $HOME/dotfiles/topics/neofetch $HOME/.config/neofetch
