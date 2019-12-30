.PHONY: git rc shell bash zsh vim neovim ranger X 
all: .PHONY
bash:
	ln -fs ${PWD}/bash/bashrc ${HOME}/.bashrc
	ln -fs ${PWD}/bash/bashenv ${HOME}/.bashenv
	ln -fs ${PWD}/bash/bashprofile ${HOME}/.bash_profile
	ln -fs ${HOME}/.aliases ${HOME}/.bashalias
git:
	ln -fs ${PWD}/git/gitconfig ${HOME}/.gitconfig
	ln -fs ${PWD}/git/gitignore ${HOME}/.gitignore
neovim: ## Init neovim
	pkg install neovim
	mkdir -p ${HOME}/.config/nvim
	ln -svf ${PWD}/nvim/init.vim ${HOME}/.config/nvim/init.vim
ranger:
	pkg install ranger 
	ln -svf ${PWD}/ranger ${HOME}/.config/ranger
rc:
	pkg install neofetch 
	test -L ${HOME}/.config/neofetch || rm -rf ${HOME}/.config/neofetch
	mkdir -p ${HOME}/.config/neofetch 
	ln -svf ${PWD}/rc/neofetch.config ${HOME}/.config/neofetch/config.conf
shell: ## provides general shell variables
	ln -fns ${PWD}/bin/ ${HOME}/bin
	ln -fs ${PWD}/sh/aliases ${HOME}/.aliases
	ln -fs ${PWD}/sh/profile ${HOME}/.profile
vim:
	mkdir -p ${HOME}/.vim 
	ln -sv ${PWD}/vim/vimrc ${HOME}/.vimrc
	ln -svf ${PWD}/vim ${HOME}/.vim
	ln -sv ${PWD}/vim/vim/plugins.vim ${HOME}/.vim/plugins.vim
	ln -svf ${PWD}/vim/vim/plugged ${HOME}/.vim/plugged
	ln -sv ${PWD}/vim/vim/autoload ${HOME}/.vim/autoload
X:
	ln -fs ${PWD}/rc/Xresources ${HOME}/.Xdefaults
	xrdb ~/.Xresources
zsh:
	 ##curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
	ln -fs ${PWD}/zsh/zshrc ${HOME}/.zshrc
	ln -fs ${PWD}/zsh/zlogout ${HOME}/.zlogout
	ln -fs ${PWD}/zsh/zshenv ${HOME}/.zshenv
	ln -sf ${PWD}/zsh/zprofile ${HOME}/.zprofile
