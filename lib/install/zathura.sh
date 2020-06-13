#!/bin/bash

echo 'Install Zathura and Support Libraries'
yay -S --sudoloop --batchinstall --noconfirm --needed zathura-pdf-mupdf-git 

yay -S --sudoloop --batchinstall --noconfirm --needed zathura-ps-git zathura-djvu-git 

echo 'Zathura Installation Complete'
