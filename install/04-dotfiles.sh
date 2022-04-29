#!/bin/bash
source "$HOME"/dotfiles/install/01-lib.sh

## Symlinks
print t "[===================================================]"
print t "Dotfiles Setup"
print t "[===================================================]"
sleep 3s
# --------------------------------------------------- #
print s "[===================================================]"
print s "Shells"
print s "[===================================================]"
sleep 3s
LINK "$HOME"/dotfiles/home/bash/bashenv "$HOME"/.bashenv
LINK "$HOME"/dotfiles/home/bash/bashrc "$HOME"/.bashrc
LINK "$HOME"/dotfiles/home/shell/profile "$HOME"/.profile
LINK "$HOME"/dotfiles/home/shell/aliases "$HOME"/.aliases

# --------------------------------------------------- #
print s "[===================================================]"
print s "Quality of Life"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.gnupg/ | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/gnupg/gpg.conf "$HOME"/.gnupg/gpg.conf
LINK "$HOME"/dotfiles/home/git/gitconfig "$HOME"/.gitconfig
LINK "$HOME"/dotfiles/home/git/gitignore "$HOME"/.gitignore
SULINK "$HOME"/dotfiles/root/motd/motd /etc/motd
LINK "$HOME"/dotfiles/home/neofetch "$HOME"/.config/neofetch

# --------------------------------------------------- #
print s "[===================================================]"
print s "X11"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.Xresources.d | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/xorg/Xresources "$HOME"/.Xresources
LINK "$HOME"/dotfiles/home/xorg/color "$HOME"/.Xresources.d/color
LINK "$HOME"/dotfiles/home/xorg/font "$HOME"/.Xresources.d/font
LINK "$HOME"/dotfiles/home/xorg/rxvt-unicode "$HOME"/.Xresources.d/rxvt-unicode
LINK "$HOME"/dotfiles/home/xorg/xterm "$HOME"/.Xresources.d/xterm
LINK "$HOME"/dotfiles/home/xorg/xprofile "$HOME"/.xprofile
LINK "$HOME"/dotfiles/home/xorg/xsettingsd "$HOME"/.xsettingsd
xrdb -merge ~/.Xresources

# --------------------------------------------------- #
print s "[===================================================]"
print s "Zathura"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.config/zathura | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/zathura/zathurarc "$HOME"/.config/zathura

# --------------------------------------------------- #
print s "[===================================================]"
print s "GTK"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.config/gtk-3.0 | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/bookmarks "$HOME"/.config/gtk-3.0/bookmarks
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/settings.ini "$HOME"/.config/gtk-3.0/settings.ini
LINK "$HOME"/dotfiles/home/gtk/gtkrc-2.0 "$HOME"/.gtkrc-2.0
mkdir -p "$HOME"/.config/Kvantum/Kvantum
LINK "$HOME"/dotfiles/home/gtk/kvantum.kvconfig "$HOME"/.config/Kvantum/kvantum.kvconfig
mkdir -p "$HOME"/.config/qt5ct
LINK "$HOME"/dotfiles/home/qt5/* "$HOME"/.config/qt5ct

# --------------------------------------------------- #
print s "[===================================================]"
print s "Background Images"
print s "[===================================================]"
sleep 3s
SULINK "$HOME"/dotfiles/root/images "$HOME"/.local/share/images
sudo cp -rvf "$HOME"/dotfiles/root/images/* /usr/share/backgrounds | tee -a /tmp/install-log.txt

# --------------------------------------------------- #
print s "[===================================================]"
print s "Picom"
print s "[===================================================]"
sleep 3s
LINK "$HOME"/dotfiles/home/picom/picom.conf "$HOME"/.config

# --------------------------------------------------- #
print s "[===================================================]"
print s "Rofi"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.config/rofi/themes | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/rofi/config "$HOME"/.config/rofi/config
LINK "$HOME"/dotfiles/home/rofi/themes "$HOME"/.config/rofi/themes
LINK "$HOME"/dotfiles/home/rofi/config.rasi "$HOME"/.config/rofi/config.rasi
LINK "$HOME"/dotfiles/home/rofi/three.rasi "$HOME"/.config/rofi/three.rasi

# --------------------------------------------------- #
print s "[===================================================]"
print s "Dunst"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.config/dunst | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/dunst/dunstrc "$HOME"/.config/dunst/dunstrc

# --------------------------------------------------- #
print s "[===================================================]"
print s "Kitty"
print s "[===================================================]"
sleep 3s
mkdir -p "$HOME"/.config/kitty | tee -a /tmp/install-log.txt
LINK "$HOME"/dotfiles/home/kitty/kitty.conf "$HOME"/.config/kitty/kitty.conf
LINK "$HOME"/dotfiles/home/kitty/theme.conf "$HOME"/.config/kitty/theme.conf

# --------------------------------------------------- #
print s "[===================================================]"
print s "Fontconfig"
print s "[===================================================]"
sleep 3s
LINK "$HOME"/dotfiles/home/fontconfig "$HOME"/.config/fontconfig
# --------------------------------------------------- #
print t "[===================================================]"
print t "Root Modifications"
print t "[===================================================]"
sleep 3s

# --------------------------------------------------- #
print s "[===================================================]"
print s "System Optimization Tweaks"
print s "[===================================================]"
sleep 3s
sudo cp -rvf "$HOME"/dotfiles/root/etc/* /etc/ | tee -a /tmp/install-log.txt

# --------------------------------------------------- #
print s "[===================================================]"
print s "Luakit Web Browser"
print s "[===================================================]"
sleep 3s
LINK "$HOME"/dotfiles/home/luakit "$HOME"/.config/luakit
