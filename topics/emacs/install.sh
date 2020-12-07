#!/bin/env bash

##############################################################################
## Emacs #####################################################################
##############################################################################

sudo pacman -S --noconfirm emacs

ln -svf $HOME/dotfiles/emacs/doom.d $HOME/.doom.d
## Remove Emacs Directory if it exists
if [[ -d "$HOME/.emacs.d" ]]; then
	rm -rvf $HOME/.emacs.d
fi

## Install Doom Emacs
git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.emacs.d
kitty -e '~/.emacs.d/bin/doom install'
