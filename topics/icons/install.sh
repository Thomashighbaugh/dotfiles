#!/bin/env bash 

wget $HOME/.local/share/icons/DamaDamas https://www.dropbox.com/s/7vqyfpuscqq51if/DamaDamas-icon-theme.tar.7z?dl=0

# Paper
yay -S --noconfirm paper-icon-theme-git

# mato
yay -S --noconfirm mato-icons-git

# aether
yay -S --noconfirm aether-icons-git


# superflat remix icons
yay -S --noconfirm oranchelo-icon-theme 
git clone https://github.com/daniruiz/Super-Flat-Remix.git /tmp/Super-Flat-Remix
mkdir ~/.icons/Super-Flat-Remix
cp -r /tmp/Super-Flat-Remix/Super\ Flat\ Remix/* ~/.icons/Super-Flat-Remix

# Flatwoken
yay -S --noconfirm awoken-icon-theme 
yay -S --noconfirm flatwoken-icons-git


# Moka and Faba
yay -S --noconfirm moka-icon-theme-git 
yay -S --noconfirm faba-icon-theme-git 

# Papirus
yay -S --noconfirm papirus-icon-theme-gtk

