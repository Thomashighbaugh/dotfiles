# Installation Script

The installation script is a large BASH shell script, written using modularized functions for each of the programs listed within the scripts menus. The menus are which statements that enable the selection of individual items, which has the draw back of requiring a menu item to return to the main menu, but the advantage of enabling the user to chain several programs together to be installed saving time and minimizing frustration navigating back to the same location repeatedly.

## Dependencies

The script has two sets of dependencies, the first is required to run the script and is just two programs: `git` and `dialog`. The first is needed to clone the repository locally and the second enables the menu itself to display.

The second set of dependencies are bundled together as the first menu item displayed on the main menu, which include a host of required programs with the most important being the `yay`

## Functions

Each of the submenu items installs programs and symlinks relevant files to their appropiate place on the system. This method keeps the portions of the installation process grouped together, making it easy to add new ones and extract various functions entirely from the script and use them elsewhere with minimal fuss.

Like all things, the method used to modularize the script does have some disadvantages, which are technical debts passed on to the developer in adding additional programs to the list which can be a tedious process but this is true of any other method that could have been used in provisioning my systems with my dotfiles and in this case, far more tolerable than the alternatives for me while enabling the installation portion to occur at the same time which is not an option for the many other options that exist  to do this task. 

## Unattended Installation 

When provisioning a system that I break the installation of often, as in the case of my latop I have also crafted a script that is a copy of the menu driven script without the submenu system at all, for mostly unattended installation. This will also be the basis for my eventual adaption of this script to other distros, such as Alpine which I am interested in as an alternative to Arch due to the inherent speed of the package manager and its low overhead that frees up the system to be more useful in other tasks instead of running systemd. 

Any alterations to the installed programs that this script installs requires the user to comment out the installation functions directly in the submenu sections where simply everything is enabled. There is still need to click through each menu item, which is to force me to notice if something didn't install as intended to fix the script or adjust my local install accordingly. 
