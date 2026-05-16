#!/bin/sh -e
# apt-get-update-upgrade.sh

# Update your linux distribution

echo " "
echo "************************************************************************"
echo "************************************ apt-get-update-upgrade.sh (START) *"
echo " "

echo "STEP 1 -----------------------------------------------------------------"
echo "sudo apt-get update"
echo "------------------------------------------------------------------------"
echo " "
sudo apt-get update

echo " "
echo "STEP 2 -----------------------------------------------------------------"
echo "sudo apt-get upgrade -y"
echo "------------------------------------------------------------------------"
echo " "
sudo apt-get upgrade -y

echo " "
echo "************************************** apt-get-update-upgrade.sh (END) *"
echo "************************************************************************"
echo " "
