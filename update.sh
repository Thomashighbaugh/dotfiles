#!/bin/env bash

    cd ${HOME}/.config/awesome && git add . && git commit -m "awesome updated" && git push --force
   
    cd ${HOME}/.config/qtile && git add . && git commit -m "qtile updated" && git push --force
   
    cd ${HOME}/.local/share/bin && git add . && git commit -m "bin scripts updated" && git push --force

    cd ${HOME}/.vimwiki-tech && git add . && git commit -m "vimwiki updates" && git push --force

    cd ${HOME}/dotfiles && git add . && git commit -m "dotfiles group update" && git push --force
