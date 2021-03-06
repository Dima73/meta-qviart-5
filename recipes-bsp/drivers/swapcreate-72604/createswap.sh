#!/bin/sh

device1=$(blkid -t /dev/mmcblk0p5 | awk '{print $2}' | cut -d '"' -f2)

swap1=$(cat /proc/swaps | grep -o "/dev/mmcblk0p5" | head -n1)

if [ "$device1" == "" ]; then
	echo "  Sorry, no swap drive found"
	exit 1
fi

grep -q "/dev/mmcblk0p5" /etc/fstab

if [ $? -ne 0 ]; then
	mkswap /dev/mmcblk0p5
	swapon /dev/mmcblk0p5
	echo '/dev/mmcblk0p5 none swap defaults 0 0' >> /etc/fstab
elif [ "$swap1" == "" ]; then
	mkswap /dev/mmcblk0p5
	swapon /dev/mmcblk0p5
fi
