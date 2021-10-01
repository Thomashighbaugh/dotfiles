#!/bin/ash



cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"

print() {
    case "$1" in
        t | title)
            shift
            printf "%s\n" "${sb}${cg}[###]$*${sn}"
        ;;
        s | step)
            shift
            printf "%s\n" "${sb}${cm}[===]$*${sn}"
        ;;
        e | error)
            shift
            printf "%s\n" "${sb}${cr}[!!!]$*${sn}"
            exit 1
        ;;
        w | warning)
            shift
            printf "%s\n" "${sb}${cy}[:::]$*${sn}"
        ;;
        *)
            printf '%s\n' "$*"
        ;;
    esac
}

setup(){
  sh $PWD/alpine-setup/
}

print t "####################################################"
print t "Dotfiles Installer"
print t "####################################################"
echo
echo
echo
print e "This script is meant to be run on a desktop installation of Alpine Linux. It will install the dotfiles contained here and in my associated repos after it clones those repos and installs the needed repos."


while true; do
    read -p "Do you wish to contine?" yn
    case $yn in
        [Yy]* ) sh -c "./alpine-setup/setup-system-core.sh"&&sh -c "./alpine-setup/setup-repos.sh" && sh -c "./alpine-setup/setup-dotfiles.sh"&& print t "Done, Please Reboot"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done


