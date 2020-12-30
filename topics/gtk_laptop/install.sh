#!/bin/bash

################################################################################
## GTK Installer #############################################################
################################################################################
yay -S --noconfirm --sudoloop --needed numix-gtk-theme arc-gtk-theme gtk-engine-murrine gtk-engines

yay -S --noconfirm --sudoloop --needed vertex-themes gtk-engines gtk-theme-arc-git pocillo-gtk-theme-git pop-gtk-theme xfce-settings

mkdir -p $HOME/.config/gtk-2.0
xfsettingsd
ln -svf $HOME/dotfiles/topics/gtk/gtk-2.0/gtkfilechooser.ini $HOME/.config/gtk-2.0/gtkfilechooser.ini

mkdir -p $HOME/.config/gtk-3.0

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/bookmarks $HOME/.config/gtk-3.0/bookmarks

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini

ln -svf $HOME/dotfiles/topics/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0

mkdir -p $HOME/.config/Kvantum

ln -svf $HOME/dotfiles/topics/gtk/kvantum.kvconfig $HOME/.config/Kvantum/kvantum.kvconfig
