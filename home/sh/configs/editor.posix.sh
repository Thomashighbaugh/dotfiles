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
