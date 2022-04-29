#!/bin/bash 
# Systemd Commands
###########################################################################

## Services Status  
alias sysup="sudo systemctl list-unit-files --state=enabled"
alias sysdown="sudo systemctl list-unit-files --state=disabled"
alias sysls="sudo systemctl list-units --type=service --state=running "

## Enable the service 
alias syson="sudo systemctl enable --now"

## Restart the Service
alias resys="sudo systemctl restart "

## Disable the Service
alias sysoff="sudo  systemctl disable "
