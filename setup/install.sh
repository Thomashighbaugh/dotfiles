#!/bin/bash
#  _____         __    ___ __ __
# |     \.-----.|  |_.'  _|__|  |.-----.-----.
# |  --  |  _  ||   _|   _|  |  ||  -__|__ --|
# |_____/|_____||____|__| |__|__||_____|_____|
# ---------------------------------------------------------------------------- #
#  _______               __          __ __         __   __
# |_     _|.-----.-----.|  |_.---.-.|  |  |.---.-.|  |_|__|.-----.-----.
#  _|   |_ |     |__ --||   _|  _  ||  |  ||  _  ||   _|  ||  _  |     |
# |_______||__|__|_____||____|___._||__|__||___._||____|__||_____|__|__|
# ---------------------------------------------------------------------------- #
#
# Author: Thomas Leon Highbaugh (thighbaugh@zoho.com)
# Description: Menu driven tool to provision and configure a fresh installation of Void Linux
# Usage: ./install.sh from within the setup subdirectory or ./setup/install.sh from within the dotfiles directory
#
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
#                                Print Statement                               #
# ---------------------------------------------------------------------------- #
# Assign Terminal Color Variables
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"
# ---------------------------------------------------------------------------- #
# Statement providing color to the stdout
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
# ---------------------------------------------------------------------------- #
#                               Install Functions                              #
# ---------------------------------------------------------------------------- #
XIN() {
    while (($# > 0)); do
        sudo xbps-install -Syv "$1"
        shift
    done
    return
}
# ---------------------------------------------------------------------------- #
#                               Install Packages                               #
# ---------------------------------------------------------------------------- #
InstallPackages() {
    bypass() {
        sudo -v
        while true; do
            sudo -n true
            sleep 45
            kill -0 "$$" || exit
        done 2>/dev/null &
    }

    set e
    print t "[===================================================]"
    print t "Starting Void Linux Package Installation"
    print t "[===================================================]"
    sleep 3s
    bypass
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Updating System and Adding Repositories"
    print s "[===================================================]"
    sleep 3s
    sudo xbps-install -Syu
    XIN void-repo-nonfree
    XIN void-repo-multilib
    XIN void-repo-multilib-nonfree
    XIN void-repo-debug
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Service Packages"
    print s "[===================================================]"
    sleep 3s
    XIN dbus dbus-elogind elogind polkit
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Power Management"
    print s "[===================================================]"
    sleep 3s
    XIN acpid rtkit tlp
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Firmware Modules"
    print s "[===================================================]"
    sleep 3s
    XIN mesa glu-devel libgbm libgbm-devel mesa-dri mesa-ati-dri mesa mesa-dbg mesa-opencl amdvlk xf86-video-amdgpu linux-firmware-amd
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Compiler"
    print s "[===================================================]"
    sleep 3s
    XIN gcc gcc-ada libgcc-devel libgcc gcc-objc gcc-objc++ gcc-objc-multilib qrintf
    XIN cmake cmake-vala extra-cmake-modules gccmakedep leatherman leatherman-devel meson-cmake-wrapper leatherman-32bit leatherman-devel
    XIN acr pkg-config pkgconf libpkgconf libopkg libopkg autoconf automake autoconf-archive perl-Config-AutoConf libuv-devel
    XIN linux-tools gperf libtool
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Development"
    print s "[===================================================]"
    sleep 3s
    XIN python3-devel python-devel ruby-devel lua-devel lgi lua51-lgi lua52-lgi lua54-lgi go cmake
    sudo pip3 install hererocks
    XIN vscode
    XIN curl ninja make
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Window Manager / Desktop Environment"
    print s "[===================================================]"
    sleep 3s
    XIN awesome rofi light kitty rofi-devel libnotify libnotify-devel libXScrnSaver-devel ruby-asciidoctor xcb-util-xrm-devel startup-notification-devel xcb-util-keysyms xcb-util-keysyms-devel xcb-util-cursor-devel xcb-util-cursor xcb-util-wm-devel startup-tools libxdg-basedir-devel luarocks gettext gettext-devel zathura zathura-cb zathura-devel zathura-pdf-mupdf zathura-ps mupdf
    sudo luarocks install ldoc
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Network"
    print s "[===================================================]"
    sleep 3s
    XIN NetworkManager linux-firmware-network openntpd openresolv networkmanager-dmenu
    sudo xbps-remove -oyv dhcpcd
    #wireguard #https://www.wireguard.com/install/
    #XIN wireguard-tools wireguard-dkms
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Bluetooth"
    print s "[===================================================]"
    sleep 3s
    XIN bluez
    XIN libspa-bluetooth                  #Server and user space API to deal with multimedia pipelines - bluetooth plugins
    XIN sbc                               #Bluetooth Subband Codec (SBC) library
    XIN broadcom-bt-firmware libbluetooth #Library to use the Bluez Linux Bluetooth Stack
    XIN hidapi                            #Simple library for communicating with USB and Bluetooth HID devices
    XIN blueman                           #GTK+ Bluetooth Manager
    XIN bluez-alsa                        #Bluetooth Audio ALSA Backend
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Audio"
    print s "[===================================================]"
    sleep 3s
    XIN alsa-utils pulseaudio alsa-plugins-pulseaudio pamixer playerctl ncpamixer
    XIN alsa-firmware alsa-lib alsa-plugins alsa-plugins-ffmpeg pavucontrol
    #spotify
    XIN spotify-tui spotifyd
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Multimedia"
    print s "[===================================================]"
    sleep 3s
    XIN imv mpv gst-libav ffmpeg ImageMagick libmagick libmagick-devel vlc gimp gimp-devel gimp-lqr-plugin gmic-gimp gimp-python resynthesizer ufraw-gimp libgimp xsane-gimp
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Passwords"
    print s "[===================================================]"
    sleep 3s
    XIN keepassxc
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Internet"
    print s "[===================================================]"
    sleep 3s
    sudo xbps-remove -y firefox-esr
    XIN dhcpcd-gtk wpa_gui firefox elinks luakit transmission-gtk
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Privacy"
    print s "[===================================================]"
    XIN dnscrypt-proxy ufw gufw
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "System utilities"
    print s "[===================================================]"
    sleep 3s
    #XIN numlockx
    XIN rsync fzf xrdb xrdb-dbg
    XIN gnome-disk-utility gparted autofs xeyes xev xcape dconf-editor ntfs-3g #Stable Read/Write NTFS Driver in userspace
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Terminal"
    print s "[===================================================]"
    sleep 3s
    XIN neofetch wget git gotop tty-clock calcurse vitetris bash-completion ranger vsv vpm
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Android"
    print s "[===================================================]"
    sleep 3s
    XIN android-tools
    clear
    # ---------------------------------------------------------------------- #
    #print s "Nvidia"
    #sleep 3s
    #nvidia - https://docs.voidlinux.org/config/graphics/optimus.html
    #XIN nvidia glxinfo

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Flatpak"
    print s "[===================================================]"
    sleep 3s
    XIN flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fonts"
    print s "[===================================================]"
    sleep 3s
    XIN font-Siji font-firacode font-hack-ttf termsyn-font
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Configuring system..."
    print s "[===================================================]"
    sleep 3s

    sudo ln -s /etc/sv/dbus /var/service/
    sudo ln -s /etc/sv/elogind /var/service/
    sudo ln -s /etc/sv/polkitd /var/service/
    sudo ln -s /etc/sv/ntpd /var/service/

    sudo ln -s /etc/sv/rtkit /var/service/
    #sudo ln -s /etc/sv/sshd /var/service/
    sudo ln -s /etc/sv/uuid /var/service/

    sudo ln -s /etc/sv/alsa /var/service/
    sudo ln -s /etc/sv/bluetoothd /var/service/
    sudo ln -s /etc/sv/ufw /var/service/
    #sudo ln -s /etc/sv/dnscrypt-proxy /var/service/
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Disable unecassary tty services"
    print s "[===================================================]"
    sleep 3s
    sudo rm -f /var/service/agetty-tty{3,4,5,6}
    sudo touch /var/service/agetty-tty{3,4,5,6}/down
    clear
    # ---------------------------------------------------------------------- #
    # print s "auto login"
    #sudo sed -i "s/--noclear/--noclear\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Bluetooth Configuration"
    print s "[===================================================]"
    sleep 3s
    sudo sed -i 's/\#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf
    sudo sed -i 's/\#DiscoverableTimeout = 0/DiscoverableTimeout = 180/g' /etc/bluetooth/
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Network Setup"
    print s "[===================================================]"
    sleep 3s
    sudo resolvconf -u
    # sudo ufw default deny
    # sudo ufw allow from 192.168.0.0/24
    # sudo ufw logging off
    # sudo ufw enable
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "System Clock"
    print s "[===================================================]"
    sleep 3s
    sudo hwclock --systohc
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print "Fix Swappiness"
    print s "[===================================================]"
    sleep 3s
    sudo mkdir /etc/sysctl.d/
    print s 'vm.swappiness=90' | sudo tee /etc/sysctl.d/99-swappiness.conf
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fix Text"
    print s "[===================================================]"
    sleep 3s
    sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-full.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/30-metric-aliases.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/51-local.conf /etc/fonts/conf.d/
    udo ln -s /usr/share/fontconfig/conf.avail/60-latin.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/60-generic.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/69-unifont.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/80-delicious.conf /etc/fonts/conf.d/
    sudo ln -s /usr/share/fontconfig/conf.avail/90-synthetic.conf /etc/fonts/conf.d/
    clear
    # ---------------------------------------------------------------------- #
    # Numlock at boot
    #for tty in /dev/tty[1-6]*;
    #	do
    #	setleds -D +num < $tty > /dev/null
    #done
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Adding user to some groups..."
    print s "[===================================================]"
    sleep 3s
    sleep 3s
    sudo usermod -a -G input "$USER"
    sudo usermod -a -G audio "$USER"
    sudo usermod -a -G video "$USER"
    sudo usermod -a -G rfkill "$USER"
    sudo usermod -a -G power "$USER"
    sudo usermod -a -G bluetooth "$USER"
    sudo usermod -a -G pulse-access "$USER"
    sudo usermod -aG libvirt "$USER"
    sudo usermod -aG kvm "$USER"
    sudo usermod -aG socklog "$USER"
    clear

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Setup Needed Directories"
    print s "[===================================================]"
    sleep 3s
    sleep 3s
    mkdir -p ~/.config
    mkdir -p ~/.local/share/bin
}
# ---------------------------------------------------------------------------- #
#                                Clone Packages                                #
# ---------------------------------------------------------------------------- #
ClonePackages() {
    print t "[===================================================]"
    print t "Git Cloning of Out-of-Repo Packages"
    print t "[===================================================]"
    sleep 3s
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Go Autolock"
    print s "[===================================================]"
    sleep 3s
    git clone https://gitlab.com/mrvik/goautolock "$HOME"/goautolock
    cd "$HOME"/goautolock && sudo make
    cd "$HOME" && rm -rvf goautolock
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "XDEB"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/toluschr/xdeb "$HOME"/xdeb
    cd "$HOME"/xdeb && sudo chmod 744 xdeb/xdeb && sudo mv xdeb /usr/local/bin/
    cd "$HOME" && rm -rvf xdeb
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "AwesomeWM"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/awesomewm/awesome "$HOME"/awesome
    cd "$HOME"/awesome && sudo make && sudo make install
    cd "$HOME" && rm -rvf awesome
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Greenclip"
    print s "[===================================================]"
    sleep 3s
    sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip /usr/local/bin/greenclip
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Notes"
    print s "[===================================================]"
    sleep 3s
    curl -Ls https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | sudo bash
    echo
    print t "Cloning Out of Repo Packages is Complete"

}
# ---------------------------------------------------------------------------- #
#                           Confirmation Repositories                          #
# ---------------------------------------------------------------------------- #
function ConfigurationRepositories() {
    print t "[===================================================]"
    print t Beginning Repository Cloning
    print t "[===================================================]"
    sleep 3s
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Awesome Window Manager
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning Grub2 Theme
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme && sh "$HOME"/.local/share/Bhairava-Grub-Theme/install.sh
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning bin Scripts
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Installing the Latest Neovim, with Packer and then Configuring It"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/neovim/neovim "$HOME"/neovim
    cd "$HOME"/neovim && sudo make CMAKE_BUILD_TYPE=Release install
    cd "$HOME" && rm "$HOME"/neovim
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://github.com/Thomashighbaugh/nvim "$HOME"/.config/nvim
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning and Installing ZSH Configuration
    print s "[===================================================]"
    sleep 3s
    git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && cd "$HOME"/.zsh && sh install
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Cloning Icon Theme and GTK Theme, then Building the GTK Theme and Installing"
    print s "[===================================================]"
    sleep 3s
    sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
    git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ~/.local/share/themes/Dhumavati-Theme
    cd ~/.local/share/themes/Dhumavati-Theme && sudo make build && sudo make install
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning QTile Configuration
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning and Patching Firefox
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox && cd /tmp/firefox && sh install.sh
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning LightDM Theme
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme
    clear
}
# ---------------------------------------------------------------------------- #
#                                   Dotfiles                                   #
# ---------------------------------------------------------------------------- #
function Dotfiles() {
    ## Symlinks
    print t "[===================================================]"
    print t "Dotfiles Setup"
    print t "[===================================================]"
    sleep 3s
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Shells"
    print s "[===================================================]"
    sleep 3s
    ln -svf "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
    ln -svf "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
    ln -svf "$HOME"/dotfiles/home/shell/profile "$HOME"/.profile
    ln -svf "$HOME"/dotfiles/home/shell/aliases "$HOME"/.aliases
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Quality of Life"
    print s "[===================================================]"
    sleep 3s
    ln -svf "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
    ln -svf "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
    ln -svf "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
    sudo ln -svf "$HOME"/dotfiles/root/motd/motd /etc/motd
    ln -svf "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "X11"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.Xresources.d
    ln -svf "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
    ln -svf "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
    ln -svf "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
    ln -svf "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
    ln -svf "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
    ln -svf "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
    ln -svf "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
    ln -svf "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
    xrdb -merge ~/.Xresources
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Zathura"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/zathura
    ln -svf "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "GTK"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/gtk
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
    ln -svf "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
    mkdir -p "$HOME"/.config/Kvantum/Kvantum
    ln -svf "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Background Images"
    print s "[===================================================]"
    sleep 3s
    sudo ln -svf "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
    sudo cp -rvf "$HOME"/dotfiles/root/images/* /usr/share/backgrounds
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Picom"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/picom
    ln -svf "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Rofi"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/rofi
    ln -svf "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
    ln -svf "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
    ln -svf "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
    ln -svf "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Dunst"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/dunst
    ln -svf "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Kitty"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/kitty
    ln -svf "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
    ln -svf "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fontconfig"
    print s "[===================================================]"
    sleep 3s
    ln -svf "$HOME"/dotfiles/home/fontconfig "$HOME"/.config/fontconfig
    # ---------------------------------------------------------------------- #
    print t "[===================================================]"
    print t "Root Modifications"
    print s "[===================================================]"
    sleep 3s
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Desktop File"
    print s "[===================================================]"
    sleep 3s
    sudo cp -rvf "$HOME"/dotfiles/root/desktop/* /usr/share/applications
    clear
    print s "[===================================================]"
    print s "Docker"
    print s "[===================================================]"
    sleep 3s
    sudo cp -rvf "$HOME"/dotfiles/root/docker /etc/
    clear
    print s "[===================================================]"
    print s "System Optimization Tweaks"
    print s "[===================================================]"
    sleep 3s
    sudo cp -rvf "$HOME"/dotfiles/root/etc/* /etc/
    clear
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Luakit Web Browser"
    print s "[===================================================]"
    sleep 3s
    ln -svf "$HOME"/dotfiles/home/luakit "$HOME"/.config/luakit
    clear

}
# ---------------------------------------------------------------------------- #
#                                   Main Menu                                  #
# ---------------------------------------------------------------------------- #
function mainmenu() {
    while true; do
        choice=$(dialog --backtitle "Dotfiles Installer - Thomas Leon Highbaugh" \
            --title "Main Menu" \
            --clear \
            --nocancel \
            --menu "Choose one" 32 76 16 \
            "Install Packages" "- Software Available Within This Configuration" \
            "Clone Packages" "- Out of Repository Software Installation" \
            "Other Configuration Repositories" "- Configurations for Programs Saved in Their Own Repositories" \
            "Dotfiles" "- Symlink Configuration Files From This Repository to the System's Expected Locations" \
            "Quit" "- Exit to desktop" 3>&1 1>&2 2>&3)

        case "$choice" in
        "Install Packages")
            InstallPackages
            ;;
        "Clone Packages")
            ClonePackages
            ;;
        "Other Configuration Repositories")
            ConfigurationRepositories
            ;;
        "Dotfiles")
            Dotfiles
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
# ---------------------------------------------------------------------------- #
#                             Install Prerequisites                            #
# ---------------------------------------------------------------------------- #
sudo xbps-install -Syuv dialog
# ---------------------------------------------------------------------------- #
#                              Confirmation Dialog                             #
# ---------------------------------------------------------------------------- #
dialog --title "Proceed?" \
    --backtitle "Post Installation Provisioning - the Electric Tantra Linux" \
    --yesno "Are You Ready to Begin?" 7 60
response=$?
case $response in
0) mainmenu ;;
1) exit ;;
255) exit ;;
esac

# mainmenu

# ---------------------------------------------------------------------------- #
#                                      Fin                                     #
# ---------------------------------------------------------------------------- #
