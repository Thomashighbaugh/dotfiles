#!/bin/bash

read -p "*** The effects of this script are irreversible and could lead to data loss and/or kernel panics if not used properly. Are you sure you want to do this? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy1]$ ]]; then
    echo "*** Exiting..."
    exit 1
fi

echo "*** Performing initial tests..."

if [ -f "/root/packages.txt" ]; then
    echo "*** File /root/packages.txt found."
else
    echo "*** File /root/packages.txt is missing."

    read -p "*** Create a /root/packages.txt with the package base-system in it? (y/n) " -n 1 -r
    echo

    if [[ ! $REPLY =~ ^[Yy1]$ ]]; then
        echo "*** Exiting..."
        exit 2
    else
        echo "base-system" >/root/packages.txt
        BASE_INSTALL=y
    fi
fi

if ping -c 1 -q google.com >/dev/null; then
    echo "*** Connected to the network."
else
    echo "*** Not connected to the network, initializing connection, then exiting..."

    echo -n "*** SSID: "
    read SSID_INPUT
    echo -n "*** Passphrase: "
    read PASS_INPUT

    wpa_supplicant -B -i wlp4s0 -c <(wpa_passphrase $SSID_INPUT $PASS_INPUT)
    exit 1
fi

read -p "*** Create a swap partition at /dev/sda2? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy1]$ ]]; then
    echo "*** Not creating swap."
else
    echo -n "*** Creating a swap at /dev/sda2 of size (for eg: 512M, 2G): "
    read SWAPSIZE_INPUT
fi

echo -n "*** Size of EFI System Partition? Can't be lower than 64M due to FAT32 (for eg: 256M, 512M): "
read ESPSIZE_INPUT

echo "*** Creating filesystems..."

# This is not an epic way of doing this, but it works.
# Explanation for each action:
# wipefs clears all of the signatures on the disk.
# g\n creates a new GPT table.
# n\n creates a new partition.
# \n auto chooses the partition number.
# \n auto chooses the starting block.
# +ESPSIZE_INPUT\m chooses the size of the ESP (boot partition).
# t\n opens the type setting dialog (auto chooses partition 1).
# 1\n sets type to EFI System.
# If swap is chosen: n\n makes new partition.
# If swap is chosen: \n auto chooses the partition number.
# If swap is chosen: \n auto chooses the starting block.
# If swap is chosen: +$SWAPSIZE_INPUT\n chooses size of the swap space.
# If swap is chosen: t\n opens the type setting dialog.
# If swap is chosen: \n chooses the newest partition.
# If swap is chosen: 19\n sets type to Linux Swap.
# n\n makes new partition.
# \n auto chooses the partition number.
# \n auto chooses the starting block.
# \n chooses till the end of the disk.
# w\n writes the partition table.

wipefs /dev/sda* -afq 2>/dev/null
echo -e $([ -z $SWAPSIZE_INPUT ] && echo "g\n n\n \n \n +$ESPSIZE_INPUT\n t\n 1\n n\n \n \n \n w\n" || echo "g\n n\n \n \n +$ESPSIZE_INPUT\n t\n 1\n n\n \n \n +$SWAPSIZE_INPUT\n t\n \n 19\n n\n \n \n \n w\n") | fdisk /dev/sda >/dev/null

echo "*** Formatting filesystems..."

mkfs.vfat -F 32 /dev/sda1 >/dev/null

if [ -z $SWAPSIZE_INPUT ]; then
    mkfs.ext4 -q /dev/sda2 >/dev/null
else
    mkswap /dev/sda2 >/dev/null
    swapon /dev/sda2
    mkfs.ext4 -q /dev/sda3 >/dev/null
fi

echo "*** Mounting partitions..."

mount $([ -z $SWAPSIZE_INPUT ] && echo "/dev/sda2" || echo "/dev/sda3") /mnt >/dev/null
mkdir -p /mnt/boot/efi >/dev/null
mount /dev/sda1 /mnt/boot/efi >/dev/null

echo "*** Setting up XBPS environment..."

REPO=https://alpha.de.repo.voidlinux.org/current
ARCH=x86_64
XBPS_ARCH=$ARCH

echo "*** Installing packages, this might take a while (if you see a few errors, thats fine)..."

xbps-install -S -r /mnt -R "$REPO" -y $(cat /root/packages.txt) >/dev/null

echo "*** Setting up chroot environment and script..."

mount --rbind /sys /mnt/sys && mount --make-rslave /mnt/sys
mount --rbind /dev /mnt/dev && mount --make-rslave /mnt/dev
mount --rbind /proc /mnt/proc && mount --make-rslave /mnt/proc

cp /etc/resolv.conf /mnt/etc/

echo '#!/bin/bash

echo "*** Performing initial tests..."

if which efibootmgr > /dev/null 2>&1; then
	echo "*** efibootmgr found."
else
	echo "*** efibootmgr is missing, installing it..."
	xbps-install -S -y efibootmgr > /dev/null
fi

if which blkid > /dev/null 2>&1; then
	echo "*** blkid found."
else
	echo "*** blkid is missing, installing util-linux..."
	xbps-install -S -y util-linux > /dev/null
fi' >/mnt/root/temp.sh

if [ ! -z $BASE_INSTALL ]; then
    echo "BASE_INSTALL=y" >>/mnt/root/temp.sh
fi

if [ ! -z $SWAPSIZE_INPUT ]; then
    echo "SWAP_INSTALL=y" >>/mnt/root/temp.sh
fi

echo echo '"*** Configuring void installation..."

echo -n "*** Hostname: "
read HOSTNAME_INPUT
echo -n "*** Username: "
read USERNAME_INPUT

echo $HOSTNAME_INPUT > /etc/hostname

useradd -m $USERNAME_INPUT

if [ -z $BASE_INSTALL ]; then
	read -p "*** Are you going to be using doas instead of sudo? (y/n) " -n 1 -r
	echo

	if [[ ! $REPLY =~ ^[Yy1]$ ]]; then
		echo "*** Changing sudoers file to allow $USERNAME_INPUT as root..."
		echo "$USERNAME_INPUT ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
	else
		echo "*** Changing doas.conf file to allow $USERNAME_INPUT as root..."
		echo "permit nopass nolog $USERNAME_INPUT" > /etc/doas.conf
	fi
else
	echo "*** Changing sudoers file to allow $USERNAME_INPUT as root..."
	echo "$USERNAME_INPUT ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

set_zone() {
	echo -n "*** Specify a timezone to link to /etc/localtime from /usr/share/zoneinfo (for eg. Asia/Kolkata, America/New_York) or press q to quit: "
	read

	if [[ $REPLY =~ ^[qQcC]$ ]]; then
		return 1
	fi

	if [ -f "/usr/share/zoneinfo/$REPLY" ]; then
		ln -sf /usr/share/zoneinfo/$REPLY /etc/localtime
	else
		echo "*** Zone file not found, retrying..."
		set_zone
	fi
}

set_zone

read -p "Is this a GNU libc (glibc) installation? (y/n) " -n 1 -r
echo

if [[ ! $REPLY =~ ^[Yy1]$ ]]; then
	echo "*** Not configuring glibc locales."
else
	echo "*** Configuring glibc locales..."

	echo "en_US.UTF-8" > /etc/default/libc-locales
	xbps-reconfigure -f glibc-locales > /dev/null
fi

echo "*** Setting password for root..."
passwd

echo "*** Setting password for $USERNAME_INPUT..."
passwd $USERNAME_INPUT

echo "*** Configuring /etc/fstab in a text editor..."

cp /proc/mounts /etc/fstab
echo "# Only keep /dev/sda<X> here, as tmpfs (and if chosen, swap) will be added automatically." >> /etc/fstab

#Open in editor to clean up
if which nvim > /dev/null 2>&1; then
	nvim /etc/fstab	
	clear
elif which vim > /dev/null 2>&1; then
	vim /etc/fstab	
	clear
elif which nano > /dev/null 2>&1; then
	nano /etc/fstab	
	clear
elif which nvi > /dev/null 2>&1; then
	nvi /etc/fstab	
	clear
elif which vi > /dev/null 2>&1; then
	vi /etc/fstab	
	clear
else
	echo "*** Editor not found! Installation does not have any editor available, terminating script..."
	exit 1
fi

echo "*** Finishing up /etc/fstab automatically..."

echo "tmpfs /tmp tmpfs defaults,nosuid,nodev 0 0" >> /etc/fstab

if [ ! -z $SWAP_INSTALL ]; then
	echo "UUID=$(blkid -o value -s UUID /dev/sda2) swap swap rw,noatime,discard 0 0" >> /etc/fstab
fi

echo "*** Reconfiguring the entire system..."

xbps-reconfigure -fa > /dev/null

echo "*** Setting up ESP and boot order..."

cp /boot/vmlinuz-* /boot/efi/
cp /boot/initr*.img /boot/efi/

#Clear boot order
efibootmgr -O > /dev/null

if [ ! -z $SWAP_INSTALL ]; then
	read -p "*** Allow for hibernation on swap space? Keep in mind this requires a swap space equal to the amount of RAM: (y/n) " -n 1 -r HIB_INPUT
	echo
fi

#Add new boot order entry
efibootmgr -c -L "$HOSTNAME_INPUT" -l $(ls /boot/efi/ | grep --color=never vmlinuz) -u "root=PARTUUID=$(blkid -o value -s PARTUUID $([ -z $SWAP_INSTALL ] && echo "/dev/sda2" || echo "/dev/sda3")) $([[ $HIB_INPUT =~ ^[Yy1]$ ]] && echo "resume=$(blkid -o value -s PARTUUID /dev/sda2) ")rw initrd=$(ls /boot/efi/ | grep --color=never initr)" > /dev/null

echo "*** Chroot script done."
exit 0' >>/mnt/root/temp.sh

echo "*** Chrooting and executing script..."

chmod +x /mnt/root/temp.sh
chroot /mnt /bin/bash -c "/root/temp.sh"

echo "*** Cleaning up..."

rm /mnt/root/temp.sh
#Trust me, you don't need these
rm /mnt/boot/vmlinuz-*
rm /mnt/boot/initr*.img

echo "*** Done. Restart your system to boot into Void."
exit 0
