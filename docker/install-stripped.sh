#!/bin/bash
# Installs all the packages together, which is not realistic or practical but easy to use to check docker for errors

PACIN() {
    while (($# > 0)); do
        sudo pacman --sync --sysupgrade --refresh --noconfirm --needed "$1"
        shift
    done
    return
}

        PACIN git base-devel
        TEMPORARY=$HOME/temp
        mkdir "$TEMPORARY"
        git clone 'https://aur.archlinux.org/yay.git' "$TEMPORARY/yay"
        cd "$TEMPORARY/yay" || exit
        makepkg -si

    PACIN git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

    PACIN atool autoconf autocutsel automake binutils bison libnotify

    PACIN gcc gcc-libs gettext glibc dialog dmidecode

    PACIN keychain grep ntp pacman-contrib pkgconf pkgfile pciutils sed


YAYIN() {
    while (($# > 0)); do
        yay --sync --sysupgrade --refresh --noconfirm --needed "$1"
        shift
    done
    return
}



YAYIN android-tools android-messages-desktop android-file-transfer android-udev jadx repo smali android-sdk-platform-tools android-sdk-build-tools android-apktool scrcpy android-bash-completion abootimg-git simg-tools sdat2img-git bootimgtool-git gpart gparted mtools nilfs-utils ntfs-3g polkit dosfstools findutils gzip lzip p7zip tar bzip2 lzop udftools cpio file file-roller filesystem gnome-disk-utility diskus xz e2fsprogs diskus coreutils dosfstools exfat-utils fatresize gvfs gvfs-afc gvfs-goa gvfs-google lostfiles lzop unace gvfs-gphoto2 gvfs-mtp gvfs-nfs lrzip hardinfo hddtemp bzip2 gvfs-smb xarchiver unrar unarj unzip borg btrfs-progs nvidia nvidia-dkms libvdpau nvidia-cg-toolkit pycuda-headers cuda cudnn mesa egl-wayland libxnvctrl ffnvcodec-headers8.1 nvtop opencl-nvidia nvidia-utils nvidia-container-runtime linux-raspberrypi4-aarch64 linux-raspberrypi4-aarch64-headers argonone-git tp_smapi tp-battery-mode hdaps-gl tpfand-git threshy libthinkpad i2c-tools  cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa amd-ucode ryzenadj-git opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call tlp powertop acpid tlp-rdw acpi acpid acpica acpitool blueberry blueman bluez-hid2hci bluez-tools bluez-utils python-pybluez docker docker-compose docker-machine python-docker containerd libsecret lxd lxc lxcfs lxc-templates makepkg-tidy-scripts-git makepkg-meta remakepkg organize  classifier-git  systemd-boot-pacman-hook grub-hook mirrorlist-rankmirrors-hook kernel-modules-hook mkinitcpio-kms mkinitcpio-modconf-hook-git mkinitcpio-archiso-git systemd-removed-services-hook ranger w3m ueberzug transmission-cli perl-image-exiftool odt2txt mediainfo lynx highlight elinks autojump vim vi sudo vim-runtime vim-spell-en python-pip python2-pip ripgrep fzf ranger wtfutil xorg xorg-apps xorg-drivers xorg-fonts pa-applet-git gnome-keyring polkit-gnome libgnome-keyring xscreensaver zsh alias-tips-git zsh-auto-notify zsh-doc lsd lshw zsh-syntax-highlighting zsh-lovers zsh-autosuggestions alias-tips-git zsh-system-clipboard-git zsh-doc powerline zsh-history-substring-search zshdb find-the-command zsh-completions keybase-zsh-completion-git python-click-completion  awesome-git feh xcape light vicious lain-git awesome-freedesktop-git archlinux-xdg-menu archlinux-menus luarocks awmtt thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman thunar-secure-delete thunar-dropbox bcompare-thunar thunarx-python thunar-custom-actions python-thunar-plugins-git zathura-git zathura-pdf-mupdf zathura-ps youtube-dl libzathura-git gtk-engine-murrine gtk-engines xfce4-settings qt5ct kvantum colord-gtk gst-plugin-gtk glade gtkglext gtkspell xdg-desktop-portal-gtk wxgtk3 gpg-crypter gtk-chtheme gtkd gtkglarea libfm-gtk3 picom-jonaburg-git qtile rofi-git sensors rofi-git lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-webkit2-greeter bitwarden keepassxc qt5-webkit firefox-extension-keepassxc-browser keepassxc-wordlists-hunspell keepassxc-client-library rofi-keepassxc-git git-credential-keepassxc caja engrampa caja-extensions-common python-caja caja-xattr-tags caja-share caja-sendto caja-open-terminal caja-image-converter  caja-dropbox gtkhash-caja caja-rename cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper dunst firefox firefox-userchromejs bdf-unifont gnome-font-viewer freetype2 libfontenc libxft libotf woff2 awesome-terminal-fonts nerd-fonts-complete fontconfig-infinality-remix sdl2_ttf t1lib birdfont gimp gimp-plugin-gmic xsane gimp-plugin-registry gimp-extras gimp-paint-studio xsane-gimp gimp-nufraw gimp-plugin-pandora gimp-plugin-bimp gimp-lensfun gimp-font-rendering-fix inkscape-git inkscape-open-symbols-git inkscape-applytransforms-git inkscape-download-palette inkscape-generate-palette python-inkscape-figures network-manager-applet networkmanager pavucontrol pulseaudio pulseaudio-alsa pulseaudio-bluetooth volumeiconvirt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi vagrant python-vagrant createvm open-vm-tools vmware-workstation vagrant-vmware-utility libview vmware-auto-unlocker-git vmware-modules-dkms-git vmware-component-extractor-git  virtualbox-ext-vnc virtualbox-guest-iso virtualbox-host-dkms virtualbox virtualbox virtualbox-ext-oracle virtualbox-guest-goodies python-pip python2-pip pyenv python python2 python-virtualenv python2-virtualenv python-pipenv python-pytest-virtualenv python-virtualenvwrapper pyenv-virtualenv lua-dbi lua-socket hererocks luakit luarocks luakit lua-socket lua-dbi lua-lgi lua-lpeg lua51 lua52 lua53 lua53-lgi ldoc lua-argparse lua-coxpcall maim lua-socket lua-posix lua-cjson lua-filesystem lua-penlight lua-socket lua53-socket luacheck lua-cjson lua53-posix lua-format cjson lua53-std-normalize lua53-std-_debug rbenv rbenv-binstubs ruby-sassc chruby ruby-build rustup rust-docs lib32-rust-libs rust-racer rust-analyzer 
