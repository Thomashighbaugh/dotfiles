#!/bin/env bash

    cd ${HOME}/.config/awesome && git add . && git commit -m "updated" && git push --force
   
    cd ${HOME}/.config/qtile && git add . && git commit -m "updated" && git push --force
   
    cd ${HOME}/.local/share/bin && git add . && git commit -m "updated" && git push --force

    cd ${HOME}/dotfiles && git add . && git commit -m "dotfiles group update" && git push --force