#!/bin/sh

if [ -z $1 ]; then
    echo "no argument, assume the target device is /dev/sdb ? Y/N"
    read key
    if [ "$key" = "y" -o "$key" = "Y" ]; then
        sudo dd if=rpibackup.img of=/dev/sdb bs=512
        sudo parted $1 resizepart 2 7168MB
    else
        echo "exiting,please run as sudo ./restore.sh /dev/sdb"
        exit 0
    fi
else
    sudo dd if=rpibackup.img of=$1 bs=512
    sudo parted $1 resizepart 2 7168MB
fi
