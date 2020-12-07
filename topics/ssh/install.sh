#!/bin/env bash

sudo pacman -S --noconfirm openssh keychain seahorse

sudo cp -rvf $HOME/dotfiles/topics/ssh/ssh_config /etc/ssh/
sudo cp -rvf $HOME/dotfiles/topics/ssh/sshd_config /etc/ssh/
