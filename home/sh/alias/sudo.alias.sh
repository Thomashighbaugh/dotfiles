#!/bin/env bash

alias fstrim="sudo fstrim -a --verbose "
alias systemctl="sudo systemctl "
alias brightnessctl="sudo brightnessctl "
# Power Control
###########################################################################
alias shutdown="sudo poweroff "
alias reboot="sudo reboot -i "


alias sudo='\sudo '

if [ "$PS1" ]; then
    complete -cf sudo
fi
