#!/bin/env bash
# @author Thomas Leon Highbaugh
# @description A convenience script to make sure everything has been backed up to git, just in case of emergencies. After all it is Linux...
# @date 2/18/2021

## Awesome Window Manager
cd "$HOME"/.config/awesome && git add . && read -rp "Enter The AwesomeWM Commit Message : " input && git commit -m "$input" && git push --force

## QTile
cd "$HOME"/.config/qtile && git add . && read -rp "Enter The AwesomeWM Commit Message : " input && git commit -m "$input" && git push --force

## Binaries Directory
cd "$HOME"/.local/share/bin && git add . && read -rp "Enter The Binaries Directory Commit Message : " input && git commit -m "$input" && git push --force

## Vimwiki
cd "$HOME"/.vimwiki-tech && git add . && read -rp "Enter The vimwiki Commit Message : " input && git commit -m "$input" && git push --force

## Dotfiles
cd "$HOME"/dotfiles && git add . && read -rp "Enter The Dotfiles Commit Message : " input && git commit -m "$input" && git push --force
