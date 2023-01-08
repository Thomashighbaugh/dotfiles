#!/bin/bash

source $HOME/dotfiles/install/artix/01-lib.sh

# --------------------------------------------------- #

print t "[===================================================]"
print t "Enabling Artix Repositories..."
print t "[===================================================]"
# --------------------------------------------------- #
sudo pacman -S --noconfirm artix-mirrorlist git base-devel fakeroot ccache
# --------------------------------------------------- #
print s "[===================================================]"
print s "Enabling Arch Repositories..."
print s "[===================================================]"

sudo cp -rvf root/pacman/artix/pacman.conf /etc/
sudo pacman-key --init
sudo pacman-key --populate artix
sudo pacman-key --refresh-keys
sudo pacman -Syy
sudo pacman --noconfirm -Sy --overwrite='*' artix-keyring artix-archlinux-support archlinux-mirrorlist

sudo bash -c 'echo " # Extra
# Arch Linux Repositories 
 [extra]

 Include = /etc/pacman.d/mirrorlist-arch

 [community]
 Include = /etc/pacman.d/mirrorlist-arch

 [multilib]
 Include = /etc/pacman.d/mirrorlist-arch" >> /etc/pacman.conf'

sudo pacman-key --populate archlinux artix
sudo pacman -Syyu --overwrite='*'

# --------------------------------------------------- #
print s "[===================================================]"
print s "Enabling BlackArch Repositories..."
print s "[===================================================]"
curl -O https://blackarch.org/strap.sh && chmod +x strap.sh && sudo bash strap.sh && sudo pacman -Syu

# --------------------------------------------------- #
print s "[===================================================]"
print s "Enabling Chaotic AUR Repositories..."
print s "[===================================================]"
sudo bash -c "pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com&& pacman-key --lsign-key FBA220DFC880C036 && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && echo '[chaotic-aur]' >> /etc/pacman.conf && echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo pacman -Syy
# --------------------------------------------------- #
print t "[===================================================]"
print t "Enabling and Optimizing AUR Package Management..."
print t "[===================================================]"
# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

if ! command -v paru &>/dev/null; then
    sudo rm -rvf /tmp/paru
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru
    cd /tmp/paru && makepkg -si
fi
# --------------------------------------------------- #
print s "[===================================================]"
print s Optimize Makepkg
print s "[===================================================]"
numberofcores=$(grep -c processor /proc/cpuinfo)
if [ $numberofcores -gt 1 ]; then
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores + 1))'"/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/!ccache/ccache/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/xz -c -z -/xz -c -z - --threads=0/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/zstd -c -z -q -/zstd -c -z -q - --threads=0/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar.zst'/g" /etc/makepkg.conf | tee -a /tmp/install-log.txt
else
    echo "makepkg.conf not changed." | tee -a /tmp/install-log.txt
fi
# --------------------------------------------------- #
print t "[===================================================]"
print t Install Packages
print t "[===================================================]"

for line in $(cat $HOME/dotfiles/install/artix/pkglist); do
    paru -S --noconfirm --needed --overwrite='*' $line | tee -a /tmp/install-log.txt
done

# For Thunar Extensions
uca-apply update

# --------------------------------------------------- #
print t "[===================================================]"
print t Remove Packages
print t "[===================================================]"

# Remove
# Get rid of these pains now, even if xfce4 is a useful secondary DE
sudo pacman -Rncs --noconfirm xfce4-screensaver xfce4-screenshooter xfce4-power-manager

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Luarocks Packages
print s "[===================================================]"

paru -S --needed --noconfirm --overwrite='*' luarocks

for package in "luasec" "luaposix" "luacheck" "luafilesystem" "ldoc" "lpeg" "argparse" "penlight"; do
    sudo luarocks install $package | tee -a /tmp/install-log.txt
done

# --------------------------------------------------- #
