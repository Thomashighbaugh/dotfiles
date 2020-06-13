#!/bin/bash

sudo pacman -S --noconfirm minikube libvirt qemu-headless ebtables docker-machine

yay -S --needed --noconfirm docker-machine-driver-kvm2

echo 'Finished Installing Minikube Packages'
