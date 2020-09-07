#!/bin/env bash

################################################################################
## xorg installer##############################################################
################################################################################

yay -S --noconfirm --sudoloop xorg xorg-apps xorg-drivers xorg-fonts 
yay -S --needed --noconfirm --sudoloop  pa-applet-git  gnome-keyring polkit-gnome libgnome-keyring xscreensaver

mkdir -p $HOME/.Xresources.d


ln -svf $HOME/dotfiles/topics/xorg/Xresources $HOME/.Xresources
ln -svf $HOME/dotfiles/topics/xorg/color $HOME/.Xresources.d/color
ln -svf $HOME/dotfiles/topics/xorg/font $HOME/.Xresources.d/font
ln -svf $HOME/dotfiles/topics/xorg/rxvt-unicode $HOME/.Xresources.d/rxvt-unicode
ln -svf $HOME/dotfiles/topics/xorg/uxterm $HOME/.Xresources.d/uxterm
ln -svf $HOME/dotfiles/topics/xorg/xterm $HOME/.Xresources.d/xterm
ln -svf $HOME/dotfiles/topics/xorg/xscreensaver $HOME/.xscreensaver
ln -fvs $HOME/dotfiles/topics/xorg/xinitrc $HOME/.xinitrc
ln -fvs $HOME/dotfiles/topics/xorg/xprofile $HOME/.xprofile
ln -fvs $HOME/dotfiles/topics/xorg/xsettingsd $HOME/.xsettingsd
ln -fvs $HOME/dotfiles/topics/xorg/xsessionrc $HOME/.xsessionrc

