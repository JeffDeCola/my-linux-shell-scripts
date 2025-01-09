#!/bin/sh -e
# vagrant-remove-images.sh

# Remove all vagrant images (boxes)

echo " "
echo "************************************************************************"
echo "************************************* vagrant-remove-images.sh (START) *"
echo " "

echo "vagrant box prune"
echo "This command removes old versions of installed boxes"
echo "------------------------------------------------------------------------"
echo " "
vagrant box prune

echo " "
echo "***************************************** vagrant-remove-images.sh (END) *"
echo "**************************************************************************"
echo " "
