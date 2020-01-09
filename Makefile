.PHONY: help sh zsh bash rc uefiupdate kitty laptop awesome archive disk X tmux vim neovim rofi browsers docker dev emacs fonts git gtk android media netsec vm minikube postgresql pip yarn

help:
	@echo 'Dotfiles Installation Makefile                                         '
	@echo '                                                                       '
	@echo '-----------------------------------------------------------------------'
	@echo '-----------------------------------------------------------------------'
	@echo '-----------------------------------------------------------------------'
	@echo 'Usage:                                                                 '
	@echo '   make                             install everything                 '
	@echo '   make android                     install android packages           '
	@echo '   make awesome                     install awesome configuration      '
	@echo '   make archive                     install archive packages           '
	@echo '   make bash                        install bash configuration         '
	@echo '   make browsers                    install browser packages           '
	@echo '   make dev                         install development environment    '
	@echo '   make disk                        install filesystem packages        '
	@echo '   make docker                      install docker packages            '
	@echo '   make emacs                       install spacemacs                  '
	@echo '   make fonts                       install tmux conf files            '
	@echo '   make git                         install git configuration          '
	@echo '   make gtk                         install gtk theme                  '
	@echo '   make kitty                       install terminal emulators         '
	@echo '   make laptop                      install laptop tools               '
	@echo '   make media                       install media packages             '
	@echo '   make minikube                    install minikube packages          '
	@echo '   make neovim                      install neovim                     '
	@echo '   make netsec                      install network sec packages       '
	@echo '   make pip                         install python packages            '
	@echo '   make postgresql                  install db packages                '
	@echo '   make rc                          install misc configurations        '
	@echo '   make rofi                        install rofi configuration         '
	@echo '   make sh                          install generic shell packages     '
	@echo '   make tmux                        install tmux configuration         '
	@echo '   make uefiupdate                  update firmware                    '
	@echo '   make vim                         install vim configuration          '
	@echo '   make vm                          install virtual machine packages   '
	@echo '   make X                           install X server packages          '
	@echo '   make yarn                        install node packages              '
	@echo '   make zsh                         install zsh configuration          '
	@echo '-----------------------------------------------------------------------'
	@echo '                                                                       '
	@echo '    Select from the above to provision your system accordingly         '
	@echo '                                                                       '

all: .PHONY

android:
	@echo 'Installing Android Packages'
	sh ${PWD}/lib/install/android.sh 
archive:
	@echo 'Installing Filesystem Archive Packages'
	sh ${PWD}/lib/install/archive.sh 
	sudo systemctl enable snapd
	sudo systemctl start snapd
awesome:
	@echo 'Installing Awesome Packages'
	sh ${PWD}/lib/install/awesome.sh 
	yay -S --needed  awesome-git
	@echo 'Installing Awesome Configuration'
	test -L ${HOME}/.config/awesome||  sudo rm -rf ${HOME}/.config/awesome
	sudo mkdir -p ${HOME}/.config/awesome
	sudo ln -sf ${PWD}/awesome/rc.lua ${HOME}/.config/awesome/rc.lua
	sudo ln -sf ${PWD}/awesome/main ${HOME}/.config/awesome/main
	sudo ln -sf ${PWD}/awesome/deco ${HOME}/.config/awesome/deco
	sudo ln -sf ${PWD}/awesome/binding ${HOME}/.config/awesome/binding
	sudo ln -sf ${PWD}/awesome/autorun.sh ${HOME}/.config/awesome/autorun.sh
	sudo ln -sf ${PWD}/awesome/themes ${HOME}/.config/awesome/themes
	sudo ln -sf ${PWD}/awesome/profile.png ${HOME}/.config/awesome/profile.png
	@echo 'Reminder: You must copy the CSS in ~/dotfiles/browser into the randomly generated Firefox Profile for your browser to render the Firefox theme perfectly'

bash:
	@echo 'Installing Bash Packages'
	sh ${PWD}/lib/install/bash.sh 
	@echo 'Installing Bash Configuration'
	sudo ln -fs ${PWD}/bash/bashrc ${HOME}/.bashrc
	sudo ln -fs ${PWD}/bash/bashenv ${HOME}/.bashenv
	sudo ln -fs ${PWD}/bash/bashprofile ${HOME}/.bash_profile
	sudo ln -fs ${HOME}/.aliases ${HOME}/.bashalias
browsers:
	@echo 'Installing Browser Configuration'
	sh ${PWD}/lib/install/browsers.sh 
	git clone https://github.com/Thomashighbaugh/startpage ${HOME}/startpage
	sudo ln -svf ${PWD}/firefox/autoconfig.cfg /usr/lib/firefox/autoconfig.cfg
	sudo ln -svf ${PWD}/firefox/autoconfig.js /usr/lib/firefox/defaults/pref/autoconfig.js
	sudo mkdir -p /usr/lib/firefox/chrome
	sudo ln -svf ${PWD}/firefox/userChrome.css /usr/lib/firefox/chrome/userChrome.css
	sudo ln -svf ${PWD}/firefox/TreeStyleTab.css /usr/lib/firefox/chrome/TreeStyleTab.css
	sudo ln -svf ${PWD}/firefox/userContent.css /usr/lib/firefox/chrome/userContent.css
	sudo mkdir -p ${HOME}/.mozilla/firefox/*.default-release/chrome
	sudo ln -svf ${PWD}/firefox/userContent.css ${HOME}/.mozilla/firefox/*.default-release/chrome/userContent.css
	sudo ln -svf ${PWD}/firefox/userChrome.css ${HOME}/.mozilla/firefox/*.default-release/userChrome.css
	sudo ln -svf ${PWD}/firefox/TreeStyleTab.css ${HOME}/.mozilla/firefox/*.default-release/TreeStyleTab.css
dev:
	@echo 'Installing Development Environment Packages'
	sh ${PWD}/lib/install/dev.sh 

disk:
	@echo 'Installing Filesystem Packages'
	sh ${PWD}/lib/install/disk.sh 
	@echo 'Install File Manager Configuration'
	mkdir -p ${HOME}/.config/pcmanfm
	sudo ln -svf ${PWD}/pcmanfm ${HOME}/.config/pcmanfm
	sudo pacman -S --noconfirm ranger 
	test -L ${HOME}/.config/ranger || rm -rf ${HOME}/.config/ranger
	mkdir -p ${HOME}/.config/ranger
	sudo ln -svf ${PWD}/rc/rc.conf ${HOME}/.config/ranger/rc.conf

docker:
	@echo 'Installing Docker Configuration'
	sh ${PWD}/lib/install/docker.sh 
	@echo 'Installing Docker Configuration'
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.socket
	sudo systemctl enable docker.socket
	sudo systemctl start docker.service
	sudo ln -svf ${PWD}/docker ${HOME}/docker
emacs:
	@echo 'Installing Spacemacs'
	sh ${PWD}/lib/install/emacs.sh 
	sudo ln -svf ${PWD}/emacs/spacemacs ${HOME}/.spacemacs
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d
fonts:
	@echo 'Installing Font Packages'
	sh ${PWD}/lib/install/fonts.sh 
	sudo pacman -Rns mousepad 
	sudo mkdir -p ${HOME}/.local/share/fonts
	sudo cp -rv ${PWD}/fonts/fonts.tar.7z ${HOME}/.local/share/fonts
	sudo 7z x -so ${HOME}/.local/share/fonts/fonts.tar.7z | sudo tar xf - -C ${HOME}/.local/share/fonts
	sudo cp -rnv ${HOME}/.local/share/fonts /usr/share/fonts
	sudo fc-cache -vf && fc-cache -vf 
git:
	@echo 'Installing Git Onfiguration'
	sudo ln -fs ${PWD}/git/gitconfig ${HOME}/.gitconfig
	sudo ln -fs ${PWD}/git/gitignore ${HOME}/.gitignore
	sudo ln -fs ${PWD}/git/gitcommit ${HOME}/.gitcommit 
	git clone https://github.com/Thomashighbaugh/Personal-Knowledge-Wiki ${HOME}/Personal-Knowledge-Wiki
gtk:
	@echo 'Installing GTK Configuration'
	sh ${PWD}/lib/install/gtk.sh
	mkdir -p ${HOME}/.config/gtk-2.0
	sudo ln -svf ${PWD}/gtk/gtk-2.0/gtkfilechooser.ini ${HOME}/.config/gtk-2.0/gtkfilechooser.ini
	mkdir -p ${HOME}/.config/gtk-3.0
	sudo ln -svf ${PWD}/gtk/gtk-3.0/bookmarks ${HOME}/.config/gtk-3.0/bookmarks
	sudo ln -svf ${PWD}/gtk/gtk-3.0/gtk.css ${HOME}/.config/gtk-3.0/gtk.css
	sudo ln -svf ${PWD}/gtk/gtk-3.0/settings.ini ${HOME}/.config/gtk-3.0/settings.ini
	sudo ln -svf ${PWD}/gtk/gtkrc-2.0 ${HOME}/.gtkrc-2.0
	mkdir -p ${HOME}/.config/Kvantum
	sudo ln -svf ${PWD}/gtk/kvantum.kvconfig ${HOME}/.config/Kvantum/kvantum.kvconfig
	mkdir -p ${HOME}/.themes
	git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ${HOME}/.themes/Dhumavati-Theme
	sh ${HOME}/.themes/Dhumavati-Theme/Install
	wget -qO- https://git.io/fhQdI | sh
	suru-plus-folders -C aurora --theme Suru++
	sudo cp -rv /usr/share/icons/Suru++/* /usr/share/icons/hicolor ## overwrites the hicolor theme with Suru++ for pretty menus
	sudo ln -sfv ${PWD}/gtk/gtk-bookmarks ${HOME}/.gtk-bookmarks
kitty:
	@echo 'Installing Terminal Emulator'
	sh ${PWD}/lib/install/kitty.sh
	test -L ${HOME}/.config/kitty || rm -rf ${HOME}/.config/kitty
	mkdir -p ${HOME}/.config/kitty
	sudo ln -sf ${PWD}/kitty/kitty.conf ${HOME}/.config/kitty/kitty.conf
	sudo ln -sf ${PWD}/kitty/colors.conf ${HOME}/.config/kitty/colors.conf
	sudo pacman -S --noconfirm alacritty alacritty-terminfo 
	sudo ln -sf ${PWD}/alacritty ${HOME}/.config/alacritty
laptop:
	@echo 'Installing Laptop Tools'
	sh ${PWD}/lib/install/laptop.sh
	systemctl enable tlp.service
	systemctl enable tlp-sleep.service
media:
	@echo 'Installing Media Packages'
	sh ${PWD}/lib/install/media.sh
	yay -S --needed --noconfirm gpick coulr  
minikube:
	@echo 'Installing Minikube Packages'
	sh ${PWD}/lib/install/minikube.sh
	sudo usermod -a -G libvirt ${USER}
	sudo systemctl start libvirtd.service
	sudo systemctl enable libvirtd.service
	sudo systemctl start virtlogd.service
	sudo systemctl enable virtlogd.service
	minikube config set vm-driver kvm2
neovim:
	@echo 'Installing Neovim Configuration'
	sh ${PWD}/lib/install/neovim.sh
	mkdir -p ${HOME}/.config/nvim
	sudo ln -svf ${PWD}/nvim/init.vim ${HOME}/.config/nvim/init.vim
	sudo ln -svf ${PWD}/nvim/nvim.desktop /usr/share/applications/nvim.desktop
netsec:
	@echo 'Installing network security packages'
	sudo curl -O https://blackarch.org/strap.sh
	sudo chmod +x strap.sh
	sudo ./strap.sh
	sudo rm -r ${PWD}/strap.sh 
	sh ${PWD}/lib/install/netsec.sh
	sudo firectl enable brave-browser
	sudo firectl enable chromium
	sudo firectl enable gimp
	sudo firectl enable min
	sudo firectl enable mpv
	sudo firectl enable thunderbird
	sudo firectl enable transmission-gtk 
	sudo firectl enable wine


pip:
	@echo 'Installing Python Packages'
	mkdir -p ${HOME}/.local
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py --user
	sudo rm -r get-pip.py
	sh ${PWD}/lib/install/pip.sh
postgresql:
	@echo 'Install Database Packages'
	sh ${PWD}/lib/install/postgresql.sh
	sudo -u postgres initdb -E UTF8 --no-locale -D '/var/lib/postgres/data'
	sudo systemctl enable postgresql.service
	sudo systemctl start postgresql.service
	sudo systemctl enable redis.service
rc:
	@echo 'Install Misc Configurations'
	sh ${PWD}/lib/install/rc.sh
	test -L ${HOME}/.config/dunst || rm -rf ${HOME}/.config/dunst
	mkdir -p ${HOME}/.config/dunst
	test -L ${HOME}/.config/neofetch || rm -rf ${HOME}/.config/neofetch
	mkdir -p ${HOME}/.config/neofetch 
	test -L ${HOME}/.config/zathura || rm -rf ${HOME}/.config/zathura
	mkdir -p ${HOME}/.config/zathura
	sudo ln -svf ${PWD}/rc/appimagelauncher.cfg ${HOME}/.config/appimagelauncher.cfg
	sudo ln -svf ${PWD}/rc/compton.conf ${HOME}/.config/compton.conf
	sudo ln -svf ${PWD}/rc/compton.conf ${HOME}/.config/compton.conf
	sudo ln -svf ${PWD}/rc/QtProject.conf ${HOME}/.config/QtProject.conf
	sudo ln -svf ${PWD}/rc/dmrc ${HOME}/.dmrc
	sudo ln -svf ${PWD}/rc/nanorc ${HOME}/.nanorc
	mkdir -p  ${HOME}/.config/neofetch
	sudo ln -svf ${PWD}/rc/neofetch.config ${HOME}/.config/neofetch/config.conf
	mkdir -p  ${HOME}/.config/zathura
	sudo ln -svf ${PWD}/rc/zathurarc ${HOME}/.config/zathura/zathurarc
	sudo ln -svf ${PWD}/rc/ackrc ${HOME}/.ackrc
	sudo ln -svf ${PWD}/rc/Trolltech.conf ${HOME}/.config/Trolltech.conf 
	sudo ln -svf ${PWD}/xfce4 ${HOME}/.config/xfce4
rofi:
	@echo 'Install Rofi Configuration'
	sh ${PWD}/lib/install/rofi.sh
	mkdir -p  ${HOME}/.config/rofi
	mkdir -p ${HOME}/.local/share/
	sudo ln -svf ${PWD}/rofi/colors.rasi ${HOME}/.config/rofi/colors.rasi
	sudo ln -svf ${PWD}/rofi/themes ${HOME}/.config/rofi
	sudo ln -svf ${PWD}/rofi/config.rasi ${HOME}/.config/rofi/config.rasi 
sh:
	@echo 'Install Generic Shell Configuration'
	sudo ln -fns ${PWD}/bin/ ${HOME}/bin
	sudo ln -fs ${PWD}/lib/ ${HOME}/lib
	sudo ln -fs ${PWD}/sh/aliases ${HOME}/.aliases
	sudo ln -fs ${PWD}/sh/profile ${HOME}/.profile
	sudo ln -vsf ${DOTFILES}/rc/xterm.desktop /usr/share/applications/xterm.desktop
	sudo ln -vsf ${DOTFILES}/rc/uxterm.desktop /usr/share/applications/uxterm.desktop
tmux:
	@echo 'Install TMUX Configuration'
	sh ${PWD}/lib/themes/tmux.sh
	mkdir -p ${HOME}/.tmuxp
	sudo ln -fs ${PWD}/tmux/tmux.conf ${HOME}/.tmux.conf
	sudo ln -vsf ${PWD}/tmux/tmuxp/main.yml ${HOME}/.tmuxp/main.yml
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
uefiupdate:
	@echo 'Update Firmware'
	sh ${PWD}/lib/themes/uefi.sh
	sudo dmidecode -s bios-version
	fwupdmgr refresh
	fwupdmgr get-updates
	fwupdmgr update
vim:
	@echo 'Install VIM configuration'
	sh ${PWD}/lib/install/vim.sh
	mkdir -p ${HOME}/.vim 
	sudo ln -sv ${PWD}/vim/vimrc ${HOME}/.vimrc
	sudo ln -svf ${PWD}/vim ${HOME}/.vim
	sudo ln -sv ${PWD}/vim/vim/plugins.vim ${HOME}/.vim/plugins.vim
	sudo ln -svf ${PWD}/vim/vim/plugged ${HOME}/.vim/plugged
	sudo ln -sv ${PWD}/vim/vim/autoload ${HOME}/.vim/autoload
vm:
	@echo 'Install Virtual Machine Packages'
	sh ${PWD}/lib/install/vm.sh
X:
	@echo 'Install X Server Configuration'
	sh ${PWD}/lib/install/x.sh
	mkdir -p ${HOME}/.Xresources.d
	sudo ln -fs ${PWD}/rc/Xresources ${HOME}/.Xresources
	sudo ln -svf ${PWD}/Xresources.d/color ${HOME}/.Xresources.d/color
	sudo ln -svf ${PWD}/Xresources.d/font ${HOME}/.Xresources.d/font
	sudo ln -svf ${PWD}/Xresources.d/rxvt-unicode ${HOME}/.Xresources.d/rxvt-unicode
	sudo ln -svf ${PWD}/Xresources.d/uxterm ${HOME}/.Xresources.d/uxterm
	sudo ln -svf ${PWD}/Xresources.d/xterm ${HOME}/.Xresources.d/xterm
	sudo ln -fs ${PWD}/rc/xinitrc ${HOME}/.xinitrc
	xrdb ~/.Xresources
yarn:
	@echo 'Install Node Packages'
	sh ${PWD}/lib/install/yarn.sh
zsh:
	@echo 'Install ZSH Configuration'
	sh ${PWD}/lib/install/zsh.sh
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	yay -S --noconfirm --needed zplug powerline 
	sudo ln -fs ${PWD}/zsh/zshrc ${HOME}/.zshrc
	sudo ln -fs ${PWD}/zsh/zlogout ${HOME}/.zlogout
	sudo ln -fs ${PWD}/zsh/zshenv ${HOME}/.zshenv
	sudo ln -sf ${PWD}/zsh/zprofile ${HOME}/.zprofile




