#!/bin/sh -e
# docker-remove-all.sh

# Remove all docker containers and images

echo " "
echo "************************************************************************"
echo "***************************************** docker-remove-all.sh (START) *"
echo " "

echo "(docker ps -a -q)"
echo "------------------------------------------------------------------------"
echo " "
docker rm "$(docker ps -a -q)"
echo

echo "(docker images -q)"
echo "------------------------------------------------------------------------"
echo " "
docker rmi "$(docker images -q)"

echo " "
echo "********************************************* docker-remove-all.sh (END) *"
echo "**************************************************************************"
echo " "
