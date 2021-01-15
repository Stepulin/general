echo "#################"
echo "Adding new client"
echo "#################"
echo "Enter you name in following form: surnamefirstname"
read surnamefirstname
echo "Enter FQDN of your server"
read serverfqdn

cd /etc/openvpn/easy-rsa/
./easyrsa gen-req $surnamefirstname nopass
./easyrsa sign-req client $surnamefirstname
mkdir /etc/openvpn/$surnamefirstname/
cp pki/ca.crt /etc/openvpn/$surnamefirstname/
cp pki/issued/$surnamefirstname.crt /etc/openvpn/$surnamefirstname/
cp pki/private/$surnamefirstname.key /etc/openvpn/$surnamefirstname/

cd /etc/openvpn/$surnamefirstname
wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/client_file.ovpn
echo cert $surnamefirstname.crt >> client_file.ovpn
echo key $surnamefirstname.key >> client_file.ovpn

sed -i "s|xyz|$serverfqdn|g" /etc/openvpn/$surnamefirstname/client_file.ovpn

mv client_file.ovpn $surnamefirstname.ovpn

cd ..

cp dh.pem ta.key $surnamefirstname/

# Config only OVPN file
cd /etc/openvpn/$surnamefirstname/
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
