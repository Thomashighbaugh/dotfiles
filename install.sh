# #!/usr/bin/env bash
echo ""

echo  "             __ __   _____  ______ "
echo  ".----.-----.|  |  |_|  |  ||    __|"
echo  "|  __|  _  ||  |   _|__    |__    |"
echo  "|____|_____||__|____|  |__||______|"
echo  ""                                 
echo  "Dotfiles Installation System"
echo
echo "Before I begin please enter the device you are provisioning."
echo "1 ) Workstation  | AMD Ryzen 3900x       | Nvidia"
echo "2 ) Laptop       | Thinkpad  Ryzen 3500  | AMDGPU "
echo "3 ) Hypervisor   | Intel 8th Gen i7      | Nvidia"
read system
echo -n ""
echo -n ""
case $system in
1) # Workstation Configuration
echo
echo "You have chosen the workstation provisioning and configuration option."
echo 
echo
sh ./dependencies/install.sh
bash "devices/workstation/install.sh"   # your processing here
echo 
echo 
echo "You are now done configuring after provisioning a workstation device."
;;
2)
echo
echo "You have chosen to provision the laptop configuration option."
echo
echo
echo
bash ./dependencies/install.sh
bash "devices/laptop/install.sh"   # your processing here
echo 
echo 
echo "You are now done configuring after provisioning a laptop device."
;;
*)
echo "Not an option, you've made the wrong choice"
;;
esac
echo ""
