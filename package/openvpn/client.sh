cd /etc/openvpn/$surnamefirstname

wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/client_user.ovpn

echo cert $surnamefirstname.crt >> client_user.ovpn
echo key $surnamefirstname.key >> client_user.ovpn

mv client_user.ovpn $surnamefirstname.ovpn

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
