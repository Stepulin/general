cd /etc/openvpn/$surnamefirstname

wget https://raw.githubusercontent.com/Stepulin/general/master/package/openvpn/client_user.ovpn

echo cert $surnamefirstname.crt >> client_user.ovpn
echo key $surnamefirstname.key >> client_user.ovpn

mv client_user.ovpn $surnamefirstname.ovpn

cd ..
cp dh.pem ta.key $surnamefirstname/
