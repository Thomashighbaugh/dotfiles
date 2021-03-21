# Arch-based (and Kaos Linux) Package Management
##########################################################################

alias pacman='pacman --color=auto '
alias yay='yay --color=auto '

## Install Packages
alias yu="yay -S --needed "
alias pu="sudo pacman -S "

## Install Package(s) Without Confirm
alias yup="yay -Syyuu --noconfirm --needed --sudoloop "
alias pup="sudo pacman -Syu --noconfirm "

## Uninstall Package(s)
alias puprm="sudo pacman -Rns "
alias yuprm="yay -Rns "

## Purge Packages
alias pupRM="sudo pacman -Rcns "
alias yupRM="yay -Rcns "

## Uninstall Without Uninstalling Dependencies
alias yudel="yay -Rdd "
alias pudel="sudo pacman -Rdd "

## Search
alias yupss="yay -Ss "
alias pupss="sudo pacman -Ss "

## No Dependencies 
alias yupxdeps="yay -Sdd "
alias pupxdeps="sudo pacman -Sdd "

alias cower="yay"
