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

## copy dotfiles to the root user for purposes of continuity
sudo cp -rnv $HOME/dotfiles /root/

## Symlink root user's .zsh files 
sudo ln -svf $HOME/dotfiles/topics/zsh/zprofile /root/.zprofile 
sudo ln -svf $HOME/dotfiles/topics/zsh/zshenv /root/.zshenv
sudo ln -svf $HOME/dotfiles/topics/zsh/zshrc /root/.zshrc
sudo ln -svf $HOME/dotfiles/topics/zsh/zlogout /root/.zlogout


install any install files

## End
