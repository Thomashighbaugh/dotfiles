#!/bin/env bash

yay -S --noconfirm --needed --sudoloop picom-ibhagwan-git 

ln -svf $HOME/dotfiles/topics/picom/picom.conf $HOME/.config

