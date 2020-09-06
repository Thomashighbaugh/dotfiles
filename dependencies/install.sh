#!/bin/bash 

sudo pacman -S --noconfirm git pacutils  fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

git clone https://aur.archlinux.org/trizen.git && cd trizen && makepkg -si && cd .. && sudo rm -rf trizen



trizen -S --needed --noedit  --noconfirm yay 
yay -S    --needed  --sudoloop  --noconfirm  arandr autorandr atool autoconf autocutsel automake  binutils bison borg  btrfs-progs
yay -S    --needed  --sudoloop  --noconfirm  bzip2 calf canto-daemon catimg  chrony  
yay -S    --needed  --sudoloop  --noconfirm  clipmenu cmus composer coreutils dosfstools exfat-utils fatresize 
yay -S    --needed  --sudoloop  --noconfirm  cpio efibootmgr file file-roller filesystem findutils gzip lzip p7zip tar \
yay -S    --needed  --sudoloop  --noconfirm  cpupower  cups cups-filters cups-pdf cups-pk-helper ddrescue  debian-archive-keyring 
yay -S    --needed  --sudoloop  --noconfirm  debootstrap 
yay -S    --needed  --sudoloop  --noconfirm  devtools dex dialog diskus dmidecode docx2txt e2fsprogs fakeroot ffmpegthumbnailer figlet 
yay -S    --needed  --sudoloop  --noconfirm  flex fortune-mod garcon gawk gcc gcc-libs gcolor3  gettext glibc gpick 
yay -S    --needed  --sudoloop  --noconfirm  grep gutenprint gvfs gvfs-afc gvfs-goa gvfs-google gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb  
yay -S    --needed  --sudoloop  --noconfirm  xarchiver  hardinfo hddtemp inotify-tools iproute2 iputils jetring jre-openjdk 
yay -S    --needed  --sudoloop  --noconfirm  keybase keybase-gui keychain   libvterm linux linux-firmware linux-headers 
yay -S    --needed  --sudoloop  --noconfirm  lostfiles  lrzip 
yay -S    --needed  --sudoloop  --noconfirm  glibc grep grilo-plugins groff gutenprint gvfs gvfs-afc gvfs-goa gvfs-google
yay -S    --needed  --sudoloop  --noconfirm  foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds oreutils cups cups-filters cups-
yay -S    --needed  --sudoloop  --noconfirm  pdf  cndrvcups-lb-bin   cnijfilter2-bin  cups-pk-helper ntp 
yay -S    --needed  --sudoloop  --noconfirm  xterm xz  xdg-user-dirs xdg-user-dirs-gtk xsane-gimp xss-lock xautomation vi
yay -S    --needed  --sudoloop  --noconfirm  system-config-printer tarantool ubuntu-keyring udftools unarj unrar unzip 
yay -S    --needed  --sudoloop  --noconfirm  linux uutils-coreutils wget which xcb-util-errors xclip 
yay -S    --needed  --sudoloop  --noconfirm  ntp pacman-contrib  pkgconf pkgfile pciutils perl-tk poppler-data powerline premake 
yay -S    --needed  --sudoloop  --noconfirm  procps-ng proselint psmisc psutils rlwrap rmlint ruby-sassc rustup rygel sassc screen scrot 
yay -S    --needed  --sudoloop  --noconfirm  seahorse sed shadow shellharden simple-scan sshfs stunnel sudo switchboard-plug-bluetooth 
yay -S    --needed  --sudoloop  --noconfirm  lsd lshw lua-dbi lua-socket luakit luarocks lvm2 lxcfs lxd  lzop maim make man-db 
yay -S    --needed  --sudoloop  --noconfirm  man-pages man2html mesa mlocate moc mosh mpc mpd namcap network-manager-applet
yay -S    --needed  --sudoloop  --noconfirm  networkmanager 



sudo systemctl enable --now fstrim.timer

sudo systemctl start fstrim.service

sudo systemctl enable --now  org.cups.cupsd.service
