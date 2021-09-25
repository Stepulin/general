#!/bin/bash
# Simple script that runs firewall.sh file, save new rules and print the output.
# Make sure that iptables-persistent package is present -> install it
apt update && apt install iptables-persistent

echo "Applying firewall_rules.sh"
for i in {3..1}
do
    echo "$i"
    /usr/bin/sleep 1
done

bash firewall_rules.sh

echo "Processing ..."
for i in {3..1}
do
    echo "$i"
    /usr/bin/sleep 1
done

PATH='/sbin'
echo "Saving rules ..."
iptables-save > /etc/iptables/rules.v4

echo "Processing ..."
for i in {5..1}
do
    echo "$i"
    /usr/bin/sleep 1
done

echo "Printing new rules"
iptables -L
iptables -L -v
