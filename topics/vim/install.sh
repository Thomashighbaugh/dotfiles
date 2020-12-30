#!/bin/env bash

yay -S --noconfirm --sudoloop --needed vim vi sudo vim-runtime vim-spell-en

ln -svf $HOME/dotfiles/topics/vim/vimrc $HOME/.vimrc
ln -rvf $HOME/dotfiles/topics/vim/vim/plugged $HOME/.vim/plugged
ln -rvf $HOME/dotfiles/topics/vim/vim/autoload $HOME/.vim/autoload
