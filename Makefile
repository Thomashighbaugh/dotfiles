.PHONY: help sh zsh bash rc uefi kitty zathura laptop neofetch ryzen awesome archive disk X  vim neovim rofi browsers docker dev emacs fonts git gtk android media netsec vm minikube postgresql pip yarn i3

help:
	@echo 'Provisioning Your System With TLH's Dotfiles                           '
	@echo '======================================================================='
	@echo '                                                                       '
	@echo 'Introduction:                                                          '
	@echo '                                                                       '
	@echo '   The repository you have downloaded features the dotfiles of Thomas  '
	@echo '   Leon Highbaugh. These are opinionated configurations TLH uses in    '
	@echo '   both professional and personal settings which have been configured  '
	@echo '   in an understandable way that provides users with a basis for deep  '
	@echo '   personalization of their pacman-based Linux installations, commonly '
	@echo '   referred to ricing an install. While suitable for use as-is, it is  '
	@echo '   that users instead take some time to modify these files to personal '
	@echo '   personal taste and, of course, YMMV.                                '
	@echo '                                                                       '
	@echo '======================================================================='
	@echo 'Usage:                                                                 '
	@echo '                                                                       '
	@echo '    To provision your system, combine the `make` command with any of   '
	@echo '    of the provisioning candidate commands. This will begin to run the '
	@echo '    specific provisioning commands listed under that system`s command. '
	@echo '                                                                       '
	@echo '======================================================================='
	@echo '                                                                       '
	@echo 'Examples:                                                              '
	@echo '                                                                       '
	@echo '   | Command       | Expected Results                              |   '
	@echo '   |---------------|-----------------------------------------------|   '
	@echo '   | make laptop   | Provision system using `laptop` system group  |   '
	@echo '   | make browsers | Only provision system with `browsers` command |   '
	@echo '                                                                       '
	@echo '======================================================================='
	@echo ' 								      '
	@echo '                                                                       '
	@echo 'System Groups:                                                         '
	@echo '                                                                       '
	@echo '   This makefile is designed to work within specific contexts, based   '
	@echo '   upon the systems utilized by TLH within his own network and thus    '
	@echo '   contain configurations and packages specific to hardware of an      '
	@echo '   idiosyncratic nature that derives from their components. Again, it  '
	@echo '   is best if users first examine and modify this Makefile and scripts '
	@echo '   which this Makefile calls before provisioning locally. The systems  '
	@echo '   listed below are those contexts which this Makefile was designed to '
	@echo '   provision are called following the make command in BASH or ZSH when '
	@echo '   in the directory of this repository.                                '
	@echo '                                                                       '
	@echo '   NOTE: Only laptop is presently configured, others will follow as    '
	@echo '         I can replace the hardware and/or I am able to power systems  '
	@echo '         presently in storage while my living situation stabilizes.    '
	@echo '         - TLH 03/10/2020                                              '
	@echo '                                                                       '
	@echo ' | System Type      | command | System Specs (requirements)          | '
	@echo ' |-------------------------------------------------------------------| '
	@echo ' | Laptop           | laptop  | AMD Ryzen 5 (> 2nd gen)              | '
	@echo ' | Desktop          | desktop | amd64 Intel systems ( > 4th gen)     | '
	@echo ' | Virtual Machines | virt      | pacman-based OS  (2 Cores + 4GB RAM) | '
	@echo ' | Raspberry Pi     | pi      | > raspberry pi 2B                    | '
	@echo '                                                                       '
	@echo '======================================================================='
	@echo 'Specific Provisioning Commands:                                        '
	@echo '                                                                       '
	@echo '   Each of the commands run by the system provisioning command is      '
	@echo '   a set of files which will be linked to the user`s home directory in '
	@echo '   locations which will be seen by the applications they configure as  '
	@echo '   well as installation scripts which install the applications and any '
	@echo '   additional libraries, applications which might be needed in the use '
	@echo '   of the title application or application category. Due to preference '
	@echo '   no minimalism is employed by these scripts and applications are not '
	@echo '   only chosen due to sheer necessity but instead by potential for use.'
	@echo '                                                                       '
	@echo '   Each of these commands could also be run following make if users    '
	@echo '   only want to provision their systems with those configurations.     '
	@echo '                                                                       '
	@echo ' | Command  | Functionality Provided                                  |'
	@echo ' |----------|---------------------------------------------------------|'
	@echo ' | sh         | - System Wide Shell Configuration                     |'
	@echo ' | zsh        | - Default Shell                                       |'
	@echo ' | bash       | - Consistent Backup Shell                             |'
	@echo ' | rc         | - Misc Configurations                                 |'
	@echo ' | uefi       | - Firmware Updater                                    |'
	@echo ' | kitty      | - Terminal Emulator                                   |'
	@echo ' | ryzen      | - AMD Laptop Tools                                    |'
	@echo ' | awesome    | - Default Window Manager                              |'
	@echo ' | archive    | - File Compression Tools and Formats                  |'
	@echo ' | disk       | - HDD/SSD Formatting Tools and Drivers                |'
	@echo ' | X          | - X Server Resources and Modifications                |'
	@echo ' | vim        | - Console-based Text Editor                           |'
	@echo ' | neovim     | - Console and GUI Text Editor                         |'
	@echo ' | rofi       | - Application Selector and Script Wrapper             |'
	@echo ' | browsers   | - Web Browsers w/System-wide Firefox Modification     |'
	@echo ' | docker     | - Containerization                                    |'
	@echo ' | dev        | - Web Development Environment Provisioning            |'
	@echo ' | emacs      | - Spacemacs (Emacs + VIM keybindings)                 |'
	@echo ' | fonts      | - System Fonts Used By Other Configurations)          |'
	@echo ' | git        | - Version Control                                     |'
	@echo ' | gtk        | - Desktop Window Theme Engine                         |'
	@echo ' | android    | - Android Development and Phone Access                |'
	@echo ' | media      | - Media Playback                                      |'
	@echo ' | netsec     | - System Security Enhancements                        |'
	@echo ' | virt       | - Virtual Machine Emulation                           |'
	@echo ' | minikube   | - Cluster Emulation                                   |'
	@echo ' | postgresql | - Database Emulation                                  |'
	@echo ' | pip        | - Python Package Installation                         |'
	@echo ' | yarn       | - Node Package Installation                           |'
	@echo '                                                                       '

all: zsh rc uefi kitty awesome zathura laptop neofetch archive disk X neovim rofi browsers docker dev emacs fonts git gtk android media netsec virt minikube postgresql pip yarn

laptop: zsh rc uefi kitty awesome zathura  laptop neofetch  archive disk X i3 neovim rofi browsers docker dev emacs fonts git gtk android media virt minikube postgresql pip yarn

vm: zsh rc kitty awesome archive zathura neofetch disk X neovim rofi browsers docker dev emacs fonts git gtk netsec pip yarn

desktop:zsh rc kitty awesome zathura neofetch archive disk X neovim rofi browsers docker dev emacs fonts git gtk android media netsec nvidia virt minikube postgresql pip yarn

pi:  zsh  rc uefi awesome archive zathura  neofetch disk X neovim rofi browsers dev emacs fonts git gtk media netsec pip yarn

temp: 

android:
	@echo 'Installing Android Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/android.sh
archive:
	@echo 'Installing Filesystem Archive Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/archive.sh
	sudo systemctl enable snapd
	sudo systemctl start snapd
awesome:
	@echo 'Installing Awesome Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/awesome.sh
	yay -S --needed --sudoloop  --noconfirm awesome-git
	@echo 'Installing Awesome Configuration'
	test -L ${HOME}/.config/awesome ||  sudo rm -rf ${HOME}/.config/awesome
	git clone https://github.com/Thomashighbaugh/AwesomeWM-Configuration ${HOME}/.config/awesome
bash: sh
	@echo 'Installing Bash Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/bash.sh
	@echo 'Installing Bash Configuration'
	sudo ln -fs ${PWD}/bash/bashrc ${HOME}/.bashrc
	sudo ln -fs ${PWD}/bash/bashenv ${HOME}/.bashenv
	sudo ln -fs ${PWD}/bash/bashprofile ${HOME}/.bash_profile
	sudo ln -fs ${HOME}/.aliases ${HOME}/.bashalias
browsers:
	@echo 'Installing Browser Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/browsers.sh
	test -L ${HOME}/startpage || sudo rm -rf ${HOME}/startpage
	git clone https://github.com/Thomashighbaugh/startpage ${HOME}/startpage
	@echo "To install cutomized the firefox theme, create a chrome directory in each profile and populate it with userChrome and friends."
dev:
	@echo 'Installing Development Environment Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/dev.sh
disk:
	@echo 'Installing Filesystem Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/disk.sh
	@echo 'Install File Manager Configuration'
	mkdir -p ${HOME}/.config/pcmanfm
	sudo ln -svf ${PWD}/pcmanfm ${HOME}/.config/pcmanfm
	sudo pacman -S --noconfirm ranger
	test -L ${HOME}/.config/ranger || rm -rf ${HOME}/.config/ranger
	mkdir -p ${HOME}/.config/ranger
	sudo ln -svf ${PWD}/rc/rc.conf ${HOME}/.config/ranger/rc.conf
desktop:
	@echo 'Installing Desktop Specific Configurations'
	test -L /etc/arch-release || sh ${PWD}/lib/install/desktop.sh
docker:
	@echo 'Installing Docker Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/docker.sh
	@echo 'Installing Docker Configuration'
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.socket
	sudo systemctl enable docker.socket
	sudo systemctl start docker.service
	sudo ln -svf ${PWD}/docker ${HOME}/docker
	@echo 'Install Virtual Machine Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/vm.sh
emacs:
	@echo 'Installing Spacemacs'
	test -L /etc/arch-release || sh ${PWD}/lib/install/emacs.sh
	#sudo ln -svf ${PWD}/emacs/spacemacs ${HOME}/.spacemacs
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	#git clone https://github.com/syl20bnr/spacemacs ${HOME}/.spacemacs.d
	#git clone https://github.com/borgnix/spacemacs-journal.git ~/.emacs.d/private/journal
	#git clone https://github.com/evacchi/tabbar-layer ~/.emacs.d/private/tabbar
	git clone https://github.com/plexus/chemacs.git ${HOME}/chemacs
	sh ${HOME}/chemacs/install.sh
	sudo ln -svf ${PWD}/emacs/emacs-profiles.el ${HOME}/.emacs-profiles.el
	sudo ln -svf ${PWD}/emacs/doom.d ${HOME}/.doom.d
	git clone --depth 1 https://github.com/hlissner/doom-emacs ${HOME}/.doom-emacs
	sudo ln -svf ${HOME}/.doom-emacs/bin/doom ${PWD}/bin
	${HOME}/.doom-emacs/bin/doom install
	sudo ln -vsf ${DOTFILES}/rc/doom.desktop /usr/share/applications/doom.desktop
fonts:
	@echo 'Installing Font Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/fonts.sh
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
gtk:
	@echo 'Installing GTK Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/gtk.sh
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
	test -L ${HOME}/.themes/Dhumavati-Theme || rm -rf ${HOME}/.themes/Dhumavati-Theme
	git clone https://github.com/Thomashighbaugh/Dhumavati-Theme ${HOME}/.themes/Dhumavati-Theme
	sh ${HOME}/.themes/Dhumavati-Theme/Install
	wget -qO- https://git.io/fhQdI | sh
	sudo ln -sfv ${PWD}/gtk/gtk-bookmarks ${HOME}/.gtk-bookmarks
	@echo 'Setting Grub Theme'
	test -L ${HOME}/Bhairava-Grub-Theme || sudo rm -rf ${HOME}/Bhairava-Grub-Theme
	git clone https://github.com/Thomashighbaugh/Bhairava-Grub-Theme ${HOME}/Bhairava-Grub-Theme
	sudo sh ${HOME}/Bhairava-Grub-Theme/svg2png.sh
	sudo sh ${HOME}/Bhairava-Grub-Theme/set-grub.sh
i3:
	@echo 'Installing i3 Window Manager Configuration'
	#test -L /etc/arch-release || sh ${PWD}/lib/install/i3.sh
	mkdir -p ${HOME}/.config/i3
	sudo ln -svf ${PWD}/i3/config ${HOME}/.config/i3/config
	sudo ln -svf ${PWD}/i3/i3blocks.conf ${HOME}/.config/i3/i3blocks.conf
	sudo ln -svf ${PWD}/polybar ${HOME}/.config
	sudo ln -svf ${PWD}/i3/autoi3 ${HOME}/.config/i3
	git clone https://github.com/Thomashighbaugh/Vice-Base16 ${HOME}/Vice-Base16
	mkdir ${HOME}/.backgrounds
	cp -rvf ${HOME}/Vice-Base16/vice.png ${HOME}/.backgrounds
kitty:
	@echo 'Installing Terminal Emulator'
	test -L /etc/arch-release || sh ${PWD}/lib/install/kitty.sh
	test -L ${HOME}/.config/kitty || rm -rf ${HOME}/.config/kitty
	mkdir -p ${HOME}/.config/kitty
	sudo ln -sf ${PWD}/kitty/kitty.conf ${HOME}/.config/kitty/kitty.conf
	sudo ln -sf ${PWD}/kitty/theme.conf ${HOME}/.config/kitty/theme.conf
laptop:
	@echo "Configuring Your ThinkPad"
	test -L /etc/arch-release || sh ${PWD}/lib/install/laptop.sh
	sudo systemctl enable tlp.service
	sudo systemctl enable acpid
media:
	@echo 'Installing Media Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/media.sh
	yay -S --needed --noconfirm gpick coulr
minikube:
	@echo 'Installing Minikube Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/minikube.sh
	sudo usermod -a -G libvirt ${USER}
	sudo systemctl start libvirtd.service
	sudo systemctl enable libvirtd.service
	sudo systemctl start virtlogd.service
	sudo systemctl enable virtlogd.service
	minikube config set vm-driver kvm2
neofetch:
	test -L ${HOME}/.config/neofetch || rm -rf ${HOME}/.config/neofetch
	mkdir -p ${HOME}/.config/neofetch
	ln -svf ${PWD}/rc/neofetch.config ${HOME}/.config/neofetch/config.conf
neovim: vim
	@echo 'Installing Neovim Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/nvim.sh
	mkdir -p ${HOME}/.config/nvim
	ln -svf ${PWD}/nvim/init.vim ${HOME}/.config/nvim/init.vim
	sudo ln -svf ${PWD}/nvim/nvim.desktop /usr/share/applications/nvim.desktop
nvidia:
	@echo 'Installing Nvidia Drivers and Packages'
	test -L /etc/arch-release || sh ${PWD}/lib/install/nvidia.sh
pip:
	@echo 'Installing Python Packages'
	#mkdir -p ${HOME}/.local
	#curl https://pyenv.run | bash
	#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	@[ -f ${HOME}/.pyenv ] && rm -r ${HOME}/.pyenv && echo "Clearing PyEnv" || echo "No PyEnv Proceeding"
	sh ${PWD}/lib/install/pip.sh
rc:
	@echo 'Install Runtime Configurations'
	@echo 'Install Pacman Configuration Globally'
	sudo ln -svf ${PWD}/rc/pacman.conf /etc/pacman.conf
	ln -svf ${PWD}/rc/autostart.sh ${HOME}/.autostart.sh
	@echo "Install Runtime Configuration Packages"
	test -L /etc/arch-release || sh ${PWD}/lib/install/rc.sh
	@echo "Runtime Configurations"
	ln -svf ${PWD}/rc/ackrc ${HOME}/.ackrc
	ln -svf ${PWD}/rc/appimagelauncher.cfg ${HOME}/.config/appimagelauncher.cfg
	ln -svf ${PWD}/rc/picom.conf ${HOME}/.config/picom.conf
	ln -svf ${PWD}/rc/dmrc ${HOME}/.dmrc
	test -L ${HOME}/.config/dunst || rm -rf ${HOME}/.config/dunst
	mkdir -p ${HOME}/.config/dunst
	sudo ln -svf ${PWD}/rc/nanorc ${HOME}/.nanorc
	sudo systemctl enable --now fstrim.timer
	sudo systemctl start fstrim.service

rofi:
	@echo 'Install Rofi Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/rofi.sh
	ln -svf ${PWD}/rofi ${HOME}/.config/
ryzen:
	@echo 'Installing Laptop Tools'
	test -L /etc/arch-release || sh ${PWD}/lib/install/ryzen.sh
sh:
	@echo 'Install Generic Shell Configuration'
	git clone https://github.com/Thomashighbaugh/bin ${HOME}/bin
	ln -fs ${PWD}/lib/ ${HOME}/lib
	ln -fs ${PWD}/sh/aliases ${HOME}/.aliases
	ln -fs ${PWD}/sh/profile ${HOME}/.profile
	sudo ln -vsf ${DOTFILES}/rc/xterm.desktop /usr/share/applications/xterm.desktop
	sudo ln -vsf ${DOTFILES}/rc/uxterm.desktop /usr/share/applications/uxterm.desktop
	test -L /etc/arch-release || git clone https://aur.archlinux.org/aic94xx-firmware.git ${HOME}/aic94xx-firmware
	test -L /etc/arch-release || cd ${HOME}/aic94xx-firmware && makepkg -sri
	test -L /etc/arch-release || git clone https://aur.archlinux.org/wd719x-firmware.git ${HOME}/w718x-firmware 
	test -L /etc/arch-release || cd ${HOME}/w718x-firmware && makepkg -sri
	test -L /etc/arch-release || rm -r ${HOME}/w718x-firmware && ${HOME}/aic94xx-firmware 
uefi:
	@echo 'Update Firmware'
	test -L /etc/arch-release || sh ${PWD}/lib/install/uefi.sh
	sudo dmidecode -s bios-version
	fwupdmgr refresh
	fwupdmgr get-updates
	fwupdmgr update
vim:
	@echo 'Install VIM configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/vim.sh
	mkdir -p ${HOME}/.vim
	ln -sv ${PWD}/vim/vimrc ${HOME}/.vimrc
	ln -svf ${PWD}/vim ${HOME}/.vim
	ln -sv ${PWD}/vim/vim/plugins.vim ${HOME}/.vim/plugins.vim
	ln -svf ${PWD}/vim/vim/plugged ${HOME}/.vim/plugged
	ln -sv ${PWD}/vim/vim/autoload ${HOME}/.vim/autoload
X:
	@echo 'Install X Server Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/x.sh
	ln -svf ${PWD}/rc/Xresources ${HOME}/.Xresources
	mkdir -p ${HOME}/.Xresources.d
	ln -svf ${PWD}/X/color ${HOME}/.Xresources.d/color
	ln -svf ${PWD}/X/font ${HOME}/.Xresources.d/font
	ln -svf ${PWD}/X/rxvt-unicode ${HOME}/.Xresources.d/rxvt-unicode
	ln -svf ${PWD}/X/uxterm ${HOME}/.Xresources.d/uxterm
	ln -svf ${PWD}/X/xterm ${HOME}/.Xresources.d/xterm
	ln -fs ${PWD}/X/xinitrc ${HOME}/.xinitrc
	ln -fs ${PWD}/X/xprofile ${HOME}/.xprofile
	xrdb ~/.Xresources
yarn:
	@echo 'Install Node Packages'
		test -L /etc/arch-release || sh ${PWD}/lib/install/yarn-pre.sh.sh
	sh ${PWD}/lib/install/yarn.sh
zathura:
	test -L /etc/arch-release || sh ${PWD}/lib/install/zathura.sh
	test -L ${HOME}/.config/zathura || rm -rf ${HOME}/.config/zathura
	mkdir -p ${HOME}/.config/zathura
	ln -svf ${PWD}/zathura/zathurarc ${HOME}/.config/zathura/zathurarc
zsh: bash
	@echo 'Install ZSH Configuration'
	test -L /etc/arch-release || sh ${PWD}/lib/install/zsh.sh
	-curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	ln -fs ${PWD}/zsh/zshrc ${HOME}/.zshrc
	ln -fs ${PWD}/zsh/zlogout ${HOME}/.zlogout
	ln -fs ${PWD}/zsh/zshenv ${HOME}/.zshenv
	ln -sf ${PWD}/zsh/zprofile ${HOME}/.zprofile



