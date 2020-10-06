#!/bin/env bash

################################################################################
## zsh installer ###############################################################
################################################################################


## Install Necessary Packages 
yay -S --noconfirm --sudoloop --needed zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw
yay -S --noconfirm --sudoloop --needed zsh-syntax-highlighting zsh-lovers   zsh-autosuggestions 
yay -S --noconfirm --sudoloop --needed alias-tips-git  zsh-system-clipboard-git  

## Symlink Files
ln -svf $HOME/dotfiles/topics/zsh/zprofile $HOME/.zprofile 
ln -svf $HOME/dotfiles/topics/zsh/zshenv $HOME/.zshenv
ln -svf $HOME/dotfiles/topics/zsh/zshrc $HOME/.zshrc
ln -svf $HOME/dotfiles/topics/zsh/zlogout $HOME/.zlogout
ln -svf $HOME/dotfiles/topics/zsh/functions$HOME/.zsh.d/functions


## End
