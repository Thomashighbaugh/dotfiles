# Installation Script 

The installation script is a large BASH shell script, written using modularized functions for each of the programs listed within the scripts menus. The menus are which statements that enable the selection of individual items, which has the draw back of requiring a menu item to return to the main menu, but the advantage of enabling the user to chain several programs together to be installed saving time and minimizing frustration navigating back to the same location repeatedly. 

## Dependencies

The script has two sets of dependencies, the first is required to run the script and is just two programs: `git` and `dialog`. The first is needed to clone the repository locally and the second enables the menu itself to display. 

The second set of dependencies are bundled together as the first menu item displayed on the main menu, which include a host of required programs with the most important being the `yay`

## Functions 

Each of the submenu items installs programs and symlinks relevant files to their appropiate place on the system. This method keeps the portions of the installation process grouped together, making it easy to add new ones and extract various functions entirely from the script and use them elsewhere with minimal fuss.
