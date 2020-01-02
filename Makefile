.PHONY: uefiupdate kitty laptop awesome archive disk rc zsh bash sh X tmux vim neovim rofi browsers docker dev emacs fonts git gtk templates android media netsec minikube postgresql redis pip yarn

all: .PHONY
android: 
	yay -S --needed --noconfirm android-bash-completion shashlik-bin archon raccoon adbfs-rootless-git  android-udev android-file-transfer smali android-messages-desktop mobydroid
archive:
	sudo pacman -S --noconfirm lzop p7zip unzip unrar atool hashdeep ddrescue bzip2 gzip lha lrzip lz4 lzip lzop p7zip tar unarj unrar unzip xz arj
	sudo pacman -S  --noconfirm zip cpio xarchiver file-roller 
	sudo pacman -S  --noconfirm packagekit pkgfile pkgconfig snapd debian-archive-keyring yajl rmlint lostfiles cmake meson autoconf automake
	sudo pacman -S  --noconfirm  debootstrap lynx pkgconf flatpak autoconf autocutsel automake autopep8 make e2fsprogs packagekit bauh snapd
	sudo systemctl enable snapd
	sudo systemctl start snapd
awesome:
	yay -S --noconfirm --needed awmtt feh networkmanager-dmenu-git lain rlwrap dex xcb-util-errors awesome-freedesktop vicious 
	yay -S --needed  awesome-git
	test -L ${HOME}/.config/awesome||  sudo rm -rf ${HOME}/.config/awesome
	sudo mkdir -p ${HOME}/.config/awesome
	sudo ln -sf ${PWD}/awesome/rc.lua ${HOME}/.config/awesome/rc.lua
	sudo ln -sf ${PWD}/awesome/main ${HOME}/.config/awesome/main
	sudo ln -sf ${PWD}/awesome/deco ${HOME}/.config/awesome/deco
	sudo ln -sf ${PWD}/awesome/binding ${HOME}/.config/awesome/binding
	sudo ln -sf ${PWD}/awesome/autorun.sh ${HOME}/.config/awesome/autorun.sh
	sudo ln -sf ${PWD}/awesome/themes ${HOME}/.config/awesome/themes

bash:
	sudo pacman -S --noconfirm bash-completion shellharden 
	sudo ln -fs ${PWD}/bash/bashrc ${HOME}/.bashrc
	sudo ln -fs ${PWD}/bash/bashenv ${HOME}/.bashenv
	sudo ln -fs ${PWD}/bash/bashprofile ${HOME}/.bash_profile
	sudo ln -fs ${HOME}/.aliases ${HOME}/.bashalias
browsers:
	sudo pacman -S  --noconfirm firefox-developer-edition falkon min browserpass chromium poppler-data links lynx w3m brave browserpass 
	sudo pacman -S  --noconfirm elinks  netsurf palemoon-bin 
	yay -S --noconfirm --needed basilisk-bin ice-ssb firefox-adblock-plus firefox-tree-style-tab 
	yay -S --noconfirm --needed firefox-extension-trackmenot  firefox-extension-https-everywhere firefox-extension-tab-session-manager 
	yay -S --noconfirm --needed firefox-extension-temporary-containers firefox-extension-privacybadger firefox-ublock-origin
	git clone https://github.com/Thomashighbaugh/startpage ${HOME}/startpage
	sudo ln -svf ${PWD}/firefox/autoconfig.cfg /usr/lib/firefox/autoconfig.cfg
	sudo ln -svf ${PWD}/firefox/autoconfig.js /usr/lib/firefox/defaults/pref/autoconfig.js
	sudo mkdir -p /usr/lib/firefox/chrome
	sudo ln -svf ${PWD}/firefox/userChrome.css /usr/lib/firefox/chrome/userChrome.css
	sudo ln -svf ${PWD}/firefox/TreeStyleTab.css /usr/lib/firefox/chrome/TreeStyleTab.css
	sudo ln -svf ${PWD}/firefox/userContent.css /usr/lib/firefox/chrome/userContent.css
dev:
	sudo pacman -S --noconfirm diffutils git ruby highlight diffutils git go highlight texinfo pandoc  ansible ansible-lint zeal devhelp 
	yay -S --noconfirm jetbrains-toolbox python-virtualenv python-virtualenvwrapper 
	yay -S --noconfirm --needed rbenv-git rubygems
	yay -S --noconfirm --needed ruby-build-git
	#rbenv install 2.6.5
	gem install neovim bundler jekyll sass gollum
	yay -S --needed --noconfirm rustup
	rustup default stable
	rustup component add rls rust-analysis rust-src


disk: 
	sudo pacman -S --noconfirm gnome-disk-utility gnome-keyring keychain less dosfstools ntfs-3g exfat-utils fatresize udftools zstd exfat-utils 
	sudo pacman -S --noconfirm  octopi f2fs-tools sysfsutils gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-nfs gvfs-smb dosfstools btrfs-progs jfsutils udiskie 
	sudo pacman -S --noconfirm udisks2 sshfs the_silver_searcher vivid cifs-utils trash-cli rclone git-crypt gnupg borg bleachbit flatpak 
	yay -S --noconfirm --needed vorta ruby-colorls 
	sudo pacman -S --noconfirm pcmanfm-gtk3
	mkdir -p ${HOME}/.config/pcmanfm
	sudo ln -svf ${PWD}/pcmanfm ${HOME}/.config/pcmanfm
	sudo pacman -S --noconfirm ranger 
#	test -L ${HOME}/.config/ranger || rm -rf ${HOME}/.config/ranger
#	mkdir -p ${HOME}/.config/ranger
#	sudo ln -svf ${PWD}/rc/rc.conf ${HOME}/.config/ranger/rc.conf

docker: 
	sudo pacman -S --noconfirm docker
	yay -S --needed --noconfirm docker-compose 
	sudo usermod -aG docker ${USER}
	sudo systemctl enable docker.service
	sudo systemctl start docker.socket
	sudo systemctl enable docker.socket
	sudo systemctl start docker.service
	sudo ln -svf ${PWD}/docker ${HOME}/docker
emacs:
	sudo pacman -S --noconfirm emacs
	sudo ln -svf ${PWD}/emacs/spacemacs ${HOME}/.spacemacs
	test -L ${HOME}/org || rm -rf ${HOME}/org
	sudo ln -svf ../${PWD}/org ${HOME}/org
	test -L ${HOME}/.emacs.d || rm -rf ${HOME}/.emacs.d
	git clone https://github.com/syl20bnr/spacemacs ${HOME}/.emacs.d
fonts:
	yay -S --noconfirm --needed nerd-fonts-complete 
	sudo mkdir -p ${HOME}/.local/share/fonts
	sudo cp -rv ${PWD}/fonts/fonts.tar.7z ${HOME}/.local/share/fonts
	sudo 7z x -so ${HOME}/.local/share/fonts/fonts.tar.7z | sudo tar xf - -C ${HOME}/.local/share/fonts
	sudo cp -rnv ${HOME}/.local/share/fonts /usr/share/fonts
	sudo fc-cache -vf && fc-cache -vf 

git:
	sudo ln -fs ${PWD}/git/gitconfig ${HOME}/.gitconfig
	sudo ln -fs ${PWD}/git/gitignore ${HOME}/.gitignore
	sudo ln -fs ${PWD}/git/gitcommit ${HOME}/.gitcommit 
	#git clone https://github.com/Thomashighbaugh/Personal-Knowledge-Wiki ${HOME}/Personal-Knowledge-Wiki
gtk:
	sudo pacman -S --noconfirm  gtk-theme-config gtk-engines exo-gtk3 p7zip 
	#yay -S --needed --noconfirm oomox-git
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
	yay -S --noconfirm suru-plus-git 
	wget -qO- https://git.io/fhQdI | sh
	suru-plus-folders -C aurora --theme Suru++
	sudo cp -rv /usr/share/icons/Suru++/* /usr/share/icons/hicolor ## overwrites the hicolor theme with Suru++ for pretty menus
	sudo ln -sfv ${PWD}/gtk/gtk-bookmarks ${HOME}/.gtk-bookmarks
kitty:
	sudo pacman -S --noconfirm kitty kitty-terminfo xterm  libvterm
	test -L ${HOME}/.config/kitty || rm -rf ${HOME}/.config/kitty
	mkdir -p ${HOME}/.config/kitty
	sudo ln -sf ${PWD}/kitty/kitty.conf ${HOME}/.config/kitty/kitty.conf
	sudo ln -sf ${PWD}/kitty/colors.conf ${HOME}/.config/kitty/colors.conf
	sudo pacman -S --noconfirm alacritty alacritty-terminfo 
	sudo ln -sf ${PWD}/alacritty ${HOME}/.config/alacritty

laptop:
	yay -S --noconfirm --needed thinkalert tlpui  powertop
	systemctl enable tlp.service
	systemctl enable tlp-sleep.service
media:
	sudo pacman -S --noconfirm alsa-firmware alsa-utils ffmpeg ffmpegthumbnailer maim scrot i3-scrot gimp imagemagick pulseaudio-bluetooth pulseaudio-ctl ffmpeg asciidoc pulseaudio-zeroconf mpv mtpfs mtr python-mpd2 youtube-dl
	yay -S --needed --noconfirm gpick coulr  
minikube: 
	sudo pacman -S --noconfirm minikube libvirt qemu-headless ebtables docker-machine
	yay -S --needed --noconfirm docker-machine-driver-kvm2
	sudo usermod -a -G libvirt ${USER}
	sudo systemctl start libvirtd.service
	sudo systemctl enable libvirtd.service
	sudo systemctl start virtlogd.service
	sudo systemctl enable virtlogd.service
	minikube config set vm-driver kvm2
neovim: 
	sudo pacman -S --noconfirm neovim
	mkdir -p ${HOME}/.config/nvim
	sudo ln -svf ${PWD}/nvim/init.vim ${HOME}/.config/nvim/init.vim
	sudo ln -svf ${PWD}/nvim/nvim.desktop /usr/share/applications/nvim.desktop
netsec:
	yay -S --noconfirm firejail-apparmor-git 
	sudo curl -O https://blackarch.org/strap.sh
	sudo chmod +x strap.sh
	sudo ./strap.sh
	sudo rm -r ${PWD}/strap.sh 
	sudo pacman -S --noconfirm metasploit armitage veil ettercap-gtk 
	sudo pacman -S --noconfirm rofi-pass pass pass-otp patch dnsmasq gnu-netcat avahi  sshuttle inetutils iproute2 iptables iputils
	yay -S --noconfirm --needed firectl  apparmor-profiles firejail-profiles firetools keybase-gui  
	sudo firectl enable wine
	sudo firectl enable thunderbird
	sudo firectl enable min
	sudo firectl enable mpv
	sudo firectl enable transmission-gtk 
	sudo firectl enable inkscape
	sudo firectl enable gimp
	sudo firectl enable chromium
	sudo firectl enable brave-browser
pip: 
	mkdir -p ${HOME}/.local
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
	python get-pip.py --user
	pip install --user --upgrade pip
	pip install --user ansible
	pip install --user ansible-lint
	pip install --user autopep8
	pip install --user awscli
	pip install --user black
	pip install --user chromedriver-binary
	pip install --user faker
	pip install --user flake8
	pip install --user graph-cli
	pip install --user httpie
	pip install --user importmagic
	pip install --user ipywidgets
	pip install --user jedi
	pip install --user jupyter
	pip install --user jupyterlab
	pip install --user jupyterthemes
	pip install --user litecli
	pip install --user mps-youtube
	pip install --user neovim
	pip install --user nose
	pip install --user opencv-python
	pip install --user pandas
	pip install --user pgcli
	pip install --user pipenv
	pip install --user progressbar2
	pip install --user psycopg2-binary
	pip install --user py-spy
	pip install --user pydoc_utils
	pip install --user pyflakes
	pip install --user pygments
	pip install --user pylint
	pip install --user redis
	pip install --user rope
	pip install --user rtv
	pip install --user scrapy
	pip install --user seaborn
	pip install --user selenium
	pip install --user speedtest-cli
	pip install --user streamlink
	pip install --user trash-cli
	pip install --user truffleHog
	pip install --user virtualenv
	pip install --user virtualenvwrapper
postgresql: 
	sudo pacman -S postgresql
	sudo -u postgres initdb -E UTF8 --no-locale -D '/var/lib/postgres/data'
	sudo systemctl enable postgresql.service
	sudo systemctl start postgresql.service
	sudo -u postgres createuser --interactive
redis: ## Redis inital setup
	sudo pacman -S --noconfirm redis
	sudo systemctl enable redis.service
rc:
	sudo pacman -S --noconfirm rofi zathura neofetch dunst
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
	yay -S rofi-dmenu udiskie-dmenu-git clipmenu morc_menu btmenu rofi-scripts rofi-pass 
	mkdir -p  ${HOME}/.config/rofi
	mkdir -p ${HOME}/.local/share/
	sudo ln -svf ${PWD}/rofi/colors.rasi ${HOME}/.config/rofi/colors.rasi
	sudo ln -svf ${PWD}/rofi/themes ${HOME}/.config/rofi
	sudo ln -svf ${PWD}/rofi/config.rasi ${HOME}/.config/rofi/config.rasi 
sh: 
	sudo ln -fns ${PWD}/bin/ ${HOME}/bin
	sudo ln -fs ${PWD}/sh/aliases ${HOME}/.aliases
	sudo ln -fs ${PWD}/sh/profile ${HOME}/.profile
	sudo ln -vsf ${DOTFILES}/rc/xterm.desktop /usr/share/applications/xterm.desktop
	sudo ln -vsf ${DOTFILES}/rc/uxterm.desktop /usr/share/applications/uxterm.desktop

templates: 
	test -L ${HOME}/Templates || rm -rf ${HOME}/Templates
	mkdir -p ${HOME}/Templates
	sudo ln -sf ${PWD}/templates ${HOME}/Templates

tmux: 
	sudo pacman -S --noconfirm tmuxp tmux
	mkdir -p ${HOME}/.tmuxp
	sudo ln -fs ${PWD}/tmux/tmux.conf ${HOME}/.tmux.conf
	sudo ln -vsf ${PWD}/tmux/tmuxp/main.yml ${HOME}/.tmuxp/main.yml
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

uefiupdate: 
	sudo pacman -S --noconfirm fwupd dmidecode
	sudo dmidecode -s bios-version
	fwupdmgr refresh
	fwupdmgr get-updates
	fwupdmgr update
vim:
	mkdir -p ${HOME}/.vim 
	sudo ln -sv ${PWD}/vim/vimrc ${HOME}/.vimrc
	sudo ln -svf ${PWD}/vim ${HOME}/.vim
	sudo ln -sv ${PWD}/vim/vim/plugins.vim ${HOME}/.vim/plugins.vim
	sudo ln -svf ${PWD}/vim/vim/plugged ${HOME}/.vim/plugged
	sudo ln -sv ${PWD}/vim/vim/autoload ${HOME}/.vim/autoload
X:
	sudo pacman -S  --noconfirm  xorg-server-xnest xorg-sessreg xorg-xclipboard xorg-xdpyinfo xorg-xfd
	sudo pacman -S --noconfirm xorg-xinit xorg-xev xdotool screen stunnel xorg-xprop autorandr xdg-utils xdotool srandrd
	sudo pacman -S --noconfirm xorg-server diskus screen mosh
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
	sudo pacman -S  --noconfirm yarn npm
	yarn global add babel-eslint
	yarn global add @babel/preset-react
	yarn global add babel-loader
	yarn global add babel-core
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
	yarn global add expo-cli
	yarn global add fastify-nextjs
	yarn global add fx
	yarn global add gulp
	yarn global add neovim
	yarn global add gulp-cli
	yarn global add heroku
	yarn global add jshint
	yarn global add netlify-cli
	yarn global add nextjs
	yarn global add now
	yarn global add prettier
	yarn global add prettier-eslint
	yarn global add react
	yarn global add react-dom
	yarn global add webpack
	yarn global add gatsby-cli
	yarn global add storybook
	yarn global add next
	yarn global add types
	yarn global add eslint 
	yarn global add corejs
	yarn install
	yarn autoclean --force
	yarn upgrade
zsh:
	sudo pacman -S --noconfirm zsh-completions  zsh-syntax-highlighting 
	curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	yay -S --noconfirm --needed zplug powerline 
	sudo ln -fs ${PWD}/zsh/zshrc ${HOME}/.zshrc
	sudo ln -fs ${PWD}/zsh/zlogout ${HOME}/.zlogout
	sudo ln -fs ${PWD}/zsh/zshenv ${HOME}/.zshenv
	sudo ln -sf ${PWD}/zsh/zprofile ${HOME}/.zprofile




