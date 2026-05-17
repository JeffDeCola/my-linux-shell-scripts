#!/bin/sh -e
# apt-get-update-upgrade.sh

# Update your linux distribution

# SUDO SUPPORT ---------------------------------------------------------------
# Use sudo only if not already root. (e.g.proxmox and lxc)
if [ "$(id -u)" -eq 0 ]; then
    SUDO=""
else
    SUDO="sudo"
fi

echo " "
echo "************************************************************************"
echo "************************************ apt-get-update-upgrade.sh (START) *"
echo " "

echo "STEP 1 -----------------------------------------------------------------"
echo "${SUDO} apt-get update"
echo "------------------------------------------------------------------------"
echo " "
$SUDO apt-get update

echo " "
echo "STEP 2 -----------------------------------------------------------------"
echo "${SUDO} apt-get upgrade -y"
echo "------------------------------------------------------------------------"
echo " "
$SUDO apt-get upgrade -y

echo " "
echo "************************************** apt-get-update-upgrade.sh (END) *"
echo "************************************************************************"
echo " "
