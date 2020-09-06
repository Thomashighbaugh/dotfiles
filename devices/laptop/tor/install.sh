#!/bin/env bash

# Install Black Arch Repo 
curl -O https://blackarch.org/strap.sh 
echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c 
chmod +x strap.sh 
sudo ./strap.sh 

# Install Tor Browser
yay -S --noconfirm --needed --sudoloop tor-browser-en 

