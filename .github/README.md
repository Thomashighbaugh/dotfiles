# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

## Introduction

The entrypoint to the complex of repositories that are what configure and customize my Linux systems. Feel free to take from them as needed, all I ask is you leave a star.

**CAUTION**: if you do use these as the basis for your own configuration set, please take care to go over everything and adjust them to your needs as my preferences are idiosyncratic in the extreme.

---

**Notice**: _Arch Linux Deprecation_

I have moved to Void Linux, so the Arch Install script is deprecated. However it is still available under the `/deprecated` subdirectory in case anyone finds it useful.

## Installation

To install these locally, you will need to have a fresh install of Void Linux on the system you wish to install them on. Then clone the repository:

```bash
git clone https://github.com/Thomashighbaugh/dotfiles $HOME/dotfiles
```

Installation and configuration are handled by the BASH scripts in the setup directory, which can be accessed via the Makefile using the following command

```bash
make all
```

This will run through the three bash shell scripts in the same order they are listed below
