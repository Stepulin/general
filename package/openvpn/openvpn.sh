apt install openvpn

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
# /etc/openvpn/easy-rsa/pki/dh.pem
# Generate extra file for safety
openvpn --genkey --secret ta.key
# Copy all the files so you can run the server
cp ta.key /etc/openvpn/
cp pki/ca.crt /etc/openvpn/
cp pki/private/vpnserver.key /etc/openvpn/
cp pki/issued/vpnserver.crt /etc/openvpn/
cp pki/dh.pem /etc/openvpn/

echo "Client part"
echo "Enter you name in following form: surnamefirstname"
read surnamefirstname
./easyrsa gen-req $surnamefirstname nopass
./easyrsa sign-req client $surnamefirstname

mkdir /etc/openvpn/$surnamefirstname/
cp pki/ca.crt /etc/openvpn/$surnamefirstname/
cp pki/issued/$surnamefirstname.crt /etc/openvpn/$surnamefirstname/
cp pki/private/$surnamefirstname.key /etc/openvpn/$surnamefirstname/

systemctl start openvpn@server
systemctl enable openvpn@server

# To see the log
tail -f /var/log/openvpn/openvpn.log
systemctl status openvpn@server
