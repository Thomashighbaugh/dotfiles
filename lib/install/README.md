# dotfiles/lib/install

### Package Manager Commands

## Introduction

This directory is loaded with the package manager commands called by the Makefile. The assumption of these files is that you are using a system which has both pacman and yay installed. The other package managers utilized are installed within these scripts.

## Use Case

The purpose of these scripts is to remove clutter from the Makefile that provisions my systems and then ports in my configurations via system link as well as bringing in my bin directory and personal library (which contains this subdirectory among other useful collections of items)

## Organization

Each of the categories that the Makefile runs through after running the `make` command has its own script in this subdirectory. The purpose of this organizational method is to enable each category to call its associated script which any potential user (or me in the future) could easily modify and know exactly what it will affect.

## What's in Each Script

Each script contains:

- Shebang
- package manager commands
- an echo statement that prints that the process has installed

## ToDo

- [ ] @TODO add if statements to support other package managers
- [ ] @TODO update shebangs to env standard
- [ ] @TODO add echo statements introducing each script and then update makefile language to configurations
- [x] @DONE Create Installation Scripts
