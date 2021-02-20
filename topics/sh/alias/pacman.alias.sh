# Arch-based (and Kaos Linux) Package Management
##########################################################################

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

## Search
alias yupss="yay -Ss "
alias pupss="sudo pacman -Ss "

## No Dependencies 
alias yupxdeps="yay -Sdd "
alias pupxdeps="sudo pacman -Sdd "
