#!/bin/bash

source $HOME/dotfiles/install/arch/01-lib.sh

# --------------------------------------------------- #

print t "[===================================================]"
print t "Preliminaaries"
print t "[===================================================]"
# --------------------------------------------------- #
sudo pacman -S --noconfirm git base-devel base devtools fakeroot ccache

# --------------------------------------------------- #
print s "[===================================================]"
print s "Enabling BlackArch Repositories..."
print s "[===================================================]"
#curl -O https://blackarch.org/strap.sh && chmod +x strap.sh && sudo bash strap.sh && sudo pacman -Syu

# --------------------------------------------------- #
print s "[===================================================]"
print s "Enabling Chaotic AUR Repositories..."
print s "[===================================================]"
#sudo bash -c "pacman-key --recv-key FBA220DFC880C036 --keyserver keyserver.ubuntu.com&& pacman-key --lsign-key FBA220DFC880C036 && pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst' && echo '[chaotic-aur]' >> /etc/pacman.conf && echo 'Include = /etc/pacman.d/chaotic-mirrorlist' >> /etc/pacman.conf"
sudo pacman -Syy
# --------------------------------------------------- #
print t "[===================================================]"
print t "Enabling and Optimizing AUR Package Management..."
print t "[===================================================]"
# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

#if ! command -v paru &>/dev/null; then
#    sudo rm -rvf /tmp/paru
#    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru
#    cd /tmp/paru && makepkg -si
#fi
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

for line in $(cat "$HOME"/dotfiles/install/arch/pkglist); do
    paru -S --noconfirm --needed --overwrite='*' $line | tee -a /tmp/install-log.txt
done

# For Thunar Extensions
uca-apply update

# --------------------------------------------------- #
