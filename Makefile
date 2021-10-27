all: core repos dotfiles

core:
	sh ${HOME}/dotfiles/setup/setup-system-core.sh

repos:
	sh ${PWD}/dotfiles/setup/setup-repos.sh

dotfiles:
	sh ${PWD}/dotfiles/setup/setup-dotfiles.sh
