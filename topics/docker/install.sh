# #!/usr/bin/env bash



yay -S --noconfirm --sudoloop --needed   docker docker-compose docker-machine  python-docker  containerd 

sudo usermod -aG docker ${USER}
sudo systemctl enable --now docker.service
sudo systemctl enable --now docker.socket