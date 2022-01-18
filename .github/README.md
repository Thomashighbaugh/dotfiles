# README: Dotfiles

> Never Mind the Bullocks, Here's the Dotfiles!

---

## Introduction

The entrypoint to the complex of repositories that are what configure and customize my Linux systems. Feel free to take from them as needed, all I ask is you leave a star.

**CAUTION**: if you do use these as the basis for your own configuration set, please take care to go over everything and adjust them to your needs as my preferences are idiosyncratic in the extreme.

---

## Prerequisites

The included installation script will take you from a fresh install of **Void Linux** using **gLibc** to a configured system, no additional dependencies need to be installed first other than `git`.

## Installation

To install these locally, you will need to have a fresh install of Void Linux on the system you wish to install them on. Then clone the repository:

```bash
git clone https://github.com/Thomashighbaugh/dotfiles $HOME/dotfiles
```

Included is a script handling the system's provisioning and configuration all at once post install. To run it:

```bash
cd $HOME/dotfiles
./setup/install.sh
```
