#!/bin/bash

source $HOME/dotfiles/install/artix/01-lib.sh


# --------------------------------------------------- #

print s "[===================================================]"
print s "Enabling Arch Repositories..." 
print s "[===================================================]"

sudo pacman -S --noconfirm artix-mirrorlist 

sudo cp -rvf root/pacman/artix/pacman.conf /etc/

sudo pacman-key --init
sudo pacman-key --populate artix 

sudo pacman -Syy 

sudo pacman --noconfirm -Sy artix-keyring artix-archlinux-support  


sudo bash -c 'echo " # Extra
# Arch Linux Repositories 
 [extra]

 Include = /etc/pacman.d/mirrorlist-arch

 [community]
 Include = /etc/pacman.d/mirrorlist-arch

 [multilib]
 Include = /etc/pacman.d/mirrorlist-arch" >> /etc/pacman.conf' 


sudo pacman-key --populate archlinux

sudo pacman -Syyu




# --------------------------------------------------- #
print s "[===================================================]"
print s Install Paru
print s "[===================================================]"

sudo pacman -S --noconfirm --needed git base-devel fakeroot ccache

if ! command -v paru &>/dev/null; then
    sudo rm -rvf /tmp/paru
    git clone https://aur.archlinux.org/paru-bin.git /tmp/paru
    cd /tmp/paru && makepkg -si
fi

# --------------------------------------------------- #
print s "[===================================================]"
print s Pacman Configuration
print s "[===================================================]"

sudo pacman-key --init
#------------------------#
# Swap in Our pacman.conf

if [[ -z "/tmp/pacman" ]]; then
    sudo cp -rvf $HOME/dotfiles/root/pacman/artix/pacman.conf /etc/pacman.conf
    #--------------------------------#
    # Add Blackarch for Security Tools
     print s "[===================================================]" 
     print s BlackArch Repos 
     print s "[===================================================]"
    cd /tmp && curl -O https://blackarch.org/strap.sh && sudo chmod +x strap.sh && sudo ./strap.sh && sudo pacman -Syu --noconfirm && cd $HOME/dotfiles || return
sudo touch /tmp/pacman
else

sleep 3

fi

# --------------------------------------------------- #
print s "[===================================================]"
print s Optimize Makepkg
print s "[===================================================]"

# makepkg.conf optimization
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
print s "[===================================================]"
print s Install Packages
print s "[===================================================]"

for line in $(cat $HOME/dotfiles/install/artix/pkglist); do
    paru -S --noconfirm --needed $line | tee -a /tmp/install-log.txt
done

# --------------------------------------------------- #
print s "[===================================================]"
print s Install Luarocks Packages 
print s "[===================================================]"

paru -S --needed --noconfirm luarocks

for package in "luasec" "luaposix" "luacheck" "luafilesystem" "ldoc" "lpeg" "argparse" "penlight"; do
    sudo luarocks install $package | tee -a /tmp/install-log.txt
done

# Get rid of these pains now, even if xfce4 is a useful secondary DE
sudo pacman -Rncs --noconfirm xfce4-screensaver xfce4-screenshooter xfce4-power-manager

# --------------------------------------------------- #
print s "[===================================================]"
print s "Install Out-of-Repo Packages" 
print s "[===================================================]"

git clone https://github.com/khuedoan/slock /tmp/slock && cd /tmp/slock && sudo make clean install && $HOME/dotfiles
