#!/bin/bash

sudo pacman -S --noconfirm docker lxd lxcfs docker-machine python-docker containerd 

yay -S --needed --noconfirm --sudoloop --batchinstall distrobuilder docker-compose lxdui hadolint-bin convoy docker-slim x11docker

echo 'Finished Installing Docker Packages'
