#!/bin/bash 

sudo pacman -S  --noconfirm  xorg-server-xnest xorg-sessreg xorg-xclipboard xorg-xdpyinfo xorg-xfd arandr

sudo pacman -S --noconfirm xorg-xinit xorg-xev xdotool screen stunnel xorg-xprop autorandr xdg-utils xdotool 

sudo pacman -S --noconfirm xorg-server diskus screen mosh

echo 'Finished Installing X Server Packages'
