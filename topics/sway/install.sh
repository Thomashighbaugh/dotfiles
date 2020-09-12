#!/bin/env bash

## Install Packages #################################################################

yay -S --noconfirm --sudoloop --needed sway-git waybar-git wofi wf-recorder swaytools  xf86-video-nouveau-git  wlroots-git  wlstreamer-git swaykbdd srandr nwg-launchers swaylock-effects mako termite grim

## Configure ########################################################################

ln -svf $HOME/dotfiles/topics/sway/config $HOME/.config/sway/config
ln -svf $HOME/dotfiles/topics/sway/lockman.sh $HOME/.config/sway/lockman.sh
ln -svf $HOME/dotfiles/topics/sway/config/window.sh $HOME/.config/sway/window.sh
ln -svf $HOME/dotfiles/topics/sway/termite.config $HOME/.config/termite/config
ln -svf $HOME/dotfiles/topics/sway/wofi.config $HOME/.config/wofi/config
ln -svf $HOME/dotfiles/topics/sway/style.css $HOME/.config/wofi/style.css
ln -svf $HOME/dotfiles/topics/windows.py $HOME/.config/wofi/windows.py
ln -svf $HOME/dotfiles/topics/sway/alternative_style.css $HOME/.config/waybar/alternative_style.css
ln -svf $HOME/dotfiles/topics/sway/waybar.config $HOME/.config/waybar/config 
ln -svf $HOME/dotfiles/topics/sway/lock.sh $HOME/.config/waybar/lock.sh
ln -svf $HOME/dotfiles/topics/sway/style.css.waybar $HOME/.config/waybar/style.css
ln -svf $HOME/dotfiles/topics/sway/taskbar $HOME/.config/waybar/taskbar
ln -svf $HOME/dotfiles/topics/sway/waybar-media.py $HOME/.config/waybar-media.py 
ln -svf $HOME/dotfiles/topics/sway/waybar-mpris $HOME/.config/waybar/waybar-mpris
ln -svf $HOME/dotfiles/topics/sway/weather.py $HOME/.config/waybar/weather.py
ln -svf $HOME/dotfiles/topics/sway/nwg-launchers $HOME/.config/nwg-launchers
ln -svf $HOME/dotfiles/topics/sway/mako.config $HOME/.config/mako/config

