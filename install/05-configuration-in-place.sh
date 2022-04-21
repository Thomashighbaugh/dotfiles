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
SULINK /etc/runit/sv/dbus /var/run/
SULINK /etc/runit/sv/elogind /var/run/
SULINK /etc/runit/sv/polkitd /var/run/
SULINK /etc/runit/sv/irqbalance /var/service
SULINK /etc/runit/sv/ntpd /var/run/
SULINK /etc/runit/sv/docker /var/service
SULINK /etc/runit/sv/rtkit /var/run/
#SULINK /etc/runit/sv/sshd /var/run/
SULINK /etc/runit/sv/uuid /var/run/
SULINK /etc/runit/sv/alsa /var/run/
SULINK /etc/runit/sv/bluetoothd /var/run/
SULINK /etc/runit/sv/ufw /var/run/
#SULINK /etc/sv/dnscrypt-proxy /var/run/
sudo rm -rvf /var/run/acpid | tee -a /tmp/install-log.txt
sudo rm -rvf /var/run/sshd | tee -a /tmp/install-log.txt
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
sudo usermod -a -G bluetooth "$USER" | tee -a /tmp/install-log.txt
sudo usermod -a -G pulse-access "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG libvirt "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG kvm "$USER" | tee -a /tmp/install-log.txt
sudo usermod -aG docker "$USER" | tee -a /tmp/install-log.txt
