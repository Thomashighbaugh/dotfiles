#!/bin/bash 

################################################################################
## Grub Theme Installer ######################################################
################################################################################


git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme $HOME/.local/share/Bhairava-Grub-Theme 
sudo sh $HOME/.local/share/Bhairava-Grub-Theme/svg2png.sh
sudo sh $HOME/.local/share/Bhairava-Grub-Theme/set-grub.sh