#!/bin/env bash

sudo pacman -S --noconfirm openssh keychain seahorse 

sudo ln -svf $PWD/ssh_config /etc/ssh/ssh_config 
sudo ln -svf $PWD/sshd_config /etc/ssh/sshd_config 
