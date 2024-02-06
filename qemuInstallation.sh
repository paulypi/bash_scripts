#!/bin/bash

#
#
#	Qemu installation:
#		This program work in two step execution.
#		1. Execute: ./qemuInstallation.sh and follow setup instructions (a file rebooted will be created into current dir)
#		2. After reboot execute again: ./qemuInstallation.sh and follow installation (rebooted will be removed) 
#
#

# Check if already rebooted and choose the step to execute
if [ ! -f "./rebooted" ]; then
# STEP 1
echo "Start STEP 1"
echo "$(LC_ALL=C lscpu | grep Virtualization)"
echo "Core number:			       $(egrep -c '(vmx|svm)' /proc/cpuinfo)"
read -r -p "Continue installation? [y-n]: " cont

# Update system and install qemu with dependency
if [ $cont == "y" ]; then
echo "Updating the system | Install qemu and dedpndency"
sudo apt update && sudo apt upgrade -y
sudo apt install qemu qemu-kvm virt-manager bridge-utils -y

# SET rebooted for execution of STEP 2
echo "Rebooting the system..."
sleep 1
touch rebooted
reboot

else
echo "Installation abortion"
fi

# STEP 2 after reboot
else
echo "Start STEP 2"
echo -e "\n$(groups)\n"
read -r -p "A new group named libvirt is present? [y-n]: " step2

if [ $step2 == "y" ]; then
# Add current user to groups and check the status of libvirt deamon
echo "Add user to groups [libvirt, libvirt-kvm] | Enable libvirtd service"
sudo useradd -g $USER libvirt;
sleep 1;
sudo useradd -g $USER libvirt-kvm;
sudo systemctl status libvirtd

# In any cases execute activation
sudo systemctl enable libvirtd.service;
sleep 1
sudo systemctl start libvirtd.service;

echo "Removing unused rebooted file"
rm rebooted

echo -e "\nExecute from terminal: virt-manager\nOr check into your apps"
echo "Good Luck"

else
echo "Check your system for any error or rety installation process"
fi

fi
