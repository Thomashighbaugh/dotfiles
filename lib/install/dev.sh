#!/bin/bash 

sudo pacman -S --noconfirm diffutils git ruby highlight diffutils git go highlight texinfo pandoc  ansible ansible-lint zeal devhelp 

yay -S --sudoloop --batchinstall --noconfirm jetbrains-toolbox python-virtualenv python-virtualenvwrapper

yay -S --sudoloop --batchinstall --noconfirm --needed rbenv-git rubygems

yay -S --sudoloop --batchinstall --noconfirm --needed ruby-build-git ruby-gollum 

rbenv install 2.8.0-dev

gem install neovim bundler jekyll sass gollum bourbon neat

yay -S --sudoloop --batchinstall --needed --noconfirm rustup

rustup default stable

rustup component add rls rust-analysis rust-src

echo 'Finished Installing Development Environment Packages'

echo 

echo 'Installing Pacmanity Package Tracking' 

cd /tmp 
 wget https://github.com/derektbrown/pacmanity/tarball/master -O - | tar xz
 cd DerekTBrown-pacmanity-*/
 makepkg -si
