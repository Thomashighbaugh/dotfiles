#!/bin/env bash

yay -S --noconfirm --needed --sudoloop amd-ucode ryzenadj-git zenstates-git  ryzen-stabilizator-git linux-amd-znver2-docs linux-amd-znver2-headers linux-amd-znver2

sudo grub-mkconfig -o /boot/grub/grub.conf 

sudo mkinitcpio -P
