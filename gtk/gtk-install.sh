#!/bin/bash 
#======================================================================================
#                               themes-icons-pack
# 
# Author  : Erik Dubois at http://www.erikdubois.be
# License : Distributed under the terms of GNU GPL version 2 or later
# 
# AS ALLWAYS, KNOW WHAT YOU ARE DOING.
#======================================================================================


# install yay -S --noconfirm first
# yaourt yay -S --noconfirm

########################################
########        I C O N S      #########
########################################

#  Sardi

yay -S --noconfirm sardi-icons
# Andromeda
yay -S --noconfirm andromeda-icon-theme

# Deepin
yay -S --noconfirm deepin-icon-theme deepin-iconthemes-manjaro

# Elementary
yay -S --noconfirm elementary-xfce-icons elementary-icon-theme 

# Menda

yay -S --noconfirm menda-circle-icon-theme
# Nitrux
yay -S --noconfirm nitrux-icon-theme
# Paper
yay -S --noconfirm paper-icon-theme-git

# Pacifica

yay -S --noconfirm pacifica-icon-theme


#echo
yay -S --noconfirm echo-icon-theme-git

#Newaita
yay -S --noconfirm newaita-icons-git
# mato
yay -S --noconfirm mato-icons-git

# Korla
yay -S --noconfirm korla-icon-theme

# aether
yay -S --noconfirm aether-icons-git

# boston
yay -S --noconfirm boston-icon-theme
# halo
yay -S --noconfirm halo-icons-git

# vertrux
yay -S --noconfirm vertrux-icon-theme

# matcha
yay -S --noconfirm matcha-icon-theme
# tebu
yay -S --noconfirm tebu-icon-theme

#neru
yay -S --noconfirm mate-neru-canta-theme
yay -S --noconfirm neru-icon-classic-theme
yay -S --noconfirm neru-icon-newyear-theme



#  Numix

yay -S --noconfirm numix-circle-arc-icons-git
yay -S --noconfirm numix-reborn-icon-themes
yay -S --noconfirm numix-manjaro-themes
yay -S --noconfirm numix-icon-theme-git
yay -S --noconfirm numix-frost-themes
yay -S --noconfirm xcursor-numix
yay -S --noconfirm gtk-theme-numix-solarized
yay -S --noconfirm numix-gtk-theme 
yay -S --noconfirm numix-circle-icon-theme-git 

#  Evopop
yay -S --noconfirm evopop-icon-theme
yay -S --noconfirm evopop-gtk-theme

#  Flattr or lüv
yay -S --noconfirm luv-icon-theme-git
yay -S --noconfirm faenzaflattr-icon-theme 
git clone https://github.com/NitruxSA/flattr-icons.git /tmp/flattr-icons
mkdir ~/.icons/Flattr
mkdir ~/.icons/Flattr\ Dark
cp -r /tmp/flattr-icons/Flattr/* ~/.icons/Flattr
cp -r /tmp/flattr-icons/Flattr\ Dark/* ~/.icons/Flattr\ Dark

# superflat remix icons
yay -S --noconfirm oranchelo-icon-theme 
git clone https://github.com/daniruiz/Super-Flat-Remix.git /tmp/Super-Flat-Remix
mkdir ~/.icons/Super-Flat-Remix
cp -r /tmp/Super-Flat-Remix/Super\ Flat\ Remix/* ~/.icons/Super-Flat-Remix

# Ultra flat icons
yay -S --noconfirm ultra-flat-icons-green ultra-flat-icons-orange ultra-flat-icons-blue 

# Flatwoken
yay -S --noconfirm awoken-icon-theme 
yay -S --noconfirm flatwoken-icons-git


# Moka and Faba
yay -S --noconfirm moka-icon-theme-git 
yay -S --noconfirm faba-icon-theme-git 


# Compass
yay -S --noconfirm compass-icon-theme 

# Vertex
yay -S --noconfirm vertex-icons-git 

# Papirus
yay -S --noconfirm papirus-icon-theme-gtk
yay -S --noconfirm papirus-maia-icon-theme
yay -S --noconfirm pop-icon-theme-bin

# 1 Vertex
#git clone https://github.com/horst3180/vertex-theme /tmp/vertex-theme
#mkdir ~/.themes/vertex-theme
#cp -r /tmp/vertex-theme/common/* ~/.themes/vertex-theme

yay -S --noconfirm vertex-themes

#  Flatabulous
yay -S --noconfirm flatabulous
yay -S --noconfirm gtk-arc-flatabulous-theme
yay -S --noconfirm vertex-maia-gtk3 vertex-maia-theme 

#  Arc theme
yay -S --noconfirm gtk-theme-arc-git 

echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"
