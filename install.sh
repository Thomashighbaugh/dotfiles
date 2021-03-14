#!/usr/bin/env bash
####################################################################################
## Introduction & Deps Installation ################################################
####################################################################################
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"

print() {
    case "$1" in
    t | title)
        shift
        printf "%s\n" "${sb}${cg}[###]$*${sn}"
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}"
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}"
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}"
        ;;
    *)
        printf '%s\n' "$*"
        ;;
    esac
}

print t "
  _____         __    ___ __ __
 |     \.-----.|  |_.'  _|__|  |.-----.-----.
 |  --  |  _  ||   _|   _|  |  ||  -__|__ --|
 |_____/|_____||____|__| |__|__||_____|_____|
  __               __          __ __
 |__|.-----.-----.|  |_.---.-.|  |  |.-----.----.
 |  ||     |__ --||   _|  _  ||  |  ||  -__|   _|
 |__||__|__|_____||____|___._||__|__||_____|__|   "
print
print
print
print w "First let's make sure we get the basics out of the way."
print w "Press any key to install the dependencies and set up your system:"
read -n1 -s -r -p $'Press any key to continue...\n' key

function deps() {
    clear

    print t "Set up local directories"

    mkdir -p "$HOME"/Pictures "$HOME"/.local/share "$HOME"/.config "$HOME"/.cache "$HOME"/.local/lib "$HOME"/Desktop "$HOME"/Documents "$HOME"/Downloads

    sudo pacman -S --noconfirm git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

    print t "####################################################################"
    print t "Install Yay"
    print t "####################################################################"

    print
    print w "You must run the following command in another terminal to continue, when done press any key (sorry its resistant to scripting)"
    print
    print s "$ git clone https://aur.archlinux.org/yay.git &&  cd yay && makepkg -si &&    sudo rm -rf yay "
    print
    print
    read -n1 -s -r -p $'Press any key to continue...\n' key2
    print
    print
    print
    print s "Installing some other packages useful for the rest of the installation process."
    gpg --receive-keys EC3CBE7F607D11E663149E811D1F0DC78F173680
    yay -S --needed --sudoloop --noconfirm atool autoconf autocutsel automake binutils bison libnotify
    yay -S --needed --sudoloop --noconfirm gcc gcc-libs gettext glibc dialog dmidecode
    yay -S --needed --sudoloop --noconfirm keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed
    return
}
########################################################################
# Menu
menu() {
    while true; do
        clear

        print t "
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
            1 "AMD Processor Hardware" off
            2 "Android OS Interfacing" off
            3 "Awesome Window Manager" off
            4 "BASH Shell" off
            5 "Bitwarden Password Manager" off
            6 "Bluetooth Interfacing" off
            7 "BSP Window Manager" off
            8 "Caja File Manager" off
            9 "CUPs Printer Interfacing" off
            10 "Disks and Archive Management" off
            11 "Docker Container Environment" off
            12 "Dunst Notification System" off
            13 "Firefox Internet Browser" off
            14 "Fonts" off
            15 "GPG Key Configuration" off
            16 "GIMP Image Editor" off
            17 "Git Version Control" off
            18 "GTK Window Theming" off
            19 "Grub Bootloader" off
            20 "Hosts File" off
            21 "HTOP Process Monitor" off
            22 "Inkscape SVG Editor" off
            23 "Kitty Terminal Emulator" off
            24 "Lua Programming Language" off
            25 "LXD Container Environment" off
            26 "Makepkg Package Build System" off
            27 "Message of the Day" off
            28 "Neofetch System Information Display" off
            29 "Network Manager" off
            30 "Nvidia Firmware and Drivers" off
            31 "Node Version Manager" off
            32 "Pacman Modifications, Hooks and Extensions" off
            33 "Picom Desktop Compostitor" off
            34 "Pulse Audio" off
            35 "Python" off
            36 "Qtile Window Manager" off
            37 "Ranger File Manager" off
            38 "Raspberry Pi 4" off
            39 "Rofi Menu Script" off
            40 "Ruby Programming Language" off
            41 "Shell Environment" off
            42 "Secure Shell" off
            43 "Sway Window Manager" off
            44 "Thinkpad E495 Settings" off
            45 "Vim Modal Text Editor" off
            46 "Virt-Manager" off
            47 "Virtualbox VM Type 2 Hypervisor" off
            48 "vmware Workstation Type 2 Hypervisor" off
            49 "X11 Window Server" off
            50 "ZSH shell" off
            51 "Exit Script" off

        )

        choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        clear
        for choice in $choices; do
            case $choice in
            1)
                print t "AMD Processors"
                yay -S --noconfirm --needed --sudoloop amd-ucode ryzenadj-git zenstates-git

                sudo grub-mkconfig -o /boot/grub/grub.conf

                sudo mkinitcpio -P
                notify-send "AMD Processors Provisioned"
                ;;
            2)
                print t "Android OS Interfacing"
                yay -S --noconfirm --needed --sudoloop pulse-sms android-tools
                notify-send "Android Phone Interfacing Provisioned"
                ;;
            3)
                print t "Awesome Window Manager"
                yay -S --noconfirm --sudoloop awesome-git feh xcape light lua-coxpcall maim

                yay -S --noconfirm --sudoloop vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus

                yay -S --noconfirm --sudoloop bemenu blueberry blueman bluez-hid2hci bluez-tools bluez-utils

                yay -S --noconfirm --sudoloop awmtt thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman

                yay -S --noconfirm --sudoloop firefox luarocks nitrogen
                yay -S --noconfirm --sudoloop --needed zathura zathura-pdf-mupdf zathura-ps youtube-dl

                ln -svf "$HOME"/dotfiles/topics/zathura/zathurarc "$HOME"/.config/zathura

                if [[ -r "$HOME/.config/awesome" ]]; then
                    rm -rvf "$HOME"/.config/awesome
                fi

                ## Install My Configuration
                git clone https://github.com/Thomashighbaugh/awesomewm "$HOME"/.config/awesome
                return
                notify-send "Awesome Window Manager Provisioned and Configured"
                ;;
            4)
                print t "BASH shell"
                function bashinit() {
                    ## Install Packages
                    sudo pacman -S bash shellharden bashlint

                    ## Link Files
                    ln -svf "$HOME"/dotfiles/topics/bash/bashenv "$HOME"/.bashenv
                    ln -svf "$HOME"/dotfiles/topics/bash/bashrc "$HOME"/.bashrc
                    return
                }
                notify-send "BASH Shell Configured"
                ;;
            5)
                print t "Bitwarden Password Manager"
                yay -S --noconfirm --sudoloop bitwarden keepassxc
                notify-send "Bitwarden Password Manager Provisioned"
                ;;
            6)
                print t "Bluetooth Interfacing"
                yay -S --noconfirm --sudoloop --needed blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez
                notify-send "Bluetooth Interfacing Provisioned"
                ;;

            7)
                print t "BSP Window Manager"
                yay --noconfirm --sudoloop --needed bspwm-rounded-corners-git bsp-layout sxhkd-git bar-aint-recursive xtitle-git sutils-git
                ln -svf "$HOME"/dotfiles/topics/bspwm "$HOME"/.config/bspwm
                notify-send "BSP Window Manager Provisioned and Configured"
                ;;
            8)
                print t "Caja File Manager"
                yay -S --noconfirm --sudoloop --needed caja engrampa caja-extensions-common python-caja caja-xattr-tags caja-share caja-sendto caja-open-terminal caja-image-converter
                yay -S --noconfirm --sudoloop --needed caja-dropbox gtkhash-caja caja-rename
                notify-send "Caja File Manager"
                ;;
            9)
                print t "CUPs Printer Interfacing"
                yay -S --noconfirm --sudoloop --batchinstall cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
                sudo systemctl enable --now cups
                notify-send "CUPs Printer Interfacing Provisioned and Configured"
                ;;
            10)
                print t "Disks and Archive Management"
                yay -S --sudoloop --batchinstall --noconfirm gpart gparted mtools nilfs-utils ntfs-3g polkit

                yay -S --noconfirm --sudoloop --needed dosfstools findutils gzip lzip p7zip tar
                yay -S --noconfirm --sudoloop --needed bzip2 lzop udftools cpio file file-roller filesystem gnome-disk-utility
                yay -S --noconfirm --sudoloop --needed diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
                yay -S --noconfirm --sudoloop --needed gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop unace
                yay -S --noconfirm --sudoloop --needed gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
                yay -S --noconfirm --sudoloop --needed gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs
                notify-send "Disks and Archive Management Provisioned"
                ;;
            11)
                print t "Docker Container Environment"
                yay -S --noconfirm --sudoloop --needed docker docker-compose docker-machine python-docker containerd
                sudo usermod -aG docker "$USER"
                sudo systemctl enable --now docker.service
                sudo systemctl enable --now docker.socket
                notify-send "Docker Container Environment"
                ;;
            12)
                print t "Dunst Notification System"
                yay -S --noconfirm --sudoloop --needed dunst
                ln -svf "$HOME"/dotfiles/topics/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
                notify-send "Dunst Notification System"
                ;;
            13)
                print t "Firefox Internet Browser"
                sudo pacman -S --noconfirm firefox firefox-nightly
                git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox
                sudo chmod +x /tmp/firefox
                sh /tmp/firefox/install.sh
                notify-send "Firefox Internet Browser"
                ;;
            14)
                print t "Fonts"
                yay -S --noconfirm --batchinstall --needed bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 awesome-terminal-fonts nerd-fonts-complete fontconfig sdl2_ttf t1lib birdfont
                sudo fc-cache -vf
                fc-cache -vf
                notify-send "Fonts Provisioned"
                ;;
            15)
                print t "GPG Key Configuration"
                sudo pacman -S --noconfirm gnupg gmime3 libcryptui seahorse mcabber hopenpgp-tools
                ln -svf "$HOME"/dotfiles/topics/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
                notify-send "GPG Key Configuration Provisioned"
                ;;
            16)
                print t "GIMP Image Editor"
                yay -S --noconfirm --needed gimp gimp-plugin-gmic xsane gimp-plugin-registry gimp-extras gimp-paint-studio
                notify-send "GIMP Image Editor Provisioned"
                ;;
            17)
                print t "Git Version Control"
                # Enter your git credentials once, forget it for the rest of the install
                git config --global credential.helper store
                ln -svf "$HOME"/dotfiles/topics/git/gitconfig %HOME/.gitconfig
                ln -svf "$HOME"/dotfiles/topics/git/gitignore %HOME/.gitignore
                notify-send "Git Version Control Provisioned and Configured"
                ;;
            18)
                print t "GTK Window Theming"
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
                notify-send "GTK Window Theming Provisioned and Configured"
                ;;
            19)
                print t "Grub Bootloader"
                git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme
                sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/svg2png.sh
                sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/set-grub.sh
                notify-send "Grub Bootloader Provisioned and Configured"
                ;;
            20)
                print t "Hosts File"
                sudo cp /etc/hosts /etc/hosts.backup
                sudo wget https://someonewhocares.org/hosts/hosts -O /etc/hosts
                sudo bash -c "cat hosts /etc/hosts | sponge /etc/hosts"
                notify-send "Hosts File Provisioned and Configured"
                ;;
            21)
                print t "HTOP Process Monitor"
                sudo pacman -S --noconfirm htop
                notify-send " Provisioned and Configured"

                ;;
            22)
                print t "Inkscape SVG Editor"
                yay -S --noconfirm --sudoloop --needed inkscape
                notify-send " Provisioned and Configured"

                ;;
            23)
                print t "Kitty Terminal Emulator"
                sudo pacman -S --noconfirm kitty kitty-terminfo catimg

                if [[ -r "$HOME/.config/kitty" ]]; then
                    rm -rvf "$HOME"/.config/kitty
                fi

                mkdir -p "$HOME"/.config/kitty

                sudo ln -sf "$HOME"/dotfiles/topics/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf

                sudo ln -sf "$HOME"/dotfiles/topics/kitty/theme.conf "$HOME"/.config/kitty/theme.conf

                sudo ln -sf "$HOME"/dotfiles/topics/motd/motd /etc/motd
                notify-send " Provisioned and Configured"

                ;;

            24)
                print t "Lua Programming Language"

                yay -S --noconfirm --sudoloop --needed lua-dbi lua-socket luakit luarocks luakit lua-socket lua-dbi
                notify-send " Provisioned and Configured"

                ;;
            25)
                print t "LXD Container Environment"

                yay -S --noconfirm --sudoloop --needed lxd lxc lxcfs lxc-templates

                sudo systemctl enable --now lxc
                sudo systemctl enable --now lxc-auto
                sudo systemctl enable --now lxcfs
                sudo systemctl enable --now containerd
                notify-send " Provisioned and Configured"

                ;;
            26)
                print t "Makepkg Package Build System"
                yay -S --noconfirm --sudoloop --needed makepkg-tidy-scripts-git makepkg-meta remakepkg
                sudo cp -rvf "$HOME"/dotfiles/topics/makepkg/makepkg.conf /etc/makepkg.conf
                notify-send " Provisioned and Configured"

                ;;
            27)
                print t "Message of the Day"
                sudo ln -svf "$HOME"/dotfiles/topics/motd/motd /etc/motd
                sudo ln -vf "$HOME"/dotfiles/topics/motd/motd.sh /etc/motd.sh
                notify-send " Provisioned and Configured"

                ;;
            28)
                print t "Neofetch System Information Display"
                sudo pacman -S --noconfirm neofetch

                ln -svf "$HOME"/dotfiles/topics/neofetch "$HOME"/.config/neofetch
                notify-send " Provisioned and Configured"

                ;;
            29)
                print t "Network Manager"
                yay -S --noconfirm --sudoloop --needed network-manager-applet networkmanager
                notify-send " Provisioned and Configured"

                ;;
            30)
                print t "Nvidia Firmware and Drivers"
                yay -S --noconfirm --sudoloop --batchinstall nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers

                yay -S --noconfirm --sudoloop --batchinstall cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1

                yay -S --noconfirm --sudoloop --batchinstall nvtop opencl-nvidia nvidia-utils nvidia-container-runtime
                notify-send " Provisioned and Configured"

                ;;
            31)
                curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
                sh -c "nvm install node && nvm use node && nvm install 12 && nvm install 10"
                sh -c "npm install --global yarn"
                notify-send " Provisioned and Configured"

                ;;

            32)
                print t "Pacman Modifications, Hooks and Extensions"
                sudo rm -rvf /etc/pacman.conf

                sudo cp -rvf "$HOME"/dotfiles/topics/pacman/pacman.conf /etc/pacman.conf

                yay -S --needed --sudoloop --noconfirm systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms pacman-kernel-install-git
                yay -S --needed --sudoloop --noconfirm smkinitcpio-modconf-hook-git mkinitcpio-archiso-git systemd-removed-services-hook
                notify-send " Provisioned and Configured"

                ;;
            33)
                print t "Picom Desktop Compostitor"
                yay -S --noconfirm --needed --sudoloop picom-ibhagwan-git

                ln -svf "$HOME"/dotfiles/topics/picom/picom.conf "$HOME"/.config
                notify-send " Provisioned and Configured"

                ;;
            34)
                print t "Pulse Audio"
                yay -S --noconfirm --sudoloop --needed pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeicon
                notify-send " Provisioned and Configured"

                ;;
            35)
                print t "Python"
                yay -S --noconfirm --sudoloop --needed python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv
                notify-send " Provisioned and Configured"

                ;;

            36)
                print t "Qtile Window Manager"
                yay -S --needed --noconfirm --sudoloop qtile rofi-git sensors

                ## Clone and Provision my QTile Configuration
                git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
                notify-send " Provisioned and Configured"

                ;;
            37)
                print t "Ranger File Manager"
                yay -S --noconfirm --sudoloop ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks
                notify-send " Provisioned and Configured"

                ;;
            38)
                print t "Raspberry Pi 4"
                yay -S --noconfirm --sudoloop --needed linux-raspberrypi4-aarch64 linux-raspberrypi4-aarch64-headers argonone-git
                notify-send " Provisioned and Configured"

                ;;

            39)
                print t "Rofi Menu Script"
                yay -S --noconfirm --sudoloop --needed rofi-git
                sudo pip install python-rofi
                mkdir -p "$HOME"/.config/rofi
                ln -svf "$HOME"/dotfiles/topics/rofi/config "$HOME"/.config/rofi
                ln -svf "$HOME"/dotfiles/topics/rofi/themes "$HOME"/.config/rofi
                sudo ln -svf "$HOME"/dotfiles/topics/rofi/themes /usr/share/rofi
                ln -svf "$HOME"/dotfiles/topics/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
                ln -svf "$HOME"/dotfiles/topics/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
                sudo cp -rvf "$HOME"/dotfiles/topics/rofi/rofi-todo /usr/bin
                notify-send " Provisioned and Configured"

                ;;
            40)
                print t "Ruby Programming Language"
                yay -S --noconfirm --sudoloop --needed rbenv rbenv-binstubs ruby-sassc chruby ruby-build
                rbenv init
                rbenv install 3.0.0
                notify-send " Provisioned and Configured"

                ;;
            41)
                print t "Shell Environment"
                git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
                ln -svf "$HOME"/dotfiles/topics/sh/profile "$HOME"/.profile
                ln -svf "$HOME"/dotfiles/topics/sh/aliases "$HOME"/.aliases
                yay -S --noconfirm --batchinstall --needed --sudoloop autojump
                notify-send " Provisioned and Configured"

                ;;
            42)
                print t "Secure Shell"
                sudo cp -rvf "$HOME"/dotfiles/topics/ssh/ssh_config /etc/ssh/
                sudo cp -rvf "$HOME"/dotfiles/topics/ssh/sshd_config /etc/ssh/
                sudo pacman -S --noconfirm openssh keychain seahorse
                notify-send " Provisioned and Configured"

                ;;

            43)
                print t "Sway Window Manager"

                yay -S --noconfirm --sudoloop --needed sway-borders-git swayidle grimshot wofi swaybg waybar wf-recorder autotiling nwg-launcher i3title swayimg swaylock wofer mako swaymgr swaytools i3keys

                mkdir -p "$HOME"/.config/sway

                ln -svf "$HOME"/dotfiles/topics/sway/config "$HOME"/.config/sway/config

                ln -svf "$HOME"/dotfiles/topics/sway/lockman.sh "$HOME"/.config/sway/lockman.sh

                ln -svf "$HOME"/dotfiles/topics/sway/window.sh "$HOME"/.config/sway/window.sh

                ln -svf "$HOME"/dotfiles/topics/sway/nwg-launchers "$HOME"/.config/nwg-launchers
                notify-send " Provisioned and Configured"

                ;;
            44)
                print t "Thinkpad E495 Settings"
                yay -S --noconfirm --sudoloop --needed tp_smapi tp-battery-mode thinkpad-scripts hdaps-gl tpfand-git threshy libthinkpad tp-battery-icon-git i2c-tools
                yay -S --noconfirm --sudoloop --needed cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor
                yay -S --noconfirm --sudoloop --needed ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa
                yay -S --noconfirm --sudoloop --needed opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git
                yay -S --noconfirm --sudoloop --needed zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call
                yay -S --noconfirm --sudoloop --needed tlp powertop acpid tlp-rdw acpi acpid acpica acpitool
                sudo systemctl enable auto-cpufreq.service
                sudo systemctl enable acpid.service
                sudo systemctl enable --now tp-battery-mode.service
                sudo systemctl enable --now cpupower.service
                sudo systemctl enable --now lm_sensors.service
                sudo systemctl enable --now ryzen-stabilizator.service
                sudo systemctl enable --now tuned.service
                sudo systemctl enable --now tlp
                tuned-adm profiles laptop-ac-powersave
                sudo mkinitcpio -Psv
                sudo grub-mkconfig -o /boot/grub/grub.conf

                notify-send " Provisioned and Configured"

                ;;
            45)
                print t "Vim Modal Text Editor"
                yay -S --noconfirm --sudoloop --needed vim vi sudo vim-runtime vim-spell-en

                git clone https://github.com/Thomashighbaugh/vim ~/.vim
                ln -s ~/.vim/vimrc ~/.vimrc
                cd ~/.vim && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                vim +PlugUpdate +qa

                # Personal Vimwiki
                git clone https://github.com/Thomashighbaugh/vimwiki
                notify-send "Vim Modal Text Editor Provisioned and Configured"

                ;;
            46)
                print t "Virt-Manager"
                yay -S --noconfirm --sudoloop --needed virt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi vagrant python-vagrant

                ## Enable the Daemon
                sudo systemctl enable --now libvirtd
                sudo systemctl enable --now virtnetworkd.service
                sudo systemctl enable --now virtinterfaced.service
                sudo systemctl enable --now virtqemud.service
                sudo systemctl enable --now libvirtd-admin.socket
                notify-send "Virt-Manager Provisioned and Configured"

                ;;
            47)
                print t "Virtualbox VM Type 2 Hypervisor"
                yay -S --noconfirm --sudoloop --needed virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies
                notify-send "Virtualbox VM Type 2 Hypervisor Provisioned and Configured"
                ;;
            48)
                print t "vmware Workstation Type 2 Hypervisor"
                yay -S --noconfirm --sudoloop createvm open-vm-tools vmware-workstation vagrant-vmware-utility libview vmware-auto-unlocker-git vmware-modules-dkms-git vmware-component-extractor-git
                sudo modprobe -a vmw_vmci vmmo notify-send "vmware Workstation Type 2 Hypervisor Provisioned and Configured"

                ;;
            49)
                print t "X11 Window Server"

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
                notify-send "X11 Window Server Provisioned and Configured"
                ;;

            50)
                print t "ZSH shell"
                ## Install Necessary Packages
                yay -S --noconfirm --sudoloop --needed zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw
                yay -S --noconfirm --sudoloop --needed zsh-syntax-highlighting zsh-lovers zsh-autosuggestions
                yay -S --noconfirm --sudoloop --needed alias-tips-git zsh-system-clipboard-git zsh-doc powerline zsh-history-substring-search zshdb find-the-command
                yay -S --noconfirm --sudoloop zsh-completions keybase-zsh-completion-git python-click-completion
                ## Symlink Files
                ln -svf "$HOME"/dotfiles/topics/zsh/zprofile "$HOME"/.zprofile
                ln -svf "$HOME"/dotfiles/topics/zsh/zshenv "$HOME"/.zshenv
                ln -svf "$HOME"/dotfiles/topics/zsh/zshrc "$HOME"/.zshrc
                ln -svf "$HOME"/dotfiles/topics/zsh/zlogout "$HOME"/.zlogout
                notify-send "ZSH shell Provisioned and Configured"
                ;;
            51)
                exit
                ;;
            esac
        done
    done
}

deps
menu
