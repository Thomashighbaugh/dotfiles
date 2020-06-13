#!/bin/bash

echo 'Installing Beta Drivers from Nvidia'

yay -S --noconfirm --batchinstall --sudoloop nvidia nvidia-dkms

echo 'Installing Driver Utilities, Settings and Extras'


yay -S --noconfirm --batchinstall --sudoloop libvdpau cuda libxnvctrl nvidia-docker nvidia-xrun nvidia-container-runtime nvidia-container-toolkit cudnn 

echo 'Nvidia Installation is Complete'

