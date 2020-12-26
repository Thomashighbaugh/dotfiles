#!/bin/bash

################################################################################
## Thinkpad Installer ##########################################################
################################################################################

yay -S --noconfirm --sudoloop --needed tp_smapi thinkfan thinkalert tp-battery-mode thinkpad-scripts hdaps-gl tpfand-git threshy libthinkpad tp-battery-icon-git i2c-tools

yay -S --noconfirm --sudoloop --needed cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor
yay -S --noconfirm --sudoloop --needed ryzen-stabilizator-git ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa

yay -S --noconfirm --sudoloop --needed opencl-amd ryzen-stabilizator-git mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git

yay -S --nconfirm --sudoloop --needed zenmonitor ryzenadj-git tuned perf-tools-git

sudo systemctl enable auto-cpufreq.service

sudo systemctl enable acpid.service

sudo systemctl enable --now tp-battery-mode.service

sudo systemctl enable --now cpupower.service

sudo systemctl enable --now lm_sensors.service

sudo systemctl enable --now ryzen-stabilizator.service

sudo systemctl enable --now tuned.service

tuned-adm profiles laptop-ac-powersave

sudo mkinitramfs -Psv

sudo grub-mkconfig -o /boot/grub/grub.conf
