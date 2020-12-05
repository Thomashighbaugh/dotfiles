#!/bin/bash 

mkdir -p  $HOME/Pictures $HOME/.local/share $HOME/.config $HOME/.cache $HOME/.local/lib $HOME/Desktop $HOME/Documents $HOME/Downloads 

sudo pacman -S --noconfirm git pacutils fakeroot perl-libwww perl-term-ui perl-json perl-data-dump perl-lwp-protocol-https perl-term-readline-gnu

git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -is && cd .. && sudo rm -rf $HOME/yay

yay -S    --needed  --sudoloop  --noconfirm  arandr autorandr atool autoconf autocutsel automake  binutils bison
yay -S    --needed  --sudoloop  --noconfirm  chrony  
yay -S    --needed  --sudoloop  --noconfirm  clipmenu cmus composer
yay -S    --needed  --sudoloop  --noconfirm  cpupower  ddrescue  debian-archive-keyring 
yay -S    --needed  --sudoloop  --noconfirm  debootstrap 
yay -S    --needed  --sudoloop  --noconfirm  devtools dex dialog dmidecode docx2txt  fakeroot ffmpegthumbnailer figlet 
yay -S    --needed  --sudoloop  --noconfirm  flex fortune-mod garcon gawk gcc gcc-libs gcolor3  gettext glibc gpick 
yay -S    --needed  --sudoloop  --noconfirm   inotify-tools iproute2 iputils 
yay -S    --needed  --sudoloop  --noconfirm  keybase keybase-gui keychain libvterm 
yay -S    --needed  --sudoloop  --noconfirm  glibc grep grilo-plugins 
yay -S    --needed  --sudoloop  --noconfirm  xterm xz xdg-user-dirs xdg-user-dirs-gtk xsane-gimp xss-lock xautomation vi
yay -S    --needed  --sudoloop  --noconfirm  tarantool ubuntu-keyring wget which xclip 
yay -S    --needed  --sudoloop  --noconfirm  ntp pacman-contrib  pkgconf pkgfile pciutils perl-tk premake 
yay -S    --needed  --sudoloop  --noconfirm  procps-ng proselint psmisc psutils rmlint rygel  screen  
yay -S    --needed  --sudoloop  --noconfirm  seahorse sed shadow shellharden simple-scan sshfs stunnel sudo switchboard-plug-bluetooth 
yay -S    --needed  --sudoloop  --noconfirm  make man-db man-pages man2html mesa mlocate moc network-manager-applet vte3 xterm 


sudo systemctl enable --now chrony

sudo systemctl enable --now fstrim.timer

sudo systemctl start fstrim.service

