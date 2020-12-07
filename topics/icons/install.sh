#!/bin/env bash

# Paper
yay -S --noconfirm paper-icon-theme-git

# superflat remix icons
yay -S --noconfirm oranchelo-icon-theme
git clone https://github.com/daniruiz/Super-Flat-Remix.git /tmp/Super-Flat-Remix
mkdir ~/.icons/Super-Flat-Remix
cp -rvf /tmp/Super-Flat-Remix/Super\ Flat\ Remix/* ~/.icons/Super-Flat-Remix
sudo cp -rvf /tmp/Super-Flat-Remix/Super\ Flat\ Remix/* /usr/share/icons

#Flatwoken
yay -S --noconfirm awoken-icon-theme
yay -S --noconfirm flatwoken-icons-git

# Moka and Faba
yay -S --noconfirm moka-icon-theme-git
yay -S --noconfirm faba-icon-theme-git

# Papirus
yay -S --noconfirm papirus-icon-theme-gtk
