#!/bin/sh -e
# clean-vagrant.sh

echo " "
echo "************************************************************************"
echo "********************************************* clean-vagrant.sh (START) *"
echo " "

echo "vagrant box prune"
echo "This command removes old versions of installed boxes" 
echo "------------------------------------------------------------------------"
echo " "
vagrant box prune

echo "************************************************* clean-vagrant.sh (END) *"
echo "**************************************************************************"
echo " "
