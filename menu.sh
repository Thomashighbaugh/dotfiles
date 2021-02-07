
#!/bin/bash
source ./menu-generator.sh

# Generates dialog with options
declare -a options=("workstation" "laptop" "pi4" "more?");
generateDialog "options" "Choose system to provision and configure:" "${options[@]}"

read choice
# Do something after getting their choice
case $choice in

  workstation)
    STATEMENTS
    ;;

  laptop)
    STATEMENTS
    ;;

  pi4)
    STATEMENTS
    ;;

  *)
    STATEMENTS
    ;;
