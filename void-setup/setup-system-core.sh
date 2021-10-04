#!/bin/bash

# void installer

sudo xbps-install -Su -y xbps 
sudo xbps-install -Su 
sudo xbps-install -S -y void-repo-nonfree void-release-keys signify dialog 
sudo xbps-install -S  -y void-repo-debug atool bash bwm-ng chrony dosfstools dracut exfat-utils ntfs-3g fcron fd ffmpeg glances hddtemp
sudo xbps-install -S  -y zsh git   inetutils inxi iproute2 kbd linux-firmware linux-firmware-intel lm_sensors
sudo xbps-install -S  -y lnav lr mle nano ncurses ncurses-devel nfs-utils opendoas openssh p7zip pciutils 
sudo xbps-install -S  -y rsnapshot smartmontools socklog-void tree vsv wget xterm gcc dtach make git pkg-config man-pages
sudo xbps-install -S mdocml curl gptfdisk unzip unrar zstd ranger font-tamsyn starship xz lshw fuse-sshfs 
sudo xbps-install -S  -y borg ncdu lsscsi lsof pam detox vscode
sudo xbps-install -S  -y   chromium filezilla firefox herbstluftwm iwd kid3 libinput-gestures linux-firmware-nvidia
sudo xbps-install -S  -y micro smplayer sndio tlp xf86-input-wacom xorg-minimal sakura mesa mesa-demos mesa-vulkan-intel
sudo xbps-install -S  -y mesa-nouveau-dri mesa-intel-dri mesa-dri mesa-vaapi mesa-vdpau autorandr w3m-img sxiv xwallpaper mupdf aerc bind-utils unbound dnscrypt-proxy wavpack-devel libmp4v2-devel libflac-devel libsndfile-devel libvorbis-devel mpg123-devel faad2-devel sndio-devel opusfile-devel papirus-icon-theme aucatctl 
sudo xbps-install -S sox polybar vlc w_scan xset fontmanager libmnl-devel dialog ghostwriter dunst udiskie keychain nemo nemo-fileroller ffmpegthumbnailer gvfs gvfs-afp gvfs-cdda gvfs-smb gvfs-afc gvfs-mtp gvfs-gphoto2 
sudo xbps-install -S -y  gconf-editor mpv alsa-utils libopenal upower gtk+3 qalculate xclip rofi rofi-calc fzy fzf xwininfo redshift-gtk xbanish arc-theme arc-icon-theme faience-icon-theme faenza-icon-theme xsetroot recoll
sudo xbps-install -S  -y i3lock-color dbus-elogind-x11 asciiquarium astroid nerd-fonts noto-fonts-cjk overpass-otf google-fonts-ttf font-iosevka emacs-x11 autocutsel shellcheck caddy  binutils tar curl xbps xz

## First Setup Needed Directories
mkdir -p ~/.config
mkdir -p ~/.local/share/bin

# VPSM

git clone git@github.com:the-Electric-Tantra-Linux/void-packages.git ~/.void-packages

git clone https://github.com/sinetoami/vpsm.git $HOME/vpsm && cd $HOME/vpsm && sudo make install && cd .. && rm $HOME/vpsm 

# VPM 

git clone https://github.com/netzverweigerer/vpm $HOME/vpm

sudo cp -rvf $HOME/vpm/vpm /usr/local/bin/ && rm $HOME/vpm 


# XDEB
git clone https://github.com/toluschr/xdeb $HOME/xdeb && cd $HOME/xdeb &&  sudo chmod 744 xdeb/xdeb && sudo mv xdeb/xdeb /usr/local/bin/ && rm xdeb 

