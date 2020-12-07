#!/bin/env bash

################################################################################
## Zathura #####################################################################
################################################################################

yay -S --noconfirm --sudoloop --needed zathura zathura-pdf-mupdf zathura-ps

ln -svf $HOME/dotfiles/topics/zathura/zathurarc $HOME/.config/zathura
