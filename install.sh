# #!/usr/bin/env bash
echo ""
echo  "  _____         __    ___ __ __                   "
echo  " |     \.-----.|  |_.'  _|__|  |.-----.-----.     "
echo  " |  --  |  _  ||   _|   _|  |  ||  -__|__ --|     "
echo  " |_____/|_____||____|__| |__|__||_____|_____|     "                         
echo  "  __               __          __ __              "
echo  " |__|.-----.-----.|  |_.---.-.|  |  |.-----.----. "
echo  " |  ||     |__ --||   _|  _  ||  |  ||  -__|   _| "
echo  " |__||__|__|_____||____|___._||__|__||_____|__|   "
echo  ""
echo  ""
echo " Select the device to provision from the list below."
echo "-------------------------------------------------------"
echo "                1 ) Workstation      "
echo "                2 ) Laptop           "
echo "                3)  (coming soon) Raspberry Pi 4   "
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
bash "devices/workstation/install.sh"   
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
bash "devices/laptop/install.sh"   
echo 
echo 
echo "You are now done configuring after provisioning a laptop device."
;;
*)
echo "Not an option, you've made the wrong choice"
;;
esac
echo ""
