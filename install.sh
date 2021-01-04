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

	sh $HOME/dotfiles/topics/git/credentials.sh

}

####################################################################################
## Application Installation FUnctions ##############################################
####################################################################################

## amd #############################################################################
amd() {
	yay -S --noconfirm --needed --sudoloop amd-ucode ryzenadj-git zenstates-git ryzen-stabilizator-git

	sudo grub-mkconfig -o /boot/grub/grub.conf

	sudo mkinitcpio -P
}
android() {
	yay -S --noconfirm --needed --sudoloop pulse-sms android-tools
}
##### awesomewm #####################################################################
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
####################################################################################
bash() {
	## Install Packages
	sudo pacman -S bash shellharden bashlint

	## Link Files
	ln -svf $HOME/dotfiles/topics/bash/bashenv $HOME/.bashenv
	ln -svf $HOME/dotfiles/topics/bash/bashrc $HOME/.bashrc
}
####################################################################################
bitwarden() {
	yay -S --noconfirm --sudoloop bitwarden
}
####################################################################################
bluetooth() {
	yay -S --noconfirm --sudoloop --needed blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez
}
####################################################################################
bspwm() {
	yay --noconfirm --sudoloop --needed bspwm-rounded-corners-git bsp-layout sxhkd-git bar-aint-recursive xtitle-git sutils-git
	ln -svf $HOME/dotfiles/topics/bspwm $HOME/.config/bspwm

}
####################################################################################
chromium() {
	sudo pacman -S --noconfirm chromium
}
####################################################################################
cups() {
	yay -S --noconfirm --sudoloop --batchinstall cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
}
####################################################################################
disks() {

	yay -S --noconfirm --sudoloop --needed dosfstools findutils gzip lzip p7zip tar
	yay -S --noconfirm --sudoloop --needed bzip2 lzop udftools cpio file file-roller filesystem
	yay -S --noconfirm --sudoloop --needed diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
	yay -S --noconfirm --sudoloop --needed gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop
	yay -S --noconfirm --sudoloop --needed gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
	yay -S --noconfirm --sudoloop --needed gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs
}
####################################################################################
docker() {
	yay -S --noconfirm --sudoloop --needed docker docker-compose docker-machine python-docker containerd
	sudo usermod -aG docker ${USER}
	sudo systemctl enable --now docker.service
	sudo systemctl enable --now docker.socket

}
####################################################################################
dunst() {
	ln -svf $HOME/dotfiles/topics/dunst/dunstrc $HOME/.config/dunst/dunstrc
}
####################################################################################
firefox() {
	sudo pacman -S --noconfirm firefo
	git clone https://github.com/Thomashighbaugh/firefox $HOME/.local/share/firefox/chrome
	cp -rvf $HOME/.local/share/firefox/chrome $HOME/.mozilla/firefox/*.default
	cp -rvf $HOME/.local/share/firefox/chrome $HOME/.mozilla/firefox/*.default-release

}
####################################################################################
font() {
	yay -S --noconfirm --batchinstall --needed bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 fontconfig sdl2_ttf t1lib birdfont
	mkdir -p ${HOME}/.local/share/fonts
	cd $HOME && wget https://www.dropbox.com/s/e1lbpaognaoiycs/fonts.tar.7z
	7z x -so $HOME/fonts.tar.7z | sudo tar xf - -C $HOME/fonts
	sudo cp -rnv $HOME/fonts /usr/share/fonts && rm -rvf $HOME/fonts $HOME/fonts.tar.7z
	sudo fc-cache -vf
	fc-cache -vf
}
####################################################################################
gimp() {
	yay -S --noconfirm --needed gimp gimp-plugin-gmic
}
####################################################################################
git() {
	sudo pacman -S --noconfirm git
	# Enter your git credentials once, forget it for the rest of the install
	git config --global credential.helper store
	ln -svf $HOME/dotfiles/topics/git/gitconfig %HOME/.gitconfig
	ln -svf $HOME/dotfiles/topics/git/gitignore %HOME/.gitignore
}
####################################################################################
gnupg() {
	sudo pacman -S --noconfirm gnupg gmime3 libcryptui seahorse mcabber hopenpgp-tools
	ln -svf $HOME/dotfiles/topics/gnupg/gpg.conf $HOME/.gnupg/gpg.conf
}
####################################################################################
gparted() {
	yay -S --sudoloop --batchinstall --noconfirm gpart gparted mtools nilfs-utils ntfs-3g polkit

}
####################################################################################
grub() {
	git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme $HOME/.local/share/Bhairava-Grub-Theme
	sudo sh $HOME/.local/share/Bhairava-Grub-Theme/svg2png.sh
	sudo sh $HOME/.local/share/Bhairava-Grub-Theme/set-grub.sh

}
####################################################################################
gtk() {
	yay -S --noconfirm gtk-engine-murrine gtk-engines xfce4-settings qt5ct kvantum colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkd gtkglarea libfm-gtk3

	mkdir -p $HOME/.config/gtk-2.0

	ln -svf $HOME/dotfiles/topics/gtk/gtk-2.0/gtkfilechooser.ini $HOME/.config/gtk-2.0/gtkfilechooser.ini

	mkdir -p $HOME/.config/gtk-3.0

	ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/bookmarks $HOME/.config/gtk-3.0/bookmarks

	ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css

	ln -svf $HOME/dotfiles/topics/gtk/gtk-3.0/settings.ini $HOME/.config/gtk-3.0/settings.ini

	ln -svf $HOME/dotfiles/topics/gtk/gtkrc-2.0 $HOME/.gtkrc-2.0

	mkdir -p $HOME/.config/Kvantum

	ln -svf $HOME/dotfiles/topics/gtk/kvantum.kvconfig $HOME/.config/Kvantum/kvantum.kvconfig

}
####################################################################################
hosts() {
	sudo cp /etc/hosts /etc/hosts.backup
	sudo wget https://someonewhocares.org/hosts/hosts -O /etc/hosts
	sudo bash -c "cat hosts /etc/hosts | sponge /etc/hosts"

}
####################################################################################
htop() {
	sudo pacman -S --noconfirm htop

}
####################################################################################
inkscape() {
	yay -S --noconfirm --sudoloop --needed inkscape

}
####################################################################################
kitty() {
	sudo pacman -S --noconfirm kitty kitty-terminfo catimg

	if [[ -r "$HOME/.config/kitty" ]]; then
		rm -rvf $HOME/.config/kitty
	fi

	mkdir -p $HOME/.config/kitty

	sudo ln -sf $HOME/dotfiles/topics/kitty/kitty.conf $HOME/.config/kitty/kitty.conf

	sudo ln -sf $HOME/dotfiles/topics/kitty/theme.conf $HOME/.config/kitty/theme.conf

	sudo ln -sf $HOME/dotfiles/topics/kitty/motd /etc/motd

}
####################################################################################
lightdm() {

	yay -S lightdm-gtk-greeter-settings lightdm lightdm-gtk-greeter
	sudo ln -svf $HOE/dotfiles/topics/lightdm/lightdm.conf /etc/lightdm
	sudo ln -svf $HOE/dotfiles/topics/lightdm/lightdm-gtk-greeter.conf /etc/lightdm

}
####################################################################################

lua() {
	yay -S --noconfirm --sudoloop --needed lua-dbi lua-socket luakit luarocks luakit lua-socket lua-dbi

}
####################################################################################
lxd() {
	yay -S --noconfirm --sudoloop --needed lxd lxc lxcfs

	sudo systemctl enable --now lxc
	sudo systemctl enable --now lxc-auto
	sudo systemctl enable --now lxcfs
	sudo systemctl enable --now containerd

}
####################################################################################
makepkg() {
	sudo cp -rvf $HOME/dotfiles/topics/makepkg/makepkg.conf /etc/makepkg.conf

}
####################################################################################
motd() {

	sudo ln -svf $HOME/dotfiles/topics/motd/motd /etc/motd
	sudo ln -vf $HOME/dotfiles/topics/motd/motd.sh /etc/motd.sh

}
####################################################################################
neofetch() {
	sudo pacman -S --noconfirm neofetch

	ln -svf $HOME/dotfiles/topics/neofetch $HOME/.config/neofetch

}
####################################################################################
network-manager() {
	yay -S --noconfirm --sudoloop --needed network-manager-applet networkmanager

}
####################################################################################
nvidia() {
	yay -S --noconfirm --sudoloop --batchinstall nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers

	yay -S --noconfirm --sudoloop --batchinstall cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1

	yay -S --noconfirm --sudoloop --batchinstall nvtop opencl-nvidia nvidia-utils nvidia-container-runtime

}
####################################################################################
nvm() {
	yay -S --noconfirm --sudoloop --batchinstall nvm
	sudo nvm install node
	sudo nvm use node
	sudo nvm alias default node

	sudo npm --global install yarn
	sudo yarn global add babel-eslint
	sudo yarn global add create-component-app
	sudo yarn global add create-next-app
	sudo yarn global add create-react-app
	sudo yarn global add eslint
	sudo yarn global add eslint-plugin-react
	sudo yarn global add eslint-plugin-jsx-a11y
	sudo yarn global add eslint-config-prettier
	sudo yarn global add gatsby
	sudo yarn global add gulp
	sudo yarn global add neovim
	sudo yarn global add heroku
	sudo yarn global add now
	sudo yarn global add prettier
	sudo yarn global add prettier-eslint
	sudo yarn global add react
	sudo yarn global add react-dom
	sudo yarn global add webpack

	sudo yarn upgrade

}
####################################################################################
pacman() {
	sudo rm -rvf /etc/pacman.conf

	sudo cp -rvf $HOME/dotfiles/topics/pacman/pacman.conf /etc/pacman.conf

	yay -S --needed --sudoloop --noconfirm systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms pacman-kernel-install-git
	yay -S --needed --sudoloop --noconfirm smkinitcpio-modconf-hook-git mkinitcpio-archiso-git systemd-removed-services-hook

}
####################################################################################
picom() {
	yay -S --noconfirm --needed --sudoloop picom-ibhagwan-git

	ln -svf $HOME/dotfiles/topics/picom/picom.conf $HOME/.config

}
pulseaudio() {
	yay -S --noconfirm --sudoloop --needed amixer pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeicon

}
python() {
	yay -S --noconfirm --sudoloop --needed python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv

}
qtile() {
	yay -S --needed --noconfirm --sudoloop qtile rofi sensors

	## Clone and Provision my QTile Configuration
	git clone https://github.com/Thomashighbaugh/qtile $HOME/.config/qtile

}
ranger() {
	yay -S --noconfirm --sudoloop ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks

}
rofi() {

	yay -S --noconfirm --sudoloop --needed rofi-git rofi-todo
	sudo pip install python-rofi

	mkdir -p $HOME/.config/rofi
	ln -svf $HOME/dotfiles/topics/rofi/config $HOME/.config/rofi
	ln -svf $HOME/dotfiles/topics/rofi/themes $HOME/.config/rofi
	sudo ln -svf $HOME/dotfiles/topics/rofi/themes /usr/share/rofi
	ln -svf $HOME/dotfiles/topics/rofi/config.rasi $HOME/.config/rofi/config.rasi
	ln -svf $HOME/dotfiles/topics/rofi/three.rasi $HOME/.config/rofi/three.rasi
	sudo cp -rvf $HOME/dotfiles/topics/rofi/rofi-todo /usr/bin

}

rpi() {

	yay -S --noconfirm --sudoloop --needed linux-raspberrypi4-aarch64 linux-raspberrypi4-aarch64-headers argonone-git

}

ruby() {

	yay -S --noconfirm --sudoloop --needed rbenv rbenv-binstubs ruby-sassc
	rbenv 2.7.1

}
rustup() {
	yay -S --noconfirm --sudoloop --needed rustup

	rustup install stable
	rustup default stable

}

sh() {

	sudo pacman -S --noconfirm keychain

	git clone https://github.com/Thomashighbaugh/bin $HOME/.local/share/bin

	yay -S --noconfirm --batchinstall --needed --sudoloop autojump nvm

	ln -svf $HOME/dotfiles/topics/sh/profile $HOME/.profile
	ln -svf $HOME/dotfiles/topics/sh/z.sh $HOME/.z.sh
	ln -svf $HOME/dotfiles/topics/sh/aliases $HOME/.aliases
}
ssh() {
	sudo pacman -S --noconfirm openssh keychain seahorse

	sudo cp -rvf $HOME/dotfiles/topics/ssh/ssh_config /etc/ssh/
	sudo cp -rvf $HOME/dotfiles/topics/ssh/sshd_config /etc/ssh/

}
sway() {
	yay -S --noconfirm --sudoloop --needed sway-borders-git swayidle grimshot wofi swaybg waybar wf-recorder autotiling nwg-launcher i3title swayimg swaylock wofer mako

	ln -svf $HOME/dotfiles/topics/sway/config $HOME/.config/sway/config

	ln -svf $HOME/dotfiles/topics/sway/lockman.sh $HOME/.config/sway/lockman.sh

	ln -svf $HOME/dotfiles/topics/sway/window.sh $HOME/.config/sway/window.sh

	ln -svf $HOME/dotfiles/topics/sway/nwg-launchers $HOME/.config/nwg-launchers

}
thinkpad() {
	yay -S --noconfirm --sudoloop --needed tp_smapi tp-battery-mode thinkpad-scripts hdaps-gl tpfand-git threshy libthinkpad tp-battery-icon-git i2c-tools
	yay -S --noconfirm --sudoloop --needed cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor
	yay -S --noconfirm --sudoloop --needed ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa
	yay -S --noconfirm --sudoloop --needed opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git
	yay -S --nconfirm --sudoloop --needed zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call
	sudo systemctl enable auto-cpufreq.service
	sudo systemctl enable acpid.service
	sudo systemctl enable --now tp-battery-mode.service
	sudo systemctl enable --now cpupower.service
	sudo systemctl enable --now lm_sensors.servic
	sudo systemctl enable --now ryzen-stabilizator.service
	sudo systemctl enable --now tuned.service
	tuned-adm profiles laptop-ac-powersave
	sudo mkinitramfs -Psv
	sudo grub-mkconfig -o /boot/grub/grub.conf

}
tlp() {
	yay -S --noconfirm --sudoloop --needed tlp powertop acpid tlp-rdw acpi acpid acpica acpitool

	sudo systemctl enable --now tlp

}
tor() {
	# Install Black Arch Repo
	curl -O https://blackarch.org/strap.sh
	echo 9c15f5d3d6f3f8ad63a6927ba78ed54f1a52176b strap.sh | sha1sum -c
	chmod +x strap.sh
	sudo ./strap.sh

	# Install Tor Browser
	yay -S --noconfirm --needed --sudoloop tor-browser-en

}
torrents() {
	yay -S --noconfirm --needed --sudoloop transmission-gtk transmission-cli libtorrent

}
vagrant() {
	yay -S --noconfirm --sudoloop --needed vagrant python-vagrant

}
vim() {
	yay -S --noconfirm --sudoloop --needed vim vi sudo vim-runtime vim-spell-en

	ln -svf $HOME/dotfiles/topics/vim/vimrc $HOME/.vimrc
	ln -svf $HOME/dotfiles/topics/vim/vim/plugged $HOME/.vim/plugged
	ln -svf $HOME/dotfiles/topics/vim/plugins.vim $HOME/.vim/plugins.vim
	ln -svf $HOME/dotfiles/topics/vim/vim/autoload $HOME/.vim/autoload

}
virt-manager() {
	yay -S virt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi

	## Enable the Daemon
	systemctl enable --now libvirtd
	systemctl enable --now virtnetworkd.service
	systemctl enable --now virtinterfaced.service
	systemctl enable --now virtqemud.service
	systemctl enable --now libvirtd-admin.socket

}
virtualbox() {
	yay -S virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies

}
vmware() {

	yay -S --noconfirm --sudoloop createvm open-vm-tools vmware-workstation vagrant-vmware-utility libview vmware-auto-unlocker-git vmware-modules-dkms-git vmware-component-extractor-git
	sudo modprobe -a vmw_vmci vmmon
}
xorg() {
	yay -S --noconfirm --sudoloop xorg xorg-apps xorg-drivers xorg-fonts
	yay -S --needed --noconfirm --sudoloop pa-applet-git gnome-keyring polkit-gnome libgnome-keyring xscreensaver

	mkdir -p $HOME/.Xresources.d

	ln -svf $HOME/dotfiles/topics/xorg/Xresources $HOME/.Xresources
	ln -svf $HOME/dotfiles/topics/xorg/color $HOME/.Xresources.d/color
	ln -svf $HOME/dotfiles/topics/xorg/font $HOME/.Xresources.d/font
	ln -svf $HOME/dotfiles/topics/xorg/rxvt-unicode $HOME/.Xresources.d/rxvt-unicode
	ln -svf $HOME/dotfiles/topics/xorg/uxterm $HOME/.Xresources.d/uxterm
	ln -svf $HOME/dotfiles/topics/xorg/xterm $HOME/.Xresources.d/xterm
	ln -svf $HOME/dotfiles/topics/xorg/xscreensaver $HOME/.xscreensaver
	ln -fvs $HOME/dotfiles/topics/xorg/xinitrc $HOME/.xinitrc
	ln -fvs $HOME/dotfiles/topics/xorg/xprofile $HOME/.xprofile
	ln -fvs $HOME/dotfiles/topics/xorg/xsettingsd $HOME/.xsettingsd
	ln -fvs $HOME/dotfiles/topics/xorg/xsessionrc $HOME/.xsessionrc
	sudo ln -fvs $HOME/dotfiles/topics/xorg/xinitrc /etc/X11/xinit/xinitrc

}
youtube-dl() {
	yay -S --noconfirm --sudoloop --needed youtube-dl

}
zathura() {

	yay -S --noconfirm --sudoloop --needed zathura zathura-pdf-mupdf zathura-ps

	ln -svf $HOME/dotfiles/topics/zathura/zathurarc $HOME/.config/zathura

}
zshenv() {
	## Install Necessary Packages
	yay -S --noconfirm --sudoloop --needed zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw
	yay -S --noconfirm --sudoloop --needed zsh-syntax-highlighting zsh-lovers zsh-autosuggestions
	yay -S --noconfirm --sudoloop --needed alias-tips-git zsh-system-clipboard-git
	yay -S --noconfirm --sudoloop zsh-completions keybase-zsh-completion-git python-click-completion
	## Symlink Files
	ln -svf $HOME/dotfiles/topics/zsh/zprofile $HOME/.zprofile
	ln -svf $HOME/dotfiles/topics/zsh/zshenv $HOME/.zshenv
	ln -svf $HOME/dotfiles/topics/zsh/zshrc $HOME/.zshrc
	ln -svf $HOME/dotfiles/topics/zsh/zlogout $HOME/.zlogout
	ln -svf $HOME/dotfiles/topics/zsh/functions$HOME/.zsh.d/functions

	## End

}
####################################################################################
## Devices #########################################################################
####################################################################################

laptop() {
	sh
	zshenv
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
	font
	firefox
	gparted
	gimp
	git
	grub
	gtk
	hosts
	htop
	inkscape
	kitty
	lightdm
	lua
	lxd
	makepkg
	motd
	neofetch
	network-manager
	nvm
	picom
	pulseaudio
	python
	qtile
	ranger
	rofi
	ruby
	rustup
	ssh
	sway
	tlp
	tor
	torrents
	vagrant
	virt-manager
	virtualbox
	vim
	vmware
	xorg
	youtube-dl
	zathura

	thinkpad
	amd
	pacman

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
	firefox
	font
	gparted
	gimp
	git
	gtk
	grub
	hosts
	htop
	inkscape
	kitty
	lightdm
	lua
	lxd
	neofetch
	network-manager
	nvidia
	pacman
	picom
	pulseaudio
	python
	qtile
	ranger
	rofi
	ruby
	rustup
	sh
	ssh
	tor
	vagrant
	vim
	virt-manager
	virtualbox
	vmware
	xorg
	youtube-dl
	zathura
	zshenv
	# Requires ZSH (thus after)
	nvm
	# Requires Node
	gtk
}

rpi4() {

	awesomewm
	bash
	bitwarden
	bluetooth
	disks
	docker
	dunst
	firefox
	font
	git
	gtk
	hosts
	htop
	kitty
	lightdm
	lua
	neofetch
	network-manager
	nvm
	picom
	pulseaudio
	python
	qtile
	ranger
	rofi
	ruby
	rustup
	sh
	ssh
	sway
	vagrant
	vim
	xorg
	sh $HOME/dotfiles/topics/yarn/install.sh
	youtube-dl
	zathura
	zshenv

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
