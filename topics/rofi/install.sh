#!/bin/env bash 

################################################################################
## bash installer ##############################################################
################################################################################

yay -S  --noconfirm  --sudoloop  --needed  rofi-git rofi-todo

mkdir -p  $HOME/.config/rofi 
ln -svf   $HOME/dotfiles/topics/rofi/config       $HOME/.config/rofi
ln -svf   $HOME/dotfiles/topics/rofi/themes       $HOME/.config/rofi
sudo ln -svf   $HOME/dotfiles/topics/rofi/themes  /usr/share/rofi
ln -svf   $HOME/dotfiles/topics/rofi/config.rasi  $HOME/.config/rofi/config.rasi
ln -svf   $HOME/dotfiles/topics/rofi/three.rasi   $HOME/.config/rofi/three.rasi
