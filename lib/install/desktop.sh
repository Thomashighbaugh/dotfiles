#!/bin/bash
echo ' Installing Nvidia Drivers and Packages'
yay -S --noconfirm --sudoloop cuda nvidia-docker nvidia-full-beta-all

echo 'Installing Zen Kernel'
yay -S --noconfirm --sudoloop linux-zen linux-zen-docs
