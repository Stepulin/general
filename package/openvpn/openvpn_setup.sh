# Install OpenVPN
apt install openvpn

# Copy Easy-RSA and edit some lines based on your preferences
cp -r /usr/share/easy-rsa/ /etc/openvpn/
cd /etc/openvpn/easy-rsa/
nano vars

# Initialize
./easyrsa init-pki
# Build CA with no password
./easyrsa build-ca nopass
# Build server certificate and key with no passwords
./easyrsa gen-req vpnserver nopass
# Sign the certificate
./easyrsa sign-req server vpnserver
# Generate DH file
./easyrsa gen-dh
# /etc/openvpn/easy-rsa/pki/dh.pem ???
# Generate extra file for safety
openvpn --genkey --secret ta.key
# Copy all the files so you can run the server
cp ta.key /etc/openvpn/
cp pki/ca.crt /etc/openvpn/
cp pki/private/vpnserver.key /etc/openvpn/
cp pki/issued/vpnserver.crt /etc/openvpn/
cp pki/dh.pem /etc/openvpn/

echo "Creating first client"
cd /etc/openvpn/easy-rsa/
echo "Enter you name in following form: surnamefirstname"
read surnamefirstname
./easyrsa gen-req $surnamefirstname nopass
./easyrsa sign-req client $surnamefirstname
mkdir /etc/openvpn/$surnamefirstname/
cp pki/ca.crt /etc/openvpn/$surnamefirstname/
cp pki/issued/$surnamefirstname.crt /etc/openvpn/$surnamefirstname/
cp pki/private/$surnamefirstname.key /etc/openvpn/$surnamefirstname/

# Remove this folders
rm -r /etc/openvpn/server/
rm -r /etc/openvpn/client/

# Download server configuration
cd /etc/openvpn/
wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/server.conf

systemctl status openvpn@server
systemctl start openvpn@server
systemctl enable openvpn@server

# To see the log
tail -f /var/log/openvpn/openvpn.log

# Add necessary rules into firewall
echo "Adding necessary rules into firewall"
echo "..."

echo "iptables -A INPUT -p udp --dport 1194 -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -A FORWARD -i eth0 -o tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -A FORWARD -s 192.168.123.0/24 -o eth0 -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -t nat -A POSTROUTING -s 192.168.123.0/24 -o eth0 -j MASQUERADE" >> /root/firewall_rules.sh

echo "Applying these rules by running firewall_apply.sh"
bash /root/firewall_apply.sh
