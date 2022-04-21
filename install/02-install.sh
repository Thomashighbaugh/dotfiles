#!/bin/bash

source $HOME/dotfiles/install/01-lib.sh

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

sudo pacman -S --noconfirm --needed git
if ! command -v paru &>/dev/null; then
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru-bin-cloned
    cd /tmp/paru-bin-cloned/ &&
        makepkg -sfci --noconfirm --needed
fi

# --------------------------------------------------- #
print s "[===================================================]"
print s Pacman Configuration and Additional Repositories
print s "[===================================================]"

# arch linux packages (makes life easier)
sudo pacman -S --noconfirm --needed artix-archlinux-support
sudo pacman-key --init
sudo pacman-key --populate artix
sudo pacman-key --populate archlinux

# Swap in Our pacman.conf
cd $HOME/dotfiles &&
    sudo cp ./root/etc/pacman.conf /etc/pacman.conf
sudo pacman -Syyu
# --------------------------------------------------- #
print s "[===================================================]"
print s Optimize Makepkg
print s "[===================================================]"

# makepkg.conf optimization
numberofcores=$(grep -c ^processor /proc/cpuinfo)
if [ $numberofcores -gt 1 ]; then
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores + 1))'"/g' /etc/makepkg.conf
    sudo sed -i 's/COMPRESSXZ=(xz -c -z -)/COMPRESSXZ=(xz -c -z - --threads=0)/g' /etc/makepkg.conf
    sudo sed -i 's/COMPRESSZST=(zstd -c -z -q -)/COMPRESSZST=(zstd -c -z -q - --threads=0)/g' /etc/makepkg.conf
    sudo sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar.zst'/g" /etc/makepkg.conf
else
    echo "makepkg.conf not changed."
fi
# --------------------------------------------------- #
print s "[===================================================]"
print s Install Packages
print s "[===================================================]"

for line in $(cat ./install/pkglist); do
    paru -S --noconfirm --needed $line | tee -a /tmp/install-log.txt
done

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Luarocks Packages
print s "[===================================================]"

for package in "luasec" "luaposix" "luacheck" "luafilesystem" "ldoc" "lpeg" "argparse" "penlight"; do
    sudo luarocks install $package | tee -a /tmp/install-log.txt
done
