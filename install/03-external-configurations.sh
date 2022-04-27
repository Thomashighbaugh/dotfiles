#!/bin/bash
# --------------------------------------------------- #
# ------------------ Source Library ----------------- #
# --------------------------------------------------- #
source "$HOME"/dotfiles/install/01-lib.sh
# --------------------------------------------------- #
# --------------------- Awesome --------------------- #
# --------------------------------------------------- #
git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome

# --------------------------------------------------- #
# -------------------- Grub Theme ------------------- #
# --------------------------------------------------- #
git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme "$HOME"/.local/share/Bhairava-Grub-Theme
bash "$HOME"/.local/share/Bhairava-Grub-Theme/install.sh

# --------------------------------------------------- #
# ------------------- Bin Scripts ------------------- #
# --------------------------------------------------- #
git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin

# --------------------------------------------------- #
# ---------------------- NeoVim --------------------- #
# --------------------------------------------------- #
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/Thomashighbaugh/nvim-forge "$HOME"/.config/nvim

# --------------------------------------------------- #
# ----------------------- ZSH ----------------------- #
# --------------------------------------------------- #
git clone https://github.com/clvv/fasd "$HOME"/fasd
cd "$HOME"/fasd && sudo make install && cd ..
rm -rvf "$HOME"/fasd
cd "$HOME" && git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && bash "$HOME"/.zsh/install
chsh --shell $(which zsh) "$USER"

# --------------------------------------------------- #
# ------------------- GTK + Icons ------------------- #
# --------------------------------------------------- #
sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
cd /tmp && wget https://github.com/the-Electric-Tantra-Linux/Dhumavati-Theme/releases/download/release/Dhumavati-White-Dark_.tar.xz
tar -xf /tmp/Dhumavati-White-Dark_.tar.xz
sudo cp -rvf /tmp/Dhumavati-White-Dark/* /usr/share/themes
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/colors.css "$HOME"/.config/gtk-3.0/colors.css
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
mkdir -p "$HOME"/.icons/default
LINK "$HOME"/dotfiles/home/icons/index.theme "$HOME"/.icons/default/
LINK /usr/share/icons/chhinamasta "$HOME"/.icons/default/cursors

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning QTile Configuration
print s "[===================================================]"
sleep 3s
git clone https://github.com/Thomashighbaugh/qtile "$HOME"/.config/qtile
# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning and Patching Firefox
print s "[===================================================]"
sleep 3s
git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox
bash /tmp/firefox/install.sh stable
bash /tmp/firefox/install.sh dev
bash /tmp/firefox/install.sh nightly

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning LightDM Theme
print s "[===================================================]"
sleep 3s
git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme /tmp/mahakali-webkit2-theme
sudo bash /tmp/mahakali-webkit2-theme/install.sh
