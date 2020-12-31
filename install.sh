# #!/usr/bin/env bash

echo -n "
  _____         __    ___ __ __                   
 |     \.-----.|  |_.'  _|__|  |.-----.-----.     
 |  --  |  _  ||   _|   _|  |  ||  -__|__ --|     
 |_____/|_____||____|__| |__|__||_____|_____|     
  __               __          __ __              
 |__|.-----.-----.|  |_.---.-.|  |  |.-----.----. 
 |  ||     |__ --||   _|  _  ||  |  ||  -__|   _| 
 |__||__|__|_____||____|___._||__|__||_____|__|   "
echo
echo
echo
echo "First let's make sure we get the basics out of the way."
echo "Press any key to install the dependencies and set up your system:"
read continue

deps() {
	clear
	echo "Set up local directories"
	mkdir -p $HOME/Pictures $HOME/.local/share $HOME/.config $HOME/.cache $HOME/.local/lib $HOME/Desktop $HOME/Documents $HOME/Downloads

	echo "Install the required packages for yay installation"
	sudo pacman -S --noconfirm git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

	echo "Install Yay"
	git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -s && cd .. && sudo rm -rf $HOME/yay

	echo "Install some other packages useful for the rest of the installation process."

	yay -S --needed --sudoloop --noconfirm atool autoconf autocutsel automake binutils bison

	yay -S --needed --sudoloop --noconfirm gcc gcc-libs gettext glibc dialog dmidecode

	yay -S --needed --sudoloop --noconfirm keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed powerpill bauerbill

}

####################################################################################
## Application Installation FUnctions ##############################################
####################################################################################
amd() {
	yay -S --noconfirm --needed --sudoloop amd-ucode ryzenadj-git zenstates-git ryzen-stabilizator-git linux-amd-znver2-docs linux-amd-znver2-headers linux-amd-znver2

	sudo grub-mkconfig -o /boot/grub/grub.conf

	sudo mkinitcpio -P
}
awesomewm() {
	yay -S --noconfirm --sudoloop awesome-git feh xcape

	yay -S --noconfirm --sudoloop vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus

	yay -S --noconfirm --sudoloop bemenu blueberry blueman bluez-hid2hci bluez-tools bluez-utils

	yay -S --noconfirm --sudoloop awmtt thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman

	yay -S --noconfirm --sudoloop maim firefox luarocks nitrogen

	## Erase Current Configuration

	if [[ -d "$HOME/.config/awesome" ]]; then
		mv $HOME/.config/awesome $HOME/.config/aweesome.old
	fi

	## Install My Configuration
	git clone https://github.com/Thomashighbaugh/awesomewm $HOME/.config/awesome
}

bash() {
	## Install Packages
	sudo pacman -S bash shellharden bashlint

	## Link Files
	ln -svf $HOME/dotfiles/topics/bash/bashenv $HOME/.bashenv
	ln -svf $HOME/dotfiles/topics/bash/bashrc $HOME/.bashrc
}

bitwarden() {
	yay -S --noconfirm --sudoloop bitwarden
}

bluetooth() {
	yay -S --noconfirm --sudoloop --needed blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez
}
bspwm() {
	yay --noconfirm --sudoloop --needed bspwm-rounded-corners-git bsp-layout sxhkd-git bar-aint-recursive xtitle-git sutils-git
	ln -svf $HOME/dotfiles/topics/bspwm $HOME/.config/bspwm

}
chromium() {
	sudo pacman -S --noconfirm chromium
}

cups() {
	yay -S --noconfirm --sudoloop --batchinstall cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
}
disks() {

	yay -S --noconfirm --sudoloop --needed dosfstools findutils gzip lzip p7zip tar
	yay -S --noconfirm --sudoloop --needed bzip2 lzop udftools cpio file file-roller filesystem
	yay -S --noconfirm --sudoloop --needed diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
	yay -S --noconfirm --sudoloop --needed gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop
	yay -S --noconfirm --sudoloop --needed gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
	yay -S --noconfirm --sudoloop --needed gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs
}
docker() {
	yay -S --noconfirm --sudoloop --needed docker docker-compose docker-machine python-docker containerd
	sudo usermod -aG docker ${USER}
	sudo systemctl enable --now docker.service
	sudo systemctl enable --now docker.socket

}

dunst() {
	ln -svf $HOME/dotfiles/topics/dunst/dunstrc $HOME/.config/dunst/dunstrc
}

####################################################################################
## Devices #########################################################################
####################################################################################

laptop() {
	amd
	awesomewm
	bash
	bitwarden
	bluetooth
	bspwm
	chromium
	cups
	disks
	docker
	dunst
	sh $HOME/dotfiles/topics/font/install.sh
	sh $HOME/dotfiles/topics/gparted/install.sh
	sh $HOME/dotfiles/topics/gimp/install.sh
	sh $HOME/dotfiles/topics/git/install.sh
	sh $HOME/dotfiles/topics/grub/install.sh
	sh $HOME/dotfiles/topics/gtk /install.sh
	sh $HOME/dotfiles/topics/hosts/install.sh
	sh $HOME/dotfiles/topics/htop/install.sh
	sh $HOME/dotfiles/topics/icons/install.sh
	sh $HOME/dotfiles/topics/inkscape/install.sh
	sh $HOME/dotfiles/topics/kitty/install.sh
	sh $HOME/dotfiles/topics/lua/install.sh
	sh $HOME/dotfiles/topics/neofetch/install.sh
	sh $HOME/dotfiles/topics/network-manager/install.sh
	sh $HOME/dotfiles/topics/nvm/install.sh
	sh $HOME/dotfiles/topics/openbox/install.sh
	sh $HOME/dotfiles/topics/picom/install.sh
	sh $HOME/dotfiles/topics/pulseaudio/install.sh
	sh $HOME/dotfiles/topics/python/install.sh
	sh $HOME/dotfiles/topics/qtile/install.sh
	sh $HOME/dotfiles/topics/ripgrep/install.sh
	sh $HOME/dotfiles/topics/rofi/install.sh
	sh $HOME/dotfiles/topics/ruby/install.sh
	sh $HOME/dotfiles/topics/rustup/install.sh
	sh $HOME/dotfiles/topics/sh/install.sh
	sh $HOME/dotfiles/topics/sqlite/install.sh
	sh $HOME/dotfiles/topics/ssh/install.sh
	sh $HOME/dotfiles/topics/sway/install.sh
	sh $HOME/dotfiles/topics/tor/install.sh
	sh $HOME/dotfiles/topics/vagrant/install.sh
	sh $HOME/dotfiles/topics/vim/install.sh
	sh $HOME/dotfiles/topics/xorg/install.sh
	sh $HOME/dotfiles/topics/yarn/install.sh
	sh $HOME/dotfiles/topics/youtube-dl/install.sh
	sh $HOME/dotfiles/topics/zathura/install.sh
	sh $HOME/dotfiles/topics/zsh/install.sh
	sh $HOME/dotfiles/topics/pacman/install.sh
	sh $HOME/dotfiles/topics/amd/install.sh
	sh $HOME/dotfiles/topics/thinkpad/install.sh
}

workstation() {
	amd
	awesomewm
	bash
	bitwarden
	bluetooth
	bspwm
	chromium
	cups

	disks
	docker
	dunst
	sh $HOME/dotfiles/topics/font/install.sh
	sh $HOME/dotfiles/topics/gparted/install.sh
	sh $HOME/dotfiles/topics/gimp/install.sh
	sh $HOME/dotfiles/topics/git/install.sh
	sh $HOME/dotfiles/topics/gtk/install.sh
	sh $HOME/dotfiles/topics/grub/install.sh
	sh $HOME/dotfiles/topics/hosts/install.sh
	sh $HOME/dotfiles/topics/htop/install.sh
	sh $HOME/dotfiles/topics/inkscape/install.sh
	sh $HOME/dotfiles/topics/kitty/install.sh
	sh $HOME/dotfiles/topics/lua/install.sh
	sh $HOME/dotfiles/topics/lxd/install.sh
	sh $HOME/dotfiles/topics/neofetch/install.sh
	sh $HOME/dotfiles/topics/network-manager/install.sh
	sh $HOME/dotfiles/topics/nvidia/install.sh
	sh $HOME/dotfiles/topics/openbox/install.sh
	sh $HOME/dotfiles/topics/p10k/install.sh
	sh $HOME/dotfiles/topics/picom/install.sh
	sh $HOME/dotfiles/topics/pulseaudio/install.sh
	sh $HOME/dotfiles/topics/python/install.sh
	sh $HOME/dotfiles/topics/qtile/install.sh
	sh $HOME/dotfiles/topics/ripgrep/install.sh
	sh $HOME/dotfiles/topics/rofi/install.sh
	sh $HOME/dotfiles/topics/ruby/install.sh
	sh $HOME/dotfiles/topics/rustup/install.sh
	sh $HOME/dotfiles/topics/sh/install.sh
	sh $HOME/dotfiles/topics/ssh/install.sh
	sh $HOME/dotfiles/topics/tor/install.sh
	sh $HOME/dotfiles/topics/vagrant/install.sh
	sh $HOME/dotfiles/topics/vim/install.sh
	sh $HOME/dotfiles/topics/virtualbox/install.sh
	sh $HOME/dotfiles/topics/xorg/install.sh
	sh $HOME/dotfiles/topics/yarn/install.sh
	sh $HOME/dotfiles/topics/youtube-dl/install.sh
	sh $HOME/dotfiles/topics/zathura/install.sh
	sh $HOME/dotfiles/topics/zsh/install.sh
	# Requires ZSH (thus after)
	sh $HOME/dotfiles/topics/nvm/install.sh
	# Requires Node
	sh $HOME/dotfiles/topics/gtk/install.sh
}

rpi4() {

	awesomewm
	bash
	bitwarden
	bluetooth
	disks
	docker
	dunst
	sh $HOME/dotfiles/topics/font/install.sh
	sh $HOME/dotfiles/topics/git/install.sh
	sh $HOME/dotfiles/topics/gtk/install.sh
	sh $HOME/dotfiles/topics/hosts/install.sh
	sh $HOME/dotfiles/topics/htop/install.sh
	sh $HOME/dotfiles/topics/kitty/install.sh
	sh $HOME/dotfiles/topics/lua/install.sh
	sh $HOME/dotfiles/topics/neofetch/install.sh
	sh $HOME/dotfiles/topics/network-manager/install.sh
	sh $HOME/dotfiles/topics/nvm/install.sh
	sh $HOME/dotfiles/topics/p10k/install.sh
	sh $HOME/dotfiles/topics/picom/install.sh
	sh $HOME/dotfiles/topics/pulseaudio/install.sh
	sh $HOME/dotfiles/topics/python/install.sh
	sh $HOME/dotfiles/topics/qtile/install.sh
	sh $HOME/dotfiles/topics/ripgrep/install.sh
	sh $HOME/dotfiles/topics/rofi/install.sh
	sh $HOME/dotfiles/topics/ruby/install.sh
	sh $HOME/dotfiles/topics/rustup/install.sh
	sh $HOME/dotfiles/topics/sh/install.sh
	sh $HOME/dotfiles/topics/ssh/install.sh
	sh $HOME/dotfiles/topics/sway/install.sh
	sh $HOME/dotfiles/topics/vagrant/install.sh
	sh $HOME/dotfiles/topics/vim/install.sh
	sh $HOME/dotfiles/topics/xorg/install.sh
	sh $HOME/dotfiles/topics/yarn/install.sh
	sh $HOME/dotfiles/topics/youtube-dl/install.sh
	sh $HOME/dotfiles/topics/zathura/install.sh
	sh $HOME/dotfiles/topics/zsh/install.sh

}

menu() {
	clear

	echo -n "
  _____         __    ___ __ __                   
 |     \.-----.|  |_.'  _|__|  |.-----.-----.     
 |  --  |  _  ||   _|   _|  |  ||  -__|__ --|     
 |_____/|_____||____|__| |__|__||_____|_____|     
  __               __          __ __              
 |__|.-----.-----.|  |_.---.-.|  |  |.-----.----. 
 |  ||     |__ --||   _|  _  ||  |  ||  -__|   _| 
 |__||__|__|_____||____|___._||__|__||_____|__|   "

	echo
	echo
	echo
	echo " Select the device to provision from the list below." \n\n\n
	echo "-------------------------------------------------------"
	echo "                1 ) Workstation      "
	echo "                2 ) Laptop           "
	echo "                3 ) Raspberry Pi 4   "
	echo "-------------------------------------------------------"
	read system
	echo
	echo
	echo
	case $system in
	1) # Workstation Configuration
		echo
		echo "You have chosen the workstation provisioning and configuration option."
		workstation
		echo
		echo
		echo "You hve completed the provisioning and configuring of your workstation system. Please Reboot."
		;;
	2)
		echo
		echo "You have chosen to provision the laptop configuration option."
		echo
		echo
		echo
		laptop
		echo
		echo
		echo "You hve completed the provisioning and configuring of your laptop system. Please Reboot."
		;;
	3)
		echo
		echo "You have chosen to provision a Raspberry Pi4."
		echo
		rpi4
		echo
		echo "You hve completed the provisioning and configuring of your laptop system. Please Reboot."
		;;
	*)
		echo "Not an option, you've made the wrong choice"
		;;
	esac
	echo ""
}

deps
menu
