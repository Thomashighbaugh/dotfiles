#!/usr/bin/env bash
####################################################################################
## Introduction & Deps Installation ################################################
####################################################################################
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
read -r continue
$continue
function yayinit() {
    git clone https://aur.archlinux.org/yay.git "$HOME"/yay && cd "$HOME"/yay && makepkg -si && cd .. && sudo rm -rf "$HOME"/yay
}

deps() {
    clear
    echo "Set up local directories"
    mkdir -p "$HOME"/Pictures "$HOME"/.local/share "$HOME"/.config "$HOME"/.cache "$HOME"/.local/lib "$HOME"/Desktop "$HOME"/Documents "$HOME"/Downloads
    sudo pacman -S --noconfirm git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

    echo "Install Yay"
    echo "You must run the following command in another terminal to continue, when done press any key (sorry its resistant to scripting)"
    echo "$ git clone https://aur.archlinux.org/yay.git &&  cd yay && makepkg -si &&    sudo rm -rf yay "
    echo
    echo
    echo
    read -rp continue
    echo
    echo
    echo
    echo "Installing some other packages useful for the rest of the installation process."
    gpg --receive-keys EC3CBE7F607D11E663149E811D1F0DC78F173680
    yay -S --needed --sudoloop --noconfirm atool autoconf autocutsel automake binutils bison
    yay -S --needed --sudoloop --noconfirm gcc gcc-libs gettext glibc dialog dmidecode
    yay -S --needed --sudoloop --noconfirm keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed
    return
}

####################################################################################
## Application Installation Functions ##############################################
####################################################################################

## amd #############################################################################
function amd() {
    yay -S --noconfirm --needed --sudoloop amd-ucode ryzenadj-git zenstates-git ryzen-stabilizator-git

    sudo grub-mkconfig -o /boot/grub/grub.conf

    sudo mkinitcpio -P
    return
}
function android() {
    yay -S --noconfirm --needed --sudoloop pulse-sms android-tools
    return
}
##### awesomewm #####################################################################
function awesomewm() {
    yay -S --noconfirm --sudoloop awesome-git feh xcape

    yay -S --noconfirm --sudoloop vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus

    yay -S --noconfirm --sudoloop bemenu blueberry blueman bluez-hid2hci bluez-tools bluez-utils

    yay -S --noconfirm --sudoloop awmtt thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman

    yay -S --noconfirm --sudoloop firefox luarocks nitrogen

    if [[ -r "$HOME/.config/awesome" ]]; then
        rm -rvf "$HOME"/.config/awesome
    fi

    ## Install My Configuration
    git clone https://github.com/Thomashighbaugh/awesomewm "$HOME"/.config/awesome
    return
}
####################################################################################
function bashinit() {
    ## Install Packages
    sudo pacman -S bash shellharden bashlint

    ## Link Files
    ln -svf "$HOME"/dotfiles/topics/bash/bashenv "$HOME"/.bashenv
    ln -svf "$HOME"/dotfiles/topics/bash/bashrc "$HOME"/.bashrc
    return
}
####################################################################################
function bitwarden() {
    yay -S --noconfirm --sudoloop bitwarden
    return
}
####################################################################################
function bluetooth() {
    yay -S --noconfirm --sudoloop --needed blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez
    return
}
####################################################################################
function bspwm() {
    yay --noconfirm --sudoloop --needed bspwm-rounded-corners-git bsp-layout sxhkd-git bar-aint-recursive xtitle-git sutils-git
    ln -svf "$HOME"/dotfiles/topics/bspwm "$HOME"/.config/bspwm
    return
}
####################################################################################
function cups() {
    yay -S --noconfirm --sudoloop --batchinstall cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
    return
}
####################################################################################
function disks() {

    yay -S --noconfirm --sudoloop --needed dosfstools findutils gzip lzip p7zip tar
    yay -S --noconfirm --sudoloop --needed bzip2 lzop udftools cpio file file-roller filesystem
    yay -S --noconfirm --sudoloop --needed diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
    yay -S --noconfirm --sudoloop --needed gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop
    yay -S --noconfirm --sudoloop --needed gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
    yay -S --noconfirm --sudoloop --needed gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs
    return
}
####################################################################################
function docker() {
    yay -S --noconfirm --sudoloop --needed docker docker-compose docker-machine python-docker containerd
    sudo usermod -aG docker "$USER"
    sudo systemctl enable --now docker.service
    sudo systemctl enable --now docker.socket
    return
}
####################################################################################
function dunst() {
    ln -svf "$HOME"/dotfiles/topics/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
    return
}
####################################################################################
function firefox() {
    sudo pacman -S --noconfirm firefo
    git clone https://github.com/Thomashighbaugh/firefox "$HOME"/.local/share/firefox/chrome
    cp -rvf "$HOME"/.local/share/firefox/chrome "$HOME"/.mozilla/firefox/*.default
    cp -rvf "$HOME"/.local/share/firefox/chrome "$HOME"/.mozilla/firefox/*.default-release
    return
}
####################################################################################
function font() {
    yay -S --noconfirm --batchinstall --needed bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 fontconfig sdl2_ttf t1lib birdfont
    sudo fc-cache -vf
    fc-cache -vf
    return
}
####################################################################################
function gimp() {
    yay -S --noconfirm --needed gimp gimp-plugin-gmic xsane gimp-plugin-registry gimp-extras gimp-paint-studio
    return
}
####################################################################################
function gitinit() {
    # Enter your git credentials once, forget it for the rest of the install
    git config --global credential.helper store
    ln -svf "$HOME"/dotfiles/topics/git/gitconfig %HOME/.gitconfig
    ln -svf "$HOME"/dotfiles/topics/git/gitignore %HOME/.gitignore
    return
}
####################################################################################
function gnupg() {
    sudo pacman -S --noconfirm gnupg gmime3 libcryptui seahorse mcabber hopenpgp-tools
    ln -svf "$HOME"/dotfiles/topics/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
    return
}
####################################################################################
function gparted() {
    yay -S --sudoloop --batchinstall --noconfirm gpart gparted mtools nilfs-utils ntfs-3g polkit

    return
}
####################################################################################
function grubinit() {
    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme
    sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/svg2png.sh
    sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/set-grub.sh
    return
}
####################################################################################
function gtk() {
    yay -S --noconfirm gtk-engine-murrine gtk-engines xfce4-settings qt5ct kvantum colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkd gtkglarea libfm-gtk3

    mkdir -p "$HOME"/.config/gtk-2.0

    ln -svf "$HOME"/dotfiles/topics/gtk/gtk-2.0/gtkfilechooser.ini "$HOME"/.config/gtk-2.0/gtkfilechooser.ini

    mkdir -p "$HOME"/.config/gtk-3.0

    ln -svf "$HOME"/dotfiles/topics/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks

    ln -svf "$HOME"/dotfiles/topics/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css

    ln -svf "$HOME"/dotfiles/topics/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini

    ln -svf "$HOME"/dotfiles/topics/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0

    mkdir -p "$HOME"/.config/Kvantum

    ln -svf "$HOME"/dotfiles/topics/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig
    return
}
####################################################################################
function hosts() {
    sudo cp /etc/hosts /etc/hosts.backup
    sudo wget https://someonewhocares.org/hosts/hosts -O /etc/hosts
    sudo bash -c "cat hosts /etc/hosts | sponge /etc/hosts"

    return
}
####################################################################################
function htopinit() {
    sudo pacman -S --noconfirm htop
    return
}
####################################################################################
function inkscape() {
    yay -S --noconfirm --sudoloop --needed inkscape
    return
}
####################################################################################
function kitty() {
    sudo pacman -S --noconfirm kitty kitty-terminfo catimg

    if [[ -r "$HOME/.config/kitty" ]]; then
        rm -rvf "$HOME"/.config/kitty
    fi

    mkdir -p "$HOME"/.config/kitty

    sudo ln -sf "$HOME"/dotfiles/topics/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf

    sudo ln -sf "$HOME"/dotfiles/topics/kitty/theme.conf "$HOME"/.config/kitty/theme.conf

    sudo ln -sf "$HOME"/dotfiles/topics/motd/motd /etc/motd

    return
}
####################################################################################
function lightdm() {

    yay -S --noconfirm --sudoloop --needed lightdm-gtk-greeter-settings lightdm lightdm-gtk-greeter
    sudo ln -svf "$HOME"/dotfiles/topics/lightdm/lightdm.conf /etc/lightdm
    sudo ln -svf "$HOME"/dotfiles/topics/lightdm/lightdm-gtk-greeter.conf /etc/lightdm
    return
}
####################################################################################

function luainit() {
    yay -S --noconfirm --sudoloop --needed lua-dbi lua-socket luakit luarocks luakit lua-socket lua-dbi

    return
}
####################################################################################
function lxd() {
    yay -S --noconfirm --sudoloop --needed lxd lxc lxcfs

    sudo systemctl enable --now lxc
    sudo systemctl enable --now lxc-auto
    sudo systemctl enable --now lxcfs
    sudo systemctl enable --now containerd
    return
}
####################################################################################
function makepkg() {
    sudo cp -rvf "$HOME"/dotfiles/topics/makepkg/makepkg.conf /etc/makepkg.conf

    return
}
####################################################################################
function motd() {

    sudo ln -svf "$HOME"/dotfiles/topics/motd/motd /etc/motd
    sudo ln -vf "$HOME"/dotfiles/topics/motd/motd.sh /etc/motd.sh

    return
}
####################################################################################
function neofetch() {
    sudo pacman -S --noconfirm neofetch

    ln -svf "$HOME"/dotfiles/topics/neofetch "$HOME"/.config/neofetch
    return
}
####################################################################################
function networkmanager() {
    yay -S --noconfirm --sudoloop --needed network-manager-applet networkmanager
    return
}
####################################################################################
function nvidia() {
    yay -S --noconfirm --sudoloop --batchinstall nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers

    yay -S --noconfirm --sudoloop --batchinstall cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1

    yay -S --noconfirm --sudoloop --batchinstall nvtop opencl-nvidia nvidia-utils nvidia-container-runtime
    return
}
####################################################################################
function nvm() {
    yay -S --noconfirm --sudoloop --batchinstall nvm
    sh -c "sudo nvm install node && \\
    sudo nvm use node && \\
    sudo nvm alias default node && \\
    sudo npm --global install yarn && \\
    sudo yarn upgrade "
    return
}
####################################################################################
function pacmaninit() {
    sudo rm -rvf /etc/pacman.conf

    sudo cp -rvf "$HOME"/dotfiles/topics/pacman/pacman.conf /etc/pacman.conf

    yay -S --needed --sudoloop --noconfirm systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms pacman-kernel-install-git
    yay -S --needed --sudoloop --noconfirm smkinitcpio-modconf-hook-git mkinitcpio-archiso-git systemd-removed-services-hook
    return
}
####################################################################################
function picom() {
    yay -S --noconfirm --needed --sudoloop picom-ibhagwan-git

    ln -svf "$HOME"/dotfiles/topics/picom/picom.conf "$HOME"/.config
    return
}
####################################################################################
function pulseaudio() {
    yay -S --noconfirm --sudoloop --needed pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeicon
    return
}
####################################################################################
function pythoninit() {
    yay -S --noconfirm --sudoloop --needed python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv
    return
}
####################################################################################
function qtile() {
    yay -S --needed --noconfirm --sudoloop qtile rofi-git sensors

    ## Clone and Provision my QTile Configuration
    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
    return
}
####################################################################################
function ranger() {
    yay -S --noconfirm --sudoloop ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks
    return
}
####################################################################################
function rofi() {

    yay -S --noconfirm --sudoloop --needed rofi-git rofi-todo
    sudo pip install python-rofi
    mkdir -p "$HOME"/.config/rofi
    ln -svf "$HOME"/dotfiles/topics/rofi/config "$HOME"/.config/rofi
    ln -svf "$HOME"/dotfiles/topics/rofi/themes "$HOME"/.config/rofi
    sudo ln -svf "$HOME"/dotfiles/topics/rofi/themes /usr/share/rofi
    ln -svf "$HOME"/dotfiles/topics/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
    ln -svf "$HOME"/dotfiles/topics/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
    sudo cp -rvf "$HOME"/dotfiles/topics/rofi/rofi-todo /usr/bin
    return
}
####################################################################################
function rpi() {
    yay -S --noconfirm --sudoloop --needed linux-raspberrypi4-aarch64 linux-raspberrypi4-aarch64-headers argonone-git
    return
}
####################################################################################
function rubyinit() {
    yay -S --noconfirm --sudoloop --needed rbenv rbenv-binstubs ruby-sassc
    rbenv install 2.7.1
    return
}
####################################################################################
function shell() {
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
    ln -svf "$HOME"/dotfiles/topics/sh/profile "$HOME"/.profile
    ln -svf "$HOME"/dotfiles/topics/sh/aliases "$HOME"/.aliases
    yay -S --noconfirm --batchinstall --needed --sudoloop autojump
    return
}
####################################################################################
function sshinit() {

    sudo cp -rvf "$HOME"/dotfiles/topics/ssh/ssh_config /etc/ssh/
    sudo cp -rvf "$HOME"/dotfiles/topics/ssh/sshd_config /etc/ssh/
    sudo pacman -S --noconfirm openssh keychain seahorse

    return
}
####################################################################################
function sway() {
    yay -S --noconfirm --sudoloop --needed sway-borders-git swayidle grimshot wofi swaybg waybar wf-recorder autotiling nwg-launcher i3title swayimg swaylock wofer mako swaymgr swaytools i3keys

    nkdir -p "$HOME"/.config/sway

    ln -svf "$HOME"/dotfiles/topics/sway/config "$HOME"/.config/sway/config

    ln -svf "$HOME"/dotfiles/topics/sway/lockman.sh "$HOME"/.config/sway/lockman.sh

    ln -svf "$HOME"/dotfiles/topics/sway/window.sh "$HOME"/.config/sway/window.sh

    ln -svf "$HOME"/dotfiles/topics/sway/nwg-launchers "$HOME"/.config/nwg-launchers
    return
}
####################################################################################
function thinkpad() {
    yay -S --noconfirm --sudoloop --needed tp_smapi tp-battery-mode thinkpad-scripts hdaps-gl tpfand-git threshy libthinkpad tp-battery-icon-git i2c-tools
    yay -S --noconfirm --sudoloop --needed cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor
    yay -S --noconfirm --sudoloop --needed ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa
    yay -S --noconfirm --sudoloop --needed opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git
    yay -S --noconfirm --sudoloop --needed zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call
    sudo systemctl enable auto-cpufreq.service
    sudo systemctl enable acpid.service
    sudo systemctl enable --now tp-battery-mode.service
    sudo systemctl enable --now cpupower.service
    sudo systemctl enable --now lm_sensors.service
    sudo systemctl enable --now ryzen-stabilizator.service
    sudo systemctl enable --now tuned.service
    tuned-adm profiles laptop-ac-powersave
    sudo mkinitcpio -Psv
    sudo grub-mkconfig -o /boot/grub/grub.conf
    return
}
####################################################################################
function tlp() {
    yay -S --noconfirm --sudoloop --needed tlp powertop acpid tlp-rdw acpi acpid acpica acpitool

    sudo systemctl enable --now tlp
    return
}
####################################################################################
function tor() {
    # Install Tor Browser
    yay -S --noconfirm --needed --sudoloop tor-browser-en
    return
}
####################################################################################
function torrents() {
    yay -S --noconfirm --needed --sudoloop transmission-gtk transmission-cli libtorrent
    return
}
####################################################################################
function vagrant() {
    yay -S --noconfirm --sudoloop --needed vagrant python-vagrant
    return
}
####################################################################################
function viminit() {
    yay -S --noconfirm --sudoloop --needed vim vi sudo vim-runtime vim-spell-en

    ln -svf "$HOME"/dotfiles/topics/vim/vimrc "$HOME"/.vimrc
    ln -svf "$HOME"/dotfiles/topics/vim/vim/plugged "$HOME"/.vim/plugged
    ln -svf "$HOME"/dotfiles/topics/vim/plugins.vim "$HOME"/.vim/plugins.vim
    ln -svf "$HOME"/dotfiles/topics/vim/vim/autoload "$HOME"/.vim/autoload

    # Personal Vimwiki 
    git clone https://github.com/Thomashighbaugh/vimwiki
    
    return
}
####################################################################################
function virtmanager() {
    yay -S --noconfirm --sudoloop --needed virt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi

    ## Enable the Daemon
    sudo systemctl enable --now libvirtd
    sudo systemctl enable --now virtnetworkd.service
    sudo systemctl enable --now virtinterfaced.service
    sudo systemctl enable --now virtqemud.service
    sudo systemctl enable --now libvirtd-admin.socket
    return
}
####################################################################################
function virtualbox() {
    yay -S --noconfirm --sudoloop --needed virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies

    return
}
####################################################################################
function vmware() {

    yay -S --noconfirm --sudoloop createvm open-vm-tools vmware-workstation vagrant-vmware-utility libview vmware-auto-unlocker-git vmware-modules-dkms-git vmware-component-extractor-git
  
    sudo modprobe -a vmw_vmci vmmon
    return
}
####################################################################################
function xorg() {
    yay -S --noconfirm --sudoloop xorg xorg-apps xorg-drivers xorg-fonts
    yay -S --needed --noconfirm --sudoloop pa-applet-git gnome-keyring polkit-gnome libgnome-keyring xscreensaver

    mkdir -p "$HOME"/.Xresources.d

    ln -svf "$HOME"/dotfiles/topics/xorg/Xresources "$HOME"/.Xresources
    ln -svf "$HOME"/dotfiles/topics/xorg/color "$HOME"/.Xresources.d/color
    ln -svf "$HOME"/dotfiles/topics/xorg/font "$HOME"/.Xresources.d/font
    ln -svf "$HOME"/dotfiles/topics/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
    ln -svf "$HOME"/dotfiles/topics/xorg/uxterm "$HOME"/.Xresources.d/uxterm
    ln -svf "$HOME"/dotfiles/topics/xorg/xterm "$HOME"/.Xresources.d/xterm
    ln -svf "$HOME"/dotfiles/topics/xorg/xscreensaver "$HOME"/.xscreensaver
    ln -fvs "$HOME"/dotfiles/topics/xorg/xinitrc "$HOME"/.xinitrc
    ln -fvs "$HOME"/dotfiles/topics/xorg/xprofile "$HOME"/.xprofile
    ln -fvs "$HOME"/dotfiles/topics/xorg/xsettingsd "$HOME"/.xsettingsd
    ln -fvs "$HOME"/dotfiles/topics/xorg/xsessionrc "$HOME"/.xsessionrc
    return
}
####################################################################################
function youtubedl() {
    yay -S --noconfirm --sudoloop --needed youtube-dl
    return
}
####################################################################################
function zathura() {
    ## Install program
    yay -S --noconfirm --sudoloop --needed zathura zathura-pdf-mupdf zathura-ps
    ## Add configuration
    ln -svf "$HOME"/dotfiles/topics/zathura/zathurarc "$HOME"/.config/zathura

    return
}
####################################################################################
function zshenv() {
    ## Install Necessary Packages
    yay -S --noconfirm --sudoloop --needed zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw
    yay -S --noconfirm --sudoloop --needed zsh-syntax-highlighting zsh-lovers zsh-autosuggestions
    yay -S --noconfirm --sudoloop --needed alias-tips-git zsh-system-clipboard-git
    yay -S --noconfirm --sudoloop zsh-completions keybase-zsh-completion-git python-click-completion
    ## Symlink Files
    ln -svf "$HOME"/dotfiles/topics/zsh/zprofile "$HOME"/.zprofile
    ln -svf "$HOME"/dotfiles/topics/zsh/zshenv "$HOME"/.zshenv
    ln -svf "$HOME"/dotfiles/topics/zsh/zshrc "$HOME"/.zshrc
    ln -svf "$HOME"/dotfiles/topics/zsh/zlogout "$HOME"/.zlogout
    ln -svf "$HOME"/dotfiles/topics/zsh/functions "$HOME"/.zsh.d/functions
    return
}
# Menu
menu() {
    while true
    do
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

    cmd=(dialog --separate-output --checklist "Select options:" 22 76 16)
    options=(
        1 "AMD" off # any option can be set to default to "on"
        2 "Awesome Window Manager" off
        3 "Bash Shell" off
        4 "Bitwarden" off
        5 "bspwm" off
        6 "cups" off
        7 "disks" off
        8 "docker" off
        9 "dunst" off
        10 "firefox" off
        11 "font" off
        12 "gparted" off
        13 "gimp" off
        14 "gitinit" off
        15 "gtk" off
        16 "grubinit" off
        17 "hosts" off
        18 "htopinit" off
        19 "inkscape" off
        20 "kitty" off
        21 "lightdm" off
        22 "luainit" off
        23 "lxd" off
        24 "neofetch" off
        25 "networkmanager" off
        26 "nvidia" off
        27 "pacmaninit" off
        28 "picom" off
        29 "pulseaudio" off
        30 "pythoninit" off
        31 "qtile" off
        32 "ranger" off
        33 "rofi" off
        34 "rubyinit" off
        35 "shell" off
        36 "sshinit" off
        37 "tor" off
        38 "vagrant" off
        39 "viminit" off
        40 "virtmanager" off
        41 "virtualbox" off
        42 "vmware" off
        43 "xorg" off
        44 "youtube-dl" off
        45 "zathura" off
        46 "zshenv" off
        47 "nvm" off
        48 "bluetooth" off
        49 "sway" off
        50 "Raspberry Pi" off
        51 "tlp" off
        52 "thinkpad" off
        53 "Exit" off
    )

    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices; do
        case $choice in
        1)
            amd
            ;; # any option can be set to default to "on"
        2)
            awesomewm

            ;;
        3)
            bashinit
            ;;
        4)
            bitwarden

            ;;
        5)
            bspwm

            ;;
        6)
            cups
            ;;
        7)
            disks
            ;;
        8)
            docker
            ;;
        9)
            dunst
            ;;
        10)
            firefox
            ;;
        11)
            font
            ;;
        12)
            gparted
            ;;
        13)
            gimp
            ;;
        14)
            gitinit
            ;;
        15)
            gtk
            ;;
        16)
            grubinit
            ;;
        17)
            hosts
            ;;
        18)
            htopinit
            ;;
        19)
            inkscape
            ;;
        20)
            kitty
            ;;
        21)
            lightdm
            ;;
        22)
            luainit
            ;;
        23)
            lxd
            ;;
        24)
            neofetch
            ;;
        25)
            networkmanager
            ;;
        26)
            nvidia
            ;;
        27)
            pacmaninit
            ;;
        28)
            picom
            ;;
        29)
            pulseaudio
            ;;
        30)
            pythoninit
            ;;
        31)
            qtile
            ;;
        32)
            ranger
            ;;
        33)
            rofi
            ;;
        34)
            rubyinit
            ;;
        35)
            shell
            ;;
        36)
            sshinit
            ;;
        37)
            tor
            ;;
        38)
            vagrant
            ;;
        39)
            viminit
            ;;
        40)
            virtmanager
            ;;
        41)
            virtualbox
            ;;
        42)
            vmware
            ;;
        43)
            xorg
            ;;
        44)
            youtube-dl
            ;;
        45)
            zathura
            ;;
        46)
            zshenv
            ;;
        47)
            nvm
            ;;
        48)
            bluetooth

            ;;
        49)
            sway

            ;;
        50)
            rpi

            ;;

        51)
            tlp

            ;;
        52)
            thinkpad
            ;;
        53) 
           exit 
            ;;
        esac
    done
done
}

deps
menu
