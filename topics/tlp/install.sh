#!/bin/bash 

################################################################################
## TLP Installer ###############################################################
################################################################################
yay -S --noconfirm --sudoloop --needed tlp powertop acpid tlp-rdw acpi acpid acpica acpitool 

sudo systemctl enable --now tlp 

