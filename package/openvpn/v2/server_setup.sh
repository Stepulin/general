# Install OpenVPN
apt install openvpn

# Checking if "openvpn" is present in /usr/local/bin/openvpn
fileopenvpn="/usr/local/bin/openvpn"
if [ ! -f "$fileopenvpn" ]
then
	echo "Creating symlink"
	ln -s /usr/sbin/openvpn /usr/local/bin/openvpn
else
	echo "File already exists ..."
fi

# Checking if "firewall_rules.sh" exists
filefwrules="/root/firewall_rules.sh"
if [ ! -f "$filefwrules" ]
then
	echo "Downloading firewall file with rules"
	wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_rules.sh
	sleep 1
else
	echo "firewall_rules.sh already exists ..."
fi

# Checking if "firewall_apply.sh" exists
filefwapply="/root/firewall_apply.sh"
if [ ! -f "$filefwapply" ]
then
	echo "Downloading firewall file to apply rules and save them"
	wget https://raw.githubusercontent.com/Stepulin/general/master/firewall/firewall_apply.sh
	sleep 1
else
	echo "firewall_apply.sh already exists ..."
fi

bash firewall_apply.sh
sleep 1

echo "####################"
echo "Seting up the server"
echo "####################"
echo "Which protocol do you want to use?"
echo "#########################################################################"
echo "Type udp for UDP (which is faster and better for poor connections)"
echo "Type tcp for TCP (which is more reliable and on port 443 works everywhere)"
echo "#########################################################################"
read proto
if [ "$proto" = "udp" ]
then
  echo "udp"
elif [ "$proto" = "tcp" ]
then
  echo "tcp"
else
  echo "Error"
  read -p "Press ENTER and start again"
fi

# Copy Easy-RSA and edit some lines based on your preferences
cp -r /usr/share/easy-rsa/ /etc/openvpn/
cd /etc/openvpn/easy-rsa/
cp vars.example vars

echo "###########################"
echo "Set information for CA/CERT"
echo "###########################"
echo "Country?"
read country
echo "City?"
read city
echo "Organization?"
read organization

echo "###########################"
echo "Set key size and expiration"
echo "###########################"
echo "Key size? | Recommended value is 2048"
read keysize
echo "CA and CERT expiration? | For 10 years set 3650"
read expire
# Add the information to /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_REQ_COUNTRY "$country"" >> /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_REQ_CITY "$city"" >> /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_REQ_ORG "$organization"" >> /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_KEY_SIZE "$keysize"" >> /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_CA_EXPIRE "$expire"" >> /etc/openvpn/easy-rsa/vars
echo "set_var EASYRSA_CERT_EXPIRE "$expire"" >> /etc/openvpn/easy-rsa/vars

# Initialize
./easyrsa init-pki
# Build CA with no password
./easyrsa build-ca nopass
# Build server certificate and key with no passwords
./easyrsa gen-req vpnserver nopass
# Sign the certificate
./easyrsa sign-req server vpnserver
# Generate extra file for safety
openvpn --genkey --secret ta.key
# Copy all the files so you can run the server
cp ta.key /etc/openvpn/
cp pki/ca.crt /etc/openvpn/
cp pki/private/vpnserver.key /etc/openvpn/
cp pki/issued/vpnserver.crt /etc/openvpn/

# Download server configuration
cd /etc/openvpn/
if [ "$proto" = "udp" ]
then
  wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/server_file_udp.conf
  mv server_file_udp.conf server.conf
elif [ "$proto" = "tcp" ]
then
  wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/server_file_tcp.conf
  mv server_file_tcp.conf server.conf
else
  echo "Error"
  read -p "Press ENTER and start again"
fi

systemctl status openvpn
read -p "Press ENTER to continue"
systemctl start openvpn
systemctl enable openvpn
systemctl status openvpn
read -p "Press ENTER to continue"

# Add necessary rules into firewall
echo "Adding necessary rules into firewall"
echo "..."

echo "iptables -A INPUT -p udp --dport 1194 -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -A FORWARD -i eth0 -o tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -A FORWARD -s 192.168.123.0/24 -o eth0 -j ACCEPT" >> /root/firewall_rules.sh
echo "iptables -t nat -A POSTROUTING -s 192.168.123.0/24 -o eth0 -j MASQUERADE" >> /root/firewall_rules.sh

echo "Applying these rules by running firewall_apply.sh"
cd
bash firewall_apply.sh

echo "To see the log run following command:"
echo "tail -f /var/log/openvpn/openvpn.log"
