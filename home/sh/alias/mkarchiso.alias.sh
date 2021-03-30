#!/bin/env bash

# intended for use in building Electric Tantra Linux, but useful with mkarchiso in general. Especially as it uses the tmpfs to house the work product, a huge improvement in terms of speed and keeping directories well ordered and easily wiped clean.

alias isobuild="sudo mkarchiso -v -w /tmp/mkarchiso-tmp ./releng"

alias isoclean="mv out/*.iso ../ && sudo rm -rvf out && sudo rm -rvf /tmp/mkarchiso-tmp && echo 'ISO build has been cleaned up... hopefully'" 
