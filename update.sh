#!/bin/env bash
# @author Thomas Leon Highbaugh
# @description A convenience script to make sure everything has been backed up to git, just in case of emergencies. After all it is Linux...
# @date 2/18/2021

## Awesome Window Manager
cd "$HOME"/.config/awesome && sh ~/.local/share/bin/gita
## QTile
cd "$HOME"/.config/qtile && sh ~/.local/share/bin/gita

## Binaries Directory
cd "$HOME"/.local/share/bin && sh ~/.local/share/bin/gita

## Vimwiki
cd "$HOME"/.vimwiki-tech && sh ~/.local/share/bin/gita

## Vim Configuration
cd "$HOME"/.vim && sh ~/.local/share/bin/gita

## Dotfiles
cd "$HOME"/dotfiles && sh ~/.local/share/bin/gita
