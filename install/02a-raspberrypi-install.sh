#!/usr/bin/env bash
#  ______                     ______ __      _____
# |   __ \.---.-.-----.-----.|   __ \__|    |  |  |
# |      <|  _  |__ --|  _  ||    __/  |    |__    |
# |___|__||___._|_____|   __||___|  |__|       |__|
#                     |__|
# --------------------------------------------------- #
# Source common functions
source "$HOME"/dotfiles/install/01-lib.sh
# --------------------------------------------------- #
# Insure the keys are set up
sudo pacman-key --init
sudo pacman-key --populate archlinuxarm

# --------------------------------------------------- #
print s "[===================================================]"
print s Optimize Makepkg
print s "[===================================================]"

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

for line in $(cat ./i-pkglist); do
    paru -S --noconfirm --needed $line | tee -a /tmp/install-log.txt
done
