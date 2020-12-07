#!/bin/env bash

# git clone https://github.com/creationix/nvm.git ~/.nvm

yay -S --noconfirm --sudoloop --batchinstall nvm
sudo nvm install node
sudo nvm use node
sudo nvm alias default node

sudo npm --global install yarn
sudo yarn global add babel-eslint
sudo yarn global add create-component-app
sudo yarn global add create-next-app
sudo yarn global add create-react-app
sudo yarn global add eslint
sudo yarn global add eslint-plugin-react
sudo yarn global add eslint-plugin-jsx-a11y
sudo yarn global add eslint-config-prettier
sudo yarn global add gatsby
sudo yarn global add gulp
sudo yarn global add neovim
sudo yarn global add heroku
sudo yarn global add now
sudo yarn global add prettier
sudo yarn global add prettier-eslint
sudo yarn global add react
sudo yarn global add react-dom
sudo yarn global add webpack

sudo yarn upgrade
