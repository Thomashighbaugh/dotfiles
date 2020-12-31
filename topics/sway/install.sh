#!/bin/env bash

yay -S --noconfirm --sudoloop --needed sway-borders-git swayidle grimshot wofi swaybg waybar wf-recorder autotiling nwg-launcher i3title swayimg swaylock wofer mako

ln -svf $HOME/dotfiles/topics/sway/config $HOME/.config/sway/config

ln -svf $HOME/dotfiles/topics/sway/lockman.sh $HOME/.config/sway/lockman.sh

ln -svf $HOME/dotfiles/topics/sway/window.sh $HOME/.config/sway/window.sh

ln -svf $HOME/dotfiles/topics/sway/nwg-launchers $HOME/.config/nwg-launchers
