#!/bin/bash
echo "You SSH config should be changed for better security"
echo "Change that ROOT and also other users cannot log in while using password"
echo "..."
echo "Allowing auth via cert only"
# Find all possible lines related to root user and change it into PermitRootLogin without-password
sed -i 's/#PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin no/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin no/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin without-password/g' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin without-password/PermitRootLogin without-password/g' /etc/ssh/sshd_config
# Disable password authentification and empty passwords (just for sure)
sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/g' /etc/ssh/sshd_config
echo "Completing ..."
