#!/bin/bash
#
#
# This is for installing the packages I use on my system, taken from what was installed, hence the huge list.
# ---------------------------------------------------------------------------- #############################################################
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"
# ---------------------------------------------------------------------------- #
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
installPackages() {
    bypass() {
        sudo -v
        while true; do
            sudo -n true
            sleep 45
            kill -0 "$$" || exit
        done 2>/dev/null &
    }

    set e

    print t "Starting Void Linux Package Installation"
    sleep 3s
    bypass
    clear

    print s "Updating system and adding repositories..."
    sleep 3s
    sudo xbps-install -Syu
    sudo xbps-install -Sy void-repo-nonfree
    sudo xbps-install -Sy vvoid-repo-multilib
    sudo xbps-install -Sy void-repo-multilib-nonfree
    sudo xbps-install -Sy void-repo-debug
    clear

    print s "Installing packages..."
    sleep 3s
    # ---------------------------------------------------------------------------- #

    print s "Services [stock installed - dhcpcd udevd]"
    sleep 3s
    sudo xbps-install -Syv dbus dbus-elogind elogind polkit

    # ---------------------------------------------------------------------------- #

    print s "Power Management"
    sleep 3s
    sudo xbps-install -Syv acpid rtkit tlp
    # ---------------------------------------------------------------------------- #

    print s "cpu and gpu firmware modules"
    sleep 3s
    sudo xbps-install -Syv mesa MesaLib MesaLib-devel glu glu-devel libgbm libgbm-devel mesa-dri mesa-ati-dri mesa mesa-dbg mesa-opencl amdvlk xf86-video-amdgpu linux-firmware-amd

    # ---------------------------------------------------------------------------- #

    print s "Compiler"
    sleep 3s
    sudo xbps-install -Syv gcc gcc-ada libgcc-devel libgcc gcc-objc gcc-objc++ gcc-objc-multilib qrintf
    sudo xbps-install -Syv cmake cmake-vala extra-cmake-modules gccmakedep leatherman leatherman-devel meson-cmake-wrapper leatherman-32bit leatherman-devel
    sudo xbps-install -Syv acr pkg-config pkgconf libpkgconf libopkg libopkg autoconf automake autoconf-archive perl-Config-AutoConf
    sudo xbps-install -Syv linux-tools gperf libtool
    # ---------------------------------------------------------------------------- #

    print s "Development"
    sleep 3s
    sudo xbps-install -Syv go python3-devel sshd uuid python2-devel ruby-devel lua-devel lgi logstalgia lua51-lgi lua52-lgi lua54-lgi
    sudo pip3 install hererocks
    sudo xbps-install -Syv vscode
    sudo xbps-install -Syv curl ninja make
    # ---------------------------------------------------------------------------- #

    print s "Window Manager / Desktop Environment"
    sleep 3s
    sudo xbps-install -Syv awesome rofi light kitty rofi-devel libnotify libnotify-devel libXScrnSaver-devel
    sudo xbps-install -Syv ruby-asciidoctor xcb-util-xrm-devel startup-notification-devel
    sudo xbps-install -Syv xcb-util-keysyms xcb-util-keysyms-devel xcb-util-cursor-devel xcb-util-cursor
    sudo xbps-install -Syv xcb-util-wm-devel startup-tools libxdg-basedir-devel
    sudo xbps-install -Syv luarocks gettext gettext-devel zathura zathura-cb zathura-devel zathura-pdf-mupdf zathura-ps mupdf
    sudo luarocks install ldoc
    # ---------------------------------------------------------------------------- #
    prnt s "Network"
    sleep 3s
    sudo xbps-install -Syv NetworkManager
    sudo xbps-install -Syv linux-firmware-network #FREE, easy to use implementation of the Network Time Protocol
    sudo xbps-install -Syv openntpd openresolv
    sudo xbps-remove -oyv dhcpcd

    #wireguard #https://www.wireguard.com/install/
    #sudo xbps-install -Syv wireguard-tools wireguard-dkms

    sudo xbps-install -Syv networkmanager-dmenu
    # ---------------------------------------------------------------------------- #
    print s "Bluetooth"
    sleep 3s
    sudo xbps-install -Syv bluez
    sudo xbps-install -Syv libspa-bluetooth                  #Server and user space API to deal with multimedia pipelines - bluetooth plugins
    sudo xbps-install -Syv sbc                               #Bluetooth Subband Codec (SBC) library
    sudo xbps-install -Syv broadcom-bt-firmware libbluetooth #Library to use the Bluez Linux Bluetooth Stack
    sudo xbps-install -Syv hidapi                            #Simple library for communicating with USB and Bluetooth HID devices
    sudo xbps-install -Syv blueman                           #GTK+ Bluetooth Manager
    sudo xbps-install -Syv bluez-alsa                        #Bluetooth Audio ALSA Backend

    # ---------------------------------------------------------------------------- #
    print s "Audio"
    sleep 3s
    sudo xbps-install -Syv alsa-utils pulseaudio alsa-plugins-pulseaudio pamixer playerctl ncpamixer
    sudo xbps-install -Syv alsa-firmware alsa-lib alsa-plugins alsa-plugins-ffmpeg pavucontrol
    #spotify
    sudo xbps-install -Syv spotify-tui spotifyd

    # ---------------------------------------------------------------------------- #
    print s "Multimedia"
    sleep 3s
    sudo xbps-install -Syv imv mpv
    sudo xbps-install -Syv blender
    sudo xbps-install -Syv darktable
    sudo xbps-install -Syv gstreamer gst-libav gst-plugins-good gst-plugins-bad gst-plugins-base gst-plugins-ugly
    sudo xbps-install -Syv ffmpeg
    sudo xbps-install -Syv ImageMagick libmagick libmagick-devel
    sudo xbps-install vlc gimp gimp-devel gimp-lqr-plugin gmic-gimp gimp-python resynthesizer ufraw-gimp libgimp xsane-gimp

    # ---------------------------------------------------------------------------- #
    print s "Passwords"
    sleep 3s
    sudo xbps-install -Syv keepassxc

    # ---------------------------------------------------------------------------- #
    print s "Internet"
    sleep 3s
    sudo xbps-remove -y firefox-esr
    sudo xbps-install -Sy dhcpcd-gtk wpa_gui
    sudo xbps-install -Syv firefox elinks luakit
    sudo xbps-install -Syv transmission-gtk

    # ---------------------------------------------------------------------------- #
    print s "Privacy"
    sudo xbps-install -Syv ufw gufw
    sudo xbps-install -Syv dnscrypt-proxy

    # ---------------------------------------------------------------------------- #
    print s "System utilities"
    sleep 3s
    #sudo xbps-install -Syv numlockx
    sudo xbps-install -Syv rsync
    sudo xbps-install -Syv gnome-disk-utility
    sudo xbps-install -Syv gparted #issues with wayland.
    sudo xbps-install -Syv autofs  # automount usb
    sudo xbps-install -Syv xeyes   # show X11 or Wayland
    sudo xbps-install -Syv xev     # show key press
    sudo xbps-install -Syv dconf-editor
    sudo xbps-install -Syv ntfs-3g #Stable Read/Write NTFS Driver in userspace
    # ---------------------------------------------------------------------------- #
    print s "Terminal"
    sudo xbps-install -Syv neofetch wget git gotop tty-clock calcurse vitetris
    sudo xbps-install -Syv bash-completion
    sudo xbps-install -yv ranger # file manager
    sudo xbps-install -Syv vsv   # runit helper
    sudo xbps-install -Syv vpm   # another package management option
    sudo xbps-install -Syv vpsm  #wrapper for xbps-src

    # ---------------------------------------------------------------------------- #
    print s "Android"
    sudo xbps-install -Syv android-tools

    # ---------------------------------------------------------------------------- #
    #print s "Nvidia"
    #sleep 3s
    #nvidia - https://docs.voidlinux.org/config/graphics/optimus.html
    #sudo xbps-install -Syv nvidia glxinfo

    # ---------------------------------------------------------------------------- #
    print s "Flatpak"
    sudo xbps-install -Syv flatpak
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # ---------------------------------------------------------------------------- #
    print s "Fonts"
    sudo xbps-install -Syv font-Siji font-firacode font-hack-ttf termsyn-font

    # ---------------------------------------------------------------------------- #

    clear

    sleep 3s

    # ---------------------------------------------------------------------------- #
    print s "Configuring system..."
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

    # ---------------------------------------------------------------------------- #
    # print s "Disable unecassary tty services"
    sudo rm -f /var/service/agetty-tty{3,4,5,6}
    sudo touch /var/service/agetty-tty{3,4,5,6}/down
    # ---------------------------------------------------------------------------- #
    # print s "auto login"
    #sudo sed -i "s/--noclear/--noclear\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf

    # ---------------------------------------------------------------------------- #
    # print s  "Bluetooth Configuration"
    sudo sed -i 's/' #AutoEnable=false'/'AutoEnable=true'/g' /etc/bluetooth/main.conf
    sudo sed -i 's/' #DiscoverableTimeout = 0'/'DiscoverableTimeout = 180'/g' /etc/bluetooth/

    # network setup
    sudo resolvconf -u
    #sudo ufw default deny
    #sudo ufw allow from 192.168.0.0/24
    #sudo ufw logging off
    #sudo ufw enable

    # system clock
    sudo hwclock --systohc

    # fix swap
    sudo mkdir /etc/sysctl.d/
    print s 'vm.swappiness=120' | sudo tee /etc/sysctl.d/99-swappiness.conf

    # fix text
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
    # ---------------------------------------------------------------------------- #
    # Numlock at boot
    #for tty in /dev/tty[1-6]*;
    #	do
    #	setleds -D +num < $tty > /dev/null
    #done
    # ---------------------------------------------------------------------------- #
    print s "Adding user to some groups..."
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

    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "Setup Needed Directories"
    print s "####################################################"
    sleep 3s
    mkdir -p ~/.config
    mkdir -p ~/.local/share/bin
}
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
clonePackages() {
    print t "####################################################"
    print t "Git Cloning of Out-of-Repo Packages"
    print t "####################################################"
    sleep 3s
    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "Go Autolock"
    print s "####################################################"
    sleep 3s
    git clone https://gitlab.com/mrvik/goautolock "$HOME"/goautolock
    cd "$HOME"/goautolock && sudo make && cd "$HOME" && rm -rvf goautolock
    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "XDEB"
    print s "####################################################"
    sleep 3s
    git clone https://github.com/toluschr/xdeb "$HOME"/xdeb
    cd "$HOME"/xdeb && sudo chmod 744 xdeb/xdeb && sudo mv xdeb /usr/local/bin/ && cd "$HOME" && rm xdeb
    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "AwesomeWM"
    print s "####################################################"
    sleep 3s
    git clone https://github.com/awesomewm/awesome "$HOME"/awesome
    cd "$HOME"/awesome && sudo make && sudo make install && cd "$HOME" && rm -rvf awesome

    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "Greenclip"
    print s "####################################################"
    sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip /usr/local/bin/greenclip
    # ---------------------------------------------------------------------------- #
    print s "####################################################"
    print s "Notes"
    print s "####################################################"
    sleep 3s
    curl -Ls https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | sudo bash
    echo
    print t "Cloning Out of Repo Packages is Complete"

}
function Repos() {
    print w "# ---------------------------------------------------------------------------- #####"
    print w Beginning Repository Cloning
    print w "# ---------------------------------------------------------------------------- #####"
    print s Awesome Window Manager
    git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome
    print s "####################################################"
    print s Cloning Grub2 Theme
    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme && sh "$HOME"/.local/share/Bhairava-Grub-Theme/install.sh
    print s "####################################################"
    print s Cloning bin Scripts
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin
    print s "####################################################"
    print s Installing the Latest Neovim, with Packer and then Configuring It
    git clone https://github.com/neovim/neovim "$HOME"/neovim && cd "$HOME"/neovim && sudo make CMAKE_BUILD_TYPE=Release install && cd .. && rm "$HOME"/neovim
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://github.com/Thomashighbaugh/nvim "$HOME"/.config/nvim
    print s "####################################################"
    print s Cloning and Installing ZSH Configuration
    git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && cd "$HOME"/.zsh && sh install
    print s "####################################################"
    print s Cloning Icon Theme and GTK Theme, then Building the GTK Theme and Installing
    sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
    git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ~/.local/share/themes/Dhumavati-Theme && cd ~/.local/share/themes/Dhumavati-Theme && sudo make build && sudo make install
    print s "####################################################"
    print s Cloning QTile Configuration
    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
    print s "####################################################"
    print s Cloning and Patching Firefox
    git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox && cd /tmp/firefox && sh install.sh
    print s "####################################################"
    print s Cloning LightDM Theme
    git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme
}
function Dotfiles() {
    ## Symlinks
    print t "####################################################"
    print t "Dotfiles Setup"
    print t "####################################################"
    print s "####################################################"
    print s "Shells"
    print s "####################################################"
    ln -svf "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
    ln -svf "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
    ln -svf "$HOME"/dotfiles/home/shell/profile "$HOME"/.profile
    ln -svf "$HOME"/dotfiles/home/shell/aliases "$HOME"/.aliases
    print s "####################################################"
    print s "Quality of Life"
    print s "####################################################"
    print s "####################################################"
    print s "X11"
    print s "####################################################"
    mkdir -p "$HOME"/.Xresources.d
    ln -svf "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
    ln -svf "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
    ln -svf "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
    ln -svf "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
    ln -svf "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
    ln -svf "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
    ln -svf "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
    ln -svf "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
    print s "####################################################"
    print s "Zathura"
    print s "####################################################"

    print s "####################################################"
    print s "GTK"
    print s "####################################################"
    mkdir -p "$HOME"/.config/gtk
    print s "####################################################"
    print s "Background Images"
    print s "####################################################"
    sudo ln -svf "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
    sudo cp -rvf "$HOME"/dotfiles/root/images/* /usr/share/backgrounds
    print s "####################################################"
    print s "Picom"
    print s "####################################################"
    mkdir -p "$HOME"/.config/picom
    ln -svf "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config
    print s "####################################################"
    print s "Rofi"
    print s "####################################################"
    mkdir -p "$HOME"/.config/rofi
    ln -svf "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
    ln -svf "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
    ln -svf "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
    ln -svf "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
    print s "####################################################"
    print s "Dunst"
    print s "####################################################"
    mkdir -p "$HOME"/.config/dunst
    ln -svf "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
    print s "####################################################"
    print s "Kitty"
    print s "####################################################"
    mkdir -p "$HOME"/.config/kitty
    ln -svf "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
    ln -svf "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf
    print s "####################################################"
    print s "Alacritty"
    print s "####################################################"
    mkdir -p "$HOME"/.config/alacritty
    ln -svf "$HOME"/dotfiles/home/alacritty/alacritty.yml "$HOME"/.config/alacritty/alacritty.yml
    print s "####################################################"
    print s "Fontconfig"
    print s "####################################################"
    ln -svf "$HOME"/dotfiles/home/fontconfig "$HOME"/.config/fontconfig
    print t "####################################################"
    print t "####################################################"
    print t "####################################################"
    print t "Root Modifications"
    print s "####################################################"
    print s "Desktop File"
    print s "####################################################"
    sudo cp -rvf "$HOME"/dotfiles/root/desktop/* /usr/share/applications
    print s "####################################################"
    print s "Docker"
    print s "####################################################"
    sudo cp -rvf "$HOME"/dotfiles/root/docker /etc/
    print s "####################################################"
    print s "System Optimization Tweaks"
    print s "####################################################"
    sudo cp -rvf "$HOME"/dotfiles/root/etc/* /etc/
    print s "####################################################"
    print s "luakit"
    print s "####################################################"
    ln -svf "$HOME"/dotfiles/home/luakit "$HOME"/.config/luakit
}
installPackages
clonePackages
Repos
Dotfiles
