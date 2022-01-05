#!/bin/bash
# Declare the variables
nft="/sbin/nft"

# Backup the current configuration
cp /etc/nftables.conf /root/nftables.conf.backup.$(date +%Y-%m-%d_%H-%M-%S)

# Copy a new file from _root_ folder to _etc_
cp /root/nftables.conf /etc/nftables.conf

# Apply the rules
${nft} -f /etc/nftables.conf

while true; do
    read -p "Do you want to CLEAR the terminal and LIST the current RULESET?" yn
    case $yn in
        [Yy]* ) clear && ${nft} list ruleset; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
