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
echo "                3 ) Raspberry Pi 4   "
echo "-------------------------------------------------------"
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
	echo "You hve completed the provisioning and configuring of your workstation system. Please Reboot."
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
	echo "You hve completed the provisioning and configuring of your laptop system. Please Reboot."
;;
3)
	echo
	echo "You have chosen to provision a Raspberry Pi4."
	echo
		read -r -p "Are You Preparing an SD Card or Installing on a Pi? [p/i] " input
	 
		case $input in
	     [pP])
			echo
	 		echo "You have chosen to prepare an SD Card"
	 		sh $HOME/dotfiles/devices/pi4/prep.sh 
	 		echo
	 		echo
	 		echo
	 		echo "You have completed preparing an SD Card for Arch Arm on the Raspberry Pi 4, now insert it into the Pi and clone this repository for installation and provisioning."
	 		;;
	     [iI])
	 		echo "You have chosen to install and provision a fresh Arch Arm."
	 		sh $HOME/dotfiles/devices/pi4/install.sh 

	       	;;
	     *)
	 		echo "Invalid Entry! Self Destruct Activated!"
			exit 1
	 		;;
		esac
	echo
;;
*)
echo "Not an option, you've made the wrong choice"
;;
esac
echo ""
