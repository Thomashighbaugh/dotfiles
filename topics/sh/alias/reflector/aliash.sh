#!/bin/env sh



# Reflector
######################################################################################
alias mirrors="sudo reflector --verbose --country 'United States' -l 0 --sort rate --save /etc/pacman.d/mirrorlist"
