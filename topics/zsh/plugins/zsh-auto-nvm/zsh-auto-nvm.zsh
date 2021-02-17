zsh-auto-nvm() {
  if [ -n "$ZAN_CURRENT_ROOT" ] && [[ "$PWD" =~ "^$ZAN_CURRENT_ROOT" ]] && [[ "$OLDPWD" =~ "^$PWD" ]]; then
    return
  fi

  local PREVIOUS_VERSION="$ZAN_CURRENT_VERSION"
  local DIR="$PWD"

  export ZAN_CURRENT_ROOT=""
  export ZAN_CURRENT_VERSION=""

  while [ -z "$ZAN_CURRENT_ROOT" ] && [[ "$DIR" =~ "^${ZAN_SEARCH_ROOT:-$HOME}" ]]; do
    local NVMRC="$DIR/.nvmrc"

    if [ -f "$NVMRC" ]; then
      local NVMRC_VERSION=$(cat "$NVMRC")

      export ZAN_CURRENT_ROOT="$DIR"
      export ZAN_CURRENT_VERSION=$(nvm version "$NVMRC_VERSION")
    
      if [ "$ZAN_CURRENT_VERSION" = "N/A" ]; then
        nvm install "$NVMRC_VERSION"
        export ZAN_CURRENT_VERSION=$(nvm version "$NVMRC_VERSION")
      elif [ "$ZAN_CURRENT_VERSION" != "$PREVIOUS_VERSION" ]; then
        nvm use "$NVMRC_VERSION"
      fi
    fi

    DIR="${DIR%/*}"
  done

  if [ -z "$ZAN_CURRENT_VERSION" ] && [ -n "$PREVIOUS_VERSION" ]; then
    if [ -z "$(nvm alias default)" ]; then
      nvm alias default node
    fi

    export ZAN_DEFAULT_VERSION="$(nvm version default)"

    if [ "$ZAN_DEFAULT_VERSION" = "N/A" ]; then
      nvm install default
      export ZAN_DEFAULT_VERSION=$(nvm version default)
    elif [ "$ZAN_DEFAULT_VERSION" != "$PREVIOUS_VERSION" ]; then
      nvm use default
    fi
  fi
}

zsh-auto-nvm

autoload -Uz add-zsh-hook
add-zsh-hook chpwd zsh-auto-nvm
