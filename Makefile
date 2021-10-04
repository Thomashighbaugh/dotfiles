all: core repos dotfiles

core: 
	sh ${HOME}/dotfiles/void-setup/setup-system-core.sh 

repos:
	sh ${PWD}/dotfiles/void-setup/setup-repos.sh 

dotfiles: 
	sh ${PWD}/dotfiles/void-setup/setup-dotfiles.sh
