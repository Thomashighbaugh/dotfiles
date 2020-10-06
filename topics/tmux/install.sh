#!/bin/bash 

yay -S --batchinstall --noconfirm --sudoloop tmux tmuxp tmuxinator 

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

ln -svf $HOME/dotfiles/topics/tmux/tmux.conf $HOME/.tmux.conf
