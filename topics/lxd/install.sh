yay -S --noconfirm --sudoloop --needed lxd lxc lxcfs

sudo systemctl enable --now lxc
sudo systemctl enable --now lxc-auto
sudo systemctl enable --now lxcfs
sudo systemctl enable --now containerd
