#!/bin/env sh

yay -S lightdm-gtk-greeter-settings lightdm lightdm-gtk-greeter
sudo ln -svf $HOE/dotfiles/topics/lightdm/lightdm.conf /etc/lightdm 
sudo ln -svf $HOE/dotfiles/topics/lightdm/lightdm-gtk-greeter.conf /etc/lightdm 
