#!/bin/bash
export EDITOR

function not_run_from_ssh() {
    ps x | grep "${PPID}.*sshd" | grep -v grep
    echo $?
}

if [[ -x $(which nvim) ]]; then
    EDITOR=nvim
elif [[ -x $(which vim) ]]; then
    EDITOR=vim
else
    EDITOR=vi
fi
export EDITORD=${EDITORD:-$EDITOR}

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS' --color=fg:#b2bfd9,bg:#1d1e22,hl:#afffff --color=fg+:#f4f4f7,bg+:#17191e,hl+:#ff87d7 --color=info:#ff87d7,prompt:#87ffff,pointer:#87ffff --color=marker:#ff87d7,spinner:#ffff73,header:#afffff'
