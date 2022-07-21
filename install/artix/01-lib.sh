#!/bin/bash
#  _____   __ __
# |     |_|__|  |--.
# |       |  |  _  |
# |_______|__|_____|
#  _______                    __   __
# |    ___|.--.--.-----.----.|  |_|__|.-----.-----.-----.
# |    ___||  |  |     |  __||   _|  ||  _  |     |__ --|
# |___|    |_____|__|__|____||____|__||_____|__|__|_____|
# --------------------------------------------------- #
# ----------------- Print Statement ----------------- #
# --------------------------------------------------- #
# Assign Terminal Color Variables
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"
# --------------------------------------------------- #
# ----------------- Print Statement ----------------- #
# --------------------------------------------------- #
# Statement providing color to the stdout
print() {
    case "$1" in
    t | title)
        shift
        printf "%s\n" "${sb}${cg}[###]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}" | tee -a /tmp/install-log.txt
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}" | tee -a /tmp/install-log.txt
        ;;
    *)
        printf '%s\n' "$*" | tee -a /tmp/install-log.txt
        ;;
    esac
}

# --------------------------------------------------- #
# --------------- Symlinking Function --------------- #
# --------------------------------------------------- #
LINK() {
    ln -svf "$1" "$2" | tee -a /tmp/install-log.txt
}
SULINK() {
    sudo ln -svf "$1" "$2" | tee -a /tmp/install-log.txt
}

SYSCTL() {
    sudo systemctl enable --now "$1"
}
