#!/bin/bash
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
        printf "%s\n" "${sb}${cg}[###]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}" | tee -a /tmp/install-log.txt
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    *)
        printf '%s\n' "$*" | tee -a /tmp/install-log.txt
        ;;
    esac
}
# ---------------------------------------------------------------------------- #
#                               Install Functions                              #
# ---------------------------------------------------------------------------- #
XIN() {
    while (($# > 0)); do
        sudo xbps-install -Syv "$1" | tee -a /tmp/install-log.txt
        shift
    done
    return
}
# ---------------------------------------------------------------------------- #
#                             Symlinking Function                              #
# ---------------------------------------------------------------------------- #
LINK() {
    ln -svf "$1" "$2" | tee -a /tmp/install-log.txt
}
SULINK() {
    sudo ln -svf "$1" "$2" | tee -a /tmp/install-log.txt
}
# ---------------------------------------------------------------------------- #
#                               Install Packages                               #
# ---------------------------------------------------------------------------- #
InstallPackages() {

    set e
    print t "[===================================================]"
    print t "Starting Void Linux Package Installation"
    print t "[===================================================]"
    sleep 3s

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Updating System and Adding Repositories"
    print s "[===================================================]"
    sleep 3s
    sudo xbps-install -Syu | tee -a /tmp/install-log.txt
    XIN void-repo-nonfree void-repo-multilib void-repo-multilib-nonfree void-repo-debug xtools

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Service Packages"
    print s "[===================================================]"
    sleep 3s
    XIN dbus dbus-elogind elogind polkit docker docker-cli docker keychain polkit-devel irqbalance

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Power Management"
    print s "[===================================================]"
    sleep 3s
    XIN acpid rtkit tlp
    sudo ln -svf /etc/sv/tlp /var/service

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Firmware Modules"
    print s "[===================================================]"
    sleep 3s
    XIN mesa glu-devel libgbm libgbm-devel mesa-dri mesa-ati-dri mesa mesa-dbg mesa-opencl amdvlk xf86-video-amdgpu linux-firmware-amd arandr

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Compiler"
    print s "[===================================================]"
    sleep 3s
    XIN gcc gcc-ada libgcc-devel libgcc gcc-objc gcc-objc++ gcc-objc-multilib qrintf cmake cmake-vala extra-cmake-modules gccmakedep leatherman leatherman-devel meson-cmake-wrapper leatherman-32bit leatherman-devel acr pkg-config pkgconf libpkgconf libopkg libopkg autoconf automake autoconf-archive perl-Config-AutoConf libuv-devel linux-tools gperf libtool

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Development"
    print s "[===================================================]"
    sleep 3s
    XIN python3-devel python-devel ruby-devel rbenv lua-devel lgi lua51-lgi lua52-lgi lua54-lgi go cmake zsh zsh-autosuggestions coreutils
    sudo pip3 install hererocks | tee -a /tmp/install-log.txt
    XIN vscode neovim tree-sitter curl ninja make wget
    rbenv install 3.0.0 | tee -a /tmp/install-log.txt

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Window Manager / Desktop Environment"
    print s "[===================================================]"
    sleep 3s
    XIN awesome rofi light kitty rofi-devel libnotify libnotify-devel libXScrnSaver-devel ruby-asciidoctor xcb-util-xrm-devel startup-notification-devel xcb-util-keysyms xcb-util-keysyms-devel xcb-util-cursor-devel xcb-util-cursor xcb-util-wm-devel startup-tools libxdg-basedir-devel luarocks gettext gettext-devel zathura zathura-cb zathura-devel zathura-pdf-mupdf zathura-ps mupdf gom gom-devel libpeas libpeas-devel lua53-cjson lua53-lgi lua53 lua-lpeg
    sudo luarocks install ldoc | tee -a /tmp/install-log.txt
    sudo luarocks install luacheck | tee -a /tmp/install-log.txt
    sudo luarocks install luaposix | tee -a /tmp/install-log.txt
    sudo luarocks install luasec | tee -a /tmp/install-log.txt
    sudo luarocks install luafilesystem | tee -a /tmp/install-log.txt

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Network"
    print s "[===================================================]"
    sleep 3s
    XIN NetworkManager linux-firmware-network openntpd openresolv networkmanager-dmenu
    sudo xbps-remove -oyv dhcpcd
    #wireguard #https://www.wireguard.com/install/
    #XIN wireguard-tools wireguard-dkms

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Bluetooth"
    print s "[===================================================]"
    sleep 3s
    XIN bluez libspa-bluetooth sbc broadcom-bt-firmware libbluetooth hidapi blueman bluez-alsa

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Audio"
    print s "[===================================================]"
    sleep 3s
    XIN alsa-utils pulseaudio alsa-plugins-pulseaudio pamixer playerctl ncpamixer
    XIN alsa-firmware alsa-lib alsa-plugins alsa-plugins-ffmpeg pavucontrol
    XIN spotify-tui spotifyd

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Multimedia"
    print s "[===================================================]"
    sleep 3s
    XIN imv mpv gst-libav ffmpeg ImageMagick libmagick libmagick-devel vlc gimp gimp-devel gimp-lqr-plugin gmic-gimp gimp-python resynthesizer ufraw-gimp libgimp xsane-gimp

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Passwords"
    print s "[===================================================]"
    sleep 3s
    XIN keepassxc

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Internet"
    print s "[===================================================]"
    sleep 3s
    sudo xbps-remove -y firefox-esr
    XIN dhcpcd-gtk wpa_gui firefox elinks luakit transmission-gtk

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Privacy"
    print s "[===================================================]"
    XIN dnscrypt-proxy ufw gufw

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "System utilities"
    print s "[===================================================]"
    sleep 3s
    #XIN numlockx
    XIN rsync fzf xrdb xrdb-dbg libcanberra-devel libcanberra-utils libcanberra-gtk gnome-disk-utility gparted autofs xeyes xev xcape maim xdg-desktop-portal xdg-desktop-portal-gtk xdgmenumaker dconf-editor ntfs-3g #Stable Read/Write NTFS Driver in userspace

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Terminal"
    print s "[===================================================]"
    sleep 3s
    XIN neofetch wget git gotop tty-clock calcurse vitetris bash-completion ranger vsv vpm

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Android"
    print s "[===================================================]"
    sleep 3s
    XIN android-tools android-udev-rules android-file-transfer-linux abootimg scrcpy smali

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
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo | tee -a /tmp/install-log.txt

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fonts"
    print s "[===================================================]"
    sleep 3s
    XIN font-Siji font-firacode font-hack-ttf termsyn-font

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Configuring system..."
    print s "[===================================================]"
    sleep 3s
    SULINK /etc/sv/dbus /var/service/
    SULINK /etc/sv/elogind /var/service/
    SULINK /etc/sv/polkitd /var/service/
    SULINK /etc/sv/irqbalance /var/service
    SULINK /etc/sv/ntpd /var/service/
    SULINK /etc/sv/docker /var/service
    SULINK /etc/sv/rtkit /var/service/
    #SULINK /etc/sv/sshd /var/service/
    SULINK /etc/sv/uuid /var/service/
    SULINK /etc/sv/alsa /var/service/
    SULINK /etc/sv/bluetoothd /var/service/
    SULINK /etc/sv/ufw /var/service/
    #SULINK /etc/sv/dnscrypt-proxy /var/service/
    sudo rm -rvf /var/service/acpid | tee -a /tmp/install-log.txt
    sudo rm -rvf /var/service/dhcpcd | tee -a /tmp/install-log.txt
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Disable unecassary tty services"
    print s "[===================================================]"
    sleep 3s
    sudo rm -f /var/service/agetty-tty{3,4,5,6} | tee -a /tmp/install-log.txt
    sudo touch /var/service/agetty-tty{3,4,5,6}/down | tee -a /tmp/install-log.txt
    # print s "auto login"
    #sudo sed -i "s/--no/--no\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Bluetooth Configuration"
    print s "[===================================================]"
    sleep 3s
    sudo sed -i 's/\#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/\#DiscoverableTimeout = 0/DiscoverableTimeout = 180/g' /etc/bluetooth/ | tee -a /tmp/install-log.txt
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Network Setup"
    print s "[===================================================]"
    sleep 3s
    sudo resolvconf -u
     sudo ufw default deny
     sudo ufw allow from 192.168.0.0/24
    sudo ufw allow from 192.168.0.1
    # Adjust to local pihole address if present
    #    sudo ufw allow from 192.168.0.12
     sudo ufw logging off
     sudo ufw enable

    # ---------------------------------------------------------------------- #
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Bleachbit"
    print s "[===================================================]"
    sleep 3s
    XIN bleachbit
    git clone https://github.com/mm2048/org.bleachbit.cleaners $HOME/org.bleachbit.cleaners
    cd "$HOME"/org.bleachbit.cleaners && sudo cp -rvf * /usr/share/bleachbit/cleaners/ && cd .$HOME && rm -rvf org.bleachbit.cleaners

    # ---------------------------------------------------------------------- #
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Blackbox"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/StackExchange/blackbox "$HOME"/blackbox
    cd "$HOME"/blackbox && sudo make copy-install && cd .. && rm -rvf blackbox
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "System Clock"
    print s "[===================================================]"
    sleep 3s
    sudo hwclock --systohc | tee -a /tmp/install-log.txt

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print "Fix Swappiness"
    print s "[===================================================]"
    sleep 3s
    sudo mkdir /etc/sysctl.d/
    print s 'vm.swappiness=90' | sudo tee -a /etc/sysctl.d/99-swappiness.conf

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fix Text"
    print s "[===================================================]"
    sleep 3s
    SULINK /usr/share/fontconfig/conf.avail/10-hinting-full.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/30-metric-aliases.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/51-local.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/60-latin.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/60-generic.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/69-unifont.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/80-delicious.conf /etc/fonts/conf.d/
    SULINK /usr/share/fontconfig/conf.avail/90-synthetic.conf /etc/fonts/conf.d/

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
    sudo usermod -a -G input "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G audio "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G video "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G rfkill "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G power "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G bluetooth "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -a -G pulse-access "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -aG libvirt "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -aG kvm "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -aG socklog "$USER" | tee -a /tmp/install-log.txt
    sudo usermod -aG docker "$USER" | tee -a /tmp/install-log.txt

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
    print s "XDEB"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/toluschr/xdeb "$HOME"/xdeb
    cd "$HOME"/xdeb && sudo chmod -Rv 744 xdeb && sudo mv xdeb /usr/local/bin/
    cd "$HOME" && rm -rvf xdeb

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "AwesomeWM"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/awesomewm/awesome "$HOME"/awesome
    cd "$HOME"/awesome && sudo make && sudo make install
    cd "$HOME" && sudo rm -rvf awesome
    SULINK /usr/local/bin/awesome /usr/bin
    SULINK /usr/local/bin/awesome-client /usr/bin

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Greenclip"
    print s "[===================================================]"
    sleep 3s
    sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip
    sudo mv -vf greenclip /usr/local/bin
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "NVM"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.nvm
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
    #   /bin/bash -c  "echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.bashrc  \
    #&& echo '[ -s "$NVM_DIR/nvm.sh" ]' >> ~/.bashrc  \
    # && echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"'  >> ~/.bashrc \
    #&& nvm install node" &
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Tym"
    print s "[===================================================]"
    sleep 3s
    XIN gtk2-engines gtk3-nocsd gtkd gtkd-devel gtkdatabox3 gtkdatabox3-devel gtkglext gtkglext-devel cairomm-devel pangomm-devel gtkmm-devel gtkmm2 gtkmm2-devel gtkmm4 gtkmm4-devel libvted-3.9.0_6 libvted-devel-3.9.0_6 evtest evtest-qt libvterm-devel vte3-devel wget tmux tmux-xpanes tmuxc tmux-mem-cpu-load python3-tmuxp
    wget https://github.com/endaaman/tym/releases/download/3.2.0/tym-3.2.0.tar.gz
    tar -xf tym-3.2.0.tar.gz
    cd tym-3.2.0.tar.gz && ./configure && sudo make install && cd .. && rm tym*
    LINK "$HOME"/dotfiles/home/tym/ "$HOME"/.config

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

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning Grub2 Theme
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme
    bash "$HOME"/.local/share/Bhairava-Grub-Theme/install.sh

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning bin Scripts
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Installing the Latest Neovim, with Packer and then Configuring It"
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://github.com/Thomashighbaugh/nvim-forge "$HOME"/.config/nvim

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning and Installing ZSH Configuration
    print s "[===================================================]"
    sleep 3s
    XIN zsh zsh-autosuggestions zsh-completions zsh-history-substring-search
    git clone https://github.com/clvv/fasd "$HOME"/fasd
    cd "$HOME"/fasd && sudo make install
    rm -rvf "$HOME"/fasd
    git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && cd "$HOME"/.zsh && sh install
    chsh tlh
    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "GTK Theme & Icon Theme"
    print s "[===================================================]"
    sleep 3s
    sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
    git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ~/.local/share/themes/Dhumavati-Theme
    wget https://github.com/the-Electric-Tantra-Linux/Dhumavati-Theme/releases/download/release/Dhumavati-White-Dark_.tar.xz
    tar -xf Dhumavati-White-Dark_.tar.xz
    sudo cp -rvf Dhumavati-White-Dark/* /usr/share/themes
    LINK $HOME/dotfiles/home/gtk/gtk-3.0/colors.css $HOME/.config/gtk-3.0/colors.css
    LINK $HOME/dotfiles/home/gtk/gtk-3.0/gtk.css $HOME/.config/gtk-3.0/gtk.css
    mkdir -p $HOME/.icons/default
    LINK $HOME/dotfiles/home/icons/index.theme $HOME/.icons/default/
    LINK /usr/share/icons/chhinamasta $HOME/.icons/default/cursors

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
    git clone https://github.com/Thomashighbaugh/firefox "$HOME"/firefox
    bash "$HOME"/firefox/install.sh stable && rm -rvf "$HOME"/firefox

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s Cloning LightDM Theme
    print s "[===================================================]"
    sleep 3s
    git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme "$HOME"/.local/share/mahakali-webkit2-theme
    cd "$HOME"/.local/share/mahakali-webkit2-theme && sudo bash install.sh

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
    LINK "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
    LINK "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
    LINK "$HOME"/dotfiles/home/shell/profile "$HOME"/.profile
    LINK "$HOME"/dotfiles/home/shell/aliases "$HOME"/.aliases

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Quality of Life"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.gnupg/
    LINK "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
    LINK "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
    LINK "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
    SULINK "$HOME"/dotfiles/root/motd/motd /etc/motd
    LINK "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "X11"
    print s "[===================================================]"
    sleep 3s
    XIN xorg-apps xorg xorg-fonts xorg-cf-files xorg-input-files xorg-server xorg-server-common xorg-server-xephyr xorg-server-xdmx xorg-server-devel xorg-video drivers xorgproto xorg-utils-macros xautolock
    mkdir -p "$HOME"/.Xresources.d
    LINK "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
    LINK "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
    LINK "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
    LINK "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
    LINK "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
    LINK "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
    LINK "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
    LINK "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
    xrdb -merge ~/.Xresources

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Zathura"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/zathura
    LINK "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "GTK"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/gtk-3.0
    LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
    LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
    LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
    LINK "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
    mkdir -p "$HOME"/.config/Kvantum/Kvantum
    LINK "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Background Images"
    print s "[===================================================]"
    sleep 3s
    SULINK "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
    sudo cp -rvf "$HOME"/dotfiles/root/images/* /usr/share/backgrounds

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Picom"
    print s "[===================================================]"
    sleep 3s
    LINK "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Rofi"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/rofi/themes
    LINK "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
    LINK "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
    LINK "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
    LINK "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Dunst"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/dunst
    LINK "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Kitty"
    print s "[===================================================]"
    sleep 3s
    mkdir -p "$HOME"/.config/kitty
    LINK "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
    LINK "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Fontconfig"
    print s "[===================================================]"
    sleep 3s
    LINK "$HOME"/dotfiles/home/fontconfig "$HOME"/.config/fontconfig
    # ---------------------------------------------------------------------- #
    print t "[===================================================]"
    print t "Root Modifications"
    print t "[===================================================]"
    sleep 3s

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "System Optimization Tweaks"
    print s "[===================================================]"
    sleep 3s
    sudo cp -rvf "$HOME"/dotfiles/root/etc/* /etc/

    # ---------------------------------------------------------------------- #
    print s "[===================================================]"
    print s "Luakit Web Browser"
    print s "[===================================================]"
    sleep 3s
    LINK "$HOME"/dotfiles/home/luakit "$HOME"/.config/luakit

}

# ---------------------------------------------------------------------------- #
#                                   Main Menu                                  #
# ---------------------------------------------------------------------------- #
function mainmenu() {
    while true; do
        choice=$(dialog --backtitle "Dotfiles Installer - Thomas Leon Highbaugh" \
            --title "Main Menu" \
            -- \
            --nocancel \
            --menu "Choose one" 32 126 16 \
            "Install Packages" "- Software Available Within This Configuration" \
            "Clone Packages" "- Out of Repository Software Installation" \
            "Other Repos" "- Configurations for Programs Saved in Their Own Repositories" \
            "Dotfiles" "- Symlink Configuration Files From This Repository to the System's Expected Locations" \
            "Reboot" "- When Finished, Restart Your System For Best Results." \
            "Quit" "- Exit to desktop" 3>&1 1>&2 2>&3)

        case "$choice" in
        "Install Packages")
            InstallPackages
            ;;
        "Clone Packages")
            ClonePackages
            ;;
        "Other Repos")
            ConfigurationRepositories
            ;;
        "Dotfiles")
            Dotfiles
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
