#!/bin/bash 

sudo pacman -S --noconfirm diffutils git ruby highlight diffutils git go highlight texinfo pandoc  ansible ansible-lint zeal devhelp 

yay -S --noconfirm jetbrains-toolbox python-virtualenv python-virtualenvwrapper

yay -S --noconfirm --needed rbenv-git rubygems

yay -S --noconfirm --needed ruby-build-git ruby-gollum 

rbenv install 2.6.5

gem install neovim bundler jekyll sass gollum bourbon neat

yay -S --needed --noconfirm rustup

rustup default stable

rustup component add rls rust-analysis rust-src

echo 'Finished Installing Development Environment Packages'
