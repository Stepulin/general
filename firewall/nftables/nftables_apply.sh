#!/bin/bash
(
# Making sure that _nftables_ package is already installed
apt install nftables
systemctl enable nftables
systemctl start nftables

# Backup the current configuration
cp /etc/nftables.conf /root/nftables.conf.backup.$(date +%Y-%m-%d_%H-%M-%S)

# Download and copy own config that was downloaded
#wget ### && cp /root/nftables.conf /etc/nftables.conf

# Apply the rules
nft -f /etc/nftables.conf && clear && nft list ruleset
) | tee -a /root/log
