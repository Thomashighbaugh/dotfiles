################################################################################
## Options #####################################################################
################################################################################

setopt notify
setopt inc_append_history
setopt autoremoveslash
setopt extendedhistory
setopt menucomplete
setopt allexport

setopt auto_list     # Automatically list choices on ambiguous completion
setopt auto_menu     # Automatically use menu completion
setopt always_to_end # Move cursor to end if word had one match

setopt RM_STAR_WAIT # 10 second wait if you do something that will delete everything

setopt globdots
setopt pushdtohome
setopt cdablevars
setopt correctall
setopt recexact
setopt longlistjobs
setopt pushdsilent
setopt autopushd
setopt pushdminus
setopt rcquotes
unsetopt bgnice
unsetopt autoparamslash

setopt correct         # Auto correct mistakes
setopt extendedglob    # Extended globbing. Allows using regular expressions with *
setopt nocaseglob      # Case insensitive globbing
setopt rcexpandparam   # Array expension with parameters
setopt nocheckjobs     # Don't warn about running processes when exiting
setopt numericglobsort # Sort filenames numerically when it makes sense
setopt autocd          # if only directory path is entered, cd there.

autoload -U history-search-end

zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

