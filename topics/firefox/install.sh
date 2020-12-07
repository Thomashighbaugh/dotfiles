#!/bin/env bash

##############################################################################
## Firefox ###################################################################
##############################################################################

sudo pacman -S --noconfirm firefox

git clone https://github.com/Thomashighbaugh/firefox $HOME/.local/share/firefox/chrome

cp -rvf $HOME/.local/share/firefox/chrome $HOME/.mozilla/firefox/*.default

cp -rvf $HOME/.local/share/firefox/chrome $HOME/.mozilla/firefox/*.default-release
