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

if [[ -d "$HOME/.config/nvm" ]]; then
	export PATH="$HOME/.config/nvm:$PATH"
fi
if [[ -d "$HOME/.nvm" ]]; then
	export PATH="$HOME/.nvm:$PATH"
fi
if [[ -d "$HOME/.config/nvm/versions/node/v15.8.0" ]]; then
	export PATH="$HOME/.config/nvm/versions/node/v15.8.0:$PATH"
fi
# Ruby Gems ################################################################################################

if [[ -d "/usr/lib/ruby/gems/2.7.0" ]]; then
	export PATH="/usr/lib/ruby/gems/2.7.0:$PATH"
fi

if [[ -d "$HOME/.local/share/gem/ruby/2.7.0" ]]; then
	export PATH="$HOME/.local/share/gem/ruby/2.7.0:$PATH"
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

if [[ -d "$HOME"/.config/nvm/versions/node/v15.8.0 ]]; then
	export PATH="$HOME/.config/nvm/versions/node/v15.8.0:$PATH"
fi
## Cargo #######################################################################################
if [[ -d "$HOME/.cargo/bin" ]]; then
	export PATH="$HOME/.cargo/bin:$PATH"
fi

## Pyenv ########################################################################################
if [[ -d "$HOME/.pyenv/bin" ]]; then
	export PATH="$HOME/.pyenv/bin:$PATH"
fi
if [[ -d "$HOME/.local/bin" ]]; then
	export PATH="$HOME/.local/bin:$PATH"
fi


## Go ###########################################################################################

if [[ -d "$HOME/go" ]]; then
	export PATH="$HOME/go:$PATH"
	export GOPATH=$HOME/go
fi

if [[ -d "$HOME/$GOPATH/bin" ]]; then
	export PATH="$HOME/$GOPATH/bin:$PATH"
fi
