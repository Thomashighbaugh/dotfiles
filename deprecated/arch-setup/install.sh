#!/usr/bin/env bash
#  _______               __          __ __
# |_     _|.-----.-----.|  |_.---.-.|  |  |
#  _|   |_ |     |__ --||   _|  _  ||  |  |
# |_______||__|__|_____||____|___._||__|__|
# ---------------------------------------------------------------------------- #
# Thomas Leon Highbaugh
# Dotfiles Installer
# ---------------------------------------------------------------------------- #
# ------------------------------ Print Function ----------------------------- #
# ---------------------------------------------------------------------------- #
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
# ---------------------------------------------------------------------------- #
# ----------------------------- Install Functions ---------------------------- #
# ---------------------------------------------------------------------------- #
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
# ---------------------------------------------------------------------------- #
# ------------------------------- Core Packages ------------------------------ #
# ---------------------------------------------------------------------------- #

function Core() {
    print t "#################################################"
    print t "Core Packages"
    print t "#################################################"
    sudo pacman -Syyu
    sudo pacman -S git vi vim base-devel libsecret org.freedesktop.secrets perl-cgi tk gnome-keyring gnome-disk-utility

    git clone https://aur.archlinux.org/yay && cd yay && makepkg -si && cd .. && rm -rvf yay
    # ---------------------------------------------------------------------------- #
    # Filesystems and Archives
    YAYIN diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize
    YAYIN gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop unace
    YAYIN gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2
    YAYIN gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs bleachbit

    # ---------------------------------------------------------------------------- #

    sudo cp /etc/hosts /etc/hosts.backup
    sudo wget https://someonewhocares.org/hosts/hosts -O /etc/hosts
    sudo bash -c "cat hosts /etc/hosts | sponge /etc/hosts"
    # ---------------------------------------------------------------------------- #
    # Python
    YAYIN python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv
    # ---------------------------------------------------------------------------- #
    # Ruby
    YAYIN rbenv rbenv-binstubs ruby-sassc chruby ruby-build
    rbenv init
    rbenv install 3.0.0
    # ---------------------------------------------------------------------------- #
    # rust
    YAYIN rustup rust-docs lib32-rust-libs rust-racer rust-analyzer
    rustup install stable
    rustup default stable

}
# ---------------------------------------------------------------------------- #
# ----------------------------- Hardware Packages ---------------------------- #
# ---------------------------------------------------------------------------- #
function Hardware() {
    print t "#################################################"
    print t "Hardware Packages"
    print t "#################################################"

    # AMD Processors
    YAYIN hipcpu-git zenpower-dkms-git zenmonitor ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa amd-ucode ryzenadj-git opencl-amd mhwd-amdgpu zenstates-git tpc-git amdcovc rapl-read-ryzen-git perf-tools-git smartmontools tlp powertop acpi acpid

    # Nvidia Cards
    #    YAYIN nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1 nvtop opencl-nvidia nvidia-utils nvidia-container-runtime

    # Bluetooth
    YAYIN blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez

}
# ---------------------------------------------------------------------------- #
# --------------------------- Terminal Packages -------------------------- #
# ---------------------------------------------------------------------------- #
function TUI() {
    print t "#################################################"
    print t "Terminal Packages"
    print t "#################################################"

    # Shell
    ln -svf "$HOME"/dotfiles/home/shell/profile "$HOME"/.profile
    ln -svf "$HOME"/dotfiles/home/shell/aliases "$HOME"/.aliases
    # ---------------------------------------------------------------------------- #
    # BASH
    YAYIN bash shellharden bashlint argbash bash-bats-support bash-bats beautysh bashlint bash-completion
    ln -svf "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
    ln -svf "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
    # ---------------------------------------------------------------------------- #
    # ZSH
    YAYIN zsh openrc-zsh-completions zsh-completions
    git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && cd "$HOME"/.zsh && sh install
    # ---------------------------------------------------------------------------- #
    # Scripts
    git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin

    # ---------------------------------------------------------------------------- #
    # Xorg
    YAYIN xorg xorg-apps xorg-drivers xorg-fonts
    YAYIN pa-applet-git gnome-keyring polkit-gnome libgnome-keyring xscreensaver

    mkdir -p "$HOME"/.Xresources.d
    ln -svf "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
    ln -svf "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
    ln -svf "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
    ln -svf "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
    ln -svf "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
    ln -svf "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
    ln -svf "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
    ln -svf "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
    xrdb -merge "$HOME"/.Xresources
    # ---------------------------------------------------------------------------- #
    # GPG
    YAYIN kgpg python-gnupg gpgkeymgr python-gpgme qgpgme distribution-gpg-keys gpg-tools-git python-gpgme ruby-gpgme-1 agent-transfer pam_exec-gpg backupd gpgsync gpg-tools-git
    ln -svf "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
    # ---------------------------------------------------------------------------- #
    # Git
    ln -svf "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
    ln -svf "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
    # ---------------------------------------------------------------------------- #
    #  Message of the Day
    sudo ln -svf "$HOME"/dotfiles/root/motd/motd /etc/motd
    # ---------------------------------------------------------------------------- #
    # Neofetch
    YAYIN neofetch
    ln -svf "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch
    # ---------------------------------------------------------------------------- #
    # SSH
    YAYIN openssh-openrc openssh
    sudo ln -svf "$HOME"/dotfiles/root/ssh/ssh_config /etc/ssh
    sudo ln -svf "$HOME"/dotfiles/root/ssh/sshd_config /etc/ssh
    # ---------------------------------------------------------------------------- #
    # Docker
    YAYIN docker docker-openrc python-docker python-docker-pycreds python-dockerpty docker-compose-cli docker-local-persist-bin containerd
    sudo rc-update docker default
    sudo ln -f "$HOME"/dotfiles/root/docker/daemon.json /etc/docker
    # ---------------------------------------------------------------------------- #
    # HTOP
    YAYIN htop
    # ---------------------------------------------------------------------------- #
    # makepkg
    YAYIN makepkg-tidy-scripts-git makepkg-meta remakepkg makepkg-optimize svgo optipng oxipng
    sudo cp -rvf "$HOME"/dotfiles/root/makepkg/makepkg.conf /etc/makepkg.conf
    # ---------------------------------------------------------------------------- #
    # Neofetch
    ln -svf "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch
    # ---------------------------------------------------------------------------- #
    #  NVM
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
    bash -c "nvm install node &&  nvm install 14 && nvm install 12 && nvm use node"
    sh -c "npm install --global yarn"
    # ---------------------------------------------------------------------------- #
    # Organize
    YAYIN organize classifier-git
    # ---------------------------------------------------------------------------- #
    # Pacman
    YAYIN grub-hook kernel-modules-hook mkinitcpio-kms
    # ---------------------------------------------------------------------------- #
    # Ranger
    YAYIN ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks
    # ---------------------------------------------------------------------------- #
    # NeoVIm
    YAYIN vim vi sudo vim-runtime vim-spell-en python-pip python2-pip ripgrep fzf neovim-nightly-bin
    pip install neovim pynvim --user
    pip2 install neovim pynvim --user
    gem install neovim
    sudo npm i -g neovim
    git clone https://github.com/Thomashighbaugh/nvim "$HOME"/.config/nvim
    print s "Installing Neovim Package Manager"
    git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    (nvim -u "$HOME"/.config/nvim/init.lua +PackerInstall)

}
# ---------------------------------------------------------------------------- #
# -------------------------- Graphical Packages -------------------------- #
# ---------------------------------------------------------------------------- #
function GUI() {
    print t "#################################################"
    print t "Graphical Packages"
    print t "#################################################"

    # AwesomeWM
    YAYIN awesome-git feh xcape light awmtt goautolock
    git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome
    # ---------------------------------------------------------------------------- #
    # Rofi
    YAYIN rofi
    mkdir -p "$HOME"/.config/rofi
    ln -svf "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
    ln -svf "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
    ln -svf "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
    ln -svf "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
    # ---------------------------------------------------------------------------- #
    # Font Config
    YAYIN fontconfig-infinality-remix
    ln -svf "$HOME"/dotfiles/home/fontconfig "$HOME"/.config/fontconfig

    # ---------------------------------------------------------------------------- #
    # Kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    mkdir -p "$HOME"/.config/kitty
    ln -svf "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
    ln -svf "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf

    # ---------------------------------------------------------------------------- #
    # Picom
    YAYIN picom-jonaburg-fix
    mkdir -p "$HOME"/.config/picom
    ln -svf "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config
    # ---------------------------------------------------------------------------- #
    # GTK
    YAYIN gtk-engine-murrine gtk-engines xfce4-settings qt5ct kvantum colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkglarea libfm-gtk3
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
    ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
    ln -svf "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
    mkdir -p "$HOME"/.config/Kvantum/Kvantum
    ln -svf "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig

    # ---------------------------------------------------------------------------- #
    # Zathura
    YAYIN zathura-git libzathura-git zathura-djvu-git zathura-pdf-mupdf-git zathura-cb-git libmupdf mupdf-tools
    ln -svf "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura

    # ---------------------------------------------------------------------------- #
    # Firefox
    YAYIN firefox-bin
    git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox && cd /tmp/firefox && sh install.sh
    # ---------------------------------------------------------------------------- #
    # Icons
    sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
    # ---------------------------------------------------------------------------- #
    # GTK Theme
    git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ~/.local/share/themes/Dhumavati-Theme && cd ~/.local/share/themes/Dhumavati-Theme && sudo make build && sudo make install
    # ---------------------------------------------------------------------------- #
    # Lightdm
    YAYIN lightdm-webkit-greeter
    git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme
    # ---------------------------------------------------------------------------- #
    # Qtile
    YAYIN qtile-git
    git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile

    # ---------------------------------------------------------------------------- #
    # GRUB
    git clone https://github.com/the-Electric-Tantra-Linux/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme && cd "$HOME"/.local/share/Bhairava-Grub-Theme && sh install.sh || exit

    # ---------------------------------------------------------------------------- #
    # Caja
    YAYIN caja engrampa caja-extensions-common python-caja caja-xattr-tags caja-share caja-sendto caja-open-terminal caja-image-converter
    YAYIN caja-dropbox gtkhash-caja caja-rename
    # ---------------------------------------------------------------------------- #
    # GIMP
    YAYIN gimp gimp-plugin-gmic xsane gimp-plugin-registry gimp-extras gimp-paint-studio xsane-gimp gimp-nufraw gimp-plugin-pandora gimp-plugin-bimp gimp-lensfun
    YAYIN gimp-font-rendering-fix
    # ---------------------------------------------------------------------------- #
    # Inkscape
    YAYIN inkscape-git inkscape-open-symbols-git inkscape-applytransforms-git inkscape-download-palette inkscape-generate-palette python-inkscape-figures
    # ---------------------------------------------------------------------------- #
    # Pulseaudio
    YAYIN pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeicon
    # ---------------------------------------------------------------------------- #
    # Virtual Box
    YAYIN virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies
}

# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #
# ---------------------------------------------------------------------------- #

print t "#################################################"
print t "Artix Install"
print t "#################################################"
function mainmenu() {
    while true; do
        choice=$(dialog --backtitle "Dotfiles Installer - Thomas Leon Highbaugh" \
            --title "Main Menu" \
            --clear \
            --nocancel \
            --menu "Choose one" 32 76 16 \
            "Core Packages" "- Start Here" \
            "Hardware" "- for Specific Systems" \
            "TUI" "- Shell Interfaces" \
            "GUI" "- Graphical Interfaces" \
            "Apps" "- Additional Applications" \
            "Dev" "- Useful for Development Purposes" \
            "Quit" "- Exit to desktop" 3>&1 1>&2 2>&3)

        case "$choice" in
        "Core Packages")
            Core
            ;;
        "Hardware")
            Hardware
            ;;
        "TUI")
            TUI
            ;;
        "GUI")
            GUI
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
dialog --title "Proceed?" \
    --backtitle "Post Installation Provisioning - the Electric Tantra Linux" \
    --yesno "Are You Ready to Begin?" 7 60
response=$?
case $response in
0) echo ;;
1) exit ;;
255) exit ;;
esac

mainmenu
