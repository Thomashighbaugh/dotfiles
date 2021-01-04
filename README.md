# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

> Warning: no minimalism can be found in this repo

## Introduction

A repo, on Github featuring dotfiles and an installation script bring an Arch system from first boot to totally useful to me and just the way I like it.

## Features

- Extensive
- Modular
- No Submodules
- Install script
  - Idemponent
  - Unattended Installation/Configuration
  - Customizable to Your System/Needs

## How To

Brave soul I presume? Well lucky you, if you have nothing to do these relatively painless steps on a fresh install of Arch Linux and you are good to go.

```bash

git clone https://github.com/Thomashighbaugh/dotfiles
cd dotfiles
sh install.sh
```

Then the installer will ask you what system you are provisioning
| System | Notes |
|-------|--------|
| Laptop | Thinkpad E495, Ryzen CPU |
| Workstation | RyzenCPU, Nvidia GPU, x570 chipset |
| Hypervisor | Intel CPU, Nvidia GPU, 300 series chipset (8th Gen), Virtualization specific packaging |
| Pi4\* | Docker centric, aarch64 kernel, headless operation with GUI available |

- Installed on Manjaro's ARM edition not ArchlinuxArm

---

### Included

The programs below are installed with the provided script and feature configurations that are either pulled in from Github or are within `dotfiles/topics` for easy, selective addition to your own dotfiles or system.

---

## Inspiration

- [Holman Does Dotfiles](https://github.com/holman/dotfiles)

- [wafflepie/dotfiles](https://github.com/wafflepie/dotfiles)
