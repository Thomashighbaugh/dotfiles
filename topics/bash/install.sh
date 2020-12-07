#!/bin/env bash

##############################################################################
## Bash Install  #############################################################
##############################################################################

## Install Packages
sudo pacman -S bash shellharden bashlint

## Link Files
ln -svf $HOME/dotfiles/topics/bash/bashenv $HOME/.bashenv
ln -svf $HOME/dotfiles/topics/bash/bashrc $HOME/.bashrc
