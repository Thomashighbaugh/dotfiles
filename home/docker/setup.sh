#!/bin/sh

set -e
# these are mirrored in the root .env file
export ELECTRIC_TANTRA_DIR="$HOME"
export ELECTRIC_TANTRA_BIN_DIR="$HOME/bin"
export ELECTRIC_TANTRA_LIBS_DIR="$ELECTRIC_TANTRA_DIR/libs"
export ELECTRIC_TANTRA_SCRIPTS_DIR="$ELECTRIC_TANTRA_DIR/scripts"

# make sure we're in the home dir
cd "$HOME"

# ensure the user has a /bin directory, and add it to the path
if [ ! -d "$ELECTRIC_TANTRA_BIN_DIR" ]; then
      mkdir "$ELECTRIC_TANTRA_BIN_DIR"
fi

export PATH="$ELECTRIC_TANTRA_BIN_DIR:$PATH"

# pull down `yadm` and symlink it into our user's /bin
yay_dir="$HOME/yay"

if [ ! -d "$yay_dir" ]; then
      git clone https://github.com/thelocehiliosan/yay.git "$yay_dir" >/dev/null

      cd $yay_dir && makepkg -s
fi

# clone our system config and update origin to use SSL in the future
git clone https://github.com/Thomashighbaugh/dotfiles >/dev/null

# check out a specific commit if it's been specified e.g. CI pull request
if [ -n "$ELECTRIC_TANTRA_CHECKOUT_SHA1" ]; then
      yadm checkout "$ELECTRIC_TANTRA_CHECKOUT_SHA1"
fi

