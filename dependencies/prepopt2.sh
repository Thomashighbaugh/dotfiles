#!/bin/env bash 

###############################################################
###############################################################
## Pi: Prepare Image ##########################################
###############################################################
###############################################################


# This script downloads and then prepares the image that will be burned onto the sd card
# This script is then followed by the next, which essentially only wraps the dd command,
# but was included for continuity purposes.

echo "Downloading preparing the image's source files"
sudo losetup /dev/loop0 && exit 1 || true
image=arch-linux-$(date +%Y%m%d).img
wget -q -N http://archlinuxarm.org/os/ArchLinuxARM-rpi-4-latest.tar.gz

# Set the Image's Size then partition it

echo "Partitioning image"
sudo truncate -s 2G $image
sudo losetup /dev/loop0 $image
sudo parted -s /dev/loop0 mklabel msdos
sudo parted -s /dev/loop0 unit s mkpart primary fat32 -- 0% 100MB
sudo parted -s /dev/loop0 set 1 boot on
sudo parted -s /dev/loop0 unit s mkpart primary ext2 -- 100MB 100%
sudo parted -s /dev/loop0 print
sudo mkfs.vfat -I -n SYSTEM /dev/loop0p1
sudo mkfs.ext4 -F -L root -b 4096 -E stride=4,stripe_width=1024 /dev/loop0p2

echo "Unpacking source files into the image's partitions"
sudo mkdir -p root
sudo mount /dev/loop0p2 root
sudo bsdtar xfz ArchLinuxARM-rpi-4-latest.tar.gz -C root
sudo mv root/boot root/boot-temp
sudo mkdir -p root/boot
mount /dev/loop0p1 root/boot
sudo mv root/boot-temp/* root/boot/
sudo rm -rf root/boot-temp
sudo sed -i "s/ defaults / defaults,noatime /" root/etc/fstab

echo "Clean up"
sudo umount root/boot root
sudo losetup -d /dev/loop0