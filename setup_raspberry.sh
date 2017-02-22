#!/bin/bash

set -e

# Assume this script is executed raspberry running Raspbian Lite on which the following commands
# have been executed:
# * sudo apt-get update
# * sudo apt-get install git omxplayer
# * Via "sudo raspi-config" :
#   * configure the board to login automatically without starting the GUI.
#   * change locale and keyboard layout to en-us

cd ~

# Make sure the directory to mount usb to exists
sudo mkdir /mnt/usb

# Enable "airplane mode" by disabling Bluetooth and WiFi
sudo echo "# WiFi" >  /etc/modprobe.d/raspi-blacklist.conf
sudo echo "blacklist brcmfmac" >> /etc/modprobe.d/raspi-blacklist.conf
sudo echo "blacklist brcmutil" >> /etc/modprobe.d/raspi-blacklist.conf
sudo echo "# Bluetooth" >> /etc/modprobe.d/raspi-blacklist.conf
sudo echo "blacklist btbcm" >> /etc/modprobe.d/raspi-blacklist.conf
sudo echo "blacklist hci_uart" >> /etc/modprobe.d/raspi-blacklist.conf

# Give GPU more memory in order to prevent green screen
# https://www.raspberrypi.org/forums/viewtopic.php?f=28&t=73769
sudo echo "gpu_mem=128" > /boot/config.txt

# "Fast boot". Don't wait for DHCP client.
# Note problems reported here: https://github.com/RPi-Distro/repo/issues/24
# Code taken from https://github.com/RPi-Distro/raspi-config/blob/98887bc18d9ff37e1ab7d373af4040d87cfb8332/raspi-config#L969
sudo rm /etc/systemd/system/dhcpcd.service.d/wait.conf

# Change locale. https://github.com/raspberrypi-ui/rc_gui/blob/bf829a6cd4a130eaa421e1a39cee6388301f8414/raspi-config#L268
sudo dpkg-reconfigure locales

# Change keyboard. https://github.com/raspberrypi-ui/rc_gui/blob/bf829a6cd4a130eaa421e1a39cee6388301f8414/raspi-config#L260
dpkg-reconfigure keyboard-configuration && printf "Reloading keymap. This may take a short while\n" && invoke-rc.d keyboard-setup start
udevadm trigger --subsystem-match=input --action=change

# Make sure video looping starts on startup
echo "RaspberryVideoLooper/loop_videos.sh" >> /home/pi/.profile

passwd
