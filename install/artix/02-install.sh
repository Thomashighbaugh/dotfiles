#!/bin/bash

source $HOME/dotfiles/install/artix/01-lib.sh

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

sudo pacman -S --noconfirm --needed git base-devel fakeroot

if ! command -v paru &>/dev/null; then
    sudo rm -rvf /tmp/paru-bin-cloned
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    cd /tmp/paru-bin-cloned/ && makepkg -si
fi

# --------------------------------------------------- #
print s "[===================================================]"
print s Pacman Configuration
print s "[===================================================]"

sudo pacman-key --init
sudo pacman-key --populate archlinux
#------------------------#
# Swap in Our pacman.conf

if [[ -z "$PACMAN" ]]; then

    sudo bash -c "echo '[universe]' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://universe.artixlinux.org/$arch' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://mirror1.artixlinux.org/universe/$arch' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://mirror.pascalpuffke.de/artix-universe/$arch' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://artixlinux.qontinuum.space/artixlinux/universe/os/$arch' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://mirror1.cl.netactuate.com/artix/universe/$arch' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = https://ftp.crifo.org/artix-universe/' >> /etc/pacman.conf"
    sudo bash -c "echo '[omniverse]' >> /etc/pacman.conf"
    sudo bash -c "echo 'Server = http://omniverse.artixlinux.org/$arch' >> /etc/pacman.conf"
    sudo pacman -Syyu
    sudo pacman -S artix-archlinux-support
    sudo pacman-key --populate archlinux
    sudo bash -c "echo '[extra]' >> /etc/pacman.conf"
    sudo bash -c "echo 'Include = /etc/pacman.d/mirrorlist-arch' >> /etc/pacman.conf"
    sudo bash -c "echo '[community]' >> /etc/pacman.conf"
    sudo bash -c "echo 'Include = /etc/pacman.d/mirrorlist-arch' >> /etc/pacman.conf"
    sudo pacman -Syyu
    export PACMAN=0

    #----------------------------------#
    # Add Choatic AUR for kernel builds
    curl https://aur.chaotic.cx/chaotic.gpg >/tmp/chaotic.pgp
    sudo pacman-key --add /tmp/chaotic.pgp
    sudo pacman-key --lsign-key FBA220DFC880C036
    sudo pacman -U 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' 'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    sudo sh -c 'echo "[chaotic-aur]" >> /etc/pacman.conf '
    sudo sh -c 'echo "Include = /etc/pacman.d/chaotic-mirrorlist" >> /etc/pacman.conf'
    sudo pacman -Syy

    #--------------------------------#
    # Add Blackarch for Security Tools
    cd /tmp && curl -O https://blackarch.org/strap.sh && sudo chmod +x strap.sh && sudo ./strap.sh && sudo pacman -Syu --noconfirm && cd $HOME/dotfiles || return

else

    return

fi

# --------------------------------------------------- #
print s "[===================================================]"
print s Optimize Makepkg
print s "[===================================================]"

# makepkg.conf optimization
numberofcores=$(grep -c processor /proc/cpuinfo)
if [ $numberofcores -gt 1 ]; then
    sudo sed -i 's/#MAKEFLAGS="-j2"/MAKEFLAGS="-j'$(($numberofcores + 1))'"/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/xz -c -z -/xz -c -z - --threads=0/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i 's/zstd -c -z -q -/zstd -c -z -q - --threads=0/g' /etc/makepkg.conf | tee -a /tmp/install-log.txt
    sudo sed -i "s/PKGEXT='.pkg.tar.xz'/PKGEXT='.pkg.tar.zst'/g" /etc/makepkg.conf | tee -a /tmp/install-log.txt
else
    echo "makepkg.conf not changed." | tee -a /tmp/install-log.txt
fi
# --------------------------------------------------- #
print s "[===================================================]"
print s Install Packages | tee -a /tmp/install-log.txt
print s "[===================================================]"

for line in $(cat $HOME/dotfiles/install/artix/pkglist); do
    paru -S --noconfirm --needed $line | tee -a /tmp/install-log.txt
done

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Luarocks Packages | tee -a /tmp/install-log.txt
print s "[===================================================]"

paru -S --needed --noconfirm luarocks

for package in "luasec" "luaposix" "luacheck" "luafilesystem" "ldoc" "lpeg" "argparse" "penlight"; do
    sudo luarocks install $package | tee -a /tmp/install-log.txt
done

# Get rid of these pains now, even if xfce4 is a useful secondary DE
sudo pacman -Rncs --noconfirm xfce4-screensaver xfce4-screenshooter xfce4-power-manager

# --------------------------------------------------- #
print s "[===================================================]"
print s "Install Out-of-Repo Packages" | tee -a /tmp/install-log.txt
print s "[===================================================]"

git clone https://github.com/khuedoan/slock /tmp/slock && cd /tmp/slock && sudo make clean install && $HOME/dotfiles
