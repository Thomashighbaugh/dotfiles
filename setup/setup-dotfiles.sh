#!/bin/bash

# Dotfiles Setup

cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"

print() {
    case "$1" in
        t | title)
            shift
            printf "%s\n" "${sb}${cg}[###]$*${sn}"
        ;;
        s | step)
            shift
            printf "%s\n" "${sb}${cm}[===]$*${sn}"
        ;;
        e | error)
            shift
            printf "%s\n" "${sb}${cr}[!!!]$*${sn}"
            exit 1
        ;;
        w | warning)
            shift
            printf "%s\n" "${sb}${cy}[:::]$*${sn}"
        ;;
        *)
            printf '%s\n' "$*"
        ;;
    esac
}
## Cloning the Dotfiles

#git clone https://github.com/Thomashighbaugh/dotfiles ~/dotfiles

## Symlinks
print t "####################################################"
print t "Dotfiles Setup"
print t "####################################################"
print s "####################################################"
print s "Shells"
print s "####################################################"
ln -svf "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
ln -svf "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
ln -svf "$HOME"/dotfiles/home/sh/profile "$HOME"/.profile
ln -svf "$HOME"/dotfiles/home/sh/aliases "$HOME"/.aliases
print s "####################################################"
print s "Quality of Life"
print s "####################################################"
ln -svf "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
ln -svf "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
ln -svf "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
sudo ln -svf "$HOME"/dotfiles/root/motd/motd /etc/motd
ln -svf "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch
print s "####################################################"
print s "X11"
print s "####################################################"
mkdir -p $HOME/.Xresources.d
ln -svf "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
ln -svf "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
ln -svf "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
ln -svf "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
ln -svf "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
ln -svf "$HOME"/dotfiles/home/xorg/xscreensaver "$HOME"/.xscreensaver
ln -svf "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
ln -svf "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
print s "####################################################"
print s "Zathura"
print s "####################################################"
ln -svf "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura
print s "####################################################"
print s "GTK"
print s "####################################################"
mkdir -p $HOME/.config/gtk
ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
ln -svf "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
ln -svf "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
mkdir -p $HOME/.config/Kvantum/Kvantum
ln -svf "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig
print s "####################################################"
print s "Background Images"
print s "####################################################"
sudo ln -svf "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
sudo cp -rvf  "$HOME"/dotfiles/root/images/* /usr/share/backgrounds
print s "####################################################"
print s "Picom"
print s "####################################################"
mkdir -p $HOME/.config/picom
ln -svf "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config
print s "####################################################"
print s "Rofi"
print s "####################################################"
mkdir -p $HOME/.config/rofi
ln -svf "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
ln -svf "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
ln -svf "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
ln -svf "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi
print s "####################################################"
print s "Dunst"
print s "####################################################"
mkdir -p $HOME/.config/dunst
ln -svf "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc
print s "####################################################"
print s "Kitty"
print s "####################################################"
mkdir -p $HOME/.config/kitty
ln -svf $HOME/dotfiles/home/kitty/kitty.conf $HOME/.config/kitty/kitty.conf
ln -svf $HOME/dotfiles/home/kitty/theme.conf $HOME/.config/kitty/theme.conf
print s "####################################################"
print s "Alacritty"
print s "####################################################"
mkdir -p $HOME/.config/alacritty
ln -svf $HOME/dotfiles/home/alacritty/alacritty.yml $HOME/.config/alacritty/alacritty.yml
print s "####################################################"
print s "Fontconfig"
print s "####################################################"
ln -svf $HOME/dotfiles/home/fontconfig $HOME/.config/fontconfig
print t "####################################################"
print t "####################################################"
print t "####################################################"
print t "Root Modifications"
print s "####################################################"
print s "Desktop File"
print s "####################################################"
sudo cp -rvf $HOME/dotfiles/root/desktop/* /usr/share/applications
print s "####################################################"
print s "Docker"
print s "####################################################"
sudo cp -rvf $HOME/dotfiles/root/docker /etc/
print s "####################################################"
print s "System Optimization Tweaks"
print s "####################################################"
sudo cp -rvf $HOME/dotfiles/root/etc/* /etc/
