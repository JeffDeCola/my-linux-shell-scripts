#!/bin/sh -e
# docker-install.sh
#
# usage: sh docker-install.sh
#

echo " "
echo "************************************************************************"
echo "******************************************** docker-install.sh (START) *"
echo "Running as $(whoami) in $(pwd)"
echo " "

# PRE-CHECK - SEE IF DOCKER ALREADY INSTALLED
if command -v docker >/dev/null 2>&1; then
    echo "Docker is already installed on this host, skipping installation."
    echo " "
    exit 0
fi

# ------------------------------------------------------------
echo "*** PART I - SELECT DISTRO"
echo " "

echo "Which Linux distro is this script running on?"
echo " "
echo "    1) Ubuntu (any apt-based version: 20.04, 22.04, 24.04, etc.)"
echo "    2) Debian (any apt-based version: 11/bullseye, 12/bookworm, 13/trixie, etc.)"
echo "    3) Quit/Exit"
echo " "

printf "Enter your choice: "
read -r choice
echo " "

case "$choice" in
    1)
        DOCKER_REPO_URL="https://download.docker.com/linux/ubuntu"
        DISTRO="ubuntu"
        ;;
    2)
        DOCKER_REPO_URL="https://download.docker.com/linux/debian"
        DISTRO="debian"
        ;;
    3)
        echo "Exiting at user request."
        exit 0
        ;;
    *)
        echo "ERROR: Invalid choice '$choice'."
        exit 1
        ;;
esac

echo "Read distro info from /etc/os-release (parsing explicitly, no shell sourcing)"
OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
OS_VERSION_CODENAME=$(grep '^VERSION_CODENAME=' /etc/os-release | cut -d= -f2 | tr -d '"')
echo "Detected distro=$OS_ID"
echo " "

if [ "$OS_ID" != "$DISTRO" ]; then
    echo "ERROR: You chose $DISTRO but /etc/os-release reports ID=$OS_ID."
    echo "Re-run and pick the correct option, or fix the host."
    echo " "
    exit 1
fi

# ------------------------------------------------------------
echo "*** PART II - SUMMARY"
echo " "

echo "*** SUMMARY"
echo " "
echo "    Distro                     $DISTRO"
echo "    Docker repo                $DOCKER_REPO_URL"
echo "    User for 'docker' group    $(whoami)"
echo " "

# ------------------------------------------------------------
echo "*** PART III - SANITY CHECK FOR SYSTEMD"
echo " "

if ! pidof systemd >/dev/null 2>&1; then
    echo "ERROR: systemd is not running on this host."
    echo "  - On WSL2: add the following to /etc/wsl.conf, then run 'wsl --shutdown' from PowerShell:"
    echo "        [boot]"
    echo "        systemd=true"
    echo "  - On Proxmox LXC: ensure the container has 'features: nesting=1' in its config."
    echo " "
    exit 1
fi

echo "systemd is active"
echo " "

# ------------------------------------------------------------
echo "*** PART IV - SET UP THE REPOSITORY"
echo " "

echo "Update apt cache before installing prerequisites"
sudo apt-get -y update
echo " "

echo "Install a few prerequisite packages"
sudo apt-get -y install \
    ca-certificates \
    curl \
    gnupg
echo " "

echo "Add Docker's official GPG key"
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL "$DOCKER_REPO_URL/gpg" -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo " "

echo "Set up the repository"
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] $DOCKER_REPO_URL \
  $OS_VERSION_CODENAME stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
echo " "

# ------------------------------------------------------------
echo "*** PART V - INSTALL DOCKER ENGINE"
echo " "

echo "Update the package database with the Docker packages from the newly added repo"
sudo apt-get -y update
echo " "

echo "Install Docker Engine, containerd, and Docker Compose"
sudo apt-get -y install \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin
echo " "

# ------------------------------------------------------------
echo "*** PART VI - POST-INSTALL"
echo " "

echo "Enable docker to start on boot"
sudo systemctl enable docker
echo " "

echo "Start docker now"
sudo systemctl start docker
echo " "

echo "Check that it will run at boot"
sudo systemctl is-enabled docker
echo " "

echo "Add user $(whoami) to docker group"
if id "$(whoami)" >/dev/null 2>&1; then
    sudo usermod -aG docker "$(whoami)"
    echo "Added $(whoami) to docker group."
    echo "NOTE: log out and back in (or run 'newgrp docker') for the group change to take effect."
else
    echo "User '$(whoami)' does not exist on this host, skipping group add."
fi
echo " "

echo "********************************* provisioning-install-docker.sh (END) *"
echo "************************************************************************"
echo " "
