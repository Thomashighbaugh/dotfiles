# #!/usr/bin/env bash
echo ""

echo  "             __ __   _____  ______ "
echo  ".----.-----.|  |  |_|  |  ||    __|"
echo  "|  __|  _  ||  |   _|__    |__    |"
echo  "|____|_____||__|____|  |__||______|"
echo  ""                                 
echo  "Dotfiles Installation Script"
echo
echo "Before I begin please enter the device you are provisioning."
echo "1 ) Workstation | AMD | Nvidia"
echo "2 ) Laptop | Thinkpad | AMD | AMDGPU "
echo "3 ) Hypervisor | Intel"
read system
echo -n ""
echo -n ""
case $system in
1) # Workstation Configuration
echo "You have chosen to provision the workstation configuration option."
sh ./dependencies/install.sh
for D in devices/workstation
do # first assign directory to present position
  directory=$D
  # second instal the script labeled install.sh within the position directory
      if [ -d "${D}" ]; then
        bash "${D}/install.sh"   # your processing here
	fi
done
;;
2)
echo "You have chosen to provision the laptop configuration option."
bash ./dependencies/install.sh
for SD in *
do
 
  directory=$d
  echo "$directory"
  bash $directory/install.sh
done
;;
*)
echo "Not an option, you've made the wrong choice"
;;
esac
echo ""
