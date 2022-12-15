#!/bin/bash
#TODO add in the color-script-manager since that's no longer in bin
# --------------------------------------------------- #
# ------------------ Source Library ----------------- #
# --------------------------------------------------- #
source "$HOME"/dotfiles/install/artix/01-lib.sh

# Only set until you reboot, enables easier time working
# with directories cloned into tmpfs, while are also
# wiped at reboot even if the commands fail
sudo chmod -Rv 777 /tmp

# --------------------------------------------------- #
print s "[===================================================]"
print s "Cloning AwesomeWM Configuration" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
git clone https://github.com/the-Electric-Tantra-Linux/awesome "$HOME"/.config/awesome

# --------------------------------------------------- #
print s "[===================================================]"
print s "Grub2 Theme" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
git clone https://github.com/the-Electric-Tantra-Linux/Bhairava-Grub-Theme /tmp/Bhairava-Grub-Theme
cd /tmp/Bhairava-Grub-Theme && sudo bash install.sh && cd "$HOME"/dotfiles || return
# To handle that annoying grub issue for arch based systems
sudo grub-install | tee -a /tmp/install-log.txt
sudo grub-mkconfig -o /boot/grub/grub.cfg | tee -a /tmp/install-log.txt

print s "[===================================================]"
print s "Bin Scripts" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
git clone https://github.com/Thomashighbaugh/bin "$HOME"/.local/share/bin

print s "[===================================================]"
print s "NeoVim" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
git clone https://github.com/wbthomason/packer.nvim "$HOME"/.local/share/nvim/site/pack/packer/start/packer.nvim
git clone https://github.com/Thomashighbaugh/nvim-forge "$HOME"/.config/nvim

# --------------------------------------------------- #
print s "[===================================================]"
print s "ZSH Theme" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
git clone https://github.com/clvv/fasd "$HOME"/fasd
cd "$HOME"/fasd && sudo make install && cd ..
rm -rvf "$HOME"/fasd
cd "$HOME" && git clone --recursive -j8 https://github.com/Thomashighbaugh/zsh "$HOME"/.zsh && bash "$HOME"/.zsh/install
chsh --shell "$(which zsh)" "$USER"
sudo chsh --shell "$(which zsh)"
# --------------------------------------------------- #
print s "[===================================================]"
print s "GTK and Icon Themes" | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3
sudo git clone https://github.com/Thomashighbaugh/chhinamasta-icon-theme /usr/share/icons/chhinamasta
cd /tmp && wget https://github.com/the-Electric-Tantra-Linux/Dhumavati-White-Dark-Theme/releases/download/release/Dhumavati-White-Dark-Black-Dark_.tar.xz
sudo tar -xf /tmp/Dhumavati-White-Dark_.tar.xz
sudo mkdir -p /usr/share/themes/Dhumavati-White-Dark
sudo cp -rvf /tmp/Dhumavati-White-Dark/* /usr/share/themes/Dhumavati-White-Dark
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/colors.css "$HOME"/.config/gtk-3.0/colors.css
LINK "$HOME"/dotfiles/home/gtk/gtk-3.0/gtk.css "$HOME"/.config/gtk-3.0/gtk.css
mkdir -p "$HOME"/.icons/default
LINK "$HOME"/dotfiles/home/icons/index.theme "$HOME"/.icons/default/
sudo ln -svf /usr/share/icons/chhinamasta "$HOME"/.icons/default/cursors

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning Firefox Modifications and Patching | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3s
git clone https://github.com/Thomashighbaugh/firefox /tmp/firefox
# By first launching firefox, we insure the script won't fail
# as each has had the time to generate a profile for the script
# to install into plus the 3 seconds from the sleep command after
# to insure there are no excuses
librewolf &
sleep 3
sudo pkill librewolf &
bash /tmp/firefox/install.sh wolf | tee -a /tmp/install-log.txt
firefox &
sleep 3
sudo pkill firefox &
bash /tmp/firefox/install.sh stable | tee -a /tmp/install-log.txt
firefox-developer-edition &
sleep 3
sudo pkill firefox-developer-edition &
bash /tmp/firefox/install.sh dev | tee -a /tmp/install-log.txt
firefox-nightly &
sleep 3
sudo pkill firefox-nightly &
bash /tmp/firefox/install.sh nightly | tee -a /tmp/install-log.txt

# --------------------------------------------------- #
print s "[===================================================]"
print s Cloning LightDM Theme | tee -a /tmp/install-log.txt
print s "[===================================================]"
sleep 3s
git clone https://github.com/the-Electric-Tantra-Linux/mahakali-webkit2-theme /tmp/mahakali-webkit2-theme
cd /tmp/mahakali-webkit2-theme && bash install.sh && cd "$HOME"/dotfiles || exit

# --------------------------------------------------- #
# without this, boot issues ensue probably due to grub theme
print s "[===================================================]"
print s "Run mkinitcpio and Update Grub" | tee -a /tmp/install-log.txt
print s "[===================================================]"

sudo mkinitcpio -P

sudo update-grub
