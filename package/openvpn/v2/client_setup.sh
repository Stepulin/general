echo "#################"
echo "Adding new client"
echo "#################"
echo "Enter you name in following form: surnamefirstname"
read surnamefirstname
echo "Enter FQDN of your server"
read serverfqdn
echo "Which protocol do you use?"
read proto

cd /etc/openvpn/easy-rsa/
./easyrsa gen-req $surnamefirstname nopass
./easyrsa sign-req client $surnamefirstname
mkdir /etc/openvpn/clients
mkdir /etc/openvpn/clients/$surnamefirstname/
cp pki/ca.crt /etc/openvpn/clients/$surnamefirstname/
cp pki/issued/$surnamefirstname.crt /etc/openvpn/clients/$surnamefirstname/
cp pki/private/$surnamefirstname.key /etc/openvpn/clients/$surnamefirstname/
cp /etc/openvpn/ta.key /etc/openvpn/clients/$surnamefirstname/

cd /etc/openvpn/clients/$surnamefirstname

if [ "$proto" = "udp" ]
then
  wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/v2/client_file_udp.ovpn -O client_file.ovpn
elif [ "$proto" = "tcp" ]
then
  wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/v2/client_file_tcp.ovpn -O client_file.ovpn
else
  echo "Error"
  read -p "Press ENTER and start again"
fi

sed -i "s|xyz|$serverfqdn|g" /etc/openvpn/clients/$surnamefirstname/client_file.ovpn

mv client_file.ovpn $surnamefirstname.ovpn

# Config only OVPN file
cd /etc/openvpn/clients/$surnamefirstname/
echo "key-direction 1" >> $surnamefirstname.ovpn
echo "<ca>" >> $surnamefirstname.ovpn
sed -n '/BEGIN CERTIFICATE/,/END CERTIFICATE/p' < ca.crt >> $surnamefirstname.ovpn
echo "</ca>" >> $surnamefirstname.ovpn
echo "<cert>" >> $surnamefirstname.ovpn
sed -n '/BEGIN CERTIFICATE/,/END CERTIFICATE/p' < $surnamefirstname.crt >> $surnamefirstname.ovpn
echo "</cert>" >> $surnamefirstname.ovpn
echo "<key>" >> $surnamefirstname.ovpn
sed -n '/BEGIN PRIVATE KEY/,/END PRIVATE KEY/p' < $surnamefirstname.key >> $surnamefirstname.ovpn
echo "</key>" >> $surnamefirstname.ovpn
echo "<tls-auth>" >> $surnamefirstname.ovpn
sed -n '/BEGIN OpenVPN Static key V1/,/END OpenVPN Static key V1/p' < ta.key >> $surnamefirstname.ovpn
echo "</tls-auth>" >> $surnamefirstname.ovpn
