#!/bin/env bash

################################################################################
## Fonts Install Script
## For Use on Arch Linux based systems
## Thomas Leon Highbaugh
################################################################################

yay -S --noconfirm --batchinstall --needed bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 fontconfig sdl2_ttf t1lib birdfont

## Create Directory ############################################################
mkdir -p ${HOME}/.local/share/fonts

## Download Package ############################################################
cd $HOME && wget https://www.dropbox.com/s/e1lbpaognaoiycs/fonts.tar.7z

7z x -so $HOME/fonts.tar.7z | sudo tar xf - -C $HOME/fonts

sudo cp -rnv $HOME/fonts /usr/share/fonts && rm -rvf $HOME/fonts $HOME/fonts.tar.7z

sudo fc-cache -vf

fc-cache -vf
