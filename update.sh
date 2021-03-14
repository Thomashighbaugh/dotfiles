#!/bin/env bash
# @author Thomas Leon Highbaugh
# @description A convenience script to make sure everything has been backed up to git, just in case of emergencies. After all it is Linux...
# @date 2/18/2021

## Awesome Window Manager
cd "$HOME"/.config/awesome && echo "Awesome" && sh ~/.local/share/bin/gita
## QTile
cd "$HOME"/.config/qtile && echo "QTile" && sh ~/.local/share/bin/gita

## Binaries Directory
cd "$HOME"/.local/share/bin && echo "Binaries" && sh ~/.local/share/bin/gita

## Vimwiki
cd "$HOME"/.vimwiki-tech && echo "Vimwiki" && sh ~/.local/share/bin/gita

## Vim Configuration
cd "$HOME"/.vim && echo "Vim Configuration" && sh ~/.local/share/bin/gita

## Dotfiles
cd "$HOME"/dotfiles && echo "Dotfiles" && sh ~/.local/share/bin/gita
