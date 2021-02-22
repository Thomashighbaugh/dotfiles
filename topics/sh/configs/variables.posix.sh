#!/bin/env sh
####################################################################
## posix variables #################################################
####################################################################

## git  ############################################################
export GIT_SSH="$HOME/bin/git-ssh"

## Config Directory ################################################
export XDG_CONFIG_HOME="$HOME/.config"

## Editor ##########################################################
unset EDITOR
unset EDITORD

if [[ -s $(which /usr/bin/vim) ]]; then
	export EDITOR=/usr/bin/vim
elif [[ -s $(which /usr/bin/nvim) ]]; then
	export EDITOR=/usr/bin/nvim
else
	export EDITOR=vi
fi
export EDITORD=${EDITORD:-$EDITOR}
export GUI_EDITOR=/usr/share/applications/sublime-text.desktop

## XDG #############################################################
export XDG_CONFIG_DIRS=/etc/xdg

## GOLANG ##########################################################
export GOPATH=$HOME/go
export GO15VENDOREXPERIMENT=1

## OS ##############################################################
export OS=$(uname -s)
export ARCH=$(uname -m)

## Pager ###########################################################
export PAGER="less"
export LESS="-RMin"
export RI_PAGER='less -FX'

## History #########################################################
export SAVEHIST=9999
export HISTSIZE=9999
export HISTFILE=$HOME/.history
export HIST_EXPIRE_DUPS_FIRST=true

## Personal Email ##################################################
export EMAIL="thighbaugh@zoho.com"

## Color man pages #################################################
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r

## NVM #############################################################
export NVM_DIR="$HOME/.nvm"

## DATE  ###########################################################
export DATE=$(date +%s)

## Term ######################################################################
export TERM="xterm-256color"
export TERMINFO=~/.terminfo

## QT ##########################################################################
export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0

## Hostname ################################################################
HOSTNAME=/etc/hostname

# ## LS Colors ######################################################################
# LS_COLORS='rs=0:di=01;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32:'

## Locale ######################################################################
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

## Personal Email ##############################################################
export EMAIL="thighbaugh@zoho.com"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

GIT_DISCOVERY_ACROSS_FILESYSTEM=1
