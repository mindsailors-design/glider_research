# Installing Arch Linux on ARM on Pi 4

## Based on this tutorial:
https://www.youtube.com/watch?v=HWWGy3tUdBQ

## 1. Partition SD card with Boot: 200MiB, FAT32 and Root: ext4
I used GParted on KDE desktop environment (on Arch btw)

## 2. Download image from:
https://archlinuxarm.org/about/downloads
*ArchLinuxARM-rpi-aarch64-latest.tar.gz*

## 3. Mount SD card in the file system:
sudo mkdir /mnt/boot
sudo mkdir /mnt/root

sudo mkfs.vfat -F 32 /dev/sdd1
sudo mkfs.ext4 /dev/sdd2

sudo mount /dev/sdd1 /mnt/boot
sudo mount /dev/sdd2 /mnt/root

## 4. Make helper directory:

mkdir root

## 5. Untar this image to the /mnt/root:
sudo bsdtar -xpf ArchLinuxARM-rpi-aarch64-latest.tar.gz -C root

## 6. Copy files to the /mnt/root:
 mv root/boot/* /mnt/boot

## 7. Change boot.txt for Pi 4:
sudo micro /mnt/boot/boot.txt

Change all file occurances from "fdt_addr_r" to "fdt_addr", save and exit.

## 8. Unmount boot and root:
sudo umount /mnt/boot
sudo umount /mnt/root

## 9. Put the SD card into the Pi and check if it boots.

## 10. If the Pi says something about not mounting a partition:
Put the SD card into your PC and mount it and in the /etc/fstab:
UUID=boot_partition_uuid  /boot  vfat  defaults  0 0
UUID=root_partition_uuid  /      ext4  defaults,noatime  0 1

Check those UUID by running lsblk -f or blkid. If it doesn't work with one, try the other UUID.
