#!/bin/bash
# Declare the variables
nft="/sbin/nft"

# Making sure that _nftables_ package is already installed
apt install nftables
systemctl enable nftables
systemctl start nftables

# Backup the current configuration
cp /etc/nftables.conf /root/nftables.conf.backup.$(date +%Y-%m-%d_%H-%M-%S)

# Download and copy own config that was downloaded
wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/nftables/nftables.conf && cp /root/nftables.conf /etc/nftables.conf
# Get an extra file for changing the rules via a file
wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/nftables/nftables_apply.sh

# Apply the rules
${nft} -f /etc/nftables.conf

# Delete / purge
apt-get purge iptables -y

while true; do
    read -p "Do you want to CLEAR the terminal and LIST the current RULESET?" yn
    case $yn in
        [Yy]* ) clear && ${nft} list ruleset; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
