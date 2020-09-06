################################################################################
## Path Modification ###########################################################
################################################################################
export PATH="$XDG_CONFIG_HOME/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
export PATH="$HOME/.config/nvm:$PATH"


# set PATH so it includes user's private bin if it exists
if [[ -d "$HOME/.local/share/bin" ]]; then
	export PATH="$HOME/.local/share/bin:$PATH"
fi

# xdg-derived, systemd file-hierarchy
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi

# Yarn (Node.js)
if [[ -d "$HOME/.yarn/bin" ]]; then
	export PATH="$HOME/.yarn/bin:$PATH"
fi

# Cargo (PHP)
if [[ -d "$HOME/.cargo/bin" ]]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

# ruby
# @TODO there are supposed to be different bins per version, find a programmic way to include this here
if [[ -d "$HOME/.gem/ruby" ]]; then
	export PATH="$HOME/.gem/ruby:$PATH"
fi

# NVM (different versions )
#@TODO Look at integrating this with ~/.yarn
if [[ -d "$HOME/.config/nvm" ]]; then
	export PATH="$HOME/.config/nvm:$PATH"
fi


# go
export GOPATH=$HOME/go

if [[ -d "$HOME/$GOPATH/bin" ]]; then
	export PATH="$HOME/$GOPATH/bin:$PATH"
fi

# go
export GOPATH=$HOME/go


## Node ##################################################################################################
export PATH="$XDG_CONFIG_HOME/yarn/global/node_modules/.bin:$PATH"
export PATH="$HOME/.yarn/bin:$PATH"

## Scripts ################################################################################################
PATH="$HOME/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

## Rust ###################################################################################################
export PATH="$HOME/.cargo/bin:$PATH"

## Ruby ###################################################################################################
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"

export PATH="$HOME/.pyenv/bin:$PATH"
