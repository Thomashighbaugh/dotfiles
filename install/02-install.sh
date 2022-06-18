#!/bin/bash

source $HOME/dotfiles/install/01-lib.sh

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

sudo pacman -S --noconfirm --needed git base-devel fakeroot
if ! command -v paru &>/dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin-cloned
    cd /tmp/paru-bin-cloned/ &&
        makepkg -sfci --noconfirm --needed
fi
# --------------------------------------------------- #
print s "[===================================================]"
print s Determining Current Host
print s "[===================================================]"

HOSTNAME=/etc/hostname

if grep -q raspberrypi4 $HOSTNAME; then
    bash ./install/02a-raspberrypi-install.sh
    return
fi

if grep -q thinkpad $HOSTNAME; then
    bash ./install/02b-thinkpad-install.sh
    return
fi
