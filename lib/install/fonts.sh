#!/bin/bash

yay -S --batchinstall --sudoloop ---noconfirm --needed nerd-fonts-complete  ttfsampler aspell gspell aspell-en hunsell hunspell-en_US vim-spell-en
yay -S ---batchinstall --sudoloop --noconfirm --needed gedit gedit-plugins libgit2-glib gucharmap  gtkspell3 

echo 'Finished Installing Fonts Packages'
