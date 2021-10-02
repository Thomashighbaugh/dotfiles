#!/bin/ash

echo "Alpine Linux Setup - Post Installation"
echo
echo "System Core Packages"
echo
echo
echo
echo "Please Remember to add kms to your mkinitfs file"

--yesno "Are You Ready to Begin?" 7 60


APKADD(){
    while(($# > 0)); do
        sudo apk add "$!"
        shift
    done
    return
}

RCSTART(){
    rc-service "$!" start
}

RCADD(){
    rc-update add "$!"
}



setup-xorg-base openbox terminator slim dbus-x11 xf86-video-intel
xf86-video-ati xf86-video-amdgpu xf86-input-mouse xf86-input-keyboard setxkbmap


WORLD=$HOME/dotfiles/alpine-setup/world

APKADD $WORLD


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

export PAGER=less



echo fbcon >> /etc/modules



RCADD dbus
RCSTART dbus

RCSTART fuse
RCADD fuse

# Fonts

APKADD terminus-font ttf-inconsolata ttf-dejavu font-bitstream-* ttf-font-awesome





