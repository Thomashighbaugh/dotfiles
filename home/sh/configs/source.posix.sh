#!/bin/bash
## RUST #########################################################################

if [[ -f $HOME/.cargo/env ]]; then
    source $HOME/.cargo/env
fi


##  NVM ########################################################################
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
