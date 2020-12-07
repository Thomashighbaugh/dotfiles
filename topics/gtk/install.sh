#!/bin/bash

################################################################################
## GTK Installer #############################################################
################################################################################
yay -S --noconfirm gtk-engine-murrine gtk-engines xfce4-settings colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkd gtkglarea libfm-gtk3

sudo git clone https://github.com/Thomashighbaugh/Dhumavati-Theme $HOME/.local/share/dhumavati

cd $HOME/.local/share/dhumavati && sh install.sh && cd .. && rm $HOME/.local/share/dhumavati

mkdir -p $HOME/.config/gtk-2.0

ln -svf $HOME/dotfiles/topics/gtk/gtk-2.0/gtkfilechooser.ini $HOME/.config/gtk-2.0/gtkfilechooser.ini

mkdir -p $HOME/.config/gtk-3.0

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/bookmarks $HOME/.config/gtk-3.0/bookmarks

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini

ln -svf $HOME/dotfiles/topics/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0

mkdir -p $HOME/.config/Kvantum

ln -svf $HOME/dotfiles/topics/gtk/kvantum.kvconfig $HOME/.config/Kvantum/kvantum.kvconfig
