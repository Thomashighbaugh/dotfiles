#!/bin/env bash



# Reflector
######################################################################################
alias mirrors="sudo reflector --verbose --country 'United States'  --sort rate --save /etc/pacman.d/mirrorlist"
