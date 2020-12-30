#!/bin/env bash

##############################################################################
## git #######################################################################
##############################################################################

sudo pacman -S --noconfirm git

# Enter your git credentials once, forget it for the rest of the install
git config --global credential.helper store
