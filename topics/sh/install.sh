#!/bin/env sh
################################################################################
## install sh   ################################################################
################################################################################

sudo pacman -S --noconfirm keychain

git clone https://github.com/Thomashighbaugh/bin $HOME/.local/share/bin

yay -S --noconfirm --batchinstall --needed --sudoloop autojump

ln -svf $HOME/dotfiles/topics/sh/profile $HOME/.profile
ln -svf $HOME/dotfiles/topics/sh/z.sh $HOME/.z.sh
ln -svf $HOME/dotfiles/topics/sh/aliases $HOME/.aliases
