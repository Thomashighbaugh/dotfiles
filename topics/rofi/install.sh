#!/bin/env bash

################################################################################
## bash installer ##############################################################
################################################################################

yay -S --noconfirm --sudoloop --needed rofi-git rofi-todo 
sudo pip install python-rofi

mkdir -p $HOME/.config/rofi
ln -svf $HOME/dotfiles/topics/rofi/config $HOME/.config/rofi
ln -svf $HOME/dotfiles/topics/rofi/themes $HOME/.config/rofi
sudo ln -svf $HOME/dotfiles/topics/rofi/themes /usr/share/rofi
ln -svf $HOME/dotfiles/topics/rofi/config.rasi $HOME/.config/rofi/config.rasi
ln -svf $HOME/dotfiles/topics/rofi/three.rasi $HOME/.config/rofi/three.rasi
sudo cp -rvf $HOME/dotfiles/topics/rofi/rofi-todo /usr/bin
