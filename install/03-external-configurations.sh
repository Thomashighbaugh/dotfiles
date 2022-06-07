#!/bin/bash
#TODO add in the color-script-manager since that's no longer in bin 
# --------------------------------------------------- #
# ------------------ Source Library ----------------- #
# --------------------------------------------------- #
source "$HOME"/dotfiles/install/01-lib.sh

# Only set until you reboot, enables easier time working
# with directories cloned into tmpfs, while are also 
# wiped at reboot even if the commands fail
sudo chmod -Rv 777  /tmp

# --------------------------------------------------- #
print s "[===================================================]"
print s "Cloning AwesomeWM Configuration"
print s "[===================================================]" 
sleep 3
git clone https://github.com/the-Electric-Tantra-Linux/awesome ~/.config/awesome

# --------------------------------------------------- #
print s "[===================================================]"
print s "Cloning Grub2 Theme"
print s "[===================================================]" 
sleep 3
git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme /tmp/Bhairava-Grub-Theme 
cd /tmp/Bhairava-Grub-Theme && bash install.sh && cd ~ && sudo rm -rvf /tmp/Bhairava-Grub-Theme 

# --------------------------------------------------- #
# ------------------- Bin Scripts ------------------- #
# --------------------------------------------------- #
sleep 3
git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin

# --------------------------------------------------- #
# ---------------------- NeoVim --------------------- #
# --------------------------------------------------- #
sleep 3
git clone https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/Thomashighbaugh/nvim-forge "$HOME"/.config/nvim

# --------------------------------------------------- #
print s "[===================================================]"
print s "Cloning ZSH Theme"
print s "[===================================================]"
sleep 3
git clone https://github.com/clvv/fasd "$HOME"/fasd
cd "$HOME"/fasd && sudo make install && cd ..
rm -rvf "$HOME"/fasd
cd "$HOME" && git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && bash "$HOME"/.zsh/install
chsh --shell $(which zsh) "$USER"
sudo chsh --shell $(which zsh) 
# --------------------------------------------------- #
print s "[===================================================]"
print s "Downloading and Installing GTK and Icon Themes"
print s "[===================================================]"
sleep 3
sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
cd /tmp && wget https://github.com/the-Electric-Tantra-Linux/Dhumavati-Theme/releases/download/release/Dhumavati-White-Dark_.tar.xz
sudo tar -xf /tmp/Dhumavati-White-Dark_.tar.xz
sudo cp -rvf /tmp/Dhumavati-White-Dark/* /usr/share/themes
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/colors.css "$HOME"/.config/gtk-3.0/colors.css
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
mkdir -p "$HOME"/.icons/default
LINK "$HOME"/dotfiles/home/icons/index.theme "$HOME"/.icons/default/
LINK /usr/share/icons/chhinamasta "$HOME"/.icons/default/cursors

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning Firefox Modifications and Patches
print s "[===================================================]"
sleep 3s
git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox
# By first launching firefox, we insure the script won't fail
# as each has had the time to generate a profile for the script
# to install into plus the 3 seconds from the sleep command after
# to insure there are no excuses
firefox & 
sleep 3
sudo pkill firefox
bash /tmp/firefox/install.sh stable
firefox-developer-edition & 
sleep 3
sudo pkill firefox-developer-edition
bash /tmp/firefox/install.sh dev
firefox-nightly &
sleep 3
sudo pkill firefox-nightly
bash /tmp/firefox/install.sh nightly

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning LightDM Theme
print s "[===================================================]"
sleep 3s
git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme /tmp/mahakali-webkit2-theme
cd /tmp/mahakali-webkit2-theme && bash install.sh && cd ~/dotfiles && sudo rm -rvf /tmp/mahakali-webkit2-theme
