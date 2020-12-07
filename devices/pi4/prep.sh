#!/bin/bash -e
if test -d tmparch
	then
		echo "Tmp folder exists"
	else
		mkdir tmparch
		mkdir -p tmparch/{root,boot}
fi
SD_MOUNT="tmparch/"

function rasp4 {
	DEV=$1
	SD_MOUNT=$2

	formatSD "${DEV}" "${SD_MOUNT}"
	if test -f  ArchLinuxARM-rpi-4-latest.tar.gz
		then
			echo "Tar file allready exists"
		else
			wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-aarch64-latest.tar.gz
	fi
	bsdtar -xvpf ArchLinuxARM-rpi-4-latest.tar.gz -C ${SD_MOUNT}root
	basicSettings "${SD_MOUNT}"	
	wifi "${SD_MOUNT}"
	changename "${SD_MOUNT}"
	finish "${DEV}"
}

function raspZero {
	DEV=$1
	SD_MOUNT=$2
	
	formatSD "${DEV}" "${SD_MOUNT}"
	if test -f  ArchLinuxARM-rpi-latest.tar.gz
		then
			echo "Tar file allready exists"
		else
			wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-latest.tar.gz
	fi
	bsdtar -xvpf ArchLinuxARM-rpi-latest.tar.gz -C ${SD_MOUNT}root
	basicSettings "${SD_MOUNT}"
	wifi "${SD_MOUNT}"
	changename "${SD_MOUNT}"
	finish "${DEV}"
}

function formatSD {
	DEV=$1
	SD_MOUNT=$2
	if [[ "${DEV##*/}" == "mmcblk0" ]] ; then
	echo "Formating SD card"
	if mount | grep ${DEV}p1 > /dev/null; then
		umount -v ${DEV}p1
	fi
	if mount | grep ${DEV}p2 > /dev/null; then
		umount -v ${DEV}p2
	fi
		wipefs --all $DEV
		parted -s $DEV mklabel msdos
		parted -s $DEV mkpart primary fat32 1 128
		parted -s $DEV mkpart primary ext4 128 -- -1
		mkfs.vfat -F32 ${DEV}p1
		mkfs.ext4 -F ${DEV}p2
		mount -v ${DEV}p1 ${SD_MOUNT}boot/
		mount -v ${DEV}p2 ${SD_MOUNT}root/
	else
		echo "Formating SD card"
		if mount | grep ${DEV}1 > /dev/null; then
			umount -v ${DEV}1
		fi
		if mount | grep ${DEV}2 > /dev/null; then
			umount -v ${DEV}2
		fi
			wipefs --all $DEV
			parted -s $DEV mklabel msdos
			parted -s $DEV mkpart primary fat32 1 128
			parted -s $DEV mkpart primary ext4 128 -- -1
			mkfs.vfat -F32 ${DEV}1
			mkfs.ext4 -F ${DEV}2
			mount -v ${DEV}1 ${SD_MOUNT}boot/
			mount -v ${DEV}2 ${SD_MOUNT}root/
		fi
}
function basicSettings {
	SD_MOUNT=$1
	
	echo "Moving boot content"
	mv ${SD_MOUNT}root/boot/* ${SD_MOUNT}boot
	echo "Setting up locale.conf"
	echo LANG=en_US.UTF-8 > ${SD_MOUNT}root/etc/locale.conf
	echo "Setting up keymap"
	echo KEYMAP=us > ${SD_MOUNT}root/etc/vconsole.conf
	echo "Setting up overscan"
	echo disable_overscan=1 >> ${SD_MOUNT}boot/config.txt
	echo "Start sync"
	sync
}
function wifi {
	SD_MOUNT=$1

	echo "Setting up WiFi on boot"
	read -p "SSID: " SSID
	read -p "Password: " PASS
	echo "[Match]" > ${SD_MOUNT}root/etc/systemd/network/wlan0.network
	echo "Name=wlan0" >> ${SD_MOUNT}root/etc/systemd/network/wlan0.network
	echo "[Network]" >> ${SD_MOUNT}root/etc/systemd/network/wlan0.network
	echo "DHCP=yes" >> ${SD_MOUNT}root/etc/systemd/network/wlan0.network

	wpa_passphrase "${SSID}" "${PASS}" > ${SD_MOUNT}root/etc/wpa_supplicant/wpa_supplicant-wlan0.conf

	ln -s /usr/lib/systemd/system/wpa_supplicant@.service ${SD_MOUNT}root/etc/systemd/system/multi-user.target.wants/wpa_supplicant@wlan0.service

}
function changename {
	SD_MOUNT=$1
	echo "Set a host name"
	read -p "Hostname: " HOST
	echo "${HOST}" > ${SD_MOUNT}root/etc/hostname
}
function finish {
	DEV=$1
	if [[ "${DEV##*/}" == "mmcblk0" ]];then
			umount -v ${DEV}p1
			umount -v ${DEV}p2
		else
			umount -v ${DEV}1
			umount -v ${DEV}2
	fi
}
echo "----> Simple bash script to format "
echo "----> and setup the SD card for raspberry pi"
echo "----> with ArchArm"
echo "--------------------------------------------"
echo ""
echo ""
lsblk
read -p "Whats the name of the SD card: " DEV
echo ""
if [[ ! -b "${DEV}" ]] ; then
   echo "Not a block device: ${DEV}"
   exit 1
fi
echo "Final target: "
echo "(1)-Raspberry Pi 4"
echo "(2)-Raspberry Pi Zero W"
read -p "Chose a device: " CHOICE
if [[ $CHOICE = 1 ]] ; then
	rasp4 "${DEV}" "${SD_MOUNT}"
else
	raspZero "${DEV}" "${SD_MOUNT}"
fi
