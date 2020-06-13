#!/bin/bash

sudo pacman -S --noconfirm gnome-disk-utility gnome-keyring keychain less dosfstools ntfs-3g exfat-utils fatresize udftools zstd exfat-utils 

sudo pacman -S --noconfirm  octopi f2fs-tools sysfsutils gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb dosfstools btrfs-progs jfsutils udiskie 

sudo pacman -S --noconfirm udisks2 sshfs vivid cifs-utils trash-cli rclone git-crypt gnupg borg bleachbit flatpak 

yay -S --sudoloop --batchinstall --noconfirm --needed vorta ruby-colorls 

sudo pacman -S --noconfirm pcmanfm-gtk3

sudo pacman -S --needed --noconfirm thunar-gtk3 thunar thunar-volman thunar-volman-gtk3 thunar-archive-plugin thunar-archive-plugin-gtk3 thunar-shares-plugin-gtk3 

echo 'Finished Installing Disk Packages'
