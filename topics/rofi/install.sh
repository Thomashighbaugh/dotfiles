#!/bin/env bash 

################################################################################
## bash installer ##############################################################
################################################################################

yay -S  --noconfirm  --sudoloop  --needed  rofi-git

mkdir -p  $HOME/.config/rofi 
ln -svf   $HOME/dotfiles/topics/rofi/config       $HOME/.config/rofi/config
ln -svf   $HOME/dotfiles/topics/rofi/themes       $HOME/.config/rofi/themes
ln -svf   $HOME/dotfiles/topics/rofi/config.rasi  $HOME/.config/rofi/config.rasi
ln -svf   $HOME/dotfiles/topics/rofi/three.rasi   $HOME/.config/rofi/three.rasi
