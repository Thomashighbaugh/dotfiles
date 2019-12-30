.PHONY: uefiupdate bleachbit cloud git rc shell bash zsh tmux vim gtk fonts awesome blackarch kitty alacritty xterm termite nvm emacs neovim curl ruby minikube kind redis ranger neovim X chunk awesome kitty bash zsh gnupg rofi tilix pcmanfm docker postgresql redis yarn packages suru
all: .PHONY

DOTFILES := $(shell DOTFILES)
uefiupdate: ## Update system firmware and uefi
	sudo pacman -S --noconfirm fwupd dmidecode
	sudo dmidecode -s bios-version
##fwupdmgr refresh
##	fwupdmgr get-updates
##	fwupdmgr update
cloud: 
	yay -S --noconfirm  pcloud-drive 
	sudo pacman -S --noconfirm rclone git-crypt gnupg
git:
	ln -fs ${PWD}/git/gitconfig ${HOME}/.gitconfig
	ln -fs ${PWD}/git/gitignore ${HOME}/.gitignore
	ln -fs ${PWD}/git/gitcommit ${HOME}/.gitcommit
shell: ## provides general shell variables
	ln -fns ${PWD}/bin/ ${HOME}/bin
	ln -fs ${PWD}/sh/aliases ${HOME}/.aliases
	ln -fs ${PWD}/sh/profile ${HOME}/.profile
bash:
	sudo ln -fs ${PWD}/bash/bashrc ${HOME}/.bashrc
	sudo ln -fs ${PWD}/bash/bashenv ${HOME}/.bashenv
	sudo ln -fs ${PWD}/bash/bashprofile ${HOME}/.bash_profile
	sudo ln -fs ${HOME}/.aliases ${HOME}/.bashalias
zsh:
	sudo ln -fs ${PWD}/zsh/zshrc ${HOME}/.zshrc
	sudo ln -fs ${PWD}/zsh/zlogout ${HOME}/.zlogout
	sudo ln -fs ${PWD}/zsh/zshenv ${HOME}/.zshenv
	sudo ln -sf ${PWD}/zsh/zprofile ${HOME}/.zprofile
	mkdir -p ${HOME}/.config/zsh/
tmux: ## init tmux with tmuxp for session management
	sudo pacman -S --noconfirm  tmuxp tmux
	mkdir -p ${HOME}/.tmuxp
	sudo ln -fs ${PWD}/tmux/tmux.conf ${HOME}/.tmux.conf
	sudo ln -fs ${PWD}/tmux/tmux.conf.local ${HOME}/.tmux.conf.local
	sudo ln -vsf ${PWD}/tmux/tmuxp/main.yml ${HOME}/.tmuxp/main.yml
	sudo ln -vsf ${PWD}/tmux/tmuxp/ranger.yml ${HOME}/.tmuxp/ranger.yml
	sudo git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
blackarch:
	curl -O https://blackarch.org/strap.sh
	sudo chmod +x strap.sh
	sudo ./strap.sh
vim:
	sudo ln -sf ${PWD}/vim/vimrc ${HOME}/.vimrc
	sudo ln -sf ${PWD}/vim/vim_runtime ${HOME}/.vim_runtime
	sudo ln -sf ${PWD}/vim/viminfo ${HOME}/.viminfo
gtk:
	sudo pacman -S --noconfirm  gtk-theme-config gtk-engines exo-gtk3 p7zip
	mkdir -p ${HOME}/.config/gtk-2.0
	sudo ln -svf ${PWD}/gtk/gtk-2.0 ${HOME}/.config/gtk-2.0
	mkdir -p ${HOME}/.config/gtk-3.0
	sudo ln -svf ${PWD}/gtk/gtk-3.0 ${HOME}/.config/gtk-3.0
	sudo ln -svf ${PWD}/gtk/gtkrc-2.0 ${HOME}/.gtkrc-2.0
	mkdir -p ${HOME}/.config/Kvantum
	sudo ln -svf ${PWD}/gtk/kvantum.kvconfig ${HOME}/.config/Kvantum/kvantum.kvconfig
	sudo pacman -S kvantum-theme-arc numix-themes-archblue  arc-gtk-theme 
awesome:
	sudo pacman -S --noconfirm lain rlwrap dex xcb-util-errors awesome-freedesktop vicious
	mkdir -p ${HOME}/.config/awesome
##	sudo ln -svf ${PWD}/awesome/rc.lua ${HOME}/.config/awesome/rc.lua
##	sudo ln -svf ${PWD}/awesome/icons ${HOME}/.config/awesome/icons
##	sudo ln -svf ${PWD}/awesome/bars ${HOME}/.config/awesome/bars
##	sudo ln -svf ${PWD}/awesome/noodle ${HOME}/.config/awesome/noodle
##	sudo ln -svf ${PWD}/awesome/themes ${HOME}/.config/awesome/themes
##	sudo ln -svf ${PWD}/awesome/icons ${HOME}/.config/awesome/icons
##	sudo ln -svf ${PWD}/awesome/keys.lua ${HOME}/.config/awesome/keys.lua
##	sudo ln -svf ${PWD}/awesome/notifications.lua ${HOME}/.config/awesome/notifications.lua
##	sudo ln -svf ${PWD}/awesome/profile.lua ${HOME}/.config/awesome/notifications.lua
##	sudo ln -svf ${PWD}/awesome/helpers.lua ${HOME}/.config/awesome/helpers.lua
##	sudo ln -svf ${PWD}/awesome/titlebars.lua ${HOME}/.config/awesome/titlebars.lua
##	sudo ln -svf ${PWD}/awesome/autostart.sh ${HOME}/.config/awesome/autostart.sh
##	sudo ln -svf ${PWD}/awesome/evil ${HOME}/.config/awesome/evil
##	sudo ln -svf ${PWD}/awesome/autostart.sh ${HOME}/.config/awesome/autostart.sh
##	sudo ln -svf ${PWD}/awesome/lib ${HOME}/.config/awesome/lib
X: 
	mkdir -p ${HOME}/.Xresources.d
	sudo ln -fs ${PWD}/rc/Xresources ${HOME}/.Xresources
	sudo ln -svf ${PWD}/Xresources.d/color ${HOME}/.Xresources.d/color
	sudo ln -svf ${PWD}/Xresources.d/font ${HOME}/.Xresources.d/font
	sudo ln -svf ${PWD}/Xresources.d/rxvt-unicode ${HOME}/.Xresources.d/rxvt-unicode
	sudo ln -fs ${PWD}/rc/Xresources ${HOME}/.Xdefaults
	sudo ln -fs ${PWD}/rc/xinitrc ${HOME}/.xinitrc

rc:
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
	sudo ln -svf ${PWD}/ack/ackrc ${HOME}/.ackrc
	sudo ln -svf ${PWD}/rc/Trolltech.conf ${HOME}/.config/Trolltech.conf 
	sudo ln -svf ${PWD}/xfce4 ${HOME}/.config/xfce4
	xrdb ~/.Xresources
kitty:
	sudo pacman -S --noconfirm kitty
	mkdir -p ${HOME}/.config/kitty
	sudo ln -fs ${PWD}/kitty/kitty.conf ${HOME}/.config/kitty/kitty.conf
	sudo ln -fs ${PWD}/kitty/colors.conf ${HOME}/.config/kitty/colors.conf
docker: ## Docker initial setup
	sudo pacman -S --noconfirm docker
	yay -S --needed --noconfirm docker-compose 
	sudo usermod -aG docker ${USER}
	mkdir -p ${HOME}/.docker
	sudo ln -vsf ${PWD}/.docker/config.json ${HOME}/.docker/config.json
	sudo systemctl enable docker.service
	sudo systemctl start docker.service
##minikube: ## Setup minikube with kvm2
########sudo pacman -S --noconfirm minikube libvirt qemu-headless ebtables docker-machine
########yay -S --needed --noconfirm docker-machine-driver-kvm2
########sudo usermod -a -G libvirt ${USER}
########sudo systemctl start libvirtd.service
########sudo systemctl enable libvirtd.service
########sudo systemctl start virtlogd.service
########sudo systemctl enable virtlogd.service
########minikube config set vm-driver kvm2
##postgresql: ## Postgresql initial setup
##	sudo pacman -S postgresql
##	sudo -u postgres initdb -E UTF8 --no-locale -D '/var/lib/postgres/data'
##	sudo systemctl enable postgresql.service
##	sudo systemctl start postgresql.service
##	sudo -u postgres createuser --interactive
##redis: ## Redis inital setup
##	sudo pacman -S --noconfirm redis
##	sudo systemctl enable redis.service
nvm:
	test -L ${HOME}/.zsh-nvm || rm -rf ${HOME}/.zsh-nvm
	git clone https://github.com/lukechilds/zsh-nvm.git ${HOME}/.zsh-nvm
yarn:
	sudo pacman -S  --noconfirm yarn npm
	yarn global add babel-eslint
	yarn global add @babel/preset-react
	yarn global add babel-loader
	yarn global add babel-preset-react-app
	yarn global add cloc
	yarn global add create-component-app
	yarn global add create-react-app
	yarn global add eslint
	yarn global add eslint-cli
	yarn global add eslint-config-vue
	yarn global add eslint-plugin-react
	yarn global add eslint-plugin-jsx-a11y  
	yarn global add eslint-plugin-vue@next
	yarn global add eslint-config-prettier 
	yarn global add eslint-plugin-html
	yarn global add eslint-plugin-babel
	yarn global add fx
	yarn global add gulp
	yarn global add neovim
	yarn global add gulp-cli
	yarn global add heroku
	yarn global add jshint
	yarn global add netlify-cli
	yarn global add nextjs
	yarn global add fastify-nextjs
	yarn global add prettier
	yarn global add prettier-eslint
	yarn global add webpack
	yarn global add gatsby-cli
	yarn global add storybook
	yarn install
	yarn autoclean --force
	yarn upgrade
neovim: ## Init neovim
	sudo pacman -S --noconfirm neovim
	mkdir -p ${HOME}/.config/nvim
	sudo ln -svf ${PWD}/nvim/init.vim ${HOME}/.config/nvim/init.vim
	sudo ln -svf ${PWD}/nvim/nvim.desktop /usr/share/applications/nvim.desktop
	sudo ln -svf ${PWD}/nvim/colors ${HOME}/.config/nvim/colors
	sudo ln -svf ${PWD}/nvim/autoload ${HOME}/.config/nvim/autoload 
	sudo ln -svf ${PWD}/nvim/statusline.vim ${HOME}/.config/nvim/statusline.vim
emacs:
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	sudo pacman -S --noconfirm emacs
	sudo ln -svf ${PWD}/emacs/spacemacs ${HOME}/.spacemacs
	sudo  cp -rnv ${PWD}/emacs/emacs.d ${HOME}/.emacs.d
	test -L ${HOME}/org || rm -rf ${HOME}/org
	sudo ln -svf ../${PWD}/org ${HOME}/org
bleachbit:
	sudo pacman -S --noconfirm bleachbit 
alacritty: ## Init alacritty
	sudo pacman -S --noconfirm alacritty
	test -L ${HOME}/.config/alacritty/alacritty.yml || rm -rf ${HOME}/.config/alacritty/alacritty.yml
	mkdir -p ${HOME}/.config/alacritty
	sudo ln -vsf ${DOTFILES}/alacritty ${HOME}/.config/alacritty
xterm: ## Init xterm terminal
	sudo pacman -S --noconfirm xterm
	sudo ln -vsf ${DOTFILES}/rc/.Xresources ${HOME}/.Xresources
	sudo ln -vsf ${DOTFILES}/rc/xterm.desktop /usr/share/applications/xterm.desktop
	sudo ln -vsf ${DOTFILES}/rc/uxterm.desktop /usr/share/applications/uxterm.desktop
termite: ## Init termite terminal
	sudo pacman -S --noconfirm termite
	mkdir -p ${HOME}/.config/termite
	sudo ln -vsf ${PWD}/termite/config ${HOME}/.config/termite/config
ranger:
	sudo pacman -S --noconfirm ranger 
	sudo ln -svf ${PWD}/ranger ${HOME}/.config/ranger
rofi:
	sudo pacman -S --noconfirm rofi zathura neofetch dunst
	mkdir -p  ${HOME}/.config/rofi
	sudo ln -svf ${PWD}/rofi/config.rasi ${HOME}/.config/rofi/config.rasi
	sudo ln -svf ${PWD}/rofi/colors.rasi ${HOME}/.config/rofi/colors.rasi
	mkdir -p  ${HOME}/.config/dunst
	sudo ln -svf ${PWD}/rofi/dunstrc ${HOME}/.config/dunst/dunstrc
pcmanfm:
	sudo pacman -S --noconfirm pcmanfm-gtk3
	mkdir -p ${HOME}/.config/pcmanfm
	sudo ln -svf ${PWD}/pcmanfm ${HOME}/.config/pcmanfm
ruby: ## Install rvenv ruby-build
	yay -S --noconfirm rbenv-git rubygems
	yay -S --noconfirm ruby-build-git
	#rbenv install 2.6.0
	#gem install neovim bundler jekyll sass gollum
fonts:
	sudo mkdir -p ${HOME}/.local/share/fonts
	sudo cp -rnv ${PWD}/fonts/* /usr/share/fonts/ 
	sudo cp -rnv ${PWD}/fonts/* ${HOME}/.local/share/fonts
	sudo fc-cache -vf
suru:
	yay -S --noconfirm suru-plus-git 
packages: ## split into categories and repo vs aur commands. Split by line in order to mitigate any packages no longer in existance so there is not a loss of all packages
## Archive
	sudo pacman -S --noconfirm lzop p7zip unzip unrar atool hashdeep ddrescue bzip2 gzip lha lrzip lz4 lzip lzop p7zip tar unarj unrar unzip xz arj zip
## X-Server
	sudo pacman -S  --noconfirm autorandr compton compton-conf neofetch xdg-utils xdotool rofi-pass srandrd xorg-server
	sudo pacman -S  --noconfirm xorg-server-xdmx xorg-server-xnest xorg-sessreg xorg-xclipboard xorg-xdpyinfo xorg-xev xorg-xfd xorg-xinit
	sudo pacman -S  --noconfirm xdotool packer ripgrep stunnel xorg-xprop
	sudo pacman -S  --noconfirm powerline  screen mosh diskus screen
## browsers
	sudo pacman -S  --noconfirm firefox-developer-edition falkon min browserpass
	sudo pacman -S  --noconfirm chromium poppler-data
	yay -S --noconfirm --needed basilisk-bin
## Media
	sudo pacman -S --noconfirm alsa-firmware alsa-utils ffmpeg ffmpegthumbnailer gimp lightdm-gtk-greeter
	sudo pacman -S  --noconfirm imagemagick lightdm-gtk-greeter-settings tmuxp pulseaudio-bluetooth pulseaudio-ctl ffmpeg asciidoc
	sudo pacman -S  --noconfirm pulseaudio-zeroconf mpv mtpfs mtr python-mpd2
	yay -S --noconfirm --needed spotify
## Security
	sudo pacman -S --noconfirm pass pass-otp patch dnsmasq
## Languages, Editors & VCS
	sudo pacman -S --noconfirm diffutils git ruby highlight  diffutils git ruby go neovim aspell aspell-en
	sudo pacman -S  --noconfirm highlight texinfo texmaker
	yay -S --noconfirm awesome-terminal-fonts awesome-themes-git jetbrains-toolbox
## System Internals
	sudo pacman -S --noconfirm lain vicious gnome-disk-utility gnome-keyring grep  keychain less pandoc
	sudo pacman -S  --noconfirm zathura zathura-djvu zathura-pdf-poppler  dosfstools ntfs-3g exfat-utils fatresize udftools arj binutils cpio
	sudo pacman -S  --noconfirm pcmanfm-gtk3 zstd exfat-utils xdotool 
	sudo pacman -S  --noconfirm f2fs-tools  cryptsetup gnome-disk-utility sysfsutils sysstat systemd gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs
	sudo pacman -S  --noconfirm gvfs-smb systemd-fsck-silent dosfstools btrfs-progs jfsutils udiskie udisks2 unace unclutter ecryptfs-utils sshfs
	sudo pacman -S   --noconfirm gnu-netcat dnsmasq  avahi  sshuttle inetutils iproute2 iptables iputils fping syncthing 
	yay -S --needed  --noconfirm autossh net-tools nethogs network-manager-applet networkmanager bleachbit proggyfonts  
	sudo pacman -S  --noconfirm the_silver_searcher cifs-utils elinks scrot bind-tools python-virtualenv python-virtualenvwrapper maim
## Packaging Tools
	sudo pacman -S  --noconfirm packagekit pkgfile pkgconfig snapd debian-archive-keyring yajl rmlint lostfiles zsh-completions
	sudo pacman -S  --noconfirm cmake meson autoconf automake xarchiver zsh-syntax-highlighting  fzf  shellcheck bash-completion
	sudo pacman -S  --noconfirm debootstrap  lynx python-pip  pkgconf flatpak autoconf autocutsel automake
	sudo pacman -S  --noconfirm ansible ansible-lint autopep8 make e2fsprogs packagekit tldr trash-cli ranger yapf youtube-dl
	yay -S --needed  --noconfirm manjaro-tools-base manjaro-tools-iso manjaro-tools-pkg arch-install-scripts mycli pgcli
	yay -Syyuu
