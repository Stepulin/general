#!/bin/bash
# Download, backup and copy/replace sshd_config file
echo "Downloading own sshd_config file"
wget https://raw.githubusercontent.com/Stepulin/general/master/package/ssh/sshd_config_own
echo "Creating backup files and copying own sshd_config file"
cp /etc/ssh/sshd_config /root/sshd_config.bak
mv /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
cp /root/sshd_config_own /etc/ssh/sshd_config
# Restart SSH service in orded to apply new configuration
echo "Restarting SSH service to apply new configuration"
systemctl restart ssh
echo "Completing ..."
echo "DONE"
