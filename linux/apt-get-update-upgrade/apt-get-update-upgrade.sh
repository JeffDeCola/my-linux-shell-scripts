#!/bin/bash -e
# apt-get-update-upgrade.sh

echo " "
echo "************************************************************************"
echo "**************************************** apt-update-upgrade.sh (START) *"
echo " "

echo "STEP 1 -----------------------------------------------------------------"
echo "sudo apt-get update"
echo "------------------------------------------------------------------------"
echo " "
sudo apt-get update

echo "STEP 2 -----------------------------------------------------------------"
echo "sudo apt-get upgrade -y"
echo "------------------------------------------------------------------------"
echo " "
sudo apt-get upgrade -y

echo "****************************************** apt-update-upgrade.sh (END) *"
echo "************************************************************************"
echo " "