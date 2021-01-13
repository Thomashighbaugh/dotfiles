#!/bin/env bash

    cd ${HOME}/.config/awesome && git add . && git commit -m "awesome window manager config has been updated" && git push --force
   
    cd ${HOME}/.config/qtile && git add . && git commit -m "qtile configuration has been updated" && git push --force
   
    cd ${HOME}/.local/share/bin && git add . && git commit -m "my bin scripts have been updated" && git push --force

    cd ${HOME}/vimwiki && git add . && git commit -m "vimwiki is updated" && git push --force

    cd ${HOME}/dotfiles && git add . && git commit -m "dotfiles group update" && git push --force
