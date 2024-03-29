#!/bin/bash
################################################################################
## Path Modification ###########################################################
################################################################################

## Node ##################################################################################################

if [[ -d "$XDG_CONFIG_HOME/yarn/global/node_modules/.bin" ]]; then
    export PATH="$XDG_CONFIG_HOME/yarn/global/node_modules/.bin:$PATH"
fi

if [[ -d "$HOME/.yarn/bin" ]]; then
    export PATH="$HOME/.yarn/bin:$PATH"
fi

if [[ -d "$HOME/.nvm" ]]; then
    export PATH="$HOME/.nvm:$PATH"
fi
if [[ -d "$HOME/.config/nvm" ]]; then
    export PATH="$HOME/.config/nvm:$PATH"
fi
## For system wide installs like with AUR packages
if [[ -d "/usr/share/nvm" ]]; then
    export PATH="/usr/share/nvm:$PATH"
fi

if [[ -d "$HOME/.nvm/versions/node/v16.15.1/bin" ]]; then 
  export PATH="$HOME/.nvm/versions/node/v16.15.1/bin:$PATH"
fi
# Ruby Gems ################################################################################################

if [[ -d "/usr/lib/ruby/gems/2.7.0" ]]; then
    export PATH="/usr/lib/ruby/gems/2.7.0:$PATH"
fi

if [[ -d "$HOME/.local/share/gem/ruby/3.0.0" ]]; then
    export PATH="$HOME/.local/share/gem/ruby/3.0.0:$PATH"
fi

if [[ -d "$HOME/.local/share/gem/ruby/3.0.3" ]]; then
    export PATH="$HOME/.local/share/gem/ruby/3.0.3:$PATH"
fi
# Scripts ################################################################################################

if [[ -d "$HOME/bin" ]]; then
    export PATH="$HOME/bin:$PATH"
fi

if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -d "$HOME/.local/share/bin" ]]; then
    export PATH="$HOME/.local/share/bin:$PATH"
fi


## Cargo #######################################################################################
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

## Pyenv ########################################################################################
if [[ -d "$HOME/.pyenv/bin" ]]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
fi


## Go ###########################################################################################
if [[ -d /usr/local/go/bin ]]; then
    export PATH=$PATH:/usr/local/go/bin
    export GO15VENDOREXPERIMENT=1
    export GOPATH=/usr/local/go
fi

## Rust  ##################################################################################################
if [[ -d "$HOME/.cargo/bin" ]]; then
    export PATH="$HOME/.cargo/bin:$PATH"
fi

## rbenv  #################################################################################################
if [[ -d "$HOME/.rbenv/bin" ]]; then
    export PATH="$HOME/.rbenv/bin:$PATH"
fi

if [[ -d "$HOME/.local/share/flutter/bin" ]]; then
    export PATH="$HOME/.local/share/flutter/bin:$PATH"
fi


if [[ -d "$HOME/.local/lib/python3.10" ]]; then 
      export PATH="$HOME/.local/lib/python3.10:$PATH"
fi
