
################################################################################
## Options #####################################################################
################################################################################

setopt notify
setopt inc_append_history 
setopt autolist
setopt autoremoveslash
setopt extendedhistory
setopt menucomplete
setopt allexport


setopt RM_STAR_WAIT # 10 second wait if you do something that will delete everything

setopt   globdots 
setopt   pushdtohome
setopt   cdablevars 
setopt   correctall 
setopt   autocd 
setopt   recexact 
setopt    longlistjobs
setopt   pushdsilent 
setopt   autopushd 
setopt   pushdminus 
setopt   extendedglob 
setopt   rcquotes 
setopt   mailwarning
unsetopt   bgnice 
unsetopt   autoparamslash

setopt    correct            # Auto correct mistakes
setopt    extendedglob       # Extended globbing. Allows using regular expressions with *
setopt    nocaseglob         # Case insensitive globbing
setopt    rcexpandparam      # Array expension with parameters
setopt    nocheckjobs        # Don't warn about running processes when exiting
setopt    numericglobsort    # Sort filenames numerically when it makes sense
setopt    nobeep             # No beep
setopt    appendhistory      # Immediately append history instead of overwriting
setopt    histignorealldups  # If a new command is a duplicate, remove the older one
setopt    autocd             # if only directory path is entered, cd there.


### Autoload zsh modules when they are referenced

autoload -U history-search-end
zmodload -a zsh/stat stat
zmodload -a zsh/zpty zpty
zmodload -a zsh/zprof zprof
# zmodload -ap zsh/mapfile mapfile
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end