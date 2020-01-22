#!/bin/bash

yay -S --noconfirm firejail-apparmor-git 

sudo pacman -S --noconfirm metasploit armitage veil ettercap-gtk 

sudo pacman -S --noconfirm rofi-pass pass pass-otp patch dnsmasq gnu-netcat avahi  sshuttle inetutils iproute2 iptables iputils

yay -S --noconfirm --needed firectl  apparmor-profiles firejail-profiles firetools keybase-gui

echo 'Finished Installing Network Security Packages'
