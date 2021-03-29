#!/bin/bash
###########################################################
# Simple Startup Menu
#
# Waits up to 10 seconds before choosing default action
# User can select by entering option # with ENTER
#
###########################################################
wait=25
hostname=$(hostname | tr '[:lower:]' '[:upper:]')

cat <<EOF

Display Manager Host: [$hostname]
============================================
1) Awesome Window Manager
2) XFCE4
3) Gnome
4) Plasma
5) Sway
6) QTile
============================================
You have $wait Seconds to choose...
EOF
echo -n "Please Select (1,2,3,4,5,6) [1]: "
read -t $wait inp
echo

case "$inp" in
1)
    echo "Starting Awesome Window Manager"
    echo
    xinit awesome
    exit 1
    ;;
2)
    echo "Starting XFCE4"
    echo
    xinit xfce4
    exit 1
    ;;
3)
    echo "Starting Gnome"
    echo
    xinit gnome
    exit 1
    ;;
5)
    echo "Starting Sway"
    echo
    xinit sway
    exit 1
    ;;
6)
    echo "Starting qtile"
    xinit qtile
    exit 1
    ;;
*)
    echo "Returning to Terminal"
    echo
    exit 1
    ;;
esac
###########################################################
# End of Script
###########################################################
