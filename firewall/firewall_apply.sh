#!/bin/bash
# Simple script that runs firewall.sh file, saves new rules and prints the output.

echo "Applying firewall.sh"
for i in {3..1}
do
    echo "$i"
    /usr/bin/sleep 1
done

bash firewall.sh

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
