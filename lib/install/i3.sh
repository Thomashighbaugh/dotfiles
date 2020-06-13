#!/bin/bash
echo "Installing i3wm Packages"

yay -S  --needed --sudoloop --batchinstall --noconfirm i3-gaps-next-git python-pillow-simd 
yay -S --needed --sudoloop --batchinstall compton-tryone-blackcapcoder-git 

sudo pacman -S  --noconfirm i3blocks perl-anyevent-i3 powerline sway i3status feh autotiling xss-lock

yay -S  --needed --sudoloop --batchinstall --noconfirm i3ipc-python-git  mako i3-layout-manager-git quickswitch-i3  autotiling-git notify-when-done-i3-git  i3-resurrect-git 
yay -S --needed --sudoloop --batchinstall --noconfirm  i3tree-git i3-projects  rofi polybar i3keys i3-vim-syntax-git i3-ws-nick-git helpers-for-i3-git autoi3 i3expo kitti3 plank-git-patched
echo "i3wm Package Installation Complete"
