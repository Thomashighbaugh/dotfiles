#!/bin/bash
# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm* | rxvt* | Eterm | aterm | kterm | gnome* | alacritty)
        export  TERM_TITLE=$'\e]0;${chroot:+($chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
    *) ;;
    
esac


# Print the previously configured title
print -Pnr -- "$TERM_TITLE"

