#!/bin/env bash 

wget $HOME/.local/share/icons/DamaDamas https://www.dropbox.com/s/7vqyfpuscqq51if/DamaDamas-icon-theme.tar.7z?dl=0

yay -S --noconfirm neru-icon-classic-theme

yay -S --noconfirm sardi-icons

# Paper
yay -S --noconfirm paper-icon-theme-git

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

# vertrux
yay -S --noconfirm vertrux-icon-theme

# tebu
yay -S --noconfirm tebu-icon-theme
#  Numix
yay -S --noconfirm numix-circle-arc-icons-git
yay -S --noconfirm numix-reborn-icon-themes
yay -S --noconfirm numix-icon-theme-git
yay -S --noconfirm numix-circle-icon-theme-git 


yay -S --noconfirm evopop-icon-theme
yay -S --noconfirm luv-icon-theme-git
yay -S --noconfirm faenzaflattr-icon-theme 

#  Flattr or lüv
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


#  Flatabulous
yay -S --noconfirm flatabulous
yay -S --noconfirm gtk-arc-flatabulous-theme
yay -S --noconfirm vertex-maia-gtk3 vertex-maia-theme canta-icon-theme-git 
