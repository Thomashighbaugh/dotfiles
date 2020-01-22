#!/bin/bash 

sudo pacman -S  --noconfirm firefox-developer-edition falkon min browserpass chromium poppler-data links lynx w3m brave 

sudo pacman -S  --noconfirm netsurf palemoon-bin

yay -S --noconfirm --needed basilisk-bin firefox-adblock-plus firefox-tree-style-tab 

yay -S --noconfirm --needed firefox-extension-trackmenot  firefox-extension-https-everywhere firefox-extension-tab-session-manager 

yay -S --noconfirm --needed firefox-extension-temporary-containers firefox-extension-privacybadger firefox-ublock-origin

echo 'Finished Installing Browser Packages'
