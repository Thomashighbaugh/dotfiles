#!/bin/bash 

################################################################################
## GTK Installer #############################################################
################################################################################
yay -S --noconfirm numix-gtk-theme  arc-gtk-theme  gtk-engine-murrine gtk-engines 

yay -S --noconfirm evopop-gtk-theme

yay -S --noconfirm vertex-themes

yay -S --noconfirm gtk-engines breeze-gtk adapta-gtk-theme materia-gtk-theme 
#  Arc theme
yay -S --noconfirm gtk-theme-arc-git 

yay -S --noconfirm paper-gtk-theme-git pocillo-gtk-theme-git 

yay -S --noconfirm pop-gtk-theme canta-gtk-theme-git themix-full-git 

mkdir -p $HOME/.config/gtk-2.0

ln -svf $HOME/dotfiles/topics/gtk/gtk-2.0/gtkfilechooser.ini $HOME/.config/gtk-2.0/gtkfilechooser.ini

mkdir -p $HOME/.config/gtk-3.0

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/bookmarks $HOME/.config/gtk-3.0/bookmarks

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css

ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini

ln -svf $HOME/dotfiles/topics/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0

mkdir -p $HOME/.config/Kvantum

ln -svf $HOME/dotfiles/topics/gtk/kvantum.kvconfig $HOME/.config/Kvantum/kvantum.kvconfig


