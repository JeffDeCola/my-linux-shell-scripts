#!/bin/bash
# my-global-repo-scripts-private install-new-version-go.sh

# Check https://go.dev/dl/ to see latest version
ver='1.20.1'

# Set file names
linuxFileName='go'$ver'.linux-amd64.tar.gz'
macOSx86_64FileName='go'$ver'.darwin-amd64.pkg'
macOSARM64FileName='go'$ver'.darwin-arm64.pkg'
windowsFileName='go'$ver'.windows-amd64.msi'

# You are about to install go $ver
echo " "
echo "You are about to install go version $ver"

# What OS do you have?
echo ""
echo "Which OS do you have?"
echo "1) Linux"
echo "2) Mac OS (x86-64)"
echo "3) Mac OS (ARM64)"
echo "4) Arch Linux"
echo "5) Windows"
echo " "
echo "q Quit"
echo " "

read -r -p "Enter your choice: " choice

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

elif 
    [ "$choice" -eq 2 ]; then
    FileName=$macOSx86_64FileName

    echo "Going to Download $FileName"

    # cd /tmp
    cd /tmp || exit

    # wget
    wget https://go.dev/dl/$FileName

    # Install
    sudo installer -pkg $FileName -target /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    go version

elif 
    [ "$choice" -eq 3 ]; then
    FileName=$macOSARM64FileName

    echo "Going to Download $FileName"

    # cd /tmp
    cd /tmp || exit

    # wget
    wget https://go.dev/dl/$FileName

    # Install
    sudo installer -pkg $FileName -target /usr/local

    # Remove downloaded file
    rm $FileName

    # Show version
    echo " "
    echo "Your updated go version is:"
    go version

elif 
    [ "$choice" -eq 4 ]; then

    # Install
    echo "sudo pacman -S go"
    sudo pacman -S go

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

else
    echo "Invalid choice"
    exit
fi
