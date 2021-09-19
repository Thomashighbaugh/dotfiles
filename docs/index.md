# TLH's Dotfiles 

## Introduction
Like many dotfiles repositories, this one contains a means of installing the dotfiles provided locally without having to manually symlink every single file to locations across the system. Unlike many other dotfiles repository, this is accomplished using an installation script that features a menu allowing for the selection of specific applications to provision and includes the installation (for Arch Linux and its derivatives only) of said program in the process. This is to speed up and regularize the installation and provisioning of my systems while avoiding the need to make git branches for each machine when often the main difference between systems I am installing on is exactly what software to install. 

To see documentation on the installation script itself [see here](./install-script.md)

## Unique Features 

- custom base16 scheme designed specifically for use in these dotfiles
- custom GTK theme for graphical applications derived from base16 scheme 
- custom icon pack using the base16 scheme and further customized to be indicative and unique

## Getting Started 

The only dependencies not handled by the installation script are `git` and `dialog` which can be acquired with 
```bash
sudo pacman -S git dialog

```

If you would like to install and provision a system beginning the installation process after cloning the repository requires minimal effort. Just navigate to the directory you have cloned this repository to and type:

```bash

./INSTALL
```

Which will bring up the installation menu.  The menu first shows a confirmation dialog that helps in case you accidentally run the script again or are debugging locally. 

### Core Dependencies

Afterwards the main menu is displayed. In order to successfully install other applications, you must run the first menu item first to install yay and various required elements that will be used to install and provision software in the other menu items' submenus. The Core Dependencies menu item is the only top level menu item without its own submenu, instead it drops into a shell and installs software right away. 

### Menu Items 

Below is a table describing each menu item and the content to expect there within it. The name of the menu item also serves as a link to its own page and descriptions of the software it installs and/or provisions. 

| Item | Description |
|------x-------------|
| [Hardware](./menu/hardware.md) | For hardware specific packages, like Thinkpad-specific and Raspberry Pi-specific applications |
| [TUI](./menu/tui.md) | Terminal applications and configurations |
| [GUI](./menu/gui.md) | Packages for displaying windows on screen |
| [Apps](./menu/apps.md) | GUI based applications, what most users are used to using locally |
| [Dev](./menu/dev.md) | Packages for specific languages and their package managers, most are called in by other modules| 

## Bundled Repositories and Configurations 

Below are the programs specifically configured by me, either in this repository or their own repository according, as indicated. The name of each program will serve as a link to its own page with information specific to that configuration. 

| Name | Local/External Repo |
|------x---------------------|
| [AwesomeWM](./apps/awesome.md) | External |
| [bash](./apps/bash.md) | Local |
| [bin](./apps/bin.md) | External | 
| [dropbox](./apps/dropbox.md) | Local | 
| [dunst](./apps/dunst.md) | Local | 
| [git](./apps/git.md) | Local | 
| [gnupg](./apps/gnipg.md) | Local | 
| [gtk](./apps/gtk.md) | Both |
| [hosts](./apps/hosts.md) | local | 
| [kitty](./apps/kitty.md) | local |
| [neofetch](./apps/neofetch.md) | Local |
| [neovim](./apps/neovim.md) | External | 
| [organize](./apps/organize.md) | Local | 
| [picom](./apps/picom.md) | both |
| [qtile](./apps/qtile.md) | external | 
| [rofi](./apps/rofi.md) | both | 
| [Posix (sh)](./apps/sh.md) | local |
| [sxhkd](./apps/sxhkd.md) | Both |
| [wtf](./apps/wtf.md) | Local | 
| [xorg](./apps/xorg.md) | Local |
| [zsh](./apps/zsh.md) | External | 
