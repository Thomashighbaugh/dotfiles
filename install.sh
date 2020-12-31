# #!/usr/bin/env bash
echo ""
echo "  _____         __    ___ __ __                   "
echo " |     \.-----.|  |_.'  _|__|  |.-----.-----.     "
echo " |  --  |  _  ||   _|   _|  |  ||  -__|__ --|     "
echo " |_____/|_____||____|__| |__|__||_____|_____|     "
echo "  __               __          __ __              "
echo " |__|.-----.-----.|  |_.---.-.|  |  |.-----.----. "
echo " |  ||     |__ --||   _|  _  ||  |  ||  -__|   _| "
echo " |__||__|__|_____||____|___._||__|__||_____|__|   "
echo ""
echo ""
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
	git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -is && cd .. && sudo rm -rf $HOME/yay

	echo "Install some other packages useful for the rest of the installation process."

	yay -S --needed --sudoloop --noconfirm chrony atool autoconf autocutsel automake binutils bison

	yay -S --needed --sudoloop --noconfirm gcc gcc-libs gettext glibc dialog dmidecode

	yay -S --needed --sudoloop --noconfirm keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed powerpill bauerbill

}

laptop() {

	sh $HOME/dotfiles/topics/awesome/install.sh
	sh $HOME/dotfiles/topics/bash/install.sh
	sh $HOME/dotfiles/topics/bitwarden/install.sh
	sh $HOME/dotfiles/topics/bluetooth/install.sh
	sh $HOME/dotfiles/topics/bspwm/install.sh
	sh $HOME/dotfiles/topics/chromium/install.sh
	sh $HOME/dotfiles/topics/cups/install.sh
	sh $HOME/dotfiles/topics/cursor/install.sh
	sh $HOME/dotfiles/topics/disks/install.sh
	sh $HOME/dotfiles/topics/docker/install.sh
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

	sh $HOME/dotfiles/topics/amd/install.sh
	sh $HOME/dotfiles/topics/awesome/install.sh
	sh $HOME/dotfiles/topics/bash/install.sh
	sh $HOME/dotfiles/topics/bitwarden/install.sh
	sh $HOME/dotfiles/topics/bluetooth/install.sh
	sh $HOME/dotfiles/topics/bspwm/install.sh
	sh $HOME/dotfiles/topics/chromium/install.sh
	sh $HOME/dotfiles/topics/cups/install.sh
	sh $HOME/dotfiles/topics/cursor/install.sh
	sh $HOME/dotfiles/topics/disks/install.sh
	sh $HOME/dotfiles/topics/docker/install.sh
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

	sh $HOME/dotfiles/topics/awesome/install.sh
	sh $HOME/dotfiles/topics/bash/install.sh
	sh $HOME/dotfiles/topics/bitwarden/install.sh
	sh $HOME/dotfiles/topics/bluetooth/install.sh
	sh $HOME/dotfiles/topics/cursor/install.sh
	sh $HOME/dotfiles/topics/disks/install.sh
	sh $HOME/dotfiles/topics/docker/install.sh
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
	echo " Select the device to provision from the list below."
	echo "-------------------------------------------------------"
	echo "                1 ) Workstation      "
	echo "                2 ) Laptop           "
	echo "                3 ) Raspberry Pi 4   "
	echo "-------------------------------------------------------"
	read system
	echo -n ""
	echo -n ""
	case $system in
	1) # Workstation Configuration
		echo
		echo "You have chosen the workstation provisioning and configuration option."
		echo
		echo
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
