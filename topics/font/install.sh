#!/bin/env bash

################################################################################
## Fonts Install Script
## For Use on Arch Linux based systems
## Thomas Leon Highbaugh
################################################################################


yay -S --noconfirm --batchinstall --needed  dina-font ttf-hack mono-tools mono-addins otf-fantasque-sans-mono otf-fira-mono \ 
  otf-hermit tamsyn-font terminus-font-otb terminus-font ttf-cascadia-code ttf-fira-mono ttf-fira-code ttf-inconsolata \ 
  ttf-ibm-plex  ttf-proggy-clean ttf-monaco terminus-font-ttf ttf-everson-mono ttf-monoid ttf-go-mono-git ttf-mononoki  \ 
  ttf-spacemono uw-ttyp0-font otf-sfmono ttf-luculent   otf-inconsolata-lgc montecarlo-font ttf-camingocode ttf-league-mono \ 
   otf-lotion-git monofonto ttf-cutive-mono triskweline-code-font ttf-agave ttf-sometype-mono ttf-hactor ttf-fifteen \ 
   ttf-anka-coder-condensed sudo-font-git ttf-mac-fonts ttf-ms-fonts ttf-google-fonts-git 

## Create Directory ############################################################
mkdir -p ${HOME}/.local/share/fonts

## Download Package ############################################################
wget $HOME/.local/share/fonts.tar.7z https://www.dropbox.com/s/e1lbpaognaoiycs/fonts.tar.7z 

7z x -so $HOME/.local/share/fonts/fonts.tar.7z | sudo tar xf - -C $HOME/.local/share/fonts

sudo cp -rnv $HOME/.local/share/fonts /usr/share/fonts && rm -rvf 

sudo fc-cache -vf 

fc-cache -vf
