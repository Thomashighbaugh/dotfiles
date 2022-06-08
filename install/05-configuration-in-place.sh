#!/bin/bash

# --------------------------------------------------- #
# ------------------ Source Library ----------------- #
# --------------------------------------------------- #
source "$HOME"/dotfiles/install/01-lib.sh

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
SSYSCTL libvirt-guests
SYSCTL lm_sensors
SYSCTL linux-modules-cleanup
SYSCTL named
SYSCTL NetworkManager
SYSCTL ntpd
SYSCTL qemu-guest-agent
SYSCTL reflector
SYSCTL sensord
SYSCTL upower

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
# --------------------------------------------------- #
print s "[===================================================]"
print s "Performance Tweaking"
print s "[===================================================]"
sleep 3s
sed -i 's|zram_checking_enabled = False|zram_checking_enabled = True|g' /etc/nohang/nohang.conf

sudo sh -e 'echo "w /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor - - - - performance" >  /usr/lib/tmpfiles.d/cpu-governor.conf'

sudo sh -e 'echo "w /sys/devices/system/cpu/cpufreq/policy*/energy_performance_preference - - - - performance" > /usr/lib/tmpfiles.d/energy_performance_preference.conf'

sudo sh -e 'echo "w /sys/module/pcie_aspm/parameters/policy - - - - performance" > /usr/lib/tmpfiles.d/pcie_aspm_performance.conf'

sudo cp -rvf $HOME/dotfiles/root/etc/* /etc/ | tee -a /tmp/install-log.txt 


# --------------------------------------------------- #

# for thinkpad speecifically
HOSTNAME=/etc/hostname
if grep -q thinkpad $HOSTNAME; then
    print s "[===================================================]"
    print s "Laptop Specific Hardware"
    print s "[===================================================]"
    sleep 3s
    sudo cp -rvf "$HOME"/dotfiles/root/e495/* /etc/

fi
