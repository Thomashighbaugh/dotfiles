#!/bin/bash 

yay -S --noconfirm --needed virtualbox vboxtool vboxwrapper qemu-headless open-vm-tools virt-install virt-manager libguestfs

yay -S --noconfirm --needed python-vagrant vagrant vagrant-libvirt libvirt-python libvirt-glib ruby-libvirt libvirt-sandbox

echo 'Finished Installing Virtual Machine Packages'
