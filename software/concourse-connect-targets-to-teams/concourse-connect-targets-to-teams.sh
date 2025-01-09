#!/bin/sh -e
# concourse-connect-targets-to-teams.sh

# Connect local machine targets to concourse teams

echo " "
echo "************************************************************************"
echo "************************ concourse-connect-targets-to-teams.sh (START) *"
echo " "

echo "THE TARGET IS ON YOUR MACHINE - WHICH YOU USE TO CONNECT TO TEAM ON CONCOURSE"
echo "END RESULT"
echo "main-ci-target - connects to the main team on concourse"
echo "jeffs-ci-target - connects to the jeffs-ci-team on concourse"
echo " "

echo " "
echo "STEP 1 -----------------------------------------------------------------"
echo "SETUP TARGET main-ci-target TO CONNECT TO main TEAM ON CONCOURSE"
fly --target main-ci-target login --team-name main --concourse-url http://192.168.20.112:8080/
echo ""

echo " "
echo "STEP 2 -----------------------------------------------------------------"
echo "CREATE NEW TEAM jeffs-ci-team"
echo "fly --target main-ci-target set-team --team-name jeffs-ci-team --local-user test"
echo " "

echo "STEP 3 -----------------------------------------------------------------"
echo "SETUP TARGET jeffs-ci-target TO CONNECT TO jeffs-ci-team TEAM ON CONCOURSE"
echo "fly --target jeffs-ci-target login --team-name jeffs-ci-team --concourse-url http://192.168.20.112:8080/"
echo ""

echo " "
echo "TO CHECK YOUR TARGETS ARE CONNECTED TO TEAMS"
echo "fly targets"
echo "cat ~/.flyrc"
echo " "
echo "TO SEE TEAMS"
echo "fly --target main-ci-target teams"
echo "fly --target jeffs-ci-target teams"
echo " "
echo "TO SEE USERS"
echo "fly --target main-ci-target userinfo"
echo "fly --target jeffs-ci-target userinfo"

echo " "
echo "**************************** concourse-connect-targets-to-teams.sh (END) *"
echo "**************************************************************************"
echo " "
