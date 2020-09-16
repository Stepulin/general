#!/bin/bash
# Created on 12. 5. 2018; version 1.2020-09-16
# Created by Jan Stepanek, contributor Martin Hunek
#####################################
#####################
# Delete all settings
#####################
PATH='/sbin'
echo "Deleting all settings"
iptables -F
iptables -X
iptables -Z

#############################################
# Starting firewall & settings default policy
#############################################
echo "..."
echo "Starting firewall"
echo "..."
echo "Setting default policy"

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

##########
# Chain(s)
##########
iptables -N ICMP_CHK

#############
# INPUT chain
#############

#######
# Local
#######
iptables -A INPUT -s 10.101.0.0/16 -j ACCEPT
iptables -A INPUT -s 192.168.1.1/24 -j ACCEPT

#######
iptables -A INPUT -p icmp -j ICMP_CHK
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -m state --state INVALID -j DROP
# Most common port, allow them later if necessary
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

###############
# FORWARD chain
###############

##############
# OUTPUT chain
##############
iptables -A OUTPUT -o lo -j ACCEPT

##################
# ICMP CHECK chain
##################
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 8 -m limit --limit 30/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 0 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 3/0 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 3/1 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 3/3 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 3/4 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -p icmp -m icmp --icmp-type 11 -m limit --limit 10/sec -j ACCEPT
iptables -A ICMP_CHK -j DROP

############
# Finalizing
############
echo "..."
echo "Done"