#!/usr/bin/env bash

set -euo pipefail

adblock_folder=$HOME/.local/share/luakit/adblock

[[ ! -d "$adblock_folder" ]] && mkdir -p "$adblock_folder"

curl \
    -o "$adblock_folder/easylist.txt" \
    "https://easylist.to/easylist/easylist.txt"
curl \
    -o "$adblock_folder/easyprivacy.txt" \
    "https://easylist.to/easylist/easyprivacy.txt"
curl \
    -o "$adblock_folder/easycookie.txt" \
    "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
