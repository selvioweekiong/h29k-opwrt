#!/bin/bash 

# Install ATC FM350 driver and related packages
# Ensure you have the necessary files in the correct directories before running this script

clear
echo "FM350-GL ATC Driver Installation Script By SxLvIo"
echo "Updating system before installation..."
#Run update and install necessary packages
opkg update
opkg install kmod-usb-serial-option kmod-usb-net-rndis comgt sms-tool

wget https://github.com/mrhaav/openwrt/raw/refs/heads/master/atc/fib-fm350_gl/atc-fib-fm350_gl_2025.02.01-r3_all.ipk -O fm350-atc.ipk
wget https://github.com/mrhaav/openwrt/raw/refs/heads/master/atc/luci-proto-atc_2025.01.10-r2_all.ipk -O luci-proto-atc.ipk

#check if the files were downloaded successfully
if [ ! -f fm350-atc.ipk ] || [ ! -f luci-proto-atc.ipk ]; then
    echo "Error: Required files not found. Please ensure the files are in the correct directory."
    exit 1
fi

#install the packages to the system
echo "Installing packages..."
opkg install luci-proto-atc.ipk
opkg install fm350-atc.ipk

# Installing the ATC FM350 driver
echo "Installing ATC FM350 driver..."
wget https://github.com/mrhaav/openwrt/raw/refs/heads/master/atc/fib-fm350_gl/50-fm350_driver -O /etc/hotplug.d/usb/50-fm350_driver
wget https://github.com/mrhaav/openwrt/raw/refs/heads/master/atc/fib-fm350_gl/60-fm350_crash -O /etc/hotplug.d/usb/60-fm350_crash

#checking if the files were downloaded successfully
if [ ! -f /etc/hotplug.d/usb/50-fm350_driver ] || [ ! -f /etc/hotplug.d/usb/60-fm350_crash ]; then
    echo "Error: Driver files not found. Please ensure the files are in the correct directory."
    exit 1
fi

#Restart the device to apply changes
echo "Installation complete. Rebooting in 5 seconds..."
sleep 5
reboot
