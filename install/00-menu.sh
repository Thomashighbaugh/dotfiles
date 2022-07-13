#!/bin/bash

# --------------------------------------------------- #
# -------------------- Main Menu -------------------- #
# --------------------------------------------------- #
function mainmenu() {
    while true; do
        choice=$(
            dialog --backtitle "Dotfiles Installer - Thomas Leon Highbaugh" \
                --title "Main Menu" \
                -- \
                --nocancel \
                --menu "Choose one" 32 126 16 \
                "Install Packages" "- Bootstrap Arch-based Systems With My Preferred Software" \
                "External Configurations" "- Other Repositories I Use to House Configurations Delivered Where the System Expects Them" \
                "Dotfiles" "- Symlink Configuration Files From This Repository to the System's Expected Locations" \
                "Configurations In Place" "- Modifications of System Configurations As Needed After Everything is in Place" \
                "Reboot" "- When Finished, Restart Your System For Best Results." \
                "Quit" "- Exit to desktop" 3>&1 1>&2 2>&3
        )

        case "$choice" in
        "Install Packages")
            bash "$HOME"/dotfiles/install/02-install.sh
            ;;
        "External Configurations")
            bash "$HOME"/dotfiles/install/03-external-configurations.sh
            ;;
        "Dotfiles")
            bash "$HOME"/dotfiles/install/04-dotfiles.sh
            ;;
        "Configurations In Place")
            bash "$HOME"/dotfiles/install/05-configuration-in-place.sh
            ;;
        "Reboot")
            sudo reboot
            ;;
        "Quit")
            exit
            ;;
        *)
            echo "Something else.  Where Am I?"
            ;;
        esac
    done
}

# --------------------------------------------------- #
# -------------- Install Prerequisites -------------- #
# --------------------------------------------------- #
sudo pacman -Syu dialog

sudo timedatectl set-ntp true

sudo hwclock --systohc --localtime

sudo touch /tmp/install-log.txt

sudo chmod -Rv 777 /tmp/install-log.txt

# --------------------------------------------------- #
# --------------- Confirmation Dialog --------------- #
# --------------------------------------------------- #
dialog --title "Proceed?" \
    --backtitle "Post Installation Provisioning - the Electric Tantra Linux" \
    --yesno "Broke Your Install Again I See, Ready to Get Back to Work??" 7 60
response=$?
case $response in
0) mainmenu ;;
1) exit ;;
255) exit ;;
esac
