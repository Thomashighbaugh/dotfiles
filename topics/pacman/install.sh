#!/bin/env bash

sudo rm -rvf /etc/pacman.conf

sudo cp -rvf $HOME/dotfiles/topics/pacman/pacman.conf /etc/pacman.conf

yay -S --needed --sudoloop --noconfirm systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms pacman-kernel-install-git 
yay -S --needed --sudoloop --noconfirm smkinitcpio-modconf-hook-git  mkinitcpio-archiso-git  systemd-removed-services-hook 
