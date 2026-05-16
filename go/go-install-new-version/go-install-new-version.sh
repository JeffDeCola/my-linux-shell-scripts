#!/bin/sh -e
# go-install-new-version.sh

# Install the latest version of golang on linux, macOS, Windows, Raspberry Pi, etc.

GREEN=$(tput setaf 2)
RESET=$(tput sgr0)

echo " "
echo "************************************************************************"
echo "************************************ go-install-new-version.sh (START) *"
echo " "

# Check https://go.dev/dl/ to see latest version
ver='1.26.3'

# What version of go do you have
if command -v go >/dev/null 2>&1; then
    currentVer=$(go version | awk '{print $3}' | sed 's/^go//')
else
    currentVer="(not installed)"
fi
echo "Current version is                    ${GREEN}$currentVer${RESET}"

# You are about to install go $ver
echo "This script will install version      ${GREEN}$ver${RESET}"
echo " "
echo "Check https://go.dev/dl/ to see latest versions"
echo " "

# Would you like to change the version to install?
printf "Would you like to change the version to install? (y/return to continue): "
read -r changeVersion
echo " "

if [ "$changeVersion" = "y" ] || [ "$changeVersion" = "Y" ]; then
    printf "Enter the version you want to install: "
    read -r ver
fi

# Set file names
linuxFileName='go'$ver'.linux-amd64.tar.gz'
macOSx86_64FileName='go'$ver'.darwin-amd64.pkg'
macOSARM64FileName='go'$ver'.darwin-arm64.pkg'
windowsFileName='go'$ver'.windows-amd64.msi'
arm64FileName='go'$ver'.linux-arm64.tar.gz'

# What OS do you have?
echo "Which OS do you have?"
echo " "
echo "    1) Linux"
echo "    2) macOS (x86-64)"
echo "    3) macOS (ARM64)"
echo "    4) Arch Linux"
echo "    5) Windows"
echo "    6) ARM 64-bit (RaspPi 4B, 3B, etc...)"
echo "    7) ARM 32-bit (RaspPi 1B, Hummingboard, etc...) - INVALID"
echo "    8) Quit/Exit"
echo " "

printf "Enter your choice: "
read -r choice

# 1 LINUX ------------------------------------------------------------------------------------------

if
    [ "$choice" -eq 1 ]; then
    FileName=$linuxFileName

    echo "Going to Download $FileName, untar and move to /usr/local"

    # cd /tmp
    cd /tmp || exit

    # wget
    wget https://go.dev/dl/$FileName

    # untar
    tar -xf $FileName

    # Remove current version go
    sudo rm -rf /usr/local/go

    # Move new version
    sudo mv go /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    go version
    echo " "

# 2 macOS (x86-64) ---------------------------------------------------------------------------------

elif
    [ "$choice" -eq 2 ]; then
    FileName=$macOSx86_64FileName

    echo "Going to Download $FileName"

    # cd /tmp
    cd /tmp || exit

    # curl
    curl -fLO https://go.dev/dl/$FileName

    # Install
    sudo installer -pkg $FileName -target /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    /usr/local/go/bin/go version
    echo " "
    echo "You may have to open a new terminal for you to test go version"
    echo " "

# 3 macOS (ARM64) ----------------------------------------------------------------------------------

elif
    [ "$choice" -eq 3 ]; then
    FileName=$macOSARM64FileName

    echo "Going to Download $FileName"

    # cd /tmp
    cd /tmp || exit

    # curl
    curl -fLO https://go.dev/dl/$FileName

    # Install
    sudo installer -pkg $FileName -target /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    /usr/local/go/bin/go version
    echo " "
    echo "You may have to open a new terminal for you to test go version"
    echo " "

# 4 ARCH LINUX -------------------------------------------------------------------------------------

elif
    [ "$choice" -eq 4 ]; then

    # Is go installed
    if command -v go >/dev/null 2>&1; then
        echo "Go already installed: $(go version | awk '{print $3}' | sed 's/^go//')"
        echo "Checking for updates..."
    else
        echo "Installing Go..."
    fi

    # installs if missing, upgrades if newer
    sudo pacman -S --noconfirm go

    # Show version
    echo " "
    echo "Your go version is:"
    go version | awk '{print $3}' | sed 's/^go//'
    echo " "

# 5 WINDOWS ----------------------------------------------------------------------------------------

elif
    [ "$choice" -eq 5 ]; then
    FileName=$windowsFileName

    echo "Going to Download $FileName"

    # cd /tmp
    cd /tmp || exit

    # wget
    wget https://go.dev/dl/$FileName

    # Install
    echo " "
    " .msi file downloaded. Double click in windows to install"
    echo " "

# 6 ARM 64-bit -------------------------------------------------------------------------------------

elif
    [ "$choice" -eq 6 ]; then
    FileName=$arm64FileName

    echo "Going to Download $FileName, untar and move to /usr/local"

    # cd /tmp
    cd /tmp || exit

    # wget
    wget https://go.dev/dl/$FileName

    # untar
    tar -xf $FileName

    # Remove current version go
    sudo rm -rf /usr/local/go

    # Move new version
    sudo mv go /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    go version
    echo " "

# 7 ARM 32-bit -------------------------------------------------------------------------------------

elif
    [ "$choice" -eq 7 ]; then

    echo "Go does not support 32-bit"
    echo " "

# 8 QUIT/EXIT --------------------------------------------------------------------------------------

elif
    [ "$choice" -eq 8 ]; then
    echo "Exit"

else
    tput setaf 1; echo "Invalid choice"; tput sgr0
fi

echo " "
echo "************************************** go-install-new-version.sh (END) *"
echo "************************************************************************"
echo " "
