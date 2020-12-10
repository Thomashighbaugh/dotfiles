#!/bin/env bash -exu

###############################################################
###############################################################
## Pi: Burn to SD Card  #######################################
###############################################################
###############################################################

# This script burns the image created in the prepare-image.sh script
# onto a block device assigned below. 

#IMPORTANT: Change your block device according to your environment, 
# USING THIS SCRIPT WITHOUT MODIFICATION MAY LEAD TO LOST DATA.	


sudo dd if=$HOME/dotfiles/arch-linux-*.img of=/dev/mmcblk0 status=progress
sync