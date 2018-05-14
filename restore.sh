#!/bin/sh

if [ -z $1 ]; then
    echo "no argument, assume the target device is /dev/sdb ? Y/N"
    read key
    if [ "$key" = "y" -o "$key" = "Y" ]; then
        sudo umount /dev/sdb1
        sudo umount /dev/sdb2
        sudo parted $1 --script -- rm 1
        sudo parted $1 --script -- rm 2
        sudo dd if=rpibackup.img of=/dev/sdb bs=512
        sudo parted /dev/sdb resizepart 2 7168MB
    else
        echo "exiting,please run as sudo ./restore.sh /dev/sdb"
        exit 0
    fi
else
    sudo umount $1"1"
    sudo umount $1"2"
    sudo parted $1 --script -- rm 1
    sudo parted $1 --script -- rm 2
    sudo dd if=rpibackup.img of=$1 bs=512
    sudo parted $1 resizepart 2 7168MB
fi
