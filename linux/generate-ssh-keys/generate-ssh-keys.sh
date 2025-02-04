#!/bin/sh -e
# generate-ssh-keys.sh

# Generate authentication keys for ssh (secure shell)

# Usage: sh generate-ssh-keys.sh

echo " "
echo "************************************************************************"
echo "***************************************** generate-ssh-keys.sh (START) *"
echo " "

# --------------------------------------------
# Ask the user for the machine name

echo "What is the name of the machine?"
echo "This will be used as a comment in the ssh key."
echo -n "Machine Name: "
read -r machine_name
echo ""

# --------------------------------------------
# Would you like to generate the keys in ~/.ssh folder or in the current folder?

echo -n "Would you like to place the keys in the ~/.ssh folder? (y/n): "
read -r answer
echo " "

# Generate the ssh keys based on the user's input
if [ "$answer" = "y" ]; then
    key_path="$HOME/.ssh/id_rsa"
else
    key_path="./id_rsa"
fi

# --------------------------------------------
# Generate the ssh keys

echo "Generating ssh keys for $machine_name"
echo "- type: rsa"
echo "- bits: 4096"
echo "- comment: $machine_name"
echo "- files: $key_path / ${key_path}.pub"
echo " "

# Generate the ssh keys
# -t switch is the rsa type key (very popular)
# -b switch is the length in bits
# -C is a comment for this key
# -f is the file name

ssh-keygen -t rsa -b 4096 -C "$machine_name" -f "$key_path"
echo ""

# --------------------------------------------
# Provide feedback to the user

tput setaf 3; echo "SSH keys generated successfully."; tput sgr0
tput setaf 3; echo "Private key: $key_path"; tput sgr0
tput setaf 3; echo "Public key: ${key_path}.pub"; tput sgr0
echo " "

# --------------------------------------------
# Display the public key fingerprints

# MD5 Fingerprint
echo "MD5:"
tput setaf 2; ssh-keygen -E md5 -lf "${key_path}.pub"; tput sgr0
echo " "

# SHA256 Fingerprint
echo "SHA256:"
tput setaf 2; ssh-keygen -E sha256 -lf "${key_path}.pub"; tput sgr0
echo " "

# SHA1 Fingerprint
echo "SHA1:"
tput setaf 2; ssh-keygen -E sha1 -lf "${key_path}.pub"; tput sgr0
echo " "

# --------------------------------------------
# What to do now?

echo "To add the key to the ssh-agent, run the following command:"
tput setaf 2; echo "ssh-add $key_path"; tput sgr0

echo " "
echo "******************************************* generate-ssh-keys.sh (END) *"
echo "************************************************************************"
echo " "
