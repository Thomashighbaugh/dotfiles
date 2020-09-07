
#!/bin/bash 


## Install Packages
yay -S virt-manager  libvirt-python libvirt libvirt-dbus libvirt-glib  perl-sys-virt ruby-libvirt archvyrt

## Enable the Daemon 
systemctl enable --now libvirtd 
systemctl enable --now virtnetworkd.service  
systemctl enable --now virtqemud.service    