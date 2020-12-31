#!/bin/bash

################################################################################
## Thinkpad Installer ##########################################################
################################################################################

yay -S --noconfirm --sudoloop --needed tp_smapi tp-battery-mode thinkpad-scripts hdaps-gl tpfand-git threshy libthinkpad tp-battery-icon-git i2c-tools

yay -S --noconfirm --sudoloop --needed cpufreqctl auto-cpufreq aocl-gcc aocl-aocc hipcpu-git zenpower-dkms-git zenmonitor

yay -S --noconfirm --sudoloop --needed ryzen_smu-dkms-git rapl-read-ryzen-git amf-headers opencl-mesa

yay -S --noconfirm --sudoloop --needed opencl-amd mhwd-amdgpu zenstates-git aocl-gcc tpc-git amdcovc rapl-read-ryzen-git

yay -S --nconfirm --sudoloop --needed zenmonitor ryzenadj-git tuned perf-tools-git smartmontools tp_smapi x86_energy_perf_policy bash-completion acpi_call

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
