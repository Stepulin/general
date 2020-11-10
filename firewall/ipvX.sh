#!/bin/bash
# The main purpose of this script is to use it along with OpenVPN
# It allows forwarding ipv4 and disables ipv6
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "Finalising ..."
echo "DONE!"
# This is Debian based, for Red Hat, us following
# To DISABLE
#sysctl -w net.ipv6.conf.all.disable_ipv6=1
#sysctl -w net.ipv6.conf.default.disable_ipv6=1
# To ENABLE
#sysctl -w net.ipv6.conf.all.disable_ipv6=0
#sysctl -w net.ipv6.conf.default.disable_ipv6=0
echo "----------------------------"
echo "REBOOT is highly recommended"
echo "----------------------------"
