#!/bin/bash

set -e

disk=$(ls /dev/sd?1 | head -n 1)

if [ -z $disk ]; then
	echo "No USB disk found"
	exit
fi

# Ensure no text is visible between videos
setterm -foreground black

# (re?)mount USB disk
sudo umount /mnt/usb || true
sudo mount -r -t vfat $disk /mnt/usb

cd /mnt/usb/Movies || cd /mnt/usb/movies

# Let's watch some videos
files=(*)
while :
do
	for movie in "${files[@]}"; do
		clear
		omxplayer -o local --hdmiclocksync "$movie" || true
	done
done
