#!/usr/bin/env bash
# Arch-based (and Kaos Linux) Package Management
##########################################################################

## Install Packages
alias yu="paru  -S --needed "
alias pu="sudo pacman -S "

## Install Package(s) Without Confirm
alias yup="paru  --sync --sysupgrade --refresh --noconfirm --needed"
alias pup="sudo pacman --sync --sysupgrade --refresh --noconfirm --needed "

## Uninstall Package(s)
alias puprm="sudo pacman -Rns "
alias yuprm="paru  -Rns "

## Purge Packages
alias pupRM="sudo pacman -Rcns "
alias yupRM="paru  -Rcns "

## Uninstall Without Uninstalling Dependencies
alias yudel="paru  -Rdd "
alias pudel="sudo pacman -Rdd "

## Search
alias yups="paruz"
alias pups="sudo pacman -Ss "

## No Dependencies
alias yupxdeps="paru  -Sdd "
alias pupxdeps="sudo pacman -Sdd "

# Clean
alias yupclean="paru -Scc"
alias pupclean="sudo pacman -Scc"
