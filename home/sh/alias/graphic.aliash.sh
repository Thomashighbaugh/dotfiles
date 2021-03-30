#!/bin/env bash

# Graphics
#################################################
alias svgtopng='for file in *.svg; do inkscape $file -o ${file%svg}png; done'
alias pngtosvg='for file in *.png do inkscape $file -o ${file%svg}svg; done'
alias pngtobmp="ls -1 *.png | xargs -n 1 bash -c 'convert "$0" "${0%.png}.bmp"'" 
alias jpgtopng="ls -1 *.jpg | xargs -n 1 bash -c 'convert "$0" "${0%.jpg}.png"'"
