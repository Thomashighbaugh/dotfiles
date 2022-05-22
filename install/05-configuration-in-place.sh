#!/bin/bash

# --------------------------------------------------- #
# ------------------ Source Library ----------------- #
# --------------------------------------------------- #
source $HOME/dotfiles/install/01-lib.sh

# --------------------------------------------------- #
# --------------------- Services -------------------- #
# --------------------------------------------------- #
print s "[===================================================]"
print s "Configuring system..."
print s "[===================================================]"
sleep 3s
SYSCTL thinkfan
SYSCTL docker
SYSCTL tp-battery-mode
SYSCTL tpacpi-bat
SYSCTL sensord
SYSCTL getty
SYSCTL auditd
SYSCTL ufw
SYSCTL bluetooth 
SYSCTL canberra-system-bootup 
SYSCTL caberra-system-shutdown
SYSCTL caberra-system-shutdown-reboot
SYSCTL containerd
SYSCTL cronie
SYSCTL dbus-broker 
SYSCTL gpm 
SYSCTL inotify-daemon 
SYSCTL libvirt-dbus
SYSCTL libvirt-guests
SYSCTL lm_sensors
SYSCTL linux-modules-cleanup 
SYSCTL named 
SYSCTL NetworkManager 
SYSCTL ntpd
SYSCTL ntpdate 
SYSCTL qemu-guest-agent
SYSCTL reflector 
SYSCTL sensord
SYSCTL upower 
# --------------------------------------------------- #
print s "[===================================================]"
print s "Bluetooth Configuration"
print s "[===================================================]"
sleep 3s
sudo sed -i 's/\#AutoEnable=false/AutoEnable=true/g' /etc/bluetooth/main.conf | tee -a /tmp/install-log.txt
sudo sed -i 's/\#DiscoverableTimeout = 0/DiscoverableTimeout = 180/g' /etc/bluetooth/bluetooth/main.conf | tee -a /tmp/install-log.txt
# --------------------------------------------------- #
print s "[===================================================]"
print s "Network Setup"
print s "[===================================================]"
sleep 3s
sudo ufw default deny | tee -a /tmp/install-log.txt
sudo ufw allow from 192.168.0.0/24 | tee -a /tmp/install-log.txt
sudo ufw allow from 192.168.0.1 | tee -a /tmp/install-log.txt
# Adjust to local pihole address if present
sudo ufw allow from 192.168.0.12 | tee -a /tmp/install-log.txt
sudo ufw logging off | tee -a /tmp/install-log.txt
sudo ufw enable | tee -a /tmp/install-log.txt
# --------------------------------------------------- #
print s "[===================================================]"
print s "Adding user to some groups..."
print s "[===================================================]"
sleep 3s
sudo usermod -a -G input "$USER" | tee -a /tmp/install-log.txt
sudo usermod -a -G audio "$USER" | tee -a /tmp/install-log.txt
sudo usermod -a -G video "$USER" | tee -a /tmp/install-log.txt
sudo usermod -a -G rfkill "$USER" | tee -a /tmp/install-log.txt
sudo usermod -a -G power "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG libvirt "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG kvm "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG docker "$USER" | tee -a /tmp/install-log.txt


HOST=/etc/hostname
if grep -q thinkpad $HOST; then 
print s "[===================================================]"
print s "Laptop Specific Hardware"
print s "[===================================================]"
sleep 3s
sudo cp -rvf $HOME/dotfiles/root/e495/* /etc/

fi 
