#!/bin/env bash

sudo pacman -S --noconfirm firefox 

yay -S --noconfirm --sudoloop tor-browser 

git clone https://github.com/Thomashighbaugh/firefox $HOME/.local/share/firefox/chrome 

