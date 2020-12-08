#!/bin/env bash

################################################################################
## Virt-Manager ################################################################
################################################################################
## Install Packages
yay -S virt-manager libvirt-python libvirt libvirt-dbus libvirt-glib perl-sys-virt ruby-libvirt zenity qemu libvirt-storage-gluster libvirt-storage-iscsi-direct libvirt-storage-rbd openbsd-netcat radvdqemu open-iscsi

## Enable the Daemon
systemctl enable --now libvirtd
systemctl enable --now virtnetworkd.service
systemctl enable --now virtinterfaced.service
systemctl enable --now virtqemud.service
systemctl enable --now libvirtd-admin.socket
