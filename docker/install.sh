#!/usr/bin/env bash
#  _______               __          __ __
# |_     _|.-----.-----.|  |_.---.-.|  |  |
#  _|   |_ |     |__ --||   _|  _  ||  |  |
# |_______||__|__|_____||____|___._||__|__|
################################################################################
# Thomas Leon Highbaugh
# Dotfiles Installer

###############################################################################
## Colors & Print Functions ###################################################
###############################################################################
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
#########################################################
## System Operation Functions
#########################################################
SYSCTL() {
    sudo systemctl enable --now "$1"
    return
}

PACIN() {
    while (($# > 0)); do
        sudo pacman --sync --sysupgrade --refresh --noconfirm --needed "$1"
        shift
    done
    return
}

YAYIN() {
    while (($# > 0)); do
        yay --sync --sysupgrade --refresh --noconfirm --needed "$1"
        shift
    done
    return
}

#########################################################
## Main Menu
#########################################################

#########################################################
## Core Dependencies
#########################################################
function deps() {
    print t "###########################################################"
    print t "Core Dependencies"
    print t "###########################################################"
    echo
    echo
    print s "###########################################################"
    print s "Set up local directories"
    print s "###########################################################"
    mkdir -p "$HOME"/Pictures "$HOME"/.local/share "$HOME"/.config "$HOME"/.cache "$HOME"/.local/lib "$HOME"/Desktop "$HOME"/Documents "$HOME"/Downloads

    print s "###########################################################"
    print s "Adding Keys"
    print s "###########################################################"
    
    gpg --receive-keys EC3CBE7F607D11E663149E811D1F0DC78F173680
    
    print s "###########################################################"
    print s "Package Dependencies Installation"
    print s "###########################################################"
    
    PACIN git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu
    
    PACIN atool autoconf autocutsel automake binutils bison libnotify
    
    PACIN gcc gcc-libs gettext glibc dialog dmidecode
    
    PACIN keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed
    
    print s "###########################################################"
    print s "Install Yay"
    print s "###########################################################"
    print
    if [ ! -x "$(command -v 'yay')" ]; then
        PACIN git base-devel
        TEMPORARY=$PWD/temp
        mkdir "$TEMPORARY"
        git clone 'https://aur.archlinux.org/yay.git' "$TEMPORARY/yay"
        cd "$TEMPORARY/yay" || exit
        makepkg -si
        cd "$WD" || exit
    else
        print s "Yay has been installed"
    fi
    print
    print t "###########################################################"
    print t "Dependencies Have Been Installed"
    print t "###########################################################"
    
    print
    print
}

#########################################################
## Hardware
#########################################################

function hardware() {
                    YAYIN amd-ucode ryzenadj-git zenstates-git
                    sudo grub-mkconfig -o /boot/grub/grub.conf
                    sudo mkinitcpio -P
                    YAYIN gpart gparted mtools nilfs-utils ntfs-3g polkit
                    YAYIN dosfstools findutils gzip lzip p7zip tar
                    YAYIN bzip2 lzop udftools cpio file file-roller filesystem gnome-disk-utility
                    YAYIN diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
                    YAYIN gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop unace
                    YAYIN gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
                    YAYIN gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs
                    print t "Disks and Archive Management Provisioned" #calls groups function
                    print t "#################################################"
                    print t "Nvidia Firmware and Drivers"
                    print t "#################################################"
                    YAYIN nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers
                    YAYIN cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1
                    YAYIN nvtop opencl-nvidia nvidia-utils nvidia-container-runtime
                    print t " Provisioned and Configured"
                     print t "#################################################"
                     print t "Performance Tweaks"
                    print t "#################################################"
                    sudo cp -rvf $HOME/dotfiles/root/etc/* /etc/
                    print t "#################################################"
                    print t "Raspberry Pi 4"
                    print t "#################################################"
                    YAYIN linux-raspberrypi4-aarch64 linux-raspberrypi4-aarch64-headers argonone-git
                    print t " Provisioned and Configured"
                    
                    print t "#################################################"
                    print t "Thinkpad E495 Settings"
                    print t "#################################################"
                    YAYIN tp_smapi tp-battery-mode hdaps-gl tpfand-git threshy libthinkpad i2c-tools
                    YAYIN cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor
                    YAYIN ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa
                    YAYIN opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git
                    YAYIN zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call
                    YAYIN tlp powertop acpid tlp-rdw acpi acpid acpica acpitool
                    sudo systemctl enable auto-cpufreq.service
                    sudo systemctl enable acpid.service
                    SYSCTL cpupower.service
                    SYSCTL lm_sensors.service
                    SYSCTL ryzen-stabilizator.service
                    SYSCTL tuned.service
                    SYSCTL tlp
                    tuned-adm profiles laptop-ac-powersave
                    sudo mkinitcpio -Psv
                    sudo grub-mkconfig -o /boot/grub/grub.conf
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Bluetooth Interfacing"
                    print t "#################################################"
                    YAYIN blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez
                    print t "Bluetooth Interfacing Provisioned"
}

#########################################################
## TUI
#########################################################

function TUI() {
                    print t "#################################################"
                    print t "BASH shell"
                    print t "#################################################"
                    ## Install Packages
                    PACIN bash shellharden bashlint argbash bash-bats-support bash-bats beautysh bashlint
                    ## Link Files
                    ln -svf "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
                    ln -svf "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
                    print t "BASH Shell Configured"
                    print t "#################################################"
                    print t "Docker Container Environment"
                    print t "#################################################"
                    print s "Installing the Docker-related programs"
                    YAYIN docker docker-compose docker-machine python-docker containerd
                    sudo usermod -aG docker "$USER"
                    print s "Enable the Daemon"
                    SYSCTL docker.service
                    SYSCTL docker.socket
                    print s "Copy the Daemon configuration file for Experimental Mode Features."
                    sudo ln -f "$HOME"/dotfiles/root/docker/daemon.json /etc/docker
                    print t "Docker Container Environment"
                    print t "#################################################"
                    print t "GPG Key Configuration"
                    print t "#################################################"
                    
                    PACIN gnupg gmime3 libcryptui seahorse mcabber hopenpgp-tools
                    ln -svf "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
                    print t "GPG Key Configuration Provisioned"
                    print t "#################################################"
                    print t "Git Version Control"
                    print t "#################################################"
                    
                    # Enter your git credentials once, forget it for the rest of the install
                    git config --global credential.helper store
                    ln -svf "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
                    ln -svf "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
                    print t "Git Version Control Provisioned and Configured"
                    print t "#################################################"
                    print t "Grub Bootloader"
                    print t "#################################################"
                    
                    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme
                    sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/svg2png.sh
                    sudo sh "$HOME"/.local/share/Bhairava-Grub-Theme/set-grub.sh
                    print t "Grub Bootloader Provisioned and Configured"
                    print t "#################################################"
                    print t "Hosts File"
                    print t "#################################################"
                    
                    sudo cp /etc/hosts /etc/hosts.backup
                    sudo wget https://someonewhocares.org/hosts/hosts -O /etc/hosts
                    sudo bash -c "cat hosts /etc/hosts | sponge /etc/hosts"
                    print t "Hosts File Provisioned and Configured"
                    print t "#################################################"
                    print t "HTOP Process Monitor"
                    print t "#################################################"
                    
                    PACIN htop
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "LXD Container Environment"
                    print t "#################################################"
                    YAYIN lxd lxc lxcfs lxc-templates
                    SYSCTL lxc
                    SYSCTL lxc-auto
                    SYSCTL lxcfs
                    SYSCTL containerd
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Makepkg Package Build System"
                    print t "#################################################"
                    YAYIN makepkg-tidy-scripts-git makepkg-meta remakepkg
                    
                    sudo cp -rvf "$HOME"/dotfiles/root/makepkg/makepkg.conf /etc/makepkg.conf
                    
                    print t "Makepkg Package Build System Provisioned and Configured"
                    print t "#################################################"
                    print t "Message of the Day"
                    print t "#################################################"
                    sudo ln -svf "$HOME"/dotfiles/root/motd/motd /etc/motd
                    sudo ln -vf "$HOME"/dotfiles/root/motd/motd.sh /etc/motd.sh
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Neofetch System Information Display"
                    print t "#################################################"
                    PACIN neofetch
                    ln -svf "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch
                    print t "Neofetch System Information Display Provisioned and Configured"
                    print t "#################################################"
                    print t "Node Version Manager"
                    print t "#################################################"
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
                    sh -c "nvm install node && nvm use node && nvm install 12 && nvm install 10"
                    sh -c "npm install --global yarn"
                    print t "Node Version Manager Provisioned and Configured"
                    print t "#################################################"
                    print t "Pacman Modifications, Hooks and Extensions"
                    print t "#################################################"
                    sudo rm -rvf /etc/pacman.conf
                    sudo cp -rvf "$HOME"/dotfiles/root/pacman/pacman.conf /etc/pacman.conf
                    YAYIN systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms pacman-kernel-install-git
                    YAYIN smkinitcpio-modconf-hook-git mkinitcpio-archiso-git systemd-removed-services-hook
                    print t "Pacman Modifications, Hooks and Extensions Provisioned and Configured"
                    print t "#################################################"
                    print t "Ranger File Manager"
                    print t "#################################################"
                    YAYIN ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Shell Environment"
                    print t "#################################################"
                    print s "Installing personal scripts"
                    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
                    print s "Configurations for All Shells"
                    ln -vf "$HOME"/dotfiles/home/sh/profile "$HOME"/.profile
                    ln -vf "$HOME"/dotfiles/home/sh/aliases "$HOME"/.aliases
                    YAYIN autojump
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Secure Shell"
                    print t "#################################################"
                    sudo cp -rvf "$HOME"/dotfiles/root/ssh/ssh_config /etc/ssh/
                    sudo cp -rvf "$HOME"/dotfiles/root/ssh/sshd_config /etc/ssh/
                    PACIN openssh keychain seahorse
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Vim Modal Text Editor"
                    print t "#################################################"
                    YAYIN vim vi sudo vim-runtime vim-spell-en python-pip python2-pip  ripgrep fzf ranger
                    print s "Installing Neovim Nightly"
                    git clone https://github.com/neovim/neovim && cd neovim && sudo make CMAKE_BUILD_TYPE=Release install && cd .. && rm neovim
                    pip install neovim pynvim --user
                    pip2 install neovim pynvim --user
                    print s "Personal Vim Configuration"
                    git clone https://github.com/Thomashighbaugh/vim ~/.vim
                    print s "Linking Personal Configuration with System"
                    ln -s ~/.vim/vimrc ~/.vimrc
                    ln -s ~/.vim/vimrc ~/.config/nvim/init.vim
                    print s "Downloading Plugin Manager"
                    cd ~/.vim && curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
                    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
                    print s "Installing Plugins"
                    vim +PlugUpdate +qa
                    print t "#################################################"
                    print s "Installing NeoVim Configuration"
                    git clone https://github.com/Thomashighbaugh/nvim "$HOME"/.config/nvim
                    print s "Installing Neovim Package Manager"
                    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
                    print s "Installing Neovim Plugins"
                    (nvim -u "$HOME"/.config/nvim/init.lua +PackerInstall)
                    print t "#################################################"
                    print t "Personal Vimwiki"
                    git clone https://github.com/Thomashighbaugh/vimwiki ~/.vimwiki
                    ln -svf .vimwiki .vimwiki-tech
                    ln -svf .vimwiki vimwiki
                    print t "Vim Modal Text Editor Provisioned and Configured"
                    YAYIN wtfutil
                    ln -svf "$HOME"/dotfiles/home/wtf/config.yml "$HOME"/.config/wtf/config.yml
                    print t "#################################################"
                    print t "X11 Window Server"
                    print t "#################################################"
                    YAYIN xorg xorg-apps xorg-drivers xorg-fonts
                    YAYIN pa-applet-git gnome-keyring polkit-gnome libgnome-keyring xscreensaver
                    mkdir -p "$HOME"/.Xresources.d
                    ln -svf "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
                    ln -svf "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
                    ln -svf "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
                    ln -svf "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
                    ln -svf "$HOME"/dotfiles/home/xorg/uxterm "$HOME"/.Xresources.d/uxterm
                    ln -svf "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
                    ln -svf "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
                    ln -fvs "$HOME"/dotfiles/home/xorg/xinitrc "$HOME"/.xinitrc
                    ln -fvs "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
                    ln -fvs "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
                    ln -fvs "$HOME"/dotfiles/home/xorg/xsessionrc "$HOME"/.xsessionrc
                    print t "X11 Window Server Provisioned and Configured"
                    print t "#################################################"
                    print t "ZSH shell"
                    print t "#################################################"
                    YAYIN zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw
                    YAYIN zsh-syntax-highlighting zsh-lovers zsh-autosuggestions
                    YAYIN alias-tips-git zsh-system-clipboard-git zsh-doc powerline zsh-history-substring-search zshdb find-the-command
                    YAYIN zsh-completions keybase-zsh-completion-git python-click-completion
                    ## Symlink Files
                    git clone https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh
                    sh "$HOME"/.zsh/install.sh
                    wait 5
                    print t "ZSH shell Provisioned and Configured"
}
#########################################################
## GUI
#########################################################
function GUI() {
                    print t "#################################################"
                    print t "Awesome Window Manager"
                    print t "#################################################"
                    YAYIN awesome-git feh xcape light lua-coxpcall maim
                    
                    YAYIN vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus
                    
                    YAYIN luarocks awmtt caja
                    
                    YAYIN zathura zathura-pdf-mupdf zathura-ps youtube-dl
                    
                    ln -svf "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura
                    
                    if [[ -r "$HOME/.config/awesome" ]]; then
                        rm -rvf "$HOME"/.config/awesome
                    fi
                    ## Install My Configuration
                    git clone https://github.com/Thomashighbaugh/awesomewm "$HOME"/.config/awesome
                    return
                    print t "Awesome Window Manager Provisioned and Configured"
                    print t "#################################################"
                    print t "BSP Window Manager"
                    print t "#################################################"
                    
                    YAYIN bspwm-rounded-corners-git bsp-layout sxhkd-git bar-aint-recursive xtitle-git sutils-git
                    ln -svf "$HOME"/dotfiles/home/bspwm "$HOME"/.config/bspwm
                    mkdir "$HOME"/.config/sxhkd
                    ln -svf "$HOME"/dotfiles/home/bspwm/sxhkdrc "$HOME"/.config/sxhkd
                    print t "BSP Window Manager Provisioned and Configured"
                    print t "#################################################"
                    print t "GTK Window Theming"
                    print t "#################################################"
                    
                    YAYIN gtk-engine-murrine gtk-engines xfce4-settings qt5ct kvantum colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkd gtkglarea libfm-gtk3
                    mkdir -p "$HOME"/.config/gtk-2.0
                    ln -svf "$HOME"/dotfiles/home/gtk/gtk-2.0/gtkfilechooser.ini "$HOME"/.config/gtk-2.0/gtkfilechooser.ini
                    mkdir -p "$HOME"/.config/gtk-3.0
                    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
                    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
                    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
                    ln -svf "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
                    ln -svf "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
                    sudo ln -svf "$HOME"/dotfiles/root/images /usr/share/backgrounds
                    mkdir -p "$HOME"/.config/Kvantum
                    ln -svf "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig
                    print t "GTK Window Theming Provisioned and Configured"
                    print t "#################################################"
                    print t "Picom Desktop Compostitor"
                    print t "#################################################"
                    YAYIN picom-ibhagwan-git
                    ln -svf "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config
                    print t "Picom Desktop Compostitor Provisioned and Configured"
                    print t "#################################################"
                    print t "Qtile Window Manager"
                    print t "#################################################"
                    YAYIN qtile rofi-git sensors
                    ## Clone and Provision my QTile Configuration
                    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
                    print t "QTile Provisioned and Configured"
                    print t "#################################################"
                    print t "Rofi Menu Script"
                    print t "#################################################"
                    YAYIN rofi-git
                    sudo pip install python-rofi
                    mkdir -p "$HOME"/.config/rofi
                    ln -svf "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi
                    ln -svf "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi
                    sudo ln -svf "$HOME"/dotfiles/home/rofi/themes /usr/share/rofi
                    ln -svf "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
                    ln -svf "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
                    sudo cp -rvf "$HOME"/dotfiles/home/rofi/rofi-todo /usr/bin
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Sway Window Manager"
                    print t "#################################################"
                    YAYIN sway-borders-git swayidle grimshot wofi swaybg waybar wf-recorder autotiling nwg-launcher i3title swayimg swaylock wofer mako swaymgr swaytools i3keys
                    mkdir -p "$HOME"/.config/sway
                    ln -svf "$HOME"/dotfiles/home/sway/config "$HOME"/.config/sway/config
                    ln -svf "$HOME"/dotfiles/home/sway/lockman.sh "$HOME"/.config/sway/lockman.sh
                    ln -svf "$HOME"/dotfiles/home/sway/window.sh "$HOME"/.config/sway/window.sh
                    ln -svf "$HOME"/dotfiles/home/sway/autostart.sh "$HOME"/.config/sway/autostart.sh
                    ln -svf "$HOME"/dotfiles/home/sway/nwg-launchers "$HOME"/.config/nwg-launchers
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Lightdm"
                    print t "#################################################"
                    YAYIN lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
                    
                    sudo ln -f "$HOME"/dotfiles/root/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf
                    
                    sudo ln -f "$HOME"/dotfiles/root/lightdm/lightdm.conf /etc/lightdm/lightdm.conf
                    
                    print t "Lightdm Provisioned and Configured"
}

#########################################################
## APPs
#########################################################

function APPs() {
                    print t "#################################################"
                    print t "Bitwarden Password Manager"
                    print t "#################################################"
                    YAYIN bitwarden keepassxc
                    print t "#################################################"
                    print t "Caja File Manager"
                    print t "#################################################"
                    YAYIN caja engrampa caja-extensions-common python-caja caja-xattr-tags caja-share caja-sendto caja-open-terminal caja-image-converter
                    YAYIN caja-dropbox gtkhash-caja caja-rename
                    print t "#################################################"
                    print t "CUPs Printer Interfacing"
                    print t "#################################################"
                    YAYIN cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
                    SYSCTL cups
                    print t "#################################################"
                    print t "Dunst Notification System"
                    print t "#################################################"
                    print s "Installing Dunst"
                    YAYIN dunst
                    print s "Linking Dunst Configuration Files"
                    ln -svf "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
                    print t "#################################################"
                    print t "Firefox Internet Browser"
                    print t "#################################################"
                    YAYIN firefox firefox-nightly
                    git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox
                    sudo chmod +x /tmp/firefox
                    sh /tmp/firefox/install.sh
                    print t "#################################################"
                    print t "Fonts"
                    print t "#################################################"
                    YAYIN bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 awesome-terminal-fonts nerd-fonts-complete fontconfig sdl2_ttf t1lib birdfont
                    sudo fc-cache -vf
                    fc-cache -vf
                    print t "#################################################"
                    print t "GIMP Image Editor"
                    print t "#################################################"
                    YAYIN gimp gimp-plugin-gmic xsane gimp-plugin-registry gimp-extras gimp-paint-studio
                    print t "#################################################"
                    print t "Inkscape SVG Editor"
                    print t "#################################################"
                    YAYIN inkscape
                    print t "#################################################"
                    print t "Kitty Terminal Emulator"
                    print t "#################################################"
                    
                    PACIN kitty kitty-terminfo catimg
                    if [[ -r "$HOME/.config/kitty" ]]; then
                        rm -rvf "$HOME"/.config/kitty
                    fi
                    mkdir -p "$HOME"/.config/kitty
                    sudo ln -sf "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
                    sudo ln -sf "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf
                    sudo ln -sf "$HOME"/dotfiles/home/motd/motd /etc/motd
                    
                    print t "#################################################"
                    print t "Network Manager"
                    print t "#################################################"
                    YAYIN network-manager-applet networkmanager
                    
                    print t "#################################################"
                    print t "Pulse Audio"
                    print t "#################################################"
                    YAYIN pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeicon
                    print t "#################################################"
                    print t "Virt-Manager"
                    print t "#################################################"
                    YAYIN virt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi vagrant python-vagrant
                    ## Enable the Daemons
                    SYSCTL libvirtid
                    SYSCTL virtnetworkd.service
                    SYSCTL virtinterfaced.service
                    SYSCTL virtqemud.service
                    SYSCTL libvirtd-admin.socket
                    
                    print t "#################################################"
                    print t "Virtualbox VM Type 2 Hypervisor"
                    print t "#################################################"
                    YAYIN virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies
                    print t "#################################################"
                    print t "vmware Workstation Type 2 Hypervisor"
                    print t "#################################################"
                    YAYIN createvm open-vm-tools vmware-workstation vagrant-vmware-utility libview vmware-auto-unlocker-git vmware-modules-dkms-git vmware-component-extractor-git
                    sudo modprobe -a vmw_vmci vmmo
                    
}
#########################################################
## Dev
#########################################################
function Dev() {
                    print t "#################################################"
                    print t "Python"
                    print t "#################################################"
                    YAYIN python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv
                    print t "#################################################"
                    print t "Lua Programming Language"
                    print t "#################################################"
                    YAYIN lua-dbi lua-socket luakit luarocks luakit lua-socket lua-dbi
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Ruby Programming Language"
                    print t "#################################################"
                    YAYIN rbenv rbenv-binstubs ruby-sassc chruby ruby-build
                    rbenv init
                    rbenv install 3.0.0:w
                    print t " Provisioned and Configured"
                    print t "#################################################"
                    print t "Rust Programming Language"
                    print t "#################################################"
                    YAYIN rustup rust-docs lib32-rust-libs rust-racer rust-analyzer
                    print t " Provisioned and Configured"
}

#############################################################################
## Main Menu
#############################################################################
print t "#################################################"
print t "Dotfiles Installer Script"
print t "#################################################"
print
print
print



deps
hardware
Dev
APPs
TUI
GUI
